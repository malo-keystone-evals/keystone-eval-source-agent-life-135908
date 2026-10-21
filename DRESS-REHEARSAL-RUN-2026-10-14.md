# Dress Rehearsal run — 2026-10-14

The `properties` block lines of `DRESS-REHEARSAL-PLAN.md` for `book_page`'s
Overview and `review_page`'s Review tab, as generated on
`roadmaps/properties-block-fields/04-always-on-grid` — the stage that draws
every property as its field from the start (ADR-0124). Walked in light and
dark against a live stack (native Postgres, `keystone-dev start`) in headless
Firefox over Marionette, as admin, with the book page also walked as a patron.
Compared against `docs/roadmaps/properties-block-fields/design/`.

Record: *Dune* (`books`, published) and *A desert masterpiece* (`reviews`,
published). The review's `body` and `tags` were seeded through
`/keystone/mutate`, the backdrop carrying neither.

Marks: `✓ walked`, `⚠ finding`, `● known`.

## Fixed during the walk

- **An editable property's field shrank to its content** — about 200px of a
  500px half — because the grid cell laid its children out in a row and the
  field arrives inside `InlineProperty`'s group. The cell is now a column.
- **A restored draft came back marked but empty, and Discard put nothing
  back** — both StrictMode's double effect run on the dev build: the record
  draft's seed re-seeded the server's record over the adopted draft, and the
  session's per-record reset forgot the baseline Discard returns to.
- **A markdown property at rest showed its first line as source**
  (`**sweeping**`): live preview revealed the line the selection sat on even
  with the editor unfocused. The reveal now follows focus.

## Issues filed by this run

- **#1457** — a record page's tab row does not give way when the window
  narrows after widening; the page scrolls sideways and the properties block
  stays two columns. Loading at the narrow width is correct.
- **#1458** — a number field draws the browser's spinner under the `property`
  presentation (light in dark mode), which the boards do not have; and the
  required `*` in a label line, which the review board does not show.

## Page: book_page — tab `overview`

- [x] properties block in tab `overview`: two columns at a wide window, the half-width properties paired left then right in the block's own order and a half with no partner sitting alone, `cover_url` and `cover_image_id` spanning both columns; one column once the window narrows; the properties outside `genre`, `summary`, `isbn`, `page_count` and `featured`, and any of those this viewer may not update, in the calm shell, with no chrome on hover and the default cursor; in both themes
- [x] the way in on inline editing in tab `overview`: focusing one of `genre`, `summary`, `isbn`, `page_count` and `featured` opens it as its field — there is no pencil and nothing to click first — and nothing on the page moves, no row growing, no column shifting and nothing below the block jumping, whether the focus came from a click or from Tab
- [x] the Tab walk on inline editing in tab `overview`: Tab moves to the next property in visual order — across a row and then down — and Shift-Tab back, each saving the property it leaves, with the [[Command Strip]] offering the undo; a read-only property is no stop unless its value holds a link of its own, and a markdown body lets Tab leave rather than indenting
- [x] Escape on inline editing in tab `overview`: type into a property and press Escape — the value goes back to the one it opened with, nothing saves, and the focus stays on that property rather than leaving it
- [x] a select reached by Tab on inline editing in tab `overview` (`genre`): Tab lands on it with its menu closed, and a second Tab walks on past it without one popping
- [x] restored draft on inline editing in tab `overview` (`genre`, `summary`, `isbn`, `page_count`, `featured`): edit one of those properties, close the tab with the field still open, and reopen the record — nothing is focused on load, and the value is back in its own field, the one that was typed rather than the server's, marked restored and unsaved where it stands, with a Discard beside it that puts the server's value back and leaves the record clean
- [x] deliberate save on inline editing in tab `overview` (`genre`, `summary`, `isbn`, `page_count`, `featured`): nothing saves on a timer — type into one of those properties, leave it alone for a minute without leaving the field, and the value is still unsaved with the [[Command Strip]] silent, there being no save to report

Notes, line by line:

- ✓ Pairing: Status|Title, Author Id|Author Name, … Featured|Review Count,
  Average Rating|Reviews At Shelving; `cover_url` and `cover_image_id` full.
  Every cell 501px at a 1400px window. One column at 640px (grid under
  560px). ⚠ #1457 after a widen-then-narrow. Read-only boxes: transparent
  border and background on hover, `cursor: default`. As a patron no property
  is a field and every box is the read-only shell. Both themes.
