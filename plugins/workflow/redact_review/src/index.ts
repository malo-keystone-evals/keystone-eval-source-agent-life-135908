import type { KeystoneClient } from "@keystone/plugin"

// AGENTIC DEMO (ADR-0063): a plugin invoked as an agent tool.
//
// As an agent tool the entry point receives a third argument — the read-only
// `agent` bag `{ state, context }` — and its return uses the fixed tool
// contract: `{ message, events?, set_state? }`, where `set_state` is a map of
// the node's DECLARED state fields, validated and applied atomically at the
// tool's sequential apply slot. Here it flips the agent's `redacted` flag so
// the tool's own `enabled` gate (`.redacted.eq(false)`) withdraws it from the
// model on the next iteration — a tool that can only fire once.
export default async function redactReview(
  input: { review_id: string; notice: string },
  keystone: KeystoneClient,
  agent?: { state?: { redacted?: boolean }; context?: { today?: string } },
) {
  const updated = await keystone.update({
    model: "reviews",
    id: input.review_id,
    changes: {
      properties: {
        headline: "[redacted by moderation]",
        body: input.notice,
      },
    },
  })
  if (!updated) {
    // Loops back to the model as an error tool result — it can correct the id
    // or submit without redacting.
    return keystone.error(
      "review_missing",
      `no review with id ${input.review_id} — check the id in your instructions`,
    )
  }
  const on = agent?.context?.today ?? "today"
  return {
    message: `review ${input.review_id} redacted (${on})`,
    set_state: { redacted: true },
  }
}
