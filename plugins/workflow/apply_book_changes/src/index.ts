import type { KeystoneClient } from "@keystone/plugin"

type StagedEdit = { field: string; value: string }

type Desk = {
  book_id?: string | null
  staged?: StagedEdit[] | null
  notes?: string[] | null
}

/**
 * Collapse the staged edit *list* into the properties patch to write.
 *
 * A list rather than an object because that is what Easel can build: its
 * `state_update` expressions compute a field's complete new value, and
 * `.staged.concat(object(...))` appends one, while merging a key into an
 * existing object has no expression. Last write wins, so re-proposing a field
 * corrects it rather than conflicting.
 */
function collapse(staged: StagedEdit[]): Record<string, string> {
  const patch: Record<string, string> = {}
  for (const edit of staged) patch[edit.field] = edit.value
  return patch
}

// The Catalogue Desk's commit step (ADR-0071).
//
// The interesting part is the read-back. `run_as: user` means this write goes
// through the librarian's own UpdatePermission on books, and the model store
// **silently drops** properties that permission doesn't list. Reporting "done"
// off the back of a successful call would therefore be a lie whenever the
// permission is narrower than the change set — so the record is re-read and the
// message names what actually landed and what didn't.
//
// (That silent drop is real: it is why `books.slug` is never written by
// generate_book_slug — `slug` appears in no update permission.)
export default async function applyBookChanges(
  _input: Record<string, never>,
  keystone: KeystoneClient,
  agent?: { state?: Desk },
) {
  const state = agent?.state ?? {}
  const staged = collapse(state.staged ?? [])
  const fields = Object.keys(staged)

  if (fields.length === 0) {
    return keystone.error(
      "nothing_staged",
      "No changes are staged. Use propose_change first, then confirm with the user.",
    )
  }
  if (!state.book_id) {
    return keystone.error(
      "no_book",
      "This conversation is not attached to a book.",
    )
  }

  const updated = await keystone.update({
    model: "books",
    id: state.book_id,
    changes: { properties: staged },
  })
  if (!updated) {
    return keystone.error(
      "apply_failed",
      "The catalogue rejected the update — you may not have permission to edit this book.",
    )
  }

  // What actually landed, field by field. `updated` is the record as it now
  // stands, so a dropped property shows up as an unchanged value.
  const landed: string[] = []
  const dropped: string[] = []
  for (const field of fields) {
    const want = staged[field]
    // Flat record back from the host: each property by its own name.
    const got = updated[field as keyof typeof updated]
    if (String(got ?? "") === String(want ?? "")) landed.push(field)
    else dropped.push(field)
  }

  const parts = [
    landed.length ? `Applied: ${landed.join(", ")}.` : "Nothing was applied.",
  ]
  if (dropped.length) {
    parts.push(
      `NOT applied (your permissions do not cover ${dropped.length === 1 ? "this field" : "these fields"}): ${dropped.join(", ")}. Tell the user plainly.`,
    )
  }

  return {
    message: parts.join(" "),
    // Clear the staging area and mark the turn done, so `propose_change`'s
    // `enabled` gate reopens for a fresh round and `apply_changes` withdraws
    // until something new is staged.
    set_state: { staged: [] },
  }
}