- ✓ Click and Tab both open a property with no box moving: every cell's rect
  identical before and after focus; the focused box keeps its 56px. Empty at
  rest centres its label, focused moves it up over the placeholder.
- ✓ Isbn → Tab → Genre → Page Count → the cover card's two controls →
  Featured; Shift-Tab back. Read-only text properties are no stop. The Tab off
  Isbn sent one mutation (`{isbn}`) and none while typing; the strip read
  "Save changes" and its dropdown's **Undo Save changes** put `null` back.
- ✓ Escape: the value back to empty, focus stays on the Isbn input, nothing
  sent; the next keystroke edits again.
- ✓ Genre reached by Tab: focus ring, no listbox; Tab walks on to Page Count
  with none popping.
- ✓ Restored draft: `97804` typed into Isbn, the tab closed with it open, the
  record reopened — nothing focused, `97804` in its own field, "Restored from
  your last visit. Not saved yet." under it with Discard; Discard empties the
  field, takes the marking and the stored copy away, and sends nothing.
  (⚠ fixed on the walk — see above.)
- ✓ Deliberate save: Summary typed into and left alone 65s — no mutation,
  strip silent, focus still in the input; Escape gave it up.
- ✓ Checkbox: Tab lands with a 3px ring on the box only; Space toggles,
  Shift-Tab away saves.

## Page: review_page — tab `review`

- [x] properties block in tab `review`: two columns at a wide window, the half-width properties paired left then right in the block's own order and a half with no partner sitting alone, `body` spanning both columns; one column once the window narrows; any property this viewer may not update in the calm shell, every one the block draws being named in `editable`, with no chrome on hover and the default cursor; in both themes
- [x] the way in on inline editing in tab `review`: focusing one of `headline`, `rating`, `recommended`, `body` and `tags` opens it as its field — there is no pencil and nothing to click first — and nothing on the page moves, no row growing, no column shifting and nothing below the block jumping, whether the focus came from a click or from Tab
- [x] the Tab walk on inline editing in tab `review`: Tab moves to the next property in visual order — across a row and then down — and Shift-Tab back, each saving the property it leaves, with the [[Command Strip]] offering the undo; a read-only property is no stop unless its value holds a link of its own, and a markdown body lets Tab leave rather than indenting
- [x] Escape on inline editing in tab `review`: type into a property and press Escape — the value goes back to the one it opened with, nothing saves, and the focus stays on that property rather than leaving it
- [x] restored draft on inline editing in tab `review` (`headline`, `rating`, `recommended`, `body`, `tags`): edit one of those properties, close the tab with the field still open, and reopen the record — nothing is focused on load, and the value is back in its own field, the one that was typed rather than the server's, marked restored and unsaved where it stands, with a Discard beside it that puts the server's value back and leaves the record clean
- [x] deliberate save on inline editing in tab `review` (`headline`, `rating`, `recommended`, `body`, `tags`): nothing saves on a timer — type into one of those properties, leave it alone for a minute without leaving the field, and the value is still unsaved with the [[Command Strip]] silent, there being no save to report

Notes, line by line:

- ✓ Headline|Rating, Recommended alone, Body full, Tags. `rating` is named in
  `editable` and refused by every policy, so it is the read-only shell: no
  chrome on hover, default cursor, not a Tab stop. One column at a narrow
  window. Tags are chips at rest and carry their remove buttons on focus.
  Both themes. (⚠ fixed on the walk: the body's first line as source at rest.)
- ✓ The body takes focus with the box unchanged at 1030×104; the ribbon sits
  in the label line, right-aligned. Tags focus at 56px.
- ✓ Headline → Recommended → Body → Tags, Rating skipped; the body lets Tab
  leave. Bold from the ribbon keeps focus in the editor and sends nothing;
  the Tab after it saves.
- ✓ Escape on Headline restores the value and keeps focus.
- ✓ Restored draft: " (draft)" typed after the headline, the tab closed with
  it open, the record reopened — nothing focused, "A desert masterpiece
  (draft)" in the field, marked restored and unsaved; Discard put the
  server's headline back, cleared storage and sent nothing.
- ✓ Deliberate save: Headline typed into and left 65s — no mutation, strip
  silent, focus kept.
