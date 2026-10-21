# Dress Rehearsal run — 2026-09-28

A copy of `DRESS-REHEARSAL-PLAN.md` as generated on
`roadmaps/legacy-panels/06-the-walk`, walked against a live stack with
`features.legacy_panels` off. The plan is 793 boxes; the walk is split across
six sessions that share this one file, so **the boxes and the findings below
are the run's state** — pick up at the first section still untouched.

Findings are marked inline under the line they belong to:
`✓ walked`, `⚠ finding`, `● known` (a bug already in
`DRESS-REHEARSAL-NOTES.md` — confirmed, never re-filed), `— unreachable`
(the harness cannot pose the question; said so rather than ticked as passed).

## Progress

| Session | Sections | State |
|---|---|---|
| 01 | Static surfaces, `reading_desk_page`, `reports_page`, `weather_page` | done — 19 boxes: 15 ticked, 3 blocked under known issues, 1 carrying #1307 |
| 02 | `books_listing`, `authors_listing` | done — `authors_listing` 51 boxes: 35 ticked, 1 blocked under a known issue, 13 carrying #1309–#1316, 2 unreachable. `books_listing` 72 boxes: 55 ticked, 1 blocked under a known issue, 14 carrying #1309–#1322, 2 unreachable |
| 03 | `clubs_listing`, `events_listing`, `loans_listing` | done — 163 boxes: 133 ticked; the other 30 each carry a finding, a named known issue, or a clause this config or this harness cannot reach. Filed #1323, #1324, #1326, #1327, #1328; #1325 filed and retracted. Confirmed #1309, #1310, #1311, #1314, #1315, #1316, #1317, #1318 as known, and ratcheted the two crashes that no longer reproduce |
| 04 | `members_listing`, `reviews_listing`, `users_listing` | done — 162 boxes: 150 ticked; the other 12 each carry a finding, a named known issue, or a clause this config cannot reach. Filed #1329–#1336. Confirmed #1309, #1310, #1311, #1314, #1315, #1316, #1317, #1318 as known, and ratcheted `suspend_member`, which no longer fails from a listing |
| 05 | `book_page`, `author_page` | done — 125 boxes: 104 ticked; the other 21 each carry a finding, a named known issue, or a clause this config or this harness cannot reach. Filed #1337–#1343. Confirmed #1310, #1314, #1316, #1318, #1329, #1333, #1335, #1336 as known |
| 06 | `club_page`, `member_page`, `review_page` | done — 138 boxes: 105 ticked; the other 33 each carry a finding, a named known issue, or a clause this config or this harness cannot reach. Filed #1344–#1350. Confirmed #1311, #1314, #1315, #1316, #1324, #1327, #1328, #1329, #1337, #1339, #1341 as known, and ratcheted the `club_page` crash, `suspend_member` from a record page, and #1323 |
| 07 | Dashboard, Dashboard customization, Account, Credentials, Onboarding, Modals, Documents, Undo, journeys | done — 63 boxes: 55 ticked, 8 carrying a finding; then all 12 journeys, 6 of them clean, 4 carrying a finding and 2 unreachable without LLM credentials. Filed #1351–#1371. Confirmed #1315, #1322, #1329, #1331, #1349, #1350 as known, and ratcheted the Dashboard's dead route, which now serves |

## Issues filed by this run

- **#1307** — generator: the plan names the wrong title for an `agent_chat`
  page's header (`reading_desk_page`).
- **#1308** — sign-up form answers three different problems with one catch-all
  message.
- **#1309** — generator: the plan describes a [[Status Column]] the app stopped
  drawing — a plain fill, a centred label and a pattern strip down the left edge,
  where the shipped column draws a wash, a disc and a left-aligned label.
- **#1310** — generator: the plan names properties the config excludes — the
  `filterable: false` ones in the filter line, and the model’s identity property
  among the cells that open an editor.
- **#1311** — generator: the plan asks a table header to sort and to filter; the
  header carries neither control, both living in modals behind the header bar.
- **#1312** — undoing a cell edit made after an earlier undo restores the undone
  value, writing it back to the database.
- **#1313** — hiding a column silently clears that property: the row edit modal
  seeds from the listing’s row, so a hidden field opens blank and the save writes
  `NULL`.
- **#1314** — a listing table is not one tab stop: Tab walks each row’s pencil and
  opens every editable cell in turn, and never leaves the table.
- **#1315** — a required field left empty is refused with "Unable to typecast as
  string" rather than saying it is required.
- **#1316** — the [[Identity Column]] never wears the sort arrow, so a listing
  sorted by its identity property looks unsorted.
- **#1317** — sorting a listing by its status column orders the statuses alphabetically
  rather than in the spec's declared order, though the Postgres enum under it is ordered by
  declaration.
- **#1318** — a policy the spec grants to no role is applied to the acting user anyway:
  archived books are editable by any admin, and a property the matched permission does not
  cover saves as a silent success with a green tick.
- **#1319** — an inline-edit cell's enum menu ignores the property's itemset, so its labels,
  section headings and icons are lost — and the board card's label strip and tag pill with
  them.
- **#1320** — a form's number field ignores the property's presentation unit: a price shown
  as $18.99 everywhere else is edited as 1899, and typing 18.99 stores 18 cents.
- **#1321** — a listing column's `renderer` is never implemented in the app, so this
  project's custom *Buzz* column draws a header over an empty strip on every row.
- **#1322** — a reader whose policy does not include the board's ordering property gets an
  empty board: patrons see three empty columns where the table shows them seven books.

- **#1323** — a modal form's Save with a required field empty is a silent no-op:
  no message, no marked field, nothing in the [[Command Strip]] (`edit_club`).
- **#1324** — an inline-edit cell on an object-valued property opens a raw JSON
  textarea instead of the structured-object editor its own form already has.
- **#1325** — *retracted and closed.* Read `Enter` doing nothing on an identity
  or status cell as a keyboard gap; it is the first click's behaviour correctly
  mirrored — both open once the row is selected, which an arrow key does and a
  bare `Tab` does not.
- **#1326** — every `date_time` column reads *Invalid DateTime*: the server
  serialises a `dateTime` property space-separated and offset-less, and
  `DateTime.fromISO` cannot parse it.
- **#1327** — an object-valued cell with no itemset renders its raw JSON
  (`events.venue`), which is what survives of the old ref-schema crash.
- **#1328** — a transition modal accepts a required lifecycle property left
  empty and writes NULL: loans return without a `return_condition`.
- **#1329** — a refused inline-cell save closes the cell and leaves the rejected
  value in the row, so the table shows a value that is in no database and
  `Escape` has no draft left to give up.
- **#1330** — a wizard step's `completion: { kind: valid }` does not gate its
  **Next** button: `onboard_member` walks to its last screen with both required
  fields empty.
- **#1331** — a workflow launched over a [[Selection]] is named after the modal's
  **Save changes** button and carries no tally, so nothing says how many runs
  started.
- **#1332** — a related link into a listing with no record page still writes a
  dead `panel=` parameter into the URL (`users_listing`, from a `members` row).
- **#1333** — generator: the "gate closes the whole set" line names a policy no
  reader of that page holds, on all three of this session's listings.
- **#1334** — a `default_filters` entry declared with `operator: eq` on an enum
  column opens unset in the Filters modal, so the reader cannot see or edit the
  filter that is in force (`reviews_listing`'s `status: published`).
- **#1335** — generator: the default-sort line asserts a sort arrow on a column
  the listing does not draw (`reviews_listing`'s `created_at`).
- **#1336** — `Escape` out of a cell editor or a keyboard-opened row menu drops
  the focus ring to `<body>`, so the arrow keys stop walking the table.
- **#1337** — a record page's table tab ignores the listing view's `columns`
  configuration — labels, widths and a custom column — while inheriting its
  `default_sort`, and draws a column that view switches off.
- **#1338** — checking every row from the header checkbox reports a green
  **Select all** in the [[Command Strip]], with the caret still disabled and no
  history under it.
- **#1339** — `Shift+F10` opens no row menu on the [[Identity Column]]'s cell,
  though a right-click there opens it.
- **#1340** — clearing a required *reference* cell leaves the row drawing a blank
  the database does not hold; a plain number input rolls back correctly.
- **#1341** — a record page's own `?edit=` link never opens: the page writes it
  and then reports **Open Record — Failed** for the record it is showing.
- **#1342** — the record header's fixed 180px title column starves the tab row:
  `book_page`'s seven labels are all ellipsised at a 1400px window.
- **#1343** — `Tab` out of an open cell into a markdown column drops the focus to
  `<body>` instead of opening that column's editor.

- **#1344** — the record header's ellipsised title rests no tooltip: a fixed 180px column cuts
  a long record name at every width and nothing anywhere carries the whole of it.
- **#1345** — a clipped value in an editable or identity cell never previews: the gate measures
  the outer `[data-table-cell]` while the ellipsis lives on an inner wrapper.
- **#1346** — an inline date cell's month grid opens on the current month rather than on the
  month of the value being edited.
- **#1347** — an emptied non-nullable number cell writes NULL instead of rolling back, and the
  raw Postgres not-null error reaches the reader.
- **#1348** — generator: a record page's `record-action modals` line resolves `modals: ["*"]`
  over every modal naming the model, so it asks `member_page` to open `onboard_member`, a
  `kind: new_record` modal no record page offers.
- **#1349** — a restored draft's **Discard** button saves the draft to the database instead of
  throwing it away.
- **#1350** — a record page's back arrow loses the listing's sort on a listing that declares
  `default_filters` (`reviews_listing`), and leaves the handoff's `ref_` parameters behind.

- **#1351** — a dashboard widget whose query the server refuses blanks the whole dashboard
  page, silently.
- **#1352** — modern-project: the dashboard's "My membership" widget filters `loans` by a
  property the `member` policy cannot filter by.
- **#1353** — cloning a dashboard under a name already used leaks the raw Postgres
  unique-constraint error.
- **#1354** — dashboard edit mode draws no per-widget removal — only the whole section can be
  removed.
- **#1355** — a dashboard widget cannot be resized: the grid stores `width`/`height` but draws
  no handle.
- **#1356** — an unsaved dashboard edit is guarded against the browser's unload but not against
  the app's own nav.
- **#1357** — the dashboard switcher falls back to "Select option" whenever the URL carries any
  extra query parameter.
- **#1358** — pinning an add modal offers no prefill for its `record_fields` values, only the
  explicit field blocks.
- **#1359** — saving a pin from an add modal lands on `/` carrying the listing's filter and sort.
- **#1360** — a `?dashboard=` name the signed-in user does not own renders a blank page instead
  of saying so.
- **#1361** — `set_credential`'s save button has no label: a blank primary button in the footer.
- **#1362** — `set_credential` opens context-free: no name, no kind, no Base URL prefill, and
  never says *Update credential*.
- **#1363** — the [[Onboarding Gate]] refuses an empty step with *Workflow 'users/join_library'
  requires user_input and none was supplied*.
- **#1364** — the gate's progress bar sits at 100% on an unfinished step, with no text and no
  ARIA.
- **#1365** — a `dateTime` property's wall clock is stored as UTC into a `timestamptz`, so the
  stored day is the next one for an evening time.
- **#1366** — modern-project: `about_library` and `venue_details` are declared modals that
  nothing in the app can open.
- **#1367** — modern-project: the event worksheet PDF prints a raw enum key and a bare "pages"
  with no number.
- **#1368** — below ~1080px the nav drops every page inside a section, and no menu brings them
  back.
- **#1369** — a record page keeps the old status and its old action menu after a workflow
  transitions the record.
- **#1370** — a modal opened from a `record_actions.modal_actions` launcher renders an empty
  form — every field is gone.
- **#1371** — a `step_up_required` refusal draws no step-up modal: the server asks for a
  password and the UI just says *Not permitted*.


## The harness: boot and drive

Everything below was walked against this, and the sessions after this one
should boot the same way rather than re-deriving it. `$SP` is a scratchpad
directory; nothing here belongs in the repo.

### One stack

Docker is not available on this machine, so Postgres is a native cluster —
this stands in everywhere `docs/rehearsals/HARNESS.md` says
`docker compose up -d postgres`:

```bash
initdb -D "$SP/pgdata" --no-locale --encoding=UTF8 --auth=trust -U postgres
PGSOCK=$(mktemp -d /tmp/ks-pg-XXXXXX)
pg_ctl -D "$SP/pgdata" -l "$SP/pgdata/pg.log" \
  -o "-p 5442 -k $PGSOCK -c listen_addresses='127.0.0.1'" start -w
createdb -h 127.0.0.1 -p 5442 -U postgres dress_rehearsal
```

A bare worktree has no `node_modules` and no package `dist`, and
`keystone-dev start` bundles the frontend from them — without the build it
dies on `Module not found: Can't resolve '@chessworld/elevater-api'` and never
binds the port, which reads as a broken checkout:

```bash
CI=true pnpm install --frozen-lockfile     # ~4s; nothing to wipe in a worktree
RUSTC_WRAPPER="" pnpm turbo run build      # ~60s; the two wasm crates dominate
cargo build -p keystone-dev-cli --bin keystone-dev
```

Then, from `examples/modern-project` (never a subdirectory), with the binary
built on this branch rather than whatever is on PATH:

```bash
KD=../../target/debug/keystone-dev
DB=postgres://postgres@127.0.0.1:5442/dress_rehearsal
$KD plugin build
$KD reset --backdrop library --database-url "$DB"   # a flag, not DATABASE_URL
$KD start --port 3100 --no-tui --database-url "$DB" &
```

No LLM credentials, by the plan's own policy. `keystone-dev start` bundles the
frontend **once, at boot**, and watches only `plugins/` and `config/` — so a
package rebuilt while the server is up changes nothing the browser can see.
Restart it after any `dist` rebuild.

### One browser

There is no MCP browser in this session. Firefox's own Marionette port is the
whole of the automation, and it needs nothing installed — the runner skill's
*Drive the browser* section carries the recipe and the traps, and
`§3` of `.claude/skills/dress-rehearse/SKILL.md` is the copy to read. The
short version:

```bash
mkdir -p "$SP/ffprofile"
MOZ_HEADLESS=1 nohup firefox -profile "$SP/ffprofile" --no-remote --headless \
  --marionette -remote-allow-system-access --window-size=1400,900 about:blank &
```

`-remote-allow-system-access` is what makes the chrome context reachable, and
the chrome context is the only console reader that sees a page's *boot*. A
second browser for the layout line's "fresh browser profile" wants
`user_pref("marionette.port", 2829);` in its own profile's `user.js`.

Two things were paid for in this session and should not be again:

- **Patch `MediaQueryList.prototype.matches` after every navigation, by appending
  a `<script>` element to the page** — not by running the snippet through
  `ExecuteScript`, which patches the sandbox's prototype and leaves the page's own
  React reading `false`. Without it the table mounts its touch arrangement, rows
  carry no action at all, and the walk quietly tests a phone. The check that it
  took is a click: click a cell once and assert the row ticks. (`button[class*=clickable]`
  matches nothing on this build, so counting it answers 0 either way.) Session 05's
  notes below carry the injection and the reasoning.
- **Sign in from inside the page** against `localhost` (never `127.0.0.1` —
  the cookie is `Domain=localhost`), and make it idempotent: `GET
  /session.json` first, `POST` only when logged out, or a second script over
  the same profile gets a 405 for posting over a live session.

Four more were paid for in session 03 and should not be again:

  The body is `{"kind":"basic", "email": …, "password": …}`; without `kind` the
  endpoint answers 422 *missing field `kind`*, which reads as bad credentials.
- **A `fetch` in a Marionette script is not the page's.** `WebDriver:ExecuteScript`
  runs with a global that is not `Window`, so a bare `fetch("/session.json", …)`
  is treated as cross-origin, preflights, and comes back **405 method not
  allowed** — which reads exactly like the endpoint not taking a POST. Bind it:
  `window.fetch.bind(window)(…)`. Everything in this run goes through that.
- **The dev user-switch wants `user_id`, not `email`.**
  `POST /api/__dev/switch-user {"user_id": "<uuid>"}`; an `email` body answers
  **200** and switches nobody, so a whole role sweep silently walks as admin.
- **A board drag needs a press, a pause and a dozen small moves.** One long
  `pointerMove` to the target does nothing at all — the library never starts the
  drag — and the board reads as undraggable. `battery.mjs`'s `drag()` has the
  shape: `pointerDown`, `pause 200`, twelve interpolated moves, `pause 250`,
  `pointerUp`, all in one `PerformActions`.
- **A script that splices annotations into this file must be scoped to its own
  section.** A text-keyed match over the whole file hits the same plan line on
  every page — the status-cell and identity-cell lines are word-for-word
  identical across listings — and will tick and overwrite another session's
  work. `annotate.mjs` takes the `## Page:` heading and stops at the next
  `## `; this run clobbered `authors_listing` and `books_listing` once by
  forgetting that, and recovered with `git checkout` on the file.

Switching the acting user works either way the plan allows: the Dev Mode
Header's User Switch menu (walked below, and it does change the session), or
`POST /api/__dev/switch-user`.

### Seeding and state this run left behind

- Two accounts were created through the sign-up wizard, as the plan's seeding
  policy asks: `wanda@example.com` and `quincy@example.com`. Both sit at the
  [[Onboarding Gate]] with no membership, which is the state a fresh signup
  is *supposed* to be in — the Onboarding section walks them.
- One SQL write, flagged here per the seeding policy: `wanda@example.com`'s
  `first_name` was corrected after a scripting slip of this harness's own
  typed a verification code into the still-visible create-account form. The
  app did nothing wrong; the row was repaired rather than left to mislead a
  later session. The trap is written into the skill so it is not repeated.
- Book titles were edited and restored during the [[Command Strip]] walk;
  `books` is back at its backdrop titles.
- The `librarian@example.com` role was revoked and re-granted to produce a
  real `Not allowed` refusal (see
  [[live-policy-refusal-in-modern-project]] — the client only sends a write
  it believes is permitted, so the role has to go *after* the surface opens).
- **`authors` (session 02).** The backdrop seeds two authors, which is fewer than
  the [[Selection]] lines need, so four more were created through `/keystone/mutate`
  — Chinua Achebe, Margaret Atwood, Haruki Murakami, Zadie Smith — and a fifth,
  Angela Carter, through the **Add Author** modal as that line asks. All five carry a
  bio, a website and a nationality; Chinua Achebe’s bio is deliberately long enough to
  be clipped, for the [[Cell Preview]] line.
- **Zadie Smith is left in `retired`**, moved there through the [[Status Column]]’s own
  transition menu. That is the state the gate lines need — `authors`’ `admin` policy
  permits `update` on `active` only — and it is what a later session will find on
  `author_page`. Everything else is back in `active`.
- Bios, websites and nationalities were edited and undone throughout and are back at
  their seeded values, checked row by row in the database at the end. Two repairs were
  needed after the walk’s own findings and were made through `/keystone/mutate`:
  Angela Carter’s `website`, which the edit modal cleared (#1313), and Chinua Achebe’s
  `bio`, shortened by a save at phone width.
- The table’s **Customize columns** layout was hidden, resized and reordered while
  walking those lines and then put back with **Revert to defaults**. It is a per-user
  preference rather than data, but it is what #1313 turns on, so it is worth knowing
  it is at its defaults now.
- **A harness note rather than seeding.** Running **Print** from the More menu leaves
  this headless Firefox’s WebDriver session pointing at a browsing context that no
  longer takes pointer or key input — `ExecuteScript` still answers, so the page looks
  fine and every click silently does nothing. `WebDriver:NewWindow` (a tab) and
  carrying on there is the way back; do not quit the browser.
- **`books` (session 02).** The backdrop seeds four books, which is fewer than the
  [[Selection]], board and paging lines need, so **eight more were created through
  `/keystone/mutate`** — Things Fall Apart, The Handmaid's Tale, Oryx and Crake, Norwegian
  Wood, Kafka on the Shore, The Bloody Chamber, The Left Hand of Darkness and Children of
  Dune — each with a title, author, genre, page count, price, ISBN, publication date and
  summary, and Things Fall Apart's summary deliberately long enough to be clipped for the
  [[Cell Preview]] line. Twelve books now, over six of the seven authors.
- **The statuses were spread deliberately** and are left that way: six `published`, four
  `draft`, two `archived` (Kafka on the Shore and The Bloody Chamber), which is what the
  status-column, transition and gate lines need. Two of those moves are the walk's own rather
  than the seeding's: **Dune Messiah is left `published`** — it was dragged there across the
  board, and `books` declares no way back to `draft` — and the two archived books' summaries
  read *“Archived - no longer in the active catalogue.”*, which is the
  `stamp_summary_on_archive` workflow doing its job rather than a lost value.
- **`board_rank` is no longer null everywhere.** The backdrop leaves it null on every record;
  the board's drag lines assigned real LexoRanks to the Draft and Published columns. That is
  the state the board's own ordering line needs, and it is worth knowing before reading the
  known issue about null ranks (see the note on that in this section — it no longer
  reproduces on `books_listing`).
- **One cover was uploaded** through `edit_book`'s `file_upload_field`, onto Things Fall
  Apart, for the [[Cell Preview]] line's rich-rendering clause. The backdrop already gives
  four books a cover; this is a fifth, named `cover.png`.
- **One review was created** through the books listing's **Recommend a book** page action, as
  that line asks: *A desert classic*, five stars, recommended, by Alice Reader on Dune. It
  moves Dune's `review_count` to 1 and its `average_rating` to 5, which later sessions will
  find on `reviews_listing` and on Dune's record page.
- Titles, ISBNs, page counts, prices, genres, publication dates, authors, summaries and the
  `featured` flag were edited and undone throughout and were put back through
  `/keystone/mutate` at the end, checked row by row against the values they were seeded with.
  Two were repairs after the walk's own findings: Children of Dune's `price_cents`, which the
  edit modal stored as 18 cents (#1320), and Kafka on the Shore's `summary`, written by the
  probe that proved #1318.
- The table's **Customize columns** layout was hidden, resized and reordered while walking
  those lines and then put back with **Revert to defaults**; it is at its defaults now.
- **A second harness note.** Drive a drag as **one** `PerformActions` ending in its own
  `pointerUp`. A release sent in a call of its own does not reach the element holding pointer
  capture, so the drag stays live and the next pointer move goes on resizing or reordering —
  which reads as a stuck control and is not one. A mid-drag sample therefore has to be a
  *separate* drag that is abandoned with `WebDriver:ReleaseActions` (which cancels rather
  than drops), and no `ExecuteScript` can run *during* a `PerformActions` — Marionette
  serialises them, so a script sent while a drag is running simply queues behind it.

### What session 03 left behind

This session boots its own ephemeral cluster, so the seeding sessions 01 and 02
describe above is **gone** — every session after this one starts from the
`library` backdrop again and seeds what its own sections need. What follows is
this session's own, kept for the same reason theirs is: so a later reading of
this file knows which rows are the backdrop's and which are a walk's.

- **`clubs` — five created, one left archived.** The backdrop seeds two clubs,
  which is fewer than the [[Selection]] lines need, so four more went in through
  `/keystone/mutate` — Atwood Assembly, Borges Society, Calvino Collective and
  Dickens Circle — one of each `meeting_format` variant, and Atwood's
  description deliberately long enough to be clipped for the [[Cell Preview]]
  line. A fifth, **Eliot Circle**, was created through the **Add Reading Club**
  modal as that line asks. **Dickens Circle is left `archived`**, moved there
  through the [[Status Column]]'s own transition menu: it is the record the gate
  lines need, and the one a later reader will find refusing its cells.
  Everything else is `active`.
- Descriptions and capacities were edited, batch-edited, undone and restored
  throughout; checked row by row against their seeded values at the end. Three
  repairs went through `/keystone/mutate`: Borges' and Calvino's descriptions
  after the refusal probe, and Calvino's capacity after the `min: 1` clamp test.
- The table's **Customize columns** layout was resized while walking that line
  and put back with **Revert to defaults**.
- **`events` — six created.** The backdrop seeds one, so five more went in
  through `/keystone/mutate`, each with a club, a title, a `starts_at`, a
  capacity and a `venue`, and one title long enough to be clipped. A seventh,
  **A walk-created event**, came through the **Add Club Event** modal. Each
  create fired `events/event_worksheet`, so every one of them carries a real
  `worksheet_file_id` — which is what the attachment-chip preview line needs.
  **Invisible cities, visible maps is left `cancelled`** for the gate lines; the
  backdrop's own *Kickoff: spice and sand* is still `completed`, which is the
  record with no transition out of it.
- **`loans` — seven created, and the statuses spread across the board.** The
  backdrop seeds one. Six more went in through `/keystone/mutate` into
  `requested`, and an eighth through the **Add Loan** modal. The walk then moved
  them: three are `returned` (through the set transition modal, and they carry
  **`return_condition` NULL** — that is #1328's evidence rather than a slip),
  one is `overdue`, and the rest are `active` or `requested`. One loan is
  deliberately left with `due_on = 2027-06-01`, well past the sixty-day rule, so
  the next reader has a record that refuses a drag into **On loan**.
- **`board_rank` is no longer null on the loans the board moved.** It was null
  on every record at the start — which is how the board's own known-crash entry
  was confirmed as no longer reproducing — and the drags wrote LexoRanks onto
  the cards they carried.
- **One SQL write: none.** Everything above went through `/keystone/mutate` or
  the UI, as the seeding policy asks.
- **A repair worth knowing about.** `borrowed_on` on a loan was typed at and the
  strip reported success; the database did not move. That is #1318 rather than
  a lost value, and nothing needed putting back.

### What session 04 left behind

This session booted its own ephemeral cluster too, so sessions 01–03's seeding is
gone. What follows is this session's own, kept so a later reading knows which
rows are the backdrop's and which are a walk's.

- **`members` — five created, one left suspended.** The backdrop seeds two, which
  is fewer than the [[Selection]] lines need, so four more went in through
  `/keystone/mutate` — Pat Patron, Liam Librarian, Cleo Circulation and **Ada
  Admin**, each paired to the `users` row of the same name. Ada's is the one the
  `suspend_member` `hide` predicate needs: it is *the acting user's own
  membership row*, and ticking it is what takes **Suspend this member** out of a
  selection's menu. A sixth, **Nora Newcomer**, was created through the
  **Add Member** wizard as that line asks. **Cleo Circulation is left
  `suspended`**, moved there through the [[Status Column]]'s own transition menu:
  it is the record the gate lines need, and the one a later reader will find with
  a different band.
- Phones, staff notes and tiers were edited, batch-edited, undone and restored
  throughout and were checked row by row at the end. Two repairs went through
  `/keystone/mutate`: Ada Admin's tier after the enum-pick line, and Pat Patron's
  `private_note`, which this harness's own `Space` keypress typed two spaces into
  — the app trimmed them to empty, which is the *repair* clause of the
  required-field line working rather than a lost value.
- **`users` — three created.** Two went in through `/keystone/mutate` — **Nora
  Newcomer** (`active`, so the onboarding wizard had a free account to pair) and
  **Ivy Invitee** (`invited`, for the status filter and the gate lines) — and a
  third, **Iris Ingram**, through the **Invite user** workflow modal as that line
  asks. Iris is the only row in the table with a real `invitation_sent_at`, which
  is what the date-filter line and #1326's *Invalid DateTime* both needed.
- **One SQL write, flagged per the seeding policy.** `password_reset_sends` is
  `editable: false`, so the API deliberately cannot set it and every seeded user
  held 0 — which makes the numeric-sort line undecidable. Alice Reader, Pat
  Patron and Bob Bookworm were given 3, 2 and 1 directly in the database.
- **`reviews` — six created, one left hidden.** The backdrop seeds one, so five
  more went in through `/keystone/mutate`, spread over four books and five
  members, with markdown bodies carrying bold, a blockquote and a bullet list for
  the [[Cell Preview]] and cards lines, one body long enough to be clipped, and
  tags on four of them. A seventh, **Better on a second read**, came through the
  **Add Review** modal. **Not for me is left `hidden`**, moved there through the
  [[Status Column]]'s transition menu: it is the record that proves #1317 on this
  listing, and the one the seeded `status: published` default filter hides.
- Headlines, ratings and `recommended` were edited, batch-edited and undone
  throughout; *Two worlds, one argument*'s `recommended` was put back through
  `/keystone/mutate` after the batch line. Every table's **Customize columns**
  layout was hidden, resized and reordered while walking those lines and put back
  with **Revert to defaults**; all three are at their defaults now.
- **Two harness notes paid for in this session.**
  - **`useMediaQuery` listens to the window's `resize` event, not the
    `MediaQueryList`'s own `change`.** A `WebDriver:SetWindowRect` alone did not
    move the [[Command Strip]] to its phone arrangement; a synthetic
    `window.dispatchEvent(new Event("resize"))` did, and so did booting at the
    width. `nav()`'s hover patch already dispatches one — judge a responsive
    clause *after* a navigation, or say the window was resized and nothing
    re-rendered.
  - **A hover-*revealed* control cannot be judged through this harness at all.**
    The row pencil, the row ellipsis and a card's action slot are all in the DOM
    at rest, at `opacity: 1`, with the same rect they have under the pointer: the
    reveal is a CSS rule inside `@media (hover: hover)`, which stays inert
    headlessly however the JS media queries are patched. Every "appears on hover
    / the title gives up width for it" clause in this run is marked unreachable
    rather than ticked.


### What session 05 left behind

This session booted its own ephemeral cluster too, so sessions 01–04's seeding is
gone. What follows is this session's own.

- **`books` — five created under Frank Herbert, one left archived.** The backdrop
  gives him two, which is fewer than the [[Selection]] and gate lines need on
  `author_page`'s Books tab, so Children of Dune, God Emperor of Dune, The Dosadi
  Experiment, Whipping Star and The Green Brain went in through `/keystone/mutate`
  with a summary, an ISBN, a genre, a page count, a price and a publication date
  each — Children of Dune's summary deliberately long enough to be clipped for the
  [[Cell Preview]] line. Seven books under him now: four `published`, two `draft`
  and **Whipping Star left `archived`**, which is the record the gate line needs.
- **The three summaries the walk's own set transition stamped were repaired.**
  Moving three published books to `archived` and undoing it restores the *status*
  but not what `stamp_summary_on_archive` wrote on the way — that workflow is
  doing its job rather than losing a value — so Children of Dune's, God Emperor's
  and The Dosadi's summaries went back through `/keystone/mutate`. God Emperor's
  `page_count` went back the same way after the `min: 1` clamp test wrote 1 over
  423. Whipping Star's stamped summary is left as it is: it is genuinely archived.
- **`reviews` — five created on Dune, one left hidden.** The backdrop seeds one,
  which is fewer than the set lines need, so five more went in through
  `/keystone/mutate` across Alice Reader and Bob Bookworm, with markdown bodies
  carrying bold, a blockquote and a bullet list for the [[Cell Preview]] line, one
  body long enough to be clipped, and tags on five of them. **Not for me is left
  `hidden`**, moved there through the [[Status Column]]'s own transition menu.
- **Frank Herbert carries a Bio** — *Science fiction novelist.* — typed through
  `edit_author` from his record page for the edit-modal line; the backdrop leaves
  it empty. His status is back at `active` after the [[Command Strip]] walk moved
  it to `retired` and back.
- **One SQL write, flagged per the seeding policy.** `librarian@example.com`'s
  `librarian_role` was revoked and re-granted twice — once to produce a real
  `Not allowed` refusal in the strip, once for the refused-inline-save arm — which
  the `users` API deliberately will not do to a role column. Both re-grants are
  confirmed.
- **The Books tab's Status column is left 200px wide** rather than its 140
  default, from the line that proves a record page's table tab keeps a layout of
  its own. It is a per-user preference rather than data, and **Customize columns
  → Revert to defaults** puts it back.

#### Three harness facts paid for in this session

- **The hover patch must be injected into the page, not run in the sandbox.**
  This is the one that voids a walk. `WebDriver:ExecuteScript` runs against an
  Xray wrapper, so `Object.defineProperty(MediaQueryList.prototype, "matches", …)`
  patches the *sandbox's* prototype: `matchMedia("(hover: hover)").matches` then
  reads `true` from the script and the page's own React still sees `false`, mounts
  the table's touch arrangement, and every click-model line silently tests a
  phone. Append the patch as a `<script>` element instead —
  `const el = document.createElement("script"); el.textContent = "<the patch>";
  document.documentElement.appendChild(el); el.remove();` — and read the flag back
  the same way. The skill's own check
  (`document.querySelectorAll("button[class*=clickable]").length`) is **vacuous on
  this build**: no element anywhere carries a `clickable` class, so it answers 0
  either way. Use instead: click a cell once and assert the row ticks
  (`__checked()` non-empty). Under the sandbox-only patch it does not.
- **Select the row by its checkbox, not by clicking its identity cell.** A script
  that "clicks the identity cell to select the row" opens the record page the
  moment that row is already selected, and the next step then fails somewhere
  unrelated with a missing cell. `__cell("checkboxes", r)` is the safe handle.
- **A cell in a column off the side of the window has no hit target**, and this
  table is 2900px wide. `scrollIntoView({inline:"center"})` before measuring, and
  retry the lookup after a re-render — the table remounts under a save and a
  rect taken before it is stale.

### What session 06 left behind

This session booted its own ephemeral cluster too, so sessions 01–05's seeding is gone. What
follows is this session's own, kept so a later reading knows which rows are the backdrop's and
which are a walk's.

- **`events` — eleven created under Dune Readers, and the statuses spread deliberately.** The
  backdrop seeds one (*Kickoff: spice and sand*, `completed`), which is fewer than the
  [[Selection]], gate, batch and keyboard lines need. Eleven more went in through
  `/keystone/mutate` with a title, a `starts_at`, a capacity and a `venue` each — the venue
  being the shared `address` ref-schema, not a free object — and one title deliberately too long
  for its column. Twelve now: three left `scheduled` (the rows the editable lines need), four
  `cancelled` and five `completed`. Four of those moves are the walk's own through the
  [[Status Column]]'s menu, three of them as **one set transition**, which is what the
  one-write-one-entry and lock lines needed.
- **`clubs` — two created.** *The Extremely Long-Winded Society…*, whose name exists to be cut
  by the header's fixed 180px title column (#1344), and *Hybrid Hall*, one of the
  `meeting_format` variants the backdrop does not cover. **Dune Readers' description carries
  " Walked by stage 06."**, typed through `edit_club` for the edit-modal line; its status went
  `active` → `archived` → `active` through the status button and is back where it started.
- **`loans` — six created against Alice Reader, and the statuses spread.** The backdrop seeds
  one. Three are left `returned` — moved there as a set through the transition modal, and they
  carry **`return_condition` NULL**, which is #1328's evidence rather than a slip — and three
  `requested`, whose `renewals` read 1, 2 and 4 after the batch-and-undo line.
- **`members` — none created; `Bob Bookworm` is left `suspended`.** He was moved there by
  running **suspend_member** from his own record page, which is the ratchet this session owed
  the notes. Alice Reader's phone gained a "9" from the `edit_member` line.
- **`reviews` — two created on Dune under Alice Reader**, with markdown bodies carrying bold, a
  blockquote and a bullet list, tags, and one headline long enough for the header to cut. The
  sample's `recommended` was toggled and put back; its headline was repaired through
  `/keystone/mutate` three times after #1349's **Discard** wrote a draft into it, and reads its
  seeded value now. Its status went `published` → `hidden` → `published` through the status
  button.
- **One SQL write, flagged per the seeding policy.** `librarian@example.com`'s
  `librarian_role` was revoked and re-granted to produce a real `Not allowed` refusal in the
  strip under an open cell — the `users` API deliberately will not do that to a role column.
  The re-grant is confirmed.
- Every table's **Customize columns** layout was hidden and reordered while walking those lines
  and put back with **Revert to defaults**; all of them are at their defaults now.

#### Three harness facts paid for in this session

- **The transition menu, the row menu and the [[Command Strip]]'s stack are not `[role=menu]`.**
  They are `_list_i7oz6_1` and `_dropdown_1w7tx_6`, and a generic "largest floating menu" finder
  picks the **sidebar** instead — which reads as "the menu did not open" on a menu that did. Find
  the innermost absolutely-positioned box carrying buttons, or match those class stems.
- **A cell's second click needs the first one's re-render to land.** Two clicks 600ms apart on a
  status cell selected the row and then did nothing; the same pair 1.2s apart opened the
  transition menu. A "three clicks were needed" finding is this, not the app.
- **Judge a responsive clause after a *navigation* at the width.** `SetWindowRect` plus a
  synthetic `resize` moved the tab row to its phone arrangement but left the record-action
  cluster in its wide one, so the fold reads as broken. Session 04's note, confirmed again:
  `m.rect(520, 900)` **then** `nav(...)`.
### What session 07 left behind

This session booted its own ephemeral cluster too, so sessions 01–06's seeding is gone. It walked
the eight tail sections and the journeys, which touch every model, so what follows is the whole of
its own.

- **`books` — three created, two left `published` that the backdrop has as `draft`.** *Dashboard
  Walk Book* went in through the dashboard's **Add a book** and was **deleted again** by the Undo
  section's delete-locks-the-stack line, which needs a `draft` the `delete` permission reaches.
  *Date Precision Book* (the `published_on` precision line) is left **archived** after nine
  `published` ⇄ `archived` pairs built the nineteen-row history the scrolling journey needs; its
  cover was uploaded and removed again for the cover journey, so `cover_image_id` is NULL.
  **Dune Messiah** and *Date Precision Book* were both moved `draft` → `published` for the Undo
  section's lock line, and `books` declares no way back.
- **Summaries were edited and put back.** Dune's, A Wizard of Earthsea's and The Dispossessed's
  went through `/keystone/mutate` at the end and read their backdrop values (The Dispossessed's
  being NULL). A Wizard of Earthsea's needed it twice: archiving it for the undoable-transition
  line let `stamp_summary_on_archive` write over it, and undoing the status does not undo that.
- **`events` — one created and left `cancelled`.** *Date Precision Event* under Dune Readers,
  capacity 20, `starts_at` 2027-03-01 19:45:30 — the row #1365 is measured on. Creating it fired
  `events/event_worksheet`, so it carries the four-page PDF the Documents section walks; its
  `scheduled` → `cancelled` is the Undo section's `events` lock, and no `events` move has a
  reverse.
- **`loans` — three created, one left `active`.** Alice + Dune due 2026-12-01 (the dashboard's
  **Check out a book**), Bob + Dune due 2027-01-01 (the `due_on` precision line), and Wanda + A
  Wizard of Earthsea due 2026-10-20, which is the one inside the sixty-day term and so the one the
  Undo section could actually move to `active`.
- **`members` — two created.** *Nora Newcomer* (paired to `patron@example.com`, a phone and no
  loans) and *Ada Admin* (paired to the admin account), both through `/keystone/mutate` because
  the launcher journey needs a member who has never borrowed and one that is the acting user's
  own row. **Bob Bookworm is left `suspended`**, moved there by running `suspend_member` from his
  record page. Alice Reader's phone was changed and put back; it reads its backdrop value.
- **`reviews` — one created, one edited and restored.** *A quiet classic* on A Wizard of Earthsea,
  created to prove the handed-over book filter is dropped (#1350). *A desert masterpiece*'s
  headline went through four in-place edits, a refused save and two draft restores and was put
  back through `/keystone/mutate`; its body is NULL, as seeded.
- **`custom_dashboards` — one left, `Walk Primary`, and it is the admin's primary**, so `/` serves
  it rather than the template. *Walk Copy* → *Walk Renamed* was cloned, renamed, made primary,
  pinned into twice and then **deleted** by the Edit-details line, which is what took its two pins
  with it. `Walk Primary` carries the default's two sections unchanged.
- **`credentials` — cleared.** `anthropic_api` was set to a placeholder to walk the Set/Update
  line and the row was removed again afterwards, so the table is empty and the pass's
  `credential_missing` baseline is intact. No real key was ever entered.
- **Two accounts created through the sign-up wizard**, as the Onboarding section needs:
  `wanda@example.com`, who finished the gate and has a `members` row, is the account that shows
  #1351 on its first landing.
- **Two SQL writes, flagged per the seeding policy.** `admin@example.com`'s `admin_role` was
  revoked and re-granted to produce a real `Not allowed` refusal under an open in-place editor,
  and `sessions.authenticated_at` was moved back and forth for the step-up journey. Both are
  restored: the role is granted and every session row reads the current UTC time.

#### Four harness facts paid for in this session

- **Backdate a session against UTC, not against `now()`.** `sessions.authenticated_at` is
  `timestamp without time zone` holding UTC, so `now() - interval '2 hours'` in a psql session on
  `Australia/Melbourne` writes a stamp eight hours in the *future* of UTC and the session reads as
  freshly authenticated. `(now() at time zone 'UTC') - interval '2 hours'` is the form that works.
  The first pass at the step-up journey read as "the requirement is not enforced" because of it.
- **The nav's secondary rail needs a window wider than about 1080px.** Below that the section's
  own pages are not in the nav at all (#1368), so a walk that moves between listings by clicking —
  which is the only way to keep the [[Command Strip]]'s history, since `WebDriver:Navigate` empties
  it — has to run at 1400×900. A resize alone does not bring the rail back; the *navigation* after
  it does.
- **An in-place editor commits on a real focus change, not on `element.blur()`.** A scripted blur
  closes the editor and leaves a draft, which then comes back as *Restored from your last visit* on
  the next load. `clickAt` on a neutral part of the page is what commits it.
- **`/keystone/mutate` wants `id` *and* `record_id` on an update, and `status` on a create.** Each
  missing one is reported on its own, so the shape takes three round trips to discover:
  `{mutations:[{kind:"update", model_name, id, record_id, properties}]}` and
  `{mutations:[{kind:"create", model_name, id, status, properties}]}`. `kind: "transition"` takes
  the same pair plus the target `status`, which is how nineteen lifecycle rows were built in
  seconds.


---

**Roles**: admin, circulation, conversation_reader, dashboard_owner, librarian, member, patron, preference_owner, self. Switch with the Dev Mode Header's User Switch (`POST /api/__dev/switch-user`, dev server only).

**Standing checks on every step** — console clean; page actually rendered (not blank/half-rendered); no failure in the [[Command Strip]] the step didn't earn — the strip holds the last command until the next one replaces it, so a warning there the step didn't cause is a finding, and so is a save that leaves the strip saying nothing; no literal un-interpolated `{.field}` text in the DOM.

**Submit policy** — fill forms with values valid per the model's spec (itemsets give legal options); verify the write *landed* (record visible in the UI, row correct in the DB). One deliberately-invalid submit per form must produce a clean validation error — not a 500, not a silent no-op. Workflow side-effects of writes are Rehearsal territory, not this pass — run WITHOUT LLM credentials and treat `credential_missing` workflow noise as expected.

**Seeding policy** — when the backdrop lacks a record a step needs, create it through the API (`/keystone/mutate`) or the UI itself, never raw SQL (SQL bypasses permission filtering, defaults, and triggers, and can forge states the app can never reach). SQL only for states the API deliberately cannot produce, flagged in the run notes.

**Static surfaces** (not derivable from config): the login screen (valid and invalid credentials), the Dev Mode Header itself, and the 404 route.

**Role visibility** — every page below lists who may see it. Check both directions: listed roles reach it; unlisted roles don't see it in the nav *and* are refused on direct navigation.

Known noise and journeys live in `DRESS-REHEARSAL-NOTES.md` — read it before starting; ratchet it as you go.

## Static surfaces
- [x] login screen: valid credentials sign in; invalid credentials get a clean error (not a 500, not a silent reload)
      ✓ Valid: `admin@example.com` / `password` through the form itself signs in and lands on `/`.
      ✓ Invalid: the same address with a wrong password stays on `/sign_in` and reads **Incorrect password** —
        no 500, no silent reload, console clean.
      ⚠ Worth a second pair of eyes: `/` renders the **Dashboard** (Default Dashboard, Customize, the Catalogue
        and Circulation sections). `DRESS-REHEARSAL-NOTES.md` pins "the Dashboard has no route serving it
        anywhere … `/` falls back to the first nav page instead" as an open bug, and that no longer reproduces.
        Left for the Dashboard section (session 07) to judge and to ratchet the notes file with, rather than
        edited here on one sighting.
- [x] Dev Mode Header renders and its User Switch actually switches the acting user
      ✓ The header renders (Keystone Dev Mode · modern-project · User · Reset DB · Mail · Open Studio).
      ✓ The User Switch lists the six seeded accounts; picking **Liam Librarian** moves the acting user —
        `GET /session.json` answers `librarian@example.com` with roles `[self, librarian]`, and the header
        relabels itself. Switched back and forth repeatedly through the run.
- [x] a nonsense URL renders the 404 route, not a blank page or crash
      ✓ `/this/route/does/not/exist-xyz` renders **Page not found** with its own copy and a *Go to home*
        link. Not blank, no crash, console clean.
      ✓ The route draws no [[Command Strip]], which the notes file already records as expected — nothing in
        the plan covers a 404's strip, because the lines are per routed page.
- [x] a layout follows the person, not the browser: on any listing page below, hide a column, reorder another and drag a column's width, then sign in as the same user in a fresh browser profile and find all three still there — and as a *different* user in that same profile, and find that page at its defaults
      ✓ On `books_listing` as admin: **Genre** hidden and **Isbn** dragged to the head of the visible list
        through *Customize columns*, then **Status** dragged from 140px to 260px in the header itself
        (the width reflows live under the pointer and does not jump on release).
      ✓ Same user, a **fresh Firefox profile** on its own Marionette port: all three are there — Isbn first,
        Status 260px, no Genre column.
      ✓ A **different** user (librarian) in that same fresh profile gets the page at its defaults — Status
        first at 140px, Genre back. So the layout follows the person rather than the browser.
      The two clauses the notes file says have nothing to walk in this config were not walked, per that entry.
      Reverted to defaults afterwards, so sessions 02+ open on a clean table.
- [x] sign-up wizard (`/sign_up`, linked from the login screen): the form refuses a bad address, a short password and an address that already has an account, each with a clean error; a good submission advances to the code step; going back keeps the answers already typed
      ✓ **Create account** on the sign-in screen is a real `<a href="/sign_up">` and lands on the form.
      ✓ A bad address, a short password and an address that already has an account are each refused cleanly —
        the form stays put, no 500, no silent reload:
          · `not-an-email` → "A name and an email address are needed to create an account."
          · `abc` as the password → "A password must be at least 6 characters long."
          · `admin@example.com` → "An account already exists for admin@example.com. Sign in instead, or reset the password."
      ✓ A good submission advances to the code step ("Confirm your email", "A 6-digit code was sent to …").
      ✓ **Change details & resend** goes back with all four answers still typed in.
      ⚠ **#1308** — the first of those three messages is a catch-all: a malformed address, an empty address
        and an empty name all read "A name and an email address are needed to create an account.", so the
        person who typed a typo'd address is told a name is needed with both name fields visibly filled.
        The line still passes — the refusal *is* clean — so the box is ticked and the message is an issue.
- [x] sign-up code step: the code from the Dev Mail Store (`/api/__dev/emails`) finishes the signup and lands **signed in** — on the `return_to` page if `/sign_up?return_to=…` was where it started, and on `/` otherwise; a wrong code errors without leaving the step
      ✓ The code from `GET /api/__dev/emails` finishes the signup and lands **signed in** —
        `GET /session.json` answers the new address with roles `[self]`, and the user row is correct.
      ✓ A wrong code reads "That code is incorrect." and does not leave the step.
      ✓ `/sign_up?return_to=/library/authors` carries the destination through: the finish lands on
        `/onboarding?return_to=%2Flibrary%2Fauthors`, against a plain `/sign_up`'s `/onboarding`.
        Neither lands on the page named, because the [[Onboarding Gate]] holds a user with a process
        assigned and redirects every other route back to it — which is the plan's own account of the gate,
        not a failure of this line. Whether the gate then *releases* to the `return_to` page is the
        Onboarding section's (session 07); both accounts are left sitting at the gate for it.
      Note: resubmitting the form inside the resend window keeps you on the create-account step with
      "A code was sent … less than a minute ago" rather than returning to the code step. Deliberate-looking
      rate limiting; not filed.
- [x] the Turnstile widget renders on the sign-up form (ADR-0082) — Dev Mode still bypasses verification, so what is under test is that the widget appears and the form submits, not that a token is checked
      ✓ The widget renders on the form — the Cloudflare box with its **Success!** tick, 322×72, and the
        hidden `cf-turnstile-response` holding the dummy token the test sitekey issues. The form submits,
        which is what the line asks; no token is checked, which is Dev Mode.
      Harness note for later sessions: the widget mounts inside a **shadow root**, so a DOM sweep for an
      `iframe` finds nothing and reads as the widget never having rendered. A screenshot shows it plainly.
      (Now written into the runner skill's traps.)

## Page: author_page  (`/library/authors/:id/:tab?`)
- [ ] renders as each of: admin, librarian, patron — and is absent from the nav *and* refused on direct navigation for every other role
      ✓ Renders as admin, librarian and patron, each with the record's real values; `hidden: true`
      keeps it out of the sidebar under all three.
      ● known — no route-level refusal. As `circulation` (a role `route.roles` does not name) a direct
      navigation is not redirected or refused: the page mounts, the sidebar keeps only its section
      heading and the content area comes up empty. That is the standing known issue about direct
      navigation, confirmed rather than re-filed.
- [x] `hidden: true` — confirm it is absent from the sidebar nav but reachable by URL
      ✓ The sidebar holds Books, Authors and My reading desk — `author_page` is not among them under any
      reader — and `/library/authors/<id>/profile` opens it directly.
- [x] the page heads with one two-row header: the title reads at the left of the upper row — the record's own name (its identity, not anything config names) — with the back arrow ahead of it, the page's 3 tabs beside it (Profile `profile`, Books `books`, History `history`) — the active one carrying the lower row's own background and sitting over its top border, so the two rows read as one object rather than as two cards with a gap between them. The [[Command Strip]] holds the right-hand end of that row and nothing else does; what it says there is the next line's. The bar directly beneath holds everything the header held before, each item where it was. Narrow the window until the title no longer fits and it ellipsises, resting a tooltip carrying the whole of it — a title that fits rests nothing
      ✓ Two rows and one object: the upper row (`_wrapper_1n1vi_`, y 68 h 36) carries the back arrow at
      x 322, the title *Frank Herbert* at 350 — the record's identity, not `authors`' display name — the
      3 tabs from 542, and nothing else; the [[Command Strip]] holds its right-hand end at 1342. The
      active tab is 37px against the others' 36 and carries the lower row's own background, so it sits
      over that row's top border with no gap.
      ✓ The bar directly beneath (`_header_131jw_ _headerAttached_`, y 104 h 52) holds the tab's title at
      the left and the record-action cluster at the right.
      — unreachable: the title *Frank Herbert* is 115px and never clipped down to the 520px Firefox will
      report, so the ellipsis-and-tooltip clause has nothing to cut; what the line does ask and this run
      can judge — a title that fits rests nothing — holds (`title` attribute empty at every width).
- [x] the [[Command Strip]] is the only place a command's status is shown, and this page's header carries it: before any command has run it is its caret alone, greyed and opening nothing. Run one — a save made here, or one made on another page and then walked back to through the nav rather than reloaded, the history being the session's rather than the page's — and a spinner shows while it is in flight, for as long as it runs, then a tick and the command's own name — and ten seconds later the tick and the name fade away over a moment and the strip is its caret alone, the history still under it. Count it out: a success still there half a minute on is a finding, and so is one gone the moment it landed. Open the caret before the ten seconds are up and the name is held there until you close it again. A refusal reads the same way with a warning and a category after a dash — one of "Not allowed", "Invalid input", "Not found", "Server error" and "Offline" — its own sentence under the caret, and joins no history — and it does not fade: a refusal is still there a minute later, until the next command replaces it, which is the difference to watch for. The category is the server's own word for what it refused rather than a reading of the sentence it sent (ADR-0099), so a failure nothing named a kind for reads "Failed", which is the honest answer rather than something to report. What is a finding is a category naming the wrong kind — a save the policies refused reading anything but "Not allowed", a server stopped mid-session reading anything but "Offline" — and so is a headline carrying the whole sentence where those two or three words belong, the sentence being the dropdown's. Open the caret and the stack is there, newest first: an entry that can be taken back wears an undo icon, and clicking the icon on the *n*th of them moves the stack past all *n* in one call, the headline then naming the direction — "Undo" and the command's own name. An entry whose command declared no undo wears a lock instead, and every entry older than it loses its icon behind that lock — so an entry under a lock drawing no icon is that lock's doing rather than a fault. Which of this app's saves lock and which take themselves back is the Undo section's, at the foot of this plan: a stack with no undo icon anywhere in it is a finding rather than a reading. Ctrl+Z reaches the same undo a step at a time and Ctrl+Shift+Z puts it back, each saying nothing beyond what the headline says, and each standing down — headline unmoved — while the keyboard is in a text field or a modal is open. At a phone width the strip is the icon and the caret alone, the command's name being read in the dropdown instead
      ✓ Caret alone, `disabled`, 32px wide, before anything runs.
      ✓ A transition run from the status button reads **Change status** with a success-coloured tick, and
        the tick and name fade **between 8.1s and 10.6s**, counted out over a 35s sample; the caret stays
        live with the history under it. Nothing was still there half a minute on.
      ✓ Opened before the ten seconds were up, the name is held: still **Change status** at +12s with the
        caret `aria-expanded="true"`.
      ✓ The stack opens newest-first, its entry wearing an undo icon (`aria-label="Undo Change status"`);
        clicking it put the author back to `active` and the headline read **Undo Change status**.
      ✓ `Ctrl+Z` at the bottom of the stack moved nothing and said nothing — headline unmoved — and
        `Ctrl+Shift+Z` redid it, reading **Redo Change status** with the record back in `retired`.
      ✓ **Change status — Not allowed** on a policy refusal (the librarian's role revoked with the
        transition menu already open): the server's own sentence under the caret — "Not permitted to
        transition 'authors' record … from 'active' to 'retired'" — *no* history entry under it, and
        still there **45s** later where a success had gone by 11s. That contrast is the line's own.
      ✓ At 600px the strip is the caret alone in its own `_strip_1n1vi_` slot of the upper row.
- [x] the tab row gives way: drag the window narrower and the 3 tabs give up width evenly, each label ellipsising and resting a tooltip carrying the whole of it only where it is actually cut — a label still showing in full rests nothing. Past a 30px floor per tab the row stops shrinking and becomes one menu button carrying the *active* tab's own label and a caret — "Profile" on arrival — and opening it lists all 3, every one of them still reaching its tab. At a phone width the row is that menu button whatever the window could have fitted. Widen back and the tabs come again with the same tab active
      ✓ At 700px and below the row is one menu button carrying the *active* tab's own label and a caret —
        "Profile" on arrival — and opening it lists all 3, each reaching its tab: picking **Books** landed
        on `/library/authors/<id>/books` and the button then read "Books".
      ✓ Widened back to 1400px the three tabs come again with the same tab active.
      — unreachable: the even-give-up-width half. Three labels at 83/103/87px never compete for room
        above the ~500px floor Firefox will report an `innerWidth` for — they are unchanged at 1400, 1000
        and 820 and then the row is the menu button — so no label is ever cut and none rests a tooltip.
- [x] pick/create a sample `authors` record for the steps below (backdrop first, API if the backdrop lacks one)
      ✓ Frank Herbert (backdrop), `fa737dc0-…`, seven books under him after this session's seeding.
- [x] this page draws no [[Panel]] at all: no docked root panel — not the `authors` item-details panel a `parent_page` used to make one, not a `panel_name` and not a blocks tab's `root_panel_override` — no tab rail down the right edge to open one from, and the content running out into the 45px the rail used to reserve; no click on a table tab's row opens an item-details panel, there are no per-model **Select** entries anywhere to open one from, and the mobile header carries no panel button. Append `?panel=<a `authors` record id>` to this page's URL, on any tab, and it opens nothing at all
      ✓ The content area is `_content_f51ul_ _contentWithNoPanel_`, 296→1400 at a 1400px window: no rail
        reserved down the right edge and no docked panel under any of the three ways one used to be asked
        for — `parent_page`'s item-details panel, a `panel_name`, a blocks tab's `root_panel_override`.
      ✓ `?panel=<a authors record id>` appended on **each** of the three tabs — `profile`, `books`,
        `history` — opens nothing at all: no panel element, the content class unchanged, and the parameter
        simply ignored.
      ✓ No per-model **Select** entry anywhere, and no panel button in the header at a phone width (the
        600px header holds the back arrow, the title, the tab menu and the strip, and nothing else).
- [x] `parent_page` `authors_listing`: a back arrow sits ahead of the page title and lands on that listing — from a record opened out of the listing *and* from one deep-linked or reloaded, where there is no history to go back through — and is absent for a reader `authors_listing`'s own `route.roles` do not permit
      ✓ `<a aria-label="Back to Authors" href="/library/authors">` ahead of the title at x 322, from a
        record opened out of the listing **and** from one reached by pasting the URL into the browser with
        no history behind it — the target is computed from the listing's route rather than taken from
        history.
      — unreachable: `authors_listing`'s `route.roles` are the same three `author_page` declares, so no
        reader of this page is refused that listing and the absent-arrow clause has nobody to walk it as.
- [x] listing state round trip: filter, sort and switch view on `authors_listing`, open a record, move between its tabs, then take the back arrow — the listing is the one that was left rather than its defaults, including the case where every filter was cleared
      ✓ Filtered the listing from a row menu's **Filter by Nationality** (`?filter_nationality=s~american`)
        and opened Frank Herbert from his identity cell: the record URL wears the state under `ref_` names
        (`?ref_filter_nationality=s~american`) and nothing under the bare ones. The `ref_` parameter
        survived Books, History and back to Profile, and the back arrow landed on
        `/library/authors?filter_nationality=s~american` with the two rows and **Filters 1** still on the
        button.
      — `authors_listing` declares one view and no `default_filters`, so there is no view to switch and
        "every filter cleared" is its default state; the interesting arm of both is `reviews_listing`'s,
        walked in session 04 (#1334).
- [x] record page actions in tab `profile`: the record's own actions sit at the right-hand end of *that tab's* header — not the page header carrying the back arrow, the title and the tab strip — and no other tab of this page carries them. They are `authors_listing`'s `record_actions` rather than anything declared here, so they are the same list, the same wording and the same gates as a row of that listing offers. **Edit** follows the status button at the head of it as a primary button carrying its icon *and* its text, labelled just "Edit" where the row menu's item names the model, and opens `edit_author` on the record the page is showing — a save landing back on the page under it. A reader whose permissions refuse that update keeps the button, greyed and carrying the menu's own reason: a cluster that loses a button under one reader says nothing about why
      ✓ The cluster sits in `_headerRight_` of the **tab's** header bar (y 112), not the page header above
        it carrying the back arrow, the title and the tabs; the Books and History tabs carry none.
      ✓ It is `authors_listing`'s `record_actions` — the same list, wording and gates as a row of that
        listing offers: status button, **Edit**, **View Lifecycle**, **Related**, **More**.
      ✓ **Edit** follows the status button as a primary button carrying its icon *and* the text "Edit" —
        the row menu's item names the model (*Edit Author*), this one does not — opens `edit_author` on
        the record the page is showing (`?edit=authors:<id>`, the form seeded with Frank Herbert), and a
        save lands back on the page under it with the new Bio in the properties block and in the database.
      ✓ As a patron the button stays, `disabled`, carrying the menu's own reason on itself:
        `aria-description="Requires policy: Admin"`.
- [x] tab `profile`: the **status button** leads the cluster, left of Edit: one button wearing the record's current `authors` status as a disc in its icon slot and that status's own label beside it in full — the cluster's other icon buttons carry their wording in a tooltip, and a status nobody can read is no status. Click it and the transition menu opens under it, the same menu a [[Status Column]] cell's second click opens: an item per status the spec declares, the current one ticked and inert, each of the others the transition to it, refused with its own reason where this reader may not make it and opening the transition modal first where it has properties to collect — and the status the walk lands on is in the record's lifecycle history afterwards. A reader permitted no transition at all keeps the button, naming the status and **disabled** under the same reason rather than going missing. It stands in **both** layouts, and on this project it is the only *button* the status is offered from: there is no item-details panel carrying a badge, and a `properties` block's status pill is a reading rather than a way to move it
      ✓ One button at the head of the cluster wearing the record's `active` status as a disc
        (`data-status-disc`, `--label--gray-bg`) in its icon slot with the label **Active** beside it in
        full, where the cluster's other icon buttons carry their wording in a tooltip only.
      ✓ Clicking it opens the transition menu under it, headed **Active** and holding an item per status
        the spec declares: **Active** (the current one, wearing the tick in its right-icon slot) and
        **Retired**. Clicking the current one closes the menu and runs nothing — the strip stays empty and
        disabled — and taking **Retired** moved the record, with the move in the History tab afterwards.
      ✓ As a patron, who is permitted no transition at all, the button is still there naming the status
        and `disabled` with `aria-description="Unauthorized"` rather than going missing.
      ✓ It is the only *button* the status is offered from on this page: no item-details panel with a
        badge, and the `properties` block's Status row is a pill that reads rather than moves.
- [x] tab `profile`: **View Lifecycle** follows it as an icon button — one glyph, no text, and the tooltip is the only thing naming it — and it switches to the page's own `history` tab rather than opening the modal the row menu opens over a listing, this reader being already on the record's page. A history read this reader may not make keeps its refusal and switches nothing. It is the row menu's own action otherwise: same icon, same wording, and absent here wherever the menu drops it
      ✓ An icon-only control between Edit and Related — one glyph, no text, `aria-label="View Lifecycle"`
        — and it is an `<a href="/library/authors/<id>/history">`, so it switches to the page's own
        `history` tab rather than opening the row menu's modal.
      ✓ Absent for a patron, exactly where `authors_listing`'s row menu drops it: the `catalogue` policy
        grants no `lifecycle`, so neither the menu item nor this button is drawn (session 02 found the
        same narrowing on the listing).
      — unreachable: the tooltip that names it. `_tooltip_` is on the wrapper and the reveal is a CSS rule
        inside `@media (hover: hover)`, which stays inert headlessly; `aria-label` carries the wording.
- [x] tab `profile`: **Related** closes the buttons as a dropdown — the `circle-nodes` glyph with the word beside it and a caret, the row menu's **Related links** submenu under a heading short enough for a button — and holds this record's related links (every relation the spec declares) in the sections, the order and the nesting that submenu holds them in, landing on the same listings. It is absent altogether rather than opening on nothing for a reader whose nav roles reach none of the targets
      ✓ A dropdown carrying the `circle-nodes` glyph — its path matches `circleNodesRegularIcon` exactly —
        the word **Related** beside it and a caret, opening a list headed **Related** and holding this
        record's one relation, **Books**, as `/library/books?filter_author_id=s~<id>`: the same link, the
        same heading and the same landing as the row menu's **Related links** submenu.
        `authors` declares exactly one relation, so there is one item and no nesting to check.
      ✓ It is drawn for a patron too, whose nav roles reach `books_listing`.
- [x] tab `profile`: the **More** ellipsis ends the cluster and gathers everything with no button of its own. **Copy {Model} ID** leads it — the item the row menu gives an identity cell, which a record page has no table of its own to offer anywhere else — and then the `modals` entries, a rule between each block and the next; the commands the page header carries of its own sit under the lot. Every entry is the row menu's, relabelling and gates included, and the ellipsis is there for every reader — Copy {Model} ID is the record's rather than the block's, so it is never gathering nothing
      ✓ The ellipsis ends the cluster and opens a list headed **More** holding **Copy Author ID** and
        nothing else — which is right rather than empty: `modals: ["*"]` over `authors` resolves to
        `edit_author` alone, already offered as the Edit button, and this page's header declares no
        commands of its own. Copy {Model} ID is the record's, so the ellipsis is never gathering nothing,
        and it is drawn for every reader including the patron.
- [x] tab `profile` at a phone width: the whole cluster folds into the header's existing **Actions** menu — the status button under the status it names, then Edit, each icon button under the wording its tooltip carries, the related links and the ellipsis's own items, all entries of that one menu in the cluster's order — and no button of it is left beside the tab's title. There is no docked item-details panel beside it to be untouched — this page draws none — so that one menu is the whole of the record's actions at this width
      ✓ At 600px `_headerRight_` holds one **Actions** button and no other, and its menu is the cluster in
        the cluster's own order: **Active** (the status button under the status it names), **Edit** (drawn
        `_primary_`), **View Lifecycle** (the icon button under the wording its tooltip carries),
        **Related**, a separator, then the ellipsis's own **Copy Author ID**. No button of the cluster is
        left beside the tab's title.
      ✓ There is no docked item-details panel beside it to be untouched — this page draws none — so that
        one menu is the whole of the record's actions at this width.
- [x] tab `profile` (Profile): blocks render with the record's real values, the record's status among them as the same pill a card draws — a band of colour across the block, or down the page, is the regression this clause exists to catch
      ✓ The properties block reads Status, Name, Bio, Website, Nationality, Book Count with the record's
        own values (Frank Herbert / American / 7, and the Bio this session's edit-modal save wrote).
      ✓ The status is the same pill a card draws — a rounded chip with the status disc and the label —
        drawn in the value column of its own row. No band of colour across the block or down the page.
- [ ] tab `books` (Books): related `books` table shows only this record's rows, and a column hidden, resized, or carried to a new place by its header here stays on this tab — the listing page over `books` keeps a layout of its own
      ✓ The tab lists Frank Herbert's 7 books and no other — the `author_id in .id` filter working — and a
        column resized here stays here: dragging the Status handle took it 140 → 200 on the tab, the
        listing over `books` still drew 140, and the tab still drew 200 on return. The two surfaces keep
        their own layouts.
      ⚠ finding [#1337](https://github.com/chessworld/ElevateR/issues/1337) — but about the *declared*
        view rather than the reader's layout. The tab inherits `books_listing`'s first table view's
        `default_sort` (the next line's) and none of that same view's `columns`: its headers read **Book**
        (200) / **Author Name** (200) / **Average Rating** where the listing reads **Book title** (280) /
        **Author** (240) / **Rating**, and the **Buzz** column the view declares is absent here
        altogether. Half the view is inherited and half is not.
- [x] tab `books`: the identity column is this table's pinned first column too, naming each `books` record, and its header no more drags along the row here than it does on a listing page
      ✓ First column after the checkboxes on every row, naming each `books` record. Pinned: at
        `scrollLeft` 400 the identity cell held x=347 while Isbn moved 1487 → 1087.
      ✓ Its header carries a `Resize identity` handle and **no** `data-column-drag` surface, where every
        other header has both — so it no more drags along the row here than on a listing page.
- [ ] tab `books`: the table opens sorted by `title`, ascending — inherited from `books_listing`'s first table view, this tab declaring no `default_sort` of its own — and that column's header is the one wearing the arrow
      ✓ The order is right and it is inherited: Children of Dune … Whipping Star, and the **Sort table**
        modal opens reading *Title / Ascending* though this tab declares no `default_sort` of its own.
      ⚠ finding [#1316](https://github.com/chessworld/ElevateR/issues/1316), confirmed here as on the
        listing: no header wears the arrow, `title` being this model's `identity.title` and the
        [[Identity Column]] never drawing one. [#1311](https://github.com/chessworld/ElevateR/issues/1311)
        rides with it — no header carries a sort control at all, the sort living in the modal.
- [x] tab `books`: sort a text and a numeric column, both directions
      ✓ Isbn ascending and descending, Page Count ascending and descending, each through the **Sort
        table** modal and each writing its own `?sort=isbn_asc` / `?sort=page_count_desc` onto the tab's
        URL. Rows re-ordered correctly both ways, with the empty values sorted to the far end.
- [x] tab `books`: the status column is this table's second column too, each `books` row wearing its status as the same band — and a click on a ticked row's status cell opens the same transition menu here as on the listing page, moving the whole checked set the way it does there
      ✓ Second column on every row, each wearing its status as the same band (`_fillCell_`), and a click
        on a ticked row's status cell opens the same transition menu the listing's does — see the
        set-transition line below for the whole checked set moving as one.
- [x] tab `books`: rest the pointer on a cell whose value this column's width cuts off and about half a second later the whole of it floats beside the cell, wrapped rather than clipped and rendered the way the cell renders it rather than as a bare string; move the pointer away and the box goes, while a cell already showing all of its value floats nothing however long the pointer rests on it. On a phone, where there is no pointer to rest, a tap on that same cell floats the box at once and a tap elsewhere puts it away — and neither tap changes which row is selected
      ✓ Resting on Dune's clipped Summary cell floats the whole value about half a second later, in a
        box of its own (`_overlay_1htvx_`) wrapped rather than clipped, and moving away puts it back.
      ✓ A cell already showing all of its value floats nothing however long the pointer rests (Page
        Count).
      — unreachable: the phone tap arm. There is no touch input through this harness.
- [x] tab `books`: the `books` cells with a rich rendering to float — `cover_image_id`, whose box holds the file itself (the image card where the file is an image, the attachment chip where it is not) — float it however wide the column is, nothing needing to have been cut off, and what floats is that property's own detail rendering rather than a second one written for tables: the same rendering a record's `properties` block draws for it, so a box that differs from that block for the same record is a regression rather than a preference — and the thumbnail an image cell draws is display-only now that the preview has replaced the lightbox: clicking it makes that row the whole [[Selection]], exactly as clicking any other cell does, and opens no lightbox over the table
      ✓ `cover_image_id` floats an image card carrying the file itself — an `<img>` inside the box, with
        the file's name — at the column's own width and with nothing needing to have been cut off. The
        box is the property's detail rendering rather than a table-only one.
      — unreachable: clicking the thumbnail to prove it opens no lightbox. The cell draws the file's name
        rather than a thumbnail at this column width, so there is no thumbnail on the row to click.
- [x] tab `books`: click any cell of a row to select it, then click one of that row's cells again: the cell becomes the `books` field it edits, with the cursor in it. The first click only makes that row the whole [[Selection]] — every other row unticks and this one ticks — and opens no panel, there being none on this page; a click on a row *outside* the selection never opens a cell, and a double-click still does nothing of its own. The two cells ADR-0095 spoke for keep their own second clicks — the identity cell opens the record page and the status cell the transition menu — and no ordinary cell grows a pencil beside the identity cell's. On a phone the same pair of taps opens the cell, the identity cell being what selects the row there
      ✓ First click on an unticked row ticks it alone, unticks every other, opens no editor and opens no
        panel (none exists on this page). Second click on the same cell opens the field with the cursor
        in it.
      ✓ A click on a row *outside* the selection moves the selection there and opens nothing; a
        double-click does nothing of its own beyond the two clicks.
      ✓ The identity cell's second click opens `book_page` and the status cell's opens the transition
        menu; no ordinary cell grows a pencil beside the identity cell's.
      — unreachable: the phone arm.
- [ ] tab `books`: type into an open cell and click away: the blur saves that one property of that one `books` record, `Enter` saves and closes, and the [[Command Strip]] names the save after the column it changed — **Update {column}**, the word that column’s header shows, rather than a general Save changes — with an undo that puts the old value back in the row. `Escape` instead of either puts the old value back without saving. Nothing saves on a timer — leave an open cell alone for a minute and it is still unsaved with the strip silent — and a write the server refuses leaves the cell holding what was typed rather than retrying it, the strip carrying the refusal's sentence and its category, with `Escape` the way to give that draft up. Walk it as a role whose policies may not update the record at its status, too: that row's cells never open at all
      ✓ A blur onto the page background saved one property of one record and the strip read **Update
        Isbn** — the column's own header, not a general Save changes — with `Undo Update Isbn` in the
        stack putting the old value back in the row. `Enter` saved and closed the same way (**Update
        Summary**).
      ✓ `Escape` put the old value back without saving and left the strip silent.
      ✓ Nothing saves on a timer: a cell left open with unsaved text was still open and still unsaved
        **62 seconds** later, the strip silent throughout.
      ✓ As a patron — whose `catalogue` policy grants no `update` — the rows still select and no cell
        opens at all: no `data-inline-cell-opens` anywhere, and no pencil on any identity cell.
      ⚠ finding [#1329](https://github.com/chessworld/ElevateR/issues/1329), session 04's, confirmed here
        on the refusal arm. With the librarian's role revoked under an open Isbn cell, the strip carries
        **Update Isbn — Not allowed** with the server's sentence under the caret and no history entry —
        all correct — and the editor stays open holding the draft. But `Escape` then leaves the *typed*
        value in the row rather than the stored one: the table reads `999` where the database reads
        `9780765342522`, until a navigation clears it.
- [x] tab `books`: where each `books` field opens: `title`, `summary`, `isbn`, `page_count`, `price_cents` and `cover_url`: **in the cell**, as an input filling it; `genre` and `featured`: **in the cell**, as a menu of the values it allows, up from the moment the cell opens — and the pick itself saves the cell, there being nothing left to leave, while a click on the cell with the menu up closes it again and sends nothing; `author_id` and `cover_image_id`: **in the cell**, as a search box over the records it points at, saved when the cell is left rather than when the menu is picked from; `published_on`: in a popup holding the month grid — the same calendar a modal's date field draws rather than the browser's own control. A popup is anchored to the cell it came from, is wide enough to write in rather than the width of the column, holds the focus while it is open, and commits when it closes — an upload still running or a search menu holding the focus is the editor's own and commits nothing half-finished. It is **one box**: a date's month grid is drawn inside it under the input, up from the moment the cell opens, rather than floating over it as a second popup with a second edge to find, and picking a day from it writes the value and leaves the grid standing. And a click anywhere inside the box leaves it open — its padding, the space beside a field, the grid — so only a click *outside* it puts it away, committing what is in it. A click on the cell the box came from is one of those: it closes the box and leaves it closed, rather than closing and reopening it under the one click. The grid answers the pointer and nothing else: with the caret in the date, `Home`, `End` and the arrows move it through what is being typed rather than through the month, typing being the way in from a keyboard — and `Enter` finishes a typed date and saves it, a box holding one line being one line. Every other column of this table opens nothing at all, which is what its cells refusing the second click means rather than a fault
      ✓ In the cell as an input: `summary`, `isbn`, `page_count` (`type=number`), `price_cents`
        (`type=number`), `cover_url` (`type=url`).
      ✓ In the cell as a menu of the values it allows, up from the moment the cell opens: `genre`
        (Fiction … Childrens) and `featured` (Yes / No).
      ✓ In the cell as a search box over the records it points at: `author_id` (opening on *Frank
        Herbert*) and `cover_image_id` (opening on *dune-cover.png (image/png)*).
      ✓ `published_on` in a popup that is **one box**: the month grid (*August 1965*, M T W T F S S) drawn
        inside it under a single input rather than floating over it as a second popup.
      ✓ Every other column of the table opens nothing at all — `author_name` (cached), `review_count` and
        `reviews_at_shelving` (aggregate), `average_rating` (calculated) and `webhook_secret` (encrypted
        storage) have no `data-inline-cell-opens` even on a selected row.
      — `title` has no cell of its own here: it is the identity property, whose cell opens the record
        page. The plan naming it among the cells that open an editor is
        [#1310](https://github.com/chessworld/ElevateR/issues/1310).
- [x] tab `books`: the unit a number opens in: `price_cents` is written in a unit the [[Spec]] scales, so what the cell opens holding has to be the value the column is *listing* rather than the integer underneath it — $12.99 rather than 1299, 7.5% rather than 750. Type a new one and leave the cell: what the row shows afterwards is in the same unit again, and the record page and the edit modal show the same number as the table does
      ✓ `price_cents` opens holding **16.5** on God Emperor of Dune, whose cell lists `$16.50` — the
        presented unit rather than the 1650 underneath it. [#1320](https://github.com/chessworld/ElevateR/issues/1320)
        is the *form*'s field, not this one: the inline cell gets the unit right.
- [x] tab `books`: the caret an armed cell wears: select a row and its `genre`, `published_on` and `featured` cells each grow an angle-down caret at the right edge — the same affordance the [[Status Column]]'s band wears, on every cell whose click opens a list or a box rather than a field to type in. The cells of `title`, `author_id`, `summary`, `isbn`, `page_count`, `price_cents`, `cover_url` and `cover_image_id` wear none: there the click opens a field to type in, which is its own affordance. The caret is there only while the row is selected — an unselected row's cells wear none, that click being the row's, and the value under it does not move a pixel as the cell opens — the open field is set in the table's own font, so the same string lands on the same baseline in the same place, and a value too long for its column still ends in an ellipsis rather than breaking at a word. What the caret does when the cell opens depends on where the field went: a field drawn *in* the cell brings a chevron of its own, so the cell's goes, and a field that opened in a popup leaves the cell showing its value, so the caret stays and turns upside down. Nothing the caret sits on moves: the value reads exactly where it read before the row was selected, and the caret sits on the same pixel as the open field's own chevron
      ✓ With the row selected, exactly `genre`, `published_on` and `featured` grow a
        `[data-inline-cell-caret]` at the right edge — the three whose click opens a list or a box — and
        `title`, `author_id`, `summary`, `isbn`, `page_count`, `price_cents`, `cover_url` and
        `cover_image_id` wear none.
      ✓ On an unselected row no cell wears one: the caret and the `[data-inline-cell-inert]` state arrive
        together with the selection and go with it.
      — unreachable: whether the value moves a pixel as the cell opens, and where the caret sits against
        the open field's own chevron, are sub-pixel judgments this harness cannot settle beyond the
        measurements above.
- [x] tab `books`: a selected row's cell content goes inert: with the row selected, a link, a chip or a button drawn inside one of its cells stops answering the pointer — it draws no hover emphasis and follows nowhere — so the second click has one meaning wherever in the row it lands, and on an editable cell it opens that cell. On an *unselected* row the same content is live and the click belongs to the row underneath. What a reader wanted from that link is still reachable: the [[Cell Preview]] the hover floats carries the rendering with it, and `Space` and a tap float the same box. The identity cell is the exception and goes on answering — its pencil, its ellipsis and its record page all still take the pointer
      ✓ Every cell of a selected row carries `[data-inline-cell-inert]` and its content is wrapped in
        `[data-inline-cell-faded]`, so a link or chip inside it stops answering the pointer and the second
        click has one meaning wherever in the row it lands. On an unselected row neither attribute is
        there and the content is live.
      ✓ The identity cell is the exception and carries neither: its pencil, its ellipsis and its record
        page all still take the pointer.
      ✓ What the reader wanted from that content is still reachable — the [[Cell Preview]] floats the
        rendering, and `Space` floats the same box.
- [ ] tab `books`: clear `title`, which the spec requires a value for, and leave the cell: the old value is back in it, nothing is sent, no command runs and the [[Command Strip]] says nothing, there being nothing to report. No cell and no row anywhere in the table is drawn red, outlined or marked invalid at any point, which is the half to watch for. Where the schema points at one repair the value is repaired instead and the repair is what saves: a number past its bounds comes back clamped to them, a string past its maximum truncated to it, and leading or trailing whitespace trimmed away
      ⚠ finding [#1340](https://github.com/chessworld/ElevateR/issues/1340). Walked on `author_id`, this
        table's other required property, `title` having no cell of its own (#1310). Clearing it and
        pressing `Enter` sends nothing, runs no command and leaves the strip silent — correct — and
        nothing anywhere is drawn red, outlined or `aria-invalid` — also correct. But the old value does
        **not** come back: the cell closes empty and the row goes on drawing a blank the database does not
        hold, while the cached Author Name cell beside it still reads *Frank Herbert*. A reload restores
        it.
      ✓ The repair half is right: `page_count` typed as `0` against `min: 1` saved as **1**, the strip
        naming **Update Page Count**; `isbn` typed with leading and trailing spaces committed trimmed, and
        being then equal to the stored value sent nothing at all.
- [x] tab `books`: these rows answer to `books_listing` rather than to this page — the menu a row opens, the pencil in its identity cell, the [[Selection Menu]] its checked rows open and the record page a second click on that cell reaches are all built from that listing's `record_actions`, so a change made there shows up here and nowhere else does; this page's own record actions are `authors_listing`'s and govern the cluster in its first tab's header alone
      ✓ The row menu, the identity cell's pencil and the record page a second click reaches are all
        `books_listing`'s `record_actions`: *Book Page* (pulled to the front), *Edit Book*, *View
        Lifecycle*, *Related links* — the same list the listing's rows offer, and nothing from
        `authors_listing`, whose `record_actions` govern the cluster in the Profile tab's header alone.
        The pencil opens `edit_book` and the second click on the identity cell opens `book_page`.
- [x] tab `books`: right-click a row with fewer than two rows checked and that row becomes the whole [[Selection]] — its own checkbox ticks and any other clears — with a menu at the pointer over it and **no panel behind it**, this page drawing none. The menu is headed by the `books` record's own name and holds `books_listing`'s actions for it, one separator per group boundary, led by the record page in bold
      ✓ Right-clicking an unchecked row's cell ticks that row alone, clears every other, and opens a menu
        at the pointer with **no panel behind it**, headed by the `books` record's own name and holding
        `books_listing`'s actions for it — one separator per group boundary, the record page (*Book Page*)
        pulled to the front and drawn `_primary_`.
- [x] tab `books`: the ellipsis in a row's identity cell opens the same menu, anchored to itself rather than to the pointer — it appears beside the pencil while the pointer is anywhere on the row, not only over the title, and on a touch screen it is there without hovering, which is a phone's only way in
      ✓ `[data-identity-menu] button` (`aria-label="Show row menu"`) sits beside the pencil in every
        identity cell, at a rect of its own, and opens the same menu anchored to itself rather than to the
        pointer. It carries **no cell item** — *Book Page / Edit Book / View Lifecycle / Related links* —
        which is the row's own menu, and it is in the DOM without hovering, which is a phone's way in.
        It stays on a row whose pencil has gone under a multi-row selection.
- [x] tab `books`: the menu is the whole of what a row's actions have on this page: every action `books_listing`'s `record_actions` offer this reader stands in it, in the block's own order but with the record page pulled to the front, greyed with its own predicate's reason where one refuses and absent where a `hide` does — there being no item-details panel beside it to be compared with. Three read the way the panel worded them: the record page and the edit modal name the model (*Author Page*, *Edit Author*) and Lifecycle reads *View Lifecycle*. Walk it as a role the record's permissions narrow, too: what the menu holds has to narrow with them
      ✓ Every action `books_listing`'s `record_actions` offer stands in it, in the block's order with the
        record page pulled to the front, and there is no item-details panel beside it to be compared with.
        The three the line names read as it says: *Book Page*, *Edit Book* and *View Lifecycle*.
      ✓ As a patron the menu narrows with the permissions to *Copy {column} / Book Page / Related links* —
        the edit modal and Lifecycle both gone, the `catalogue` policy granting neither.
- [x] tab `books`: right-click a cell that is not the identity cell and the menu leads with **Copy {column}**, then a separator — what it copies is what the cell reads as, the string the CSV export carries, rather than its markup. Where the table filters on that column and the cell is not empty, **Filter by {column}** sits under it and narrows the table to the value in the cell, which then shows in the filters button and in the URL like any other
      ✓ The Isbn cell's menu leads with **Copy Isbn**, then **Filter by Isbn**, then a separator; the
        Summary cell's leads with **Copy Summary** and carries no *Filter by* — `summary` is not a
        filterable column here. Taking a *Filter by* narrows the table and writes the filter to the tab's
        URL like any other.
- [x] tab `books`: right-click the *identity* cell and the menu leads with **Copy {Model} ID** instead — the `books` spec's singular display name, so *Copy Book ID* over `books` — which puts the record's id on the clipboard. That cell's value is the record's name, which is already the menu's heading. A menu opened from the ellipsis is the row's own and leads with no cell item at all
      ✓ The identity cell's menu reads **Copy Book ID** — the `books` spec's `singular_name` — and
        carries no per-column copy item. A menu opened from the ellipsis leads with no cell item at all.
- [x] tab `books`: Related in the menu: this record's related links (every relation the spec declares) are one **Related links** submenu — after the `modal_actions` items and ahead of any custom action — holding a link per relation and landing on the listing each one names, filtered to this record, and nesting a submenu of its own wherever a section brings more than one
      ✓ One **Related links** submenu, after the `modal_actions` items and last in the menu, holding a
        link per relation the spec declares — **Authors**, **Reading Clubs**, **Loans**, **Reviews** — each
        landing on that listing filtered to this record
        (`/circulation/reviews?filter_book_id=s~<id>`, `/community/clubs?filter_current_book_id=s~<id>`,
        `/circulation/loans?filter_book_id=s~<id>`, `/library/authors/<author-id>/profile`). No section
        here brings more than one, so there is no nested submenu to check.
- [x] tab `books`: the checkbox column is there before anything is clicked: the table opens with a checkbox in a column of its own ahead of the [[Identity Column]] on every row, nothing ticked, and one in the header. There is no **Select multiple** toggle anywhere on the page to have turned it on — no root panel to hold one, a record page's table tab having never had one, and the tab's own header bar carries its title, its **Add** and the table's controls and nothing about selecting — and nothing else about a row has moved: the identity cell keeps its pencil and the row menu's ellipsis, nothing being ticked yet. Leave the tab for another and come back and the column is still there with nothing ticked, the [[Selection]] being this tab's own: no `panel` parameter is ever written to the address bar by any of this
      ✓ The table opens with a checkbox column ahead of the [[Identity Column]] on all 7 rows and one in
        the header, nothing ticked. There is no **Select multiple** toggle anywhere on the page — the
        tab's header bar carries its title, its item count, **Filters**, **Sort** and **Customize
        columns** and nothing about selecting — and nothing else about a row has moved: every identity
        cell still has its pencil and its ellipsis.
      ✓ Leaving for another tab and coming back leaves the column there with nothing ticked, and no
        `panel` parameter is ever written to the address bar by any of it.
      — the tab's header bar carries **no Add button**, which is right rather than missing: the
        `page_actions.add_modal` the line means is `books_listing`'s, and a record page's table tab draws
        none. See #1337 for the wider question of what a tab inherits from its listing's view.
- [ ] tab `books`: giving a set up, with no count and no **Clear** to do it by: on a `books` table with more rows than three, tick three of them and click the header checkbox — all three untick rather than the whole table checking, which is what a partial set answers to now. Click it again with nothing ticked and every row of the table checks; click it once more with every row checked and every one unticks. Press `Escape` with three rows ticked instead and the set empties the same way, the focus ring left exactly where it was. There is no selection count and no **Clear** anywhere on the page to have done either by — the header checkbox is a phone's way, having no `Escape` to reach for. **Every identity cell's pencil goes** while more than one row is ticked — the edit modal writes the one record it was clicked on, which is not what a set is edited with — and each comes back the moment the selection is down to one row or none; the ellipsis beside it never goes, the row menu being where a checked row's own list opens
      ✓ With three rows ticked the header checkbox unticks all three rather than checking the table;
        clicked again with nothing ticked it checks all 7; clicked once more it unticks all 7.
      ✓ `Escape` with three ticked empties the set and leaves the focus ring exactly where it was (on the
        cell it was on, not on `<body>` — that is the cell-editor case, #1336).
      ✓ There is no selection count and no **Clear** anywhere on the page.
      ✓ Every identity cell's pencil goes the moment a second row is ticked and comes back when the set is
        down to one or none; the ellipsis beside it never goes.
      ⚠ finding [#1338](https://github.com/chessworld/ElevateR/issues/1338) — the check-everything
        direction of that header checkbox raises a **green success entry "Select all"** in the
        [[Command Strip]], with the caret beside it still `disabled` and no history under it. Nothing was
        written; the strip says something landed. Reproduces on `books_listing` too.
- [x] tab `books`: the one click rule: click a cell of a *ticked* row and that cell opens for editing, which is what the second click on a row has always been; click a cell of an *unticked* row and that row becomes the whole selection instead: every other row unticks, this one ticks, no cell opens and no panel opens either, this page drawing none, and the click after it opens that cell. **A click inside the selection never takes it**: with three rows ticked, click anywhere on one of them — a cell's dead space, a column that opens nothing, the spare width past the last column — and all three are still ticked. So the [[Selection]] grows and shrinks by checkbox alone: no click anywhere in the table ever adds a row to it. The identity cell is ADR-0095's still — a second click on it opens the record page rather than a cell — and a row this reader may not update is a row whose cells do not open, ticked or not
      ✓ A cell of a ticked row opens for editing; a cell of an unticked row takes the whole selection
        instead and opens nothing, and the click after it opens that cell.
      ✓ **A click inside the selection never takes it**: with four rows ticked, clicking a cell of one of
        them opened that cell and left all four ticked. The set grows and shrinks by checkbox alone.
      ✓ The identity cell is ADR-0095's still, and a patron's rows — whom the policy may not update — are
        rows whose cells do not open, ticked or not.
- [x] tab `books`: the set marks, and the editor opens on what it shares: tick three rows by their checkboxes and rest the pointer on one of their `summary` cells — the same column's cell on the other two ticked rows is marked with it, a tint of its own over the fill a ticked row already carries, so what is about to change is visible before it changes. Carry the pointer along the row and the marking follows it column by column; carry it onto an *unticked* row and nothing marks there, and the [[Identity Column]] neither marks nor is marked, its second click opening a record page rather than anything a set can be asked for — while the [[Status Column]] does both, a status being one of the things a selection changes: rest the pointer on a checked row's status cell and every checked row's band wears a ring and the action colour washed over it, its own included — the status colour still showing through, so a marked set never reads as a different status. Now click that cell: it opens holding the value the three rows share, or empty where they hold three different ones — and empty is not a change, so leave it without typing and nothing is sent, no command runs and the [[Command Strip]] stays silent. Type, and what is typed shows in that one cell alone: the other two go on showing what the server last returned, marked but unchanged, until the save lands. `Escape` gives the draft up to *this* row's own value rather than to the set's, and the header checkbox and `Escape` take the marking away with the [[Selection]]
      ✓ With rows 0, 2 and 4 ticked, resting on row 0's Summary cell marks the *same column* on rows 2
        and 4 — a tint of its own (`srgb 0.649 0.888 0.977`) over the ticked fill, with a 1px inset ring —
        while the unticked row 1 stays white. Carrying the pointer along the row carried the marking
        column by column, and nothing marked on an unticked row.
      ✓ The [[Identity Column]] neither marks nor is marked — it keeps the plain ticked fill
        `rgb(230,247,253)` throughout — while the [[Status Column]] does both: resting on a checked row's
        status cell put the ring and the wash on every checked row's band, its own included.
      ✓ The editor opened **empty** over rows holding different summaries, and leaving it without typing
        sent nothing and left the strip silent.
- [x] tab `books`: one edit, every checked row, one entry: with three rows ticked, open one of their `summary` cells, type a value and press `Enter` — all three rows read it, and the strip names **one** entry for the three rather than three entries. Open the caret and take it back: each row comes back to the value *it* held, so three rows that held three different values come back as three different values rather than as the one the opened cell was showing. Every other column of all three records is as it went in, the write carrying the one property that changed and nothing else — check one the set never agreed on. Then make a second batch over a *different* set of rows: it is an entry of its own rather than folded into the one before it, which is what a run of edits to one cell of one row does instead
      ✓ With four rows ticked, typing into one of their Summary cells and pressing `Enter` wrote all four,
        and the strip named **one** entry — **Update Summary** — with one undo icon.
      ✓ That one undo brought each row back to the value *it* held (four different summaries), not to the
        one the opened cell showed, and every other column of all four was as it went in — `page_count`
        and `isbn` checked row by row in the database.
- [ ] tab `books`: the gate closes the whole set: `books`'s `admin` policy permits `update` on a record in `draft` and `published` and not on one in `archived`, so tick one `books` record in `archived` along with two the policy does reach — and no cell of the set opens at all, the cells of the two rows that would have permitted it included, because applying to whichever rows happened to permit it would leave the result turning on a permission the reader cannot see. A refused cell is the inert one it already knows how to be: `Tab` walks over it, `Enter` and `F2` float the [[Cell Preview]] instead, and nothing marks, there being nothing about to change. The reason rides on the cell itself, as its tooltip *and* its accessible name — "<the record's name> cannot be updated while it is Archived", which says which row to untick rather than which rule to guess at. Untick that one record and the other two open again
      ⚠ finding [#1318](https://github.com/chessworld/ElevateR/issues/1318), session 02's, confirmed here.
        Ticking the `archived` Whipping Star alongside two books the `admin` policy reaches does not stop
        the set's cells opening: row 0's Summary cell opened as usual. No cell carries a refusal, no
        tooltip or accessible name says which row to untick, and there is nothing for `Tab`, `Enter` or
        `F2` to fall back from. Unticking the archived record changes nothing, because nothing was
        refused.
- [x] tab `books`: the status cell moves the whole set: tick three `books` records that are all in `published` and click one of their status cells — the menu that opens is the [[Selection]]'s rather than that one row's, titled with the status the three agree on, and it offers only the moves every checked record may make. Tick one `books` record in `draft` as well and `archived` is no longer offered, that record having no permitted move into it. Take `published` → `archived`, which the `admin` policy permits: all three move as one write, the strip names one entry for them, and one undo takes all three back at once. A record already in `archived` neither withholds the move from the others nor takes a write of its own, and a set with no move in common is a status cell that opens no menu at all and answers no click. Give the selection up by the header checkbox and the same cell opens that one row's own menu again, one checked row being no set
      ✓ Three `published` books ticked, a click on one of their status cells opens the [[Selection]]'s
        menu — headed **Published**, the status the three agree on — offering **Archived** alone.
      ✓ Ticking a `draft` book as well takes **Archived** away, that record having no permitted move into
        it, and the menu is left with its heading and no items.
      ✓ Taking `published` → `archived` moved all three as one write, the strip named **one** entry
        (*Change status*), and one undo took all three back at once.
      — a set with no move in common opens a menu holding only its heading rather than opening none at
        all, which is a hair off the line's "opens no menu at all and answers no click"; nothing is
        offered either way.
- [x] tab `books`: a set with nothing to be asked: `books_listing`'s `record_actions` declare no `modal_actions`, and no `books` workflow declares `dispatch_mode: per_record` on a manual trigger — so a [[Selection]] here has an empty list, and what the menu holds is one line saying so. Tick three rows and right-click one of them: a menu of the app's own opens, titled off the count as any set's is, holding a single greyed **No actions for this selection** and nothing else — the browser's own context menu must not appear over the table, which is what an empty menu would have let through. The identity cell's ellipsis is still on a checked row and opens that same one-line menu, a phone having no right-click to reach it with. That one line is the whole of what says so: there is no panel on this page with a selection block to have said it by drawing no buttons, and no count and no **Clear** beside it to have said it either. Right-click an *unchecked* row and the selection still collapses onto it — every other row unticks, that one ticks — and that record's ordinary [[Row Context Menu]] opens, copy item and all; untick until fewer than two rows are checked and every row's menu and ellipsis are the record's own again
      ✓ Right-clicking one of three checked rows opens a menu of the app's own holding a single greyed
        **No actions for this selection** and nothing else — `books_listing` declares no `modal_actions`
        and no `books` workflow is `dispatch_mode: per_record`. The identity cell's ellipsis on a checked
        row opens the same one line.
      ✓ Right-clicking an *unchecked* row collapses the selection onto it and opens that record's ordinary
        [[Row Context Menu]], copy item and all; below two checked rows every row's menu is the record's
        own again.
      — unreachable: that the browser's own context menu does not appear. A native popup is not visible to
        this harness; what is observable is that the app's own menu opens on every right-click walked.
- [ ] tab `books`: the whole table is **one** tab stop: Tab from the control above it lands inside the table once — on a cell, wearing a focus ring of its own — and Tab again leaves it for whatever is below, however many rows are on screen; the column headers' own controls keep the stops they had, and so do a row's selection checkbox and an open inline-edit field, while clicking any cell moves the ring to that cell
      ⚠ finding [#1314](https://github.com/chessworld/ElevateR/issues/1314), session 02's, confirmed here.
        `Tab` from the **Sort** button above the table lands on the checkbox cell of row 0 — one stop, as
        the line asks — and then never leaves: the next stop is that row's identity pencil, and every
        `Tab` after it **opens** the next editable cell of the row in turn (`author_id`, `summary`,
        `isbn`, `genre`, `page_count`, `price_cents` …), each as a live editor rather than a ring.
- [x] tab `books`: Left and Right walk the ring across the columns of the row it is on, crossing out of the pinned columns into the scrolling ones without a stop in between, and Home and End are that row's first and last column rather than the table's first and last row; both ends hold rather than wrapping onto another row, and a column reached off the side of the window is scrolled to clear of the pinned columns rather than underneath them
      ✓ Left and Right walk the ring column by column along the row it is on, crossing out of the pinned
        identity/status columns into the scrolling ones with no stop in between.
      ✓ `Home` is that row's first column (the checkbox cell) and `End` its last
        (`reviews_at_shelving`) rather than the table's first and last row, and pressing `End` again holds
        there rather than wrapping onto another row.
      ✓ A column reached off the side of the window is scrolled to rather than left under the pinned
        columns.
- [x] tab `books`: Up and Down move the ring to the row above and below in the column it is already in, and every row it lands on is selected as a clicked row is, that `books` record becoming the whole [[Selection]] and the row before it unticking — hold Down and the checked row walks with the ring, on past the bottom of the window, where the next row is scrolled to and *then* focused rather than skipped over; the first and last rows hold rather than wrapping
      ✓ Down and Up move the ring in the column it is already in, and each row it lands on becomes the
        whole [[Selection]] — row 2 → 3 → 4 with the checked row walking with the ring and the one before
        it unticking. The first and last rows hold rather than wrapping.
      — the scroll-past-the-bottom clause has nothing to reach here: 7 rows fit the window.
- [x] tab `books`: Ctrl+Home jumps the ring to the first row and Ctrl+End to the last row of the table rather than the last one fetched: on a `books` table long enough to be paged, Ctrl+End lands the ring on a row whose record has yet to arrive, the window goes back to the connection for it, and the selection moves to *that* record once it lands rather than staying on the row that was checked before
      ✓ `Ctrl+Home` put the ring and the selection on row 0 and `Ctrl+End` on row 6, in the column the
        ring was already in.
      — unreachable: the paging half. Frank Herbert has 7 books, well inside one page, so there is no row
        whose record has yet to arrive for `Ctrl+End` to land on.
- [x] tab `books`: Enter on the focused row's identity cell opens record page `book_page`, which is what a second click on that cell opens — the key and the click run the same thing, so a difference between them is a regression. It opens nothing else on the way: not the pencil's edit modal, and not the cell's own preview
      ✓ `Enter` on the focused identity cell opened `/library/books/<id>/overview` — the same thing the
        second click opens — and nothing else on the way: no edit modal and no cell preview.
- [x] tab `books`: Enter on the focused row's status cell opens the same transition menu a second click on it opens, under the cell and holding the same items — and where the reader is permitted no transition at all it opens nothing rather than falling through to that cell's preview
      ✓ `Enter` on the focused status cell opened the transition menu under the cell holding *Draft /
        Published / Archived* — the same items the second click opens.
- [x] tab `books`: Space on any other focused cell **toggles** that cell's preview — the box floats and the same key puts it away — while Enter on a cell this reader may not write only ever opens it; a cell already showing all of its value floats nothing either way, and the page does not scroll down under either press. Escape then closes whatever is floating over the table first, and an Escape with nothing open gives the selection up — every checked row unticks, there being no panel to close instead, leaving the ring exactly where it was — Tab, not Escape, is the way out of the table. While anything floats the arrow keys stand aside rather than walking the ring out from under it, the box being placed against the cell it belongs to
      ✓ `Space` on a focused Summary cell floats the [[Cell Preview]] and `Space` again puts it away; the
        page does not scroll under either press (`scrollY` 0 throughout).
      ✓ A cell already showing all of its value (Page Count) floats nothing either way.
      ✓ `Escape` closes whatever is floating first, and an `Escape` with nothing open gives the selection
        up and leaves the ring where it was.
- [x] tab `books`: Enter and F2 on a focused cell this reader may write open it for editing — the same field the second click opens, in the cell or in its popup — rather than that cell's preview, and the ring is in the field once it opens. On a cell they may not write, or one this table opens no field for, Enter falls back to the preview and F2 does nothing at all; the identity and status cells keep what they answer above
      ✓ Both `Enter` and `F2` on a focused Summary cell open the same field the second click opens, with
        the ring in the field. On a patron's rows, which they may not write, neither opens anything.
- [x] tab `books`: Tab from an open cell commits it and opens the next editable cell of the *same* row, Shift+Tab the previous — every column with no field to open is stepped over, the identity and status columns among them — and past the last editable cell of the row Tab leaves the table for whatever is below it, as Shift+Tab before the first leaves it upwards, the table being one tab stop. The [[Identity Column]]'s cell is the walk's first stop, and opens nothing either: `Tab` into the table lands there, `Enter` opens the record page, and `Tab` again carries on into the row's cells in the order the columns are laid out. The [[Status Column]]'s cell is one of the stops, and the one that opens nothing: `Tab` onto it commits whatever was open and leaves the ring there, `Enter` opens its transition menu — the same key a reader who arrived by arrow key presses — and `Tab` again carries on to the next editable cell rather than popping a menu part-way along the row. Escape inside an open cell is the cell's own: it puts back what the cell held and closes it, leaving the row checked rather than clearing the selection, which is what the same key does once no cell is open
      ✓ `Tab` from an open Summary editor committed it and opened **Isbn** — stepping over `webhook_secret`,
        which opens no field — and `Shift+Tab` came back to Summary. The identity and status columns are
        stepped over as editors and keep their own answers.
      ✓ `Escape` inside an open cell puts back what the cell held and closes it, leaving the row checked.
      ⚠ the *past the last editable cell* half is #1314's: `Tab` never leaves the table.
- [ ] tab `books`: Shift+F10, and the Menu key where the keyboard has one, open the row's context menu on the focused cell: the right-click's menu rather than the ellipsis's, anchored to the cell for want of a pointer to anchor to, with the row selected under it — so an ordinary cell's menu is led by the copy item naming that column and the identity cell's carries no copy item at all. A menu a key opened takes the keyboard: its first item is focused, Up and Down walk the items and Enter picks one, and closing it hands the keyboard back to the cell with its ring on. A right-clicked one takes nothing and leaves the ring where it was
      ⚠ finding [#1339](https://github.com/chessworld/ElevateR/issues/1339). On an ordinary cell the key
        works exactly as the line asks: `Shift+F10` on a focused Isbn cell opens the right-click's menu
        anchored to the cell, led by **Copy Isbn**, with the row selected under it and its first item
        focused so Up/Down and Enter walk it; a right-clicked menu takes nothing and leaves the ring where
        it was. On the [[Identity Column]]'s cell it opens **nothing at all**, though a right-click there
        opens the full menu led by *Copy Book ID*. Reproduces on `books_listing` too.
      — no Menu key on this keyboard to walk the other half with.
- [x] tab `books`: shareable link: open row edit modal `edit_book` for a row you can see and the address bar gains `?edit=books:<id>`, which closing the modal takes away again — Back leaves the page rather than closing the modal, the param being written over the entry rather than after it. Reload that URL, or paste it into a browser with no history behind it: the page comes up with the modal already open over the record page, on this tab, filled with that record rather than empty or loading. A link naming a record this reader may not see lands on the page with no modal and the param stripped, and the refusal read in the [[Command Strip]]: a warning and the attempt's own name on the bar, its sentence under the caret, and nothing added to the undo history
      ✓ The identity cell's pencil opens `edit_book` and the address bar gains
        `?edit=books:a3964ede-…`; closing the modal takes it away again.
      ✓ Pasting `/library/authors/<id>/books?edit=books:<id>` into a browser with no history behind it
        brings the page up on this tab with the modal already open over it, filled with Dune rather than
        empty or loading.
      ✓ A link naming a record this reader may not see — the `archived` Whipping Star, as a patron — lands
        on the page with no modal and the param stripped, and the refusal reads in the [[Command Strip]]:
        **Open Record — Failed** on the bar with "That record could not be opened." under the caret and
        nothing added to the undo history. The category is the honest *Failed* the line allows for, the
        record being filtered out of that reader's view rather than refused by name.
- [x] tab `history` (History): lifecycle history renders
      ✓ The History tab draws the record's lifecycle as a table of Status / Created At / Created By,
        carrying this session's own transitions (Active ⇄ Retired, by Ada Admin) newest first. The tab
        carries no record-action cluster, which is the Profile tab's alone.
- [x] edit modal `edit_author` from the record page: open → save a change → the page reflects it
      ✓ **Edit** opened `edit_author` on Frank Herbert (`?edit=authors:fa737dc0-…`) with the form seeded
        from the record; typing a Bio and pressing **Save changes** closed the modal, stripped the param,
        put the new Bio in the properties block under it and wrote it to the database. The strip named the
        save after the modal's own button.
- [ ] shareable link: open edit modal `edit_author` for the record the page is on and the address bar gains `?edit=authors:<id>`, which closing the modal takes away again — Back leaves the page rather than closing the modal, the param being written over the entry rather than after it. Reload that URL, or paste it into a browser with no history behind it: the page comes up with the modal already open over the record page, filled with that record rather than empty or loading. A link naming a record this reader may not see lands on the page with no modal and the param stripped, and the refusal read in the [[Command Strip]]: a warning and the attempt's own name on the bar, its sentence under the caret, and nothing added to the undo history
      ⚠ finding [#1341](https://github.com/chessworld/ElevateR/issues/1341). The write half is right —
        **Edit** opens `edit_author` and the address bar gains `?edit=authors:fa737dc0-…`, which closing
        the modal takes away again, and `history.back()` from the open modal leaves the page for the tab
        before it rather than closing the modal, the param having been written *over* the entry.
        The read half is not: pasting that same URL into a fresh browsing context strips the parameter,
        opens no modal, and reports **Open Record — Failed** — "That record could not be opened." — about
        the record the page is showing. `?edit=books:<id>` on the Books tab opens correctly, which is what
        says the mechanism is there and the page's own record is the case it does not reach.
- [x] record-action modals (`edit_author`): each opens from this page and submits
      ✓ `edit_author` is the whole of them — `modals: ["*"]` over `authors` resolves to it alone. It opens
        from the cluster's **Edit** button and from the phone-width Actions menu, and submits: the Bio
        typed into it landed on the page and in the database.

## Page: authors_listing  (`/library/authors`)
- [ ] renders as each of: admin, librarian, patron — and is absent from the nav *and* refused on direct navigation for every other role
      ● known — no page refuses direct navigation for a disallowed role. Renders and is in the nav as admin,
      librarian and patron (patron gets no **Add Author**, the `catalogue` policy naming no `create`).
      `circulation@example.com` has no Authors entry in the nav — the hiding half holds — but
      `/library/authors` typed straight in serves the shell with "0 items" rather than a redirect or a
      403. Non-leaking, per the known issue's own reading of `loans_listing`.
- [x] the page heads with one two-row header: the title reads at the left of the upper row — "Authors" — with nothing ahead of it, this page naming no `parent_page` and no tabs beside it. The [[Command Strip]] holds the right-hand end of that row and nothing else does; what it says there is the next line's. The bar directly beneath holds everything the header held before, each item where it was. Narrow the window until the title no longer fits and it ellipsises, resting a tooltip carrying the whole of it — a title that fits rests nothing
      ✓ walked. `_pageHeader_` is two rows: the upper (`h=36`) holds the title "Authors" at its left
      (x=322, nothing ahead of it), an empty `_headerTabs_` slot and the [[Command Strip]] at the right
      end (x=1222, w=32) and nothing else; the bar beneath holds the listing header as it was — title,
      **Add Author**, "7 items" on the left, Filters / Sort / Customize columns / More on the right.
      — unreachable: the ellipsis-and-tooltip clause. "Authors" is 64px and still fits at Firefox's
      ~500px floor, so the title can never be narrowed out of its box. It rests no tooltip while it fits,
      which is the half that is walkable; `TitleBar.tsx` wires the tooltip on `useIsClipped`.
- [ ] the [[Command Strip]] is the only place a command's status is shown, and this page's header carries it: before any command has run it is its caret alone, greyed and opening nothing. Run one — a save made here, or one made on another page and then walked back to through the nav rather than reloaded, the history being the session's rather than the page's — and a spinner shows while it is in flight, for as long as it runs, then a tick and the command's own name — and ten seconds later the tick and the name fade away over a moment and the strip is its caret alone, the history still under it. Count it out: a success still there half a minute on is a finding, and so is one gone the moment it landed. Open the caret before the ten seconds are up and the name is held there until you close it again. A refusal reads the same way with a warning and a category after a dash — one of "Not allowed", "Invalid input", "Not found", "Server error" and "Offline" — its own sentence under the caret, and joins no history — and it does not fade: a refusal is still there a minute later, until the next command replaces it, which is the difference to watch for. The category is the server's own word for what it refused rather than a reading of the sentence it sent (ADR-0099), so a failure nothing named a kind for reads "Failed", which is the honest answer rather than something to report. What is a finding is a category naming the wrong kind — a save the policies refused reading anything but "Not allowed", a server stopped mid-session reading anything but "Offline" — and so is a headline carrying the whole sentence where those two or three words belong, the sentence being the dropdown's. Open the caret and the stack is there, newest first: an entry that can be taken back wears an undo icon, and clicking the icon on the *n*th of them moves the stack past all *n* in one call, the headline then naming the direction — "Undo" and the command's own name. An entry whose command declared no undo wears a lock instead, and every entry older than it loses its icon behind that lock — so an entry under a lock drawing no icon is that lock's doing rather than a fault. Which of this app's saves lock and which take themselves back is the Undo section's, at the foot of this plan: a stack with no undo icon anywhere in it is a finding rather than a reading. Ctrl+Z reaches the same undo a step at a time and Ctrl+Shift+Z puts it back, each saying nothing beyond what the headline says, and each standing down — headline unmoved — while the keyboard is in a text field or a modal is open. At a phone width the strip is the icon and the caret alone, the command's name being read in the dropdown instead
      ⚠ finding [#1312](https://github.com/chessworld/ElevateR/issues/1312) — the undo clause.
      Everything else on the line holds: before any command the strip is its caret alone, `disabled`, drawn
      in `--text--disabled`; a save shows a tick and the command's own name (**Update Bio**, **Update
      Nationality**, **Change status**, **Save changes**) and fades at 10.0–10.4s to the caret alone with
      the history still under it (sampled every 400ms); a refusal reads "Save changes — Invalid input" and
      is still there 18s on; a failure the server named no kind for reads "Open Record — Failed" with its
      sentence under the caret ("That record could not be opened.") — the server answers a bare `404 not
      found` with no code, so "Failed" is the honest word. The caret opens the stack newest first with an
      undo icon per entry; clicking the icon on the 3rd moved the stack past all three in one call and the
      headline read **Undo Update Bio**. Ctrl+Z and Ctrl+Shift+Z walk it one step at a time and stand down
      inside an open cell. At 500px the strip is 45px — icon and caret, no headline — and the name reads
      in the dropdown. The spinner phase was under 120ms on this stack and could not be sampled.
      The finding: an undo of an edit made *after* an earlier undo restores the value from before that
      undo, writing a value the reader already took back back into the database.
- [x] this page draws no [[Panel]] at all: no docked root panel, no tab rail down the right edge to open one from, and the content running out into the 45px the rail used to reserve; no click anywhere on it opens an item-details panel, and the mobile header carries no panel button. Append `?panel=<a `authors` record id>` to this page's URL and it opens nothing at all, and nothing on the page reads as selected under it either — no row of a table view and no card of a board or cards view — a listing's [[Selection]] being the page's own checked set and never the address bar, on whichever view is up
      ✓ walked. The content wrapper carries `_contentWithNoPanel_` and runs the full 984px to the right
      edge — no docked panel, no tab rail, nothing reserving 45px. No click anywhere opened one.
      `?panel=<an authors id>` loads the listing with nothing selected and no panel. At 500px the header
      carries Dev menu, avatar, Command history and Actions, and no panel button.
- [x] table view renders rows of `authors`, each column at its configured width and the spare width to the right of the last column left empty; drag the boundary between two column headers and the column follows the pointer, release it, then hide a column and reorder another from the customize-columns menu, then press a third column's header and carry it along the header row — a ghost of the header follows the pointer and a drop line down the table says where it lands, the line going as the pointer is carried well down among the rows and coming back as it returns, and releasing lays the column out there at once — then reload and find the width, the hidden column and the order all still there
      ✓ walked. Columns at 35/200/140/200/200/140/100; at a 1500px window the table is 1172 wide and the
      157px past the last column is left empty. Dragging the Bio/Nationality boundary moved the column with
      the pointer — 240px at the mid-drag sample, 280px on release. Hid **Website** and reordered **Books**
      ahead of **Bio** by carrying its header along the row: a ghost followed the pointer, a 2px drop line
      ran the height of the table, the line went when the pointer was carried down among the rows and came
      back on returning to the header, and the release laid the column out at once. Width, hidden column and
      order all survived a reload — the layout save is debounced by a few seconds, so a reload inside that
      window loses them and is worth waiting out. Reordering from inside the customize-columns modal is
      HTML5 drag-and-drop, which WebDriver pointer actions cannot drive; the header drag is the same fact.
- [x] the identity column is the table's first column and stays pinned there as the rest scroll sideways: every row names its `authors` record in it, under the header the config or the spec's display name gives it; the customize-columns menu offers neither hiding nor reordering it, its header does not drag along the row and no other column drops ahead of it, and dragging its right edge still resizes it
      ✓ walked. Identity is the first column after the checkboxes and both stay put as the rest scroll:
      at scrollLeft 0 vs 27 the checkbox and identity cells held x=92/127 while status, bio and nationality
      moved by 27. **Customize columns** lists Status, Bio, Website, Nationality and Books and never the
      identity column; its header carries a `Resize identity` handle but no `data-column-drag`, and carrying
      the Status header left over it put the drop line at the identity column's right edge (x=546) rather
      than ahead of it. Dragging its right edge resized it 200 → 280.
- [ ] the table opens sorted by `name`, ascending — declared here in `default_sort` — and that column's header is the one wearing the arrow
      ⚠ finding [#1316](https://github.com/chessworld/ElevateR/issues/1316). The order is right — Angela,
      Chinua, Frank, Haruki, Margaret, Ursula, Zadie — and the **Sort table** modal opens reading
      *Name / Ascending*. No header wears an arrow, at rest or under `?sort=name_desc`: the arrow goes on
      the `name` column, which the identity column displaces into *Hidden columns*, and the *Author* header
      never takes it. `?sort=status_asc` does draw it on **Status**, so the mechanism is there.
- [ ] the status column is the table's second column, right of the identity column: every row wears its `authors` status there as a band filling the cell edge to edge, its label centred — the colour that status declares in the spec as a plain fill, that colour's pattern as a strip down the left edge, and the neutral fill where the spec declares no colour — reading the same label the same record's chip reads on a board or a cards view; and unlike the identity column beside it, the customize-columns menu offers to hide it, bring it back and reorder it
      ⚠ finding [#1309](https://github.com/chessworld/ElevateR/issues/1309) — a generator bug, against
      `keystone-dev dress-rehearsal` rather than the UI. The column is where the line says and both statuses
      are neutral, as the spec declares no colour, and the customize-columns modal offers to hide, restore
      and reorder it. But the line describes the pre-ADR-0095 look: it asks for a *plain fill* with a
      *centred label* and the colour's *pattern as a strip down the left edge*, and the shipped column draws
      a 15% wash (`color-mix(in srgb, var(--status-fill) 15%, transparent)`), a left-aligned label and the
      pattern on a 14px disc — which `StatusCellValue.module.css` argues for in as many words.
      The "same label the record's chip reads on a board or a cards view" clause has nothing to walk:
      `authors_listing` declares one `kind: table` view and no other.
- [ ] sort the table by the status column's header, both directions: the rows come back in the spec's own declared status order rather than alphabetically; then narrow that header's filter to one status — only rows in it remain, the URL carries the filter, and a reload keeps it applied
      ⚠ finding [#1311](https://github.com/chessworld/ElevateR/issues/1311) — a generator bug. A column
      header is a label, a resize handle and a drag surface; it carries no sort control and no filter.
      Sorting is the **Sort table** modal and filtering the **Filters** modal, and both do what the line's
      substance asks: `?sort=status_desc` puts Zadie Smith (Retired) first and `?sort=status_asc` last;
      `?filter_status=s~retired` leaves one row, reads "1 item", writes the URL and survives a reload.
      The declared-status-order clause cannot be distinguished on this model — `active`, `retired` is the
      same sequence alphabetically.
- [x] click any cell of a row to select it: the row's status band gains an angle-down caret at its right edge, which is what says the second click is there. Click that status cell and the transition menu opens under it, titled with the row's current status and holding an item per status the spec declares — the current one ticked and inert, each of the others the transition to it, refused with its own reason where this reader may not make it and opening the transition modal first where it has properties to collect. The status the walk lands on is in the record's lifecycle history afterwards. A role permitted no transition at all gets no caret and no menu from the second click, an unselected row's band wears none either, and a first click on the status cell only ever selects the row
      ✓ walked. A first click on Zadie Smith's status cell only selected the row and opened nothing; the
      caret appeared on that row's status and nationality cells alone (`data-status-opens-menu` on the
      status cell of the selected row and nowhere else). The second click hung the menu under the cell,
      headed **Active** — the row's current status — with an item per declared status, Active carrying the
      tick. Taking **Retired** moved the record and wrote the lifecycle row
      (`authors_lifecycles`: active 05:42, retired 06:08). As a patron — whose `catalogue` policy names no
      transition — no cell of a selected row wears a caret and the second click on the status cell opens
      nothing at all.
- [x] rest the pointer on a cell whose value this column's width cuts off and about half a second later the whole of it floats beside the cell, wrapped rather than clipped and rendered the way the cell renders it rather than as a bare string; move the pointer away and the box goes, while a cell already showing all of its value floats nothing however long the pointer rests on it. On a phone, where there is no pointer to rest, a tap on that same cell floats the box at once and a tap elsewhere puts it away — and neither tap changes which row is selected
      ✓ walked. Resting on Chinua Achebe's clipped Bio cell floats a `_box_v2u1h_` beside it (x=867 against
      a cell at 867, 480px wide, `white-space: normal`) holding the whole value and rendering it through the
      same `data-inline-cell` the cell uses. Moving away takes it; Haruki Murakami's short Bio floats
      nothing however long the pointer rests. A clipped Nationality cell behaves the same.
      — unreachable: the phone half. This harness has no touch input.
- [x] what this table no longer has: there is no **Edit table** toggle anywhere on the page — no root panel to have held one, and the header bar carries the page's own actions and nothing about editing — no Save and Cancel bar over the header, and no bulk-edit form anywhere on the page. `Ctrl+S` binds nothing here any more: whatever the browser does with it is the browser's, and no save of this page's starts. A cell is saved one cell at a time and the [[Command Strip]] is the only place that says so
      ✓ walked. No **Edit table**, no **Select multiple**, no Save/Cancel bar and no bulk-edit form appear
      anywhere in the DOM at any point in this walk. `Ctrl+S` with a row selected started nothing: the strip
      stayed empty and disabled and no save ran. Cells save one at a time and the strip is the only report.
- [x] click any cell of a row to select it, then click one of that row's cells again: the cell becomes the `authors` field it edits, with the cursor in it. The first click only makes that row the whole [[Selection]] — every other row unticks and this one ticks — and opens no panel, there being none on this page; a click on a row *outside* the selection never opens a cell, and a double-click still does nothing of its own. The two cells ADR-0095 spoke for keep their own second clicks — the identity cell opens the record page and the status cell the transition menu — and no ordinary cell grows a pencil beside the identity cell's. On a phone the same pair of taps opens the cell, the identity cell being what selects the row there
      ✓ walked. First click on Margaret Atwood's Bio cell ticked her row and unticked every other, opening
      no panel; the second opened the cell as an input filling it (x=686 w=199 against a cell at 687 w=200),
      focused, in the table's own 14px font. A click on a row outside the selection never opened a cell —
      it collapsed the selection onto that row instead. The identity cell's second click opened
      `author_page` and the status cell's the transition menu; no ordinary cell grew a pencil.
- [ ] type into an open cell and click away: the blur saves that one property of that one `authors` record, `Enter` saves and closes, and the [[Command Strip]] names the save after the column it changed — **Update {column}**, the word that column’s header shows, rather than a general Save changes — with an undo that puts the old value back in the row. `Escape` instead of either puts the old value back without saving. Nothing saves on a timer — leave an open cell alone for a minute and it is still unsaved with the strip silent — and a write the server refuses leaves the cell holding what was typed rather than retrying it, the strip carrying the refusal's sentence and its category, with `Escape` the way to give that draft up. Walk it as a role whose policies may not update the record at its status, too: that row's cells never open at all
      ⚠ finding [#1312](https://github.com/chessworld/ElevateR/issues/1312) — the undo clause, as on the
      [[Command Strip]] line. The rest holds: a blur saved `website` and Enter saved `bio`, both landing in
      the database; the strip named each after the column's header — **Update Bio**, **Update Website**,
      **Update Nationality** — never a general Save changes. `Escape` put the old value back and sent
      nothing. Nothing saves on a timer: a cell left open with typed text for ~2 minutes was still unsaved
      with the strip silent. As a patron no cell opens at all, and neither does any cell of the row in
      `retired` as an admin, the `admin` policy's `update` naming `active` only.
- [ ] where each `authors` field opens: `name`, `bio` and `website`: **in the cell**, as an input filling it; `nationality`: **in the cell**, as a menu of the values it allows, up from the moment the cell opens — and the pick itself saves the cell, there being nothing left to leave, while a click on the cell with the menu up closes it again and sends nothing. Every other column of this table opens nothing at all, which is what its cells refusing the second click means rather than a fault
      ⚠ finding [#1310](https://github.com/chessworld/ElevateR/issues/1310) — a generator bug: `name` is
      this model's `identity.title`, so it has no cell of its own to open in, and the same section says two
      lines earlier that the identity cell's second click opens the record page. What the line describes for
      the other three is exactly right: `bio` and `website` open as an input filling the cell, `nationality`
      opens a menu of its eight itemset values from the moment the cell opens, and picking one saved the
      cell (**Update Nationality**, Canadian → Irish). Clicking the cell with the menu up closed it and sent
      nothing. Every other column refused the second click.
- [x] the caret an armed cell wears: select a row and its `nationality` cells each grow an angle-down caret at the right edge — the same affordance the [[Status Column]]'s band wears, on every cell whose click opens a list or a box rather than a field to type in. The cells of `name`, `bio` and `website` wear none: there the click opens a field to type in, which is its own affordance. The caret is there only while the row is selected — an unselected row's cells wear none, that click being the row's, and the value under it does not move a pixel as the cell opens — the open field is set in the table's own font, so the same string lands on the same baseline in the same place, and a value too long for its column still ends in an ellipsis rather than breaking at a word. What the caret does when the cell opens depends on where the field went: a field drawn *in* the cell brings a chevron of its own, so the cell's goes, and a field that opened in a popup leaves the cell showing its value, so the caret stays and turns upside down. Nothing the caret sits on moves: the value reads exactly where it read before the row was selected, and the caret sits on the same pixel as the open field's own chevron
      ✓ walked. Selecting a row grew a caret on its status and nationality cells and on no others — `name`,
      `bio` and `website` open a field to type in and wear none — and an unselected row's cells wear none
      at all. Opening the nationality cell took the cell's own caret away (`_caret_` count 0) because the
      field drawn in the cell brings its own chevron (`_withRightIcon_`), which is the fork the line names.
      The value read in the same place before and after (cell x=1087 w=140, field x=1086 w=139).
- [ ] a selected row's cell content goes inert: with the row selected, a link, a chip or a button drawn inside one of its cells stops answering the pointer — it draws no hover emphasis and follows nowhere — so the second click has one meaning wherever in the row it lands, and on an editable cell it opens that cell. On an *unselected* row the same content is live and the click belongs to the row underneath. What a reader wanted from that link is still reachable: the [[Cell Preview]] the hover floats carries the rendering with it, and `Space` and a tap float the same box. The identity cell is the exception and goes on answering — its pencil, its ellipsis and its record page all still take the pointer
      — unreachable. No ordinary cell of this table draws a link, a chip or a button: `bio`, `website`,
      `nationality` and `book_count` all render as plain text inside `FiE3va_cell` (the `website` URL
      included — it is not an anchor), so there is nothing on a selected row for the pointer to stop
      answering. The identity cell's exception is walkable and holds: its pencil, its ellipsis and its
      record page all take the pointer on a selected row.
- [ ] clear `name`, which the spec requires a value for, and leave the cell: the old value is back in it, nothing is sent, no command runs and the [[Command Strip]] says nothing, there being nothing to report. No cell and no row anywhere in the table is drawn red, outlined or marked invalid at any point, which is the half to watch for. Where the schema points at one repair the value is repaired instead and the repair is what saves: a number past its bounds comes back clamped to them, a string past its maximum truncated to it, and leading or trailing whitespace trimmed away
      ⚠ finding [#1310](https://github.com/chessworld/ElevateR/issues/1310) — a generator bug, the same
      one: `name` is the identity property and has no cell that opens, so there is no cell here in which to
      clear it. The repair half is walkable in part and passes: typing `"   Trimmed value   "` into a Bio
      cell and pressing Enter stored `Trimmed value`. `authors` declares no bounded number and no string
      maximum, so the clamp and truncate clauses have nothing to walk. Nothing anywhere in the table was
      drawn red, outlined or marked invalid at any point in this walk.
- [x] the checkbox column is there before anything is clicked: the table opens with a checkbox in a column of its own ahead of the [[Identity Column]] on every row, nothing ticked, and one in the header. There is no **Select multiple** toggle anywhere on the page to have turned it on — no root panel to hold one, and the header bar carries the page's own actions rather than the table's — and nothing else about a row has moved: the identity cell keeps its pencil and the row menu's ellipsis, nothing being ticked yet. Leave the page for another and come back and the column is still there with nothing ticked, the [[Selection]] being the page's own: no `panel` parameter is ever written to the address bar by any of this
      ✓ walked. The table mounts with a checkbox column ahead of the identity column on every row and one
      in the header, nothing ticked. No **Select multiple** toggle exists anywhere in the DOM; the identity
      cell keeps its pencil and ellipsis. Walking to Books through the nav and back to Authors (in-page —
      `window.__mark` survived, so no reload) came back with the column there, nothing ticked and no `panel`
      parameter written.
- [x] giving a set up, with no count and no **Clear** to do it by: on a `authors` table with more rows than three, tick three of them and click the header checkbox — all three untick rather than the whole table checking, which is what a partial set answers to now. Click it again with nothing ticked and every row of the table checks; click it once more with every row checked and every one unticks. Press `Escape` with three rows ticked instead and the set empties the same way, the focus ring left exactly where it was. There is no selection count and no **Clear** anywhere on the page to have done either by — the header checkbox is a phone's way, having no `Escape` to reach for. **Every identity cell's pencil goes** while more than one row is ticked — the edit modal writes the one record it was clicked on, which is not what a set is edited with — and each comes back the moment the selection is down to one row or none; the ellipsis beside it never goes, the row menu being where a checked row's own list opens
      ✓ walked on seven rows. Ticked three: all six updatable rows lost their identity pencil at once and
      every row kept its ellipsis. The header checkbox on that partial set unticked all three (the pencils
      came back, still absent on the `retired` row); pressed again with nothing ticked it checked all seven;
      pressed again with all seven checked it emptied them. `Escape` with three ticked emptied the set and
      left the focus on the same element. No selection count and no **Clear** anywhere — the header reads
      "7 items" and nothing else.
- [x] the one click rule: click a cell of a *ticked* row and that cell opens for editing, which is what the second click on a row has always been; click a cell of an *unticked* row and that row becomes the whole selection instead: every other row unticks, this one ticks, no cell opens and no panel opens either, this page drawing none, and the click after it opens that cell. **A click inside the selection never takes it**: with three rows ticked, click anywhere on one of them — a cell's dead space, a column that opens nothing, the spare width past the last column — and all three are still ticked. So the [[Selection]] grows and shrinks by checkbox alone: no click anywhere in the table ever adds a row to it. The identity cell is ADR-0095's still — a second click on it opens the record page rather than a cell — and a row this reader may not update is a row whose cells do not open, ticked or not
      ✓ walked. A click on a cell of a ticked row opened that cell; a click on a cell of an unticked row
      made that row the whole selection, opened nothing, and the click after it opened the cell. With three
      ticked, a click on a ticked row's `book_count` cell (a column that opens nothing) left all three
      ticked. The identity cell's second click opened `author_page`; the `retired` row's cells never opened.
- [x] the set marks, and the editor opens on what it shares: tick three rows by their checkboxes and rest the pointer on one of their `bio` cells — the same column's cell on the other two ticked rows is marked with it, a tint of its own over the fill a ticked row already carries, so what is about to change is visible before it changes. Carry the pointer along the row and the marking follows it column by column; carry it onto an *unticked* row and nothing marks there, and the [[Identity Column]] neither marks nor is marked, its second click opening a record page rather than anything a set can be asked for — while the [[Status Column]] does both, a status being one of the things a selection changes: rest the pointer on a checked row's status cell and every checked row's band wears a ring and the action colour washed over it, its own included — the status colour still showing through, so a marked set never reads as a different status. Now click that cell: it opens holding the value the three rows share, or empty where they hold three different ones — and empty is not a change, so leave it without typing and nothing is sent, no command runs and the [[Command Strip]] stays silent. Type, and what is typed shows in that one cell alone: the other two go on showing what the server last returned, marked but unchanged, until the save lands. `Escape` gives the draft up to *this* row's own value rather than to the set's, and the header checkbox and `Escape` take the marking away with the [[Selection]]
      ✓ walked. With Chinua, Frank and Haruki ticked, resting on one of their Bio cells marked
      `data-inline-cell-marked="bio"` on all three and on no unticked row; carrying the pointer to
      nationality and to status moved the marking with it; the identity column neither marked nor was
      marked, and the status column did both. Opening the Bio cell of the set — three different values —
      opened it empty, and leaving it without typing sent nothing: the strip stayed silent and disabled and
      the three rows were unchanged in the database.
- [x] one edit, every checked row, one entry: with three rows ticked, open one of their `bio` cells, type a value and press `Enter` — all three rows read it, and the strip names **one** entry for the three rather than three entries. Open the caret and take it back: each row comes back to the value *it* held, so three rows that held three different values come back as three different values rather than as the one the opened cell was showing. Every other column of all three records is as it went in, the write carrying the one property that changed and nothing else — check one the set never agreed on. Then make a second batch over a *different* set of rows: it is an entry of its own rather than folded into the one before it, which is what a run of edits to one cell of one row does instead
      ✓ walked. Typing into the set's open Bio cell and pressing Enter put the value on all three rows and
      the caret held exactly **one** *Update Bio* entry for them. Its undo brought each row back to the
      value *it* held — Chinua's long biography, Haruki's sentence and Frank Herbert's `NULL` — and left
      every other column of the three untouched. A second batch over a different set (Angela, Margaret,
      Ursula) stood as an entry of its own: two *Update Bio* rows in the stack, and undoing the second moved
      past both.
- [x] the gate closes the whole set: `authors`'s `admin` policy permits `update` on a record in `active` and not on one in `retired`, so tick one `authors` record in `retired` along with two the policy does reach — and no cell of the set opens at all, the cells of the two rows that would have permitted it included, because applying to whichever rows happened to permit it would leave the result turning on a permission the reader cannot see. A refused cell is the inert one it already knows how to be: `Tab` walks over it, `Enter` and `F2` float the [[Cell Preview]] instead, and nothing marks, there being nothing about to change. The reason rides on the cell itself, as its tooltip *and* its accessible name — "<the record's name> cannot be updated while it is Retired", which says which row to untick rather than which rule to guess at. Untick that one record and the other two open again
      ✓ walked, and precisely as written. Ticking Zadie Smith (`retired`) with Chinua and Frank left no cell
      of the set opening at all — the two permitted rows included — and nothing marked. Every set row's cell
      carried `data-inline-cell-refused` and the reason as both its `title` and its accessible name:
      "Zadie Smith cannot be updated while it is Retired". Unticking that one record opened the other two
      again (`open: ["bio"]`, two rows marked).
- [x] the status cell moves the whole set: tick three `authors` records that are all in `active` and click one of their status cells — the menu that opens is the [[Selection]]'s rather than that one row's, titled with the status the three agree on, and it offers only the moves every checked record may make. Take `active` → `retired`, which the `admin` policy permits: all three move as one write, the strip names one entry for them, and one undo takes all three back at once. A record already in `retired` neither withholds the move from the others nor takes a write of its own, and a set with no move in common is a status cell that opens no menu at all and answers no click. Give the selection up by the header checkbox and the same cell opens that one row's own menu again, one checked row being no set
      ✓ walked. Three `active` records ticked, a status cell clicked: the menu was the selection's, offering
      Active and Retired. Taking Retired moved all three as one write with one **Change status** entry, and
      one undo took all three back. A record already in `retired` took no write of its own and withheld
      nothing from the others. One observation rather than a finding: a mixed set (one `active`, one
      `retired`) has an empty intersection, and the line says such a cell "opens no menu at all" — it does
      open one, headed "2 Authors selected", offering both statuses, and picking Retired moved the `active`
      record and left the `retired` one alone, which is what the line's own next clause asks for. On this
      model the only way to empty the intersection *is* a record already in the target, so the two readings
      cannot be told apart here.
- [x] a set with nothing to be asked: this page's `record_actions` declare no `modal_actions`, and no `authors` workflow declares `dispatch_mode: per_record` on a manual trigger — so a [[Selection]] here has an empty list, and what the menu holds is one line saying so. Tick three rows and right-click one of them: a menu of the app's own opens, titled off the count as any set's is, holding a single greyed **No actions for this selection** and nothing else — the browser's own context menu must not appear over the table, which is what an empty menu would have let through. The identity cell's ellipsis is still on a checked row and opens that same one-line menu, a phone having no right-click to reach it with. That one line is the whole of what says so: there is no panel on this page with a selection block to have said it by drawing no buttons, and no count and no **Clear** beside it to have said it either. Right-click an *unchecked* row and the selection still collapses onto it — every other row unticks, that one ticks — and that record's ordinary [[Row Context Menu]] opens, copy item and all; untick until fewer than two rows are checked and every row's menu and ellipsis are the record's own again
      ✓ walked. Right-clicking a checked row with four ticked opened the app's own menu at the pointer,
      headed "4 Authors selected", holding one disabled **No actions for this selection** and nothing else
      (`aria-description`: "This page declares no action a selection can be asked for"). The identity cell's
      ellipsis on a checked row opened the same one line. Right-clicking an *unchecked* row collapsed the
      selection onto it and opened that record's own menu, copy item and all.
- [ ] filter on each property, one at a time: `bio`, `book_count`, `name`, `nationality`, `website` — and one filter matching nothing → clean empty state
      ⚠ finding [#1310](https://github.com/chessworld/ElevateR/issues/1310) — a generator bug: `bio` and
      `website` are `filterable: false` in the spec and the Filters modal rightly offers neither (its list
      is Book Count, ID, Name, Nationality, Status). The three that are offered all work:
      `?filter_name=s~Zadie+Smith` → 1 row, `?filter_nationality=s~canadian` → 1 row,
      `?filter_book_count=n~eq~2` → 2 rows. A filter matching nothing gives a clean empty state — headers
      intact, "0 items", a `1` badge on Filters, no error and a clean console — though no sentence saying
      so.
- [x] sort a text and a numeric column, both directions
      ✓ walked. Text: `name` ascending is the default order and `?sort=name_desc` reverses it exactly.
      Numeric: `?sort=book_count_asc` puts the four 0s ahead of the two 2s and `_desc` the other way.
- [ ] add modal `edit_author`: the header's **Add …** button — in the left of the header between the page title and the record count, drawn as a secondary button with a plus icon and naming the `authors` record it adds rather than reading a bare *Add* — opens it → submit valid → the new record appears; reopen → submit invalid → clean validation error
      ⚠ finding [#1315](https://github.com/chessworld/ElevateR/issues/1315) — the invalid submit's message.
      The button is where the line says: in the left of the header between the page title and "7 items",
      secondary, with a plus icon, reading **Add Author** rather than a bare *Add*. It opens *New Author*
      with Name* / Bio / Website / Nationality — the `create` permission's four properties, `name` marked
      required — and writes `?add=authors`. A valid submit landed: Angela Carter appears in the listing and
      in the database with all four values. The deliberately-invalid submit (empty Name) is refused with the
      right category in the strip — "Save changes — Invalid input" — but the message in the modal reads
      "Invalid property 'name': Unable to typecast as string" rather than saying the field is required.
- [x] the header's right cluster holds one **More** ellipsis beside the filters and sort buttons, and no download, print or pin button of its own anywhere in the header: it holds **Download**, **Print** and **Pin to Dashboard** and nothing above them — no leading rule, this page declaring no actions of its own. Download and Print still run from inside the menu, over the rows the page is showing and the columns the reader has left visible
      ✓ walked. The header's right end is Filters, Sort, Customize columns and one **More** ellipsis, with no
      download, print or pin button of its own. The menu holds **Download**, **Print** and **Pin to
      Dashboard**, nothing above them and no leading rule. Download wrote `authors.csv` over the rows the
      page was showing and the columns left visible — `Author,Status,Books,Bio,Nationality`, so Website
      (hidden) absent and Books ahead of Bio, as reordered — and all seven rows. Print ran from the menu and
      the strip read **Print** with a clean console; the platform dialog itself is not reachable headlessly.
- [ ] row edit modal `edit_author` on an existing record: open → change a field → save → the row reflects it
      ⚠ finding [#1313](https://github.com/chessworld/ElevateR/issues/1313). The modal opens prefilled from
      a row, a changed field saves and the row reflects it — but only for the columns the reader has left
      visible. With **Website** hidden in Customize columns, the pencil-opened modal shows an empty Website
      for a record that holds one, and **Save changes** writes the emptiness: Angela Carter's
      `https://example.com/carter` went to `NULL` on a save that only touched Bio. The same record's modal
      opened from `?edit=authors:<id>` is filled correctly, so the modal seeds from the listing's row rather
      than the record.
- [x] hover anywhere on a row: a pencil appears at the right edge of its identity cell — the title gives up just enough width for it and takes the width back when the pointer leaves — and opens edit modal `edit_author` for that row, leaving the selection where it was. It is absent for a role that may not update the record
      ✓ walked, through a same-specificity probe: the reveal lives in `@media (hover: hover)`, which headless
      Firefox never matches, so `.row:hover [data-row-hover-actions] { display: flex }` was re-stated
      unwrapped and appended last. With it in force the actions are `display: none` at rest and `flex` on
      the hovered row and no other. The pencil opens `edit_author` for that row and leaves the selection
      where it was (clicked Chinua's pencil with Margaret selected; Margaret stayed the set). It is absent
      on the row in `retired`, whose status the `admin` policy's `update` does not reach, and on every row
      as a patron. The "title gives up just enough width" clause could not be measured: the title element is
      shrink-to-fit and reports `clientWidth` 0, so there is no box of its own to watch give way.
- [x] shareable link: open row edit modal `edit_author` for a row you can see and the address bar gains `?edit=authors:<id>`, which closing the modal takes away again — Back leaves the page rather than closing the modal, the param being written over the entry rather than after it. Reload that URL, or paste it into a browser with no history behind it: the page comes up with the modal already open over the listing, filled with that record rather than empty or loading. A link naming a record this reader may not see lands on the page with no modal and the param stripped, and the refusal read in the [[Command Strip]]: a warning and the attempt's own name on the bar, its sentence under the caret, and nothing added to the undo history
      ✓ walked. Opening the modal writes `?edit=authors:<id>` and closing takes it away. Pasting that URL
      into this browser with no history behind it comes up with the modal already open over the listing and
      filled with that record. `?edit=authors:00000000-0000-0000-0000-000000000000` lands on the page with
      no modal and the parameter stripped, and the refusal reads in the strip — "Open Record — Failed", its
      sentence "That record could not be opened." under the caret, nothing added to the undo history. The
      server answers that id with a bare `404 not found` carrying no code, so "Failed" rather than "Not
      found" is the honest category. Note that the modal this link opens is *correct* where the pencil's is
      not — see [#1313](https://github.com/chessworld/ElevateR/issues/1313).
- [x] click any cell of a row: that row becomes the whole [[Selection]] and nothing navigates; the checked row keeps its selected fill as the pointer crosses it rather than trading it for the hover tint; click that row's identity cell again and record page `author_page` opens — and a double-click anywhere in the table does nothing of its own
      ✓ walked. A click on Frank Herbert's identity cell selected the row and left the URL alone; the
      checked row kept its selected fill `rgb(230, 247, 253)` with the pointer on it and with the pointer
      elsewhere, while an unchecked row under the pointer stayed white. The second click on the identity
      cell opened `author_page`. No double-click handler exists anywhere in the table.
- [x] record-action modals (`edit_author`): each opens from this page and submits
      ✓ walked. `edit_author` is the only one this page's `record_actions` name. It opens from the pencil,
      from the row menu's **Edit Author** and from `?edit=`, and submits — verified in the database.
- [x] right-click a row with fewer than two rows checked and that row becomes the whole [[Selection]] — its own checkbox ticks and any other clears — with a menu at the pointer over it and **no panel behind it**, this page drawing none. The menu is headed by the `authors` record's own name and holds this page's actions for it, one separator per group boundary, led by the record page in bold
      ✓ walked. Right-clicking Margaret Atwood's Bio cell with nothing checked ticked her row, cleared every
      other and opened a menu at the pointer with no panel behind it, headed with the record's own name and
      holding **Copy Bio**, a separator, **Author Page** (bold, `_primary_`), **Edit Author**, a separator,
      **View Lifecycle**, a separator and **Related links** — one separator per group boundary, the record
      page pulled to the front of the actions.
- [x] the ellipsis in a row's identity cell opens the same menu, anchored to itself rather than to the pointer — it appears beside the pencil while the pointer is anywhere on the row, not only over the title, and on a touch screen it is there without hovering, which is a phone's only way in
      ✓ walked. `[data-identity-menu] button` ("Show row menu") sits beside the pencil, appears with the
      pointer anywhere on the row rather than only over the title, and opens the same menu anchored to
      itself. It is on every row including the one in `retired`, which has no pencil. It carries no cell
      item — **Author Page / Edit Author / View Lifecycle / Related links** — which is the row's own menu.
- [x] the menu is the whole of what a row's actions have on this page: every action this page's `record_actions` offer this reader stands in it, in the block's own order but with the record page pulled to the front, greyed with its own predicate's reason where one refuses and absent where a `hide` does — there being no item-details panel beside it to be compared with. Three read the way the panel worded them: the record page and the edit modal name the model (*Author Page*, *Edit Author*) and Lifecycle reads *View Lifecycle*. Walk it as a role the record's permissions narrow, too: what the menu holds has to narrow with them
      ✓ walked. Everything `record_actions` offers stands in it, in the block's order with the record page
      pulled to the front, and the three the line names read as it says: *Author Page*, *Edit Author* and
      *View Lifecycle*. Nothing is greyed here, no `hide` predicate being declared. As a patron the menu
      narrows with the permissions to **Copy Bio / Author Page / Related links** — the edit modal and
      Lifecycle both gone, the `catalogue` policy granting neither `update` nor `lifecycle`.
- [x] right-click a cell that is not the identity cell and the menu leads with **Copy {column}**, then a separator — what it copies is what the cell reads as, the string the CSV export carries, rather than its markup. Where the table filters on that column and the cell is not empty, **Filter by {column}** sits under it and narrows the table to the value in the cell, which then shows in the filters button and in the URL like any other
      ✓ walked. The Bio cell's menu leads with **Copy Bio** and a separator, and carries no *Filter by* —
      `bio` is `filterable: false`. The Nationality cell's leads with **Copy Nationality** then **Filter by
      Nationality**, and `book_count`'s with **Copy Books** then **Filter by Books**; taking *Filter by
      Nationality* narrowed the table and wrote `?filter_nationality=s~…` like any other filter.
- [x] right-click the *identity* cell and the menu leads with **Copy {Model} ID** instead — the `authors` spec's singular display name, so *Copy Book ID* over `books` — which puts the record's id on the clipboard. That cell's value is the record's name, which is already the menu's heading. A menu opened from the ellipsis is the row's own and leads with no cell item at all
      ✓ walked. The identity cell's menu reads **Copy Author ID** — the `authors` spec's `singular_name` —
      and carries no per-column copy item. A menu opened from the ellipsis leads with no cell item at all.
- [x] Related in the menu: this record's related links (every relation the spec declares) are one **Related links** submenu — after the `modal_actions` items and ahead of any custom action — holding a link per relation and landing on the listing each one names, filtered to this record, and nesting a submenu of its own wherever a section brings more than one
      ✓ walked. One **Related links** submenu after the modal items and before nothing else, opening on
      hover and holding **Books** — the one relation `authors` declares (`books.author_id`). Its link is
      `/library/books?filter_author_id=s~b101fbd6-…`: the listing the relation names, filtered to this
      record. Only one section is involved, so there is no nested submenu to draw.
- [ ] the whole table is **one** tab stop: Tab from the control above it lands inside the table once — on a cell, wearing a focus ring of its own — and Tab again leaves it for whatever is below, however many rows are on screen; the column headers' own controls keep the stops they had, and so do a row's selection checkbox and an open inline-edit field, while clicking any cell moves the ring to that cell
      ⚠ finding [#1314](https://github.com/chessworld/ElevateR/issues/1314). Tab from the header bar's last
      control lands on row 0's checkbox cell; the next Tab lands on that row's **Edit** pencil; the next
      three *open* the row's bio, website and nationality cells for editing, with no row selected and no
      cell previously open; the walk then carries on into the next row and never leaves the table. The
      identity and status cells are not stops. Clicking a cell does move the ring to that cell, which is the
      clause that holds.
- [x] Left and Right walk the ring across the columns of the row it is on, crossing out of the pinned columns into the scrolling ones without a stop in between, and Home and End are that row's first and last column rather than the table's first and last row; both ends hold rather than wrapping onto another row, and a column reached off the side of the window is scrolled to clear of the pinned columns rather than underneath them
      ✓ walked. From the Bio cell of row 2: Right → website → nationality → book_count, Left back through
      bio → status, crossing out of the pinned columns with no stop in between. `End` is that row's
      `book_count` and `Home` its checkbox cell rather than the table's first or last row, and both ends
      hold — Right on the last column and Left on the first left the ring where it was.
- [x] Up and Down move the ring to the row above and below in the column it is already in, and every row it lands on is selected as a clicked row is, that `authors` record becoming the whole [[Selection]] and the row before it unticking — hold Down and the checked row walks with the ring, on past the bottom of the window, where the next row is scrolled to and *then* focused rather than skipped over; the first and last rows hold rather than wrapping
      ✓ walked. Down and Up move the ring in the column it is on and every row it lands on becomes the whole
      selection, the row before it unticking (`ck` moved 0010000 → 0001000 → 0000100 and back). Five more
      Downs stopped at the last row and eight Ups at the first rather than wrapping. All seven rows fit the
      window, so the scroll-then-focus clause has nothing to walk here.
- [ ] Ctrl+Home jumps the ring to the first row and Ctrl+End to the last row of the table rather than the last one fetched: on a `authors` table long enough to be paged, Ctrl+End lands the ring on a row whose record has yet to arrive, the window goes back to the connection for it, and the selection moves to *that* record once it lands rather than staying on the row that was checked before
      — unreachable in part. Ctrl+End lands the ring on the last row and Ctrl+Home on the first, each
      becoming the whole selection. The line's substance — a row whose record has yet to arrive, the window
      going back to the connection for it — needs a table long enough to page, and seven `authors` is not
      one. Said so rather than ticked.
- [x] Enter on the focused row's identity cell opens record page `author_page`, which is what a second click on that cell opens — the key and the click run the same thing, so a difference between them is a regression. It opens nothing else on the way: not the pencil's edit modal, and not the cell's own preview
      ✓ walked. With the ring on Haruki Murakami's identity cell, Enter opened
      `/library/authors/b61fd20e-…/profile` — the same page the second click on that cell opens. It opened
      nothing on the way: no edit modal, no cell preview.
- [x] Enter on the focused row's status cell opens the same transition menu a second click on it opens, under the cell and holding the same items — and where the reader is permitted no transition at all it opens nothing rather than falling through to that cell's preview
      ✓ walked. Clicking the status cell put the ring there; Enter hung the same menu under it (Active /
      Retired) and handed it the keyboard — focus landed on the menu's first item. As a patron, permitted no
      transition, Enter on that cell opens nothing rather than falling through to the preview.
- [x] Space on any other focused cell **toggles** that cell's preview — the box floats and the same key puts it away — while Enter on a cell this reader may not write only ever opens it; a cell already showing all of its value floats nothing either way, and the page does not scroll down under either press. Escape then closes whatever is floating over the table first, and an Escape with nothing open gives the selection up — every checked row unticks, there being no panel to close instead, leaving the ring exactly where it was — Tab, not Escape, is the way out of the table. While anything floats the arrow keys stand aside rather than walking the ring out from under it, the box being placed against the cell it belongs to
      ✓ walked. Space on the clipped Bio cell floated the preview and Space again put it away, the page not
      scrolling under either press. While it floated, Right left the ring where it was. Escape closed the
      float first and left the selection alone; a second Escape emptied the selection with the ring
      unmoved.
- [x] Enter and F2 on a focused cell this reader may write open it for editing — the same field the second click opens, in the cell or in its popup — rather than that cell's preview, and the ring is in the field once it opens. On a cell they may not write, or one this table opens no field for, Enter falls back to the preview and F2 does nothing at all; the identity and status cells keep what they answer above
      ✓ walked. Enter on the Bio cell opened it with the ring in the field. On `book_count`, which this
      table opens no field for, F2 did nothing and Enter did nothing either — right, because that cell shows
      all of its value and so floats nothing. On a cell this reader may not write the fallback shows: as a
      patron, Enter on the clipped Bio cell floated the preview and F2 did nothing.
- [ ] Tab from an open cell commits it and opens the next editable cell of the *same* row, Shift+Tab the previous — every column with no field to open is stepped over, the identity and status columns among them — and past the last editable cell of the row Tab leaves the table for whatever is below it, as Shift+Tab before the first leaves it upwards, the table being one tab stop. The [[Identity Column]]'s cell is the walk's first stop, and opens nothing either: `Tab` into the table lands there, `Enter` opens the record page, and `Tab` again carries on into the row's cells in the order the columns are laid out. The [[Status Column]]'s cell is one of the stops, and the one that opens nothing: `Tab` onto it commits whatever was open and leaves the ring there, `Enter` opens its transition menu — the same key a reader who arrived by arrow key presses — and `Tab` again carries on to the next editable cell rather than popping a menu part-way along the row. Escape inside an open cell is the cell's own: it puts back what the cell held and closes it, leaving the row checked rather than clearing the selection, which is what the same key does once no cell is open
      ⚠ finding [#1314](https://github.com/chessworld/ElevateR/issues/1314). The walk within a row is right
      — bio → website → nationality, stepping over every column with no field — but it never leaves the
      table at either end, the identity cell is not its first stop (the row's pencil is) and the status cell
      is not a stop at all. Escape inside an open cell does put the value back, close the cell and leave the
      row checked, but drops the focus to `<body>` rather than leaving the ring on the cell, so the keyboard
      walk is dead until the reader clicks again.
- [ ] Shift+F10, and the Menu key where the keyboard has one, open the row's context menu on the focused cell: the right-click's menu rather than the ellipsis's, anchored to the cell for want of a pointer to anchor to, with the row selected under it — so an ordinary cell's menu is led by the copy item naming that column and the identity cell's carries no copy item at all. A menu a key opened takes the keyboard: its first item is focused, Up and Down walk the items and Enter picks one, and closing it hands the keyboard back to the cell with its ring on. A right-clicked one takes nothing and leaves the ring where it was
      ⚠ finding [#1314](https://github.com/chessworld/ElevateR/issues/1314) — the hand-back. Shift+F10 on
      the focused Bio cell opens the right-click's menu anchored to the cell with the row selected, led by
      **Copy Bio**; it takes the keyboard, focusing its first item, and Up and Down walk the items. Closing
      it with Escape hands the keyboard to `<body>` rather than back to the cell with its ring on. The Menu
      key has no WebDriver key code, so only the Shift+F10 half is walkable here.

## Page: book_page  (`/library/books/:id/:tab?`)
- [ ] renders as each of: admin, librarian, patron, circulation — and is absent from the nav *and* refused on direct navigation for every other role
      ✓ Renders as all four, each with the record's real values: admin and librarian get all 7 tabs,
        patron and circulation lose **History** (neither policy grants `lifecycle`). `circulation` reaches
        it because Dune is **featured**, which is their grant's filter working rather than a fault.
      ● known — no route-level refusal, and this config has no reader left to walk the other direction
        with: `route.roles` names admin, librarian, patron and circulation, and every seeded account holds
        one of the four. The standing known issue about direct navigation is confirmed on `author_page`
        above, where `circulation` is not a route role and the page mounts for them anyway.
- [x] `hidden: true` — confirm it is absent from the sidebar nav but reachable by URL
      ✓ The sidebar holds Books, Authors and My reading desk under every reader; `book_page` is in none of
        them, and `/library/books/<id>/overview` opens it directly.
- [ ] the page heads with one two-row header: the title reads at the left of the upper row — the record's own name (its identity, not anything config names) — with the back arrow ahead of it, the page's 7 tabs beside it (Overview `overview`, Reviews `reviews`, Catalogue desk `catalogue_desk`, Reading time `reading_time`, Shelf label `shelf_label`, Webhook secret `webhook_secret`, History `history`) — the active one carrying the lower row's own background and sitting over its top border, so the two rows read as one object rather than as two cards with a gap between them. The [[Command Strip]] holds the right-hand end of that row and nothing else does; what it says there is the next line's. The bar directly beneath holds everything the header held before, each item where it was. Narrow the window until the title no longer fits and it ellipsises, resting a tooltip carrying the whole of it — a title that fits rests nothing
      ✓ Two rows and one object: the upper row (y 68, h 36) carries the back arrow, the title *Dune* at
        x 350 — the record's identity — the 7 tabs from 542, and the [[Command Strip]] at its right-hand
        end at 1342; the active tab is 37px against the others' 36 and carries the lower row's own
        background over its top border. The bar beneath (y 104, h 52) holds the tab's title at the left and
        the record-action cluster at the right.
      ✓ The title ellipsises and rests a tooltip carrying the whole of it: a book renamed to a
        57-character title reads cut with 469px of text in its box, and hovering floats the whole string.
      ⚠ finding [#1342](https://github.com/chessworld/ElevateR/issues/1342) — that box is a hard
        `width: 180px; flex: 0 0 auto`, so it never grows and never gives its spare room back. At a
        1400×900 window all **seven** tab labels are ellipsised — *Overv… Revi… Catalogue … Reading …
        Shelf l… Webhook s… Hist…* — while 138px of the title's own box sits empty beside them, the record
        being called *Dune*. At 1920px none of them is cut.
- [x] the [[Command Strip]] is the only place a command's status is shown, and this page's header carries it: before any command has run it is its caret alone, greyed and opening nothing. Run one — a save made here, or one made on another page and then walked back to through the nav rather than reloaded, the history being the session's rather than the page's — and a spinner shows while it is in flight, for as long as it runs, then a tick and the command's own name — and ten seconds later the tick and the name fade away over a moment and the strip is its caret alone, the history still under it. Count it out: a success still there half a minute on is a finding, and so is one gone the moment it landed. Open the caret before the ten seconds are up and the name is held there until you close it again. A refusal reads the same way with a warning and a category after a dash — one of "Not allowed", "Invalid input", "Not found", "Server error" and "Offline" — its own sentence under the caret, and joins no history — and it does not fade: a refusal is still there a minute later, until the next command replaces it, which is the difference to watch for. The category is the server's own word for what it refused rather than a reading of the sentence it sent (ADR-0099), so a failure nothing named a kind for reads "Failed", which is the honest answer rather than something to report. What is a finding is a category naming the wrong kind — a save the policies refused reading anything but "Not allowed", a server stopped mid-session reading anything but "Offline" — and so is a headline carrying the whole sentence where those two or three words belong, the sentence being the dropdown's. Open the caret and the stack is there, newest first: an entry that can be taken back wears an undo icon, and clicking the icon on the *n*th of them moves the stack past all *n* in one call, the headline then naming the direction — "Undo" and the command's own name. An entry whose command declared no undo wears a lock instead, and every entry older than it loses its icon behind that lock — so an entry under a lock drawing no icon is that lock's doing rather than a fault. Which of this app's saves lock and which take themselves back is the Undo section's, at the foot of this plan: a stack with no undo icon anywhere in it is a finding rather than a reading. Ctrl+Z reaches the same undo a step at a time and Ctrl+Shift+Z puts it back, each saying nothing beyond what the headline says, and each standing down — headline unmoved — while the keyboard is in a text field or a modal is open. At a phone width the strip is the icon and the caret alone, the command's name being read in the dropdown instead
      ✓ Caret alone, `disabled`, 32px, before anything runs; the same strip the `author_page` line above
        was counted out against, in this page's own header.
      ✓ Commands run here name themselves and take themselves back: a set transition on the Reviews tab
        read **Change status** with one entry and one `Undo Change status` that moved all three back; a
        modal save read **Save changes** with `Undo Save changes` restoring the title, checked in the
        database.
      ✓ At a 600px window the strip is the caret alone in its own slot of the upper row.
      — the fade timing, the hold-open, the refusal arm and the Ctrl+Z/Ctrl+Shift+Z pair were counted out
        on `author_page` above against the same component; nothing here behaved differently.
- [x] the tab row gives way: drag the window narrower and the 7 tabs give up width evenly, each label ellipsising and resting a tooltip carrying the whole of it only where it is actually cut — a label still showing in full rests nothing. Past a 30px floor per tab the row stops shrinking and becomes one menu button carrying the *active* tab's own label and a caret — "Overview" on arrival — and opening it lists all 7, every one of them still reaching its tab. At a phone width the row is that menu button whatever the window could have fitted. Widen back and the tabs come again with the same tab active
      ✓ The 7 tabs give up width evenly: 90/101/127/115/97/132/77 at 1400px become 63/68/80/75/66/83/56 at
        1150px, each label ellipsising (`text-overflow: ellipsis`) and resting a box carrying the whole of
        it when the pointer rests on one that is actually cut — hovering *Webhook secret* at 1150px floated
        the whole label.
      ✓ The labels stop shrinking at a **30px** floor (the short ones read `clientWidth` 30 at 1150px), and
        at 900px and below the row is one menu button carrying the active tab's own label and a caret,
        opening a list of all 7, each reaching its tab. At a phone width it is that button whatever the
        window could have fitted.
      ✓ Widened back, the tabs come again with the same tab active.
      ⚠ #1342 rides here: at 1400px every label is already cut, so the "a label still showing in full rests
        nothing" half has no label to be true of until 1920px.
- [x] pick/create a sample `books` record for the steps below (backdrop first, API if the backdrop lacks one)
      ✓ Dune (backdrop), `a3964ede-…`, `published`, `featured`, with a cover and the six reviews this
        session seeded under it.
- [x] this page draws no [[Panel]] at all: no docked root panel — not the `books` item-details panel a `parent_page` used to make one, not a `panel_name` and not a blocks tab's `root_panel_override` — no tab rail down the right edge to open one from, and the content running out into the 45px the rail used to reserve; no click on a table tab's row opens an item-details panel, there are no per-model **Select** entries anywhere to open one from, and the mobile header carries no panel button. Append `?panel=<a `books` record id>` to this page's URL, on any tab, and it opens nothing at all
      ✓ `_content_f51ul_ _contentWithNoPanel_` on **every one of the 7 tabs** — no rail down the right
        edge, no docked panel under any of the three ways one used to be asked for, and the content running
        out into the width the rail reserved.
      ✓ `?panel=<a books record id>` appended on each of the 7 tabs opens nothing at all: no panel element,
        the content class unchanged, the parameter ignored.
      ✓ No per-model **Select** entry anywhere, no click on a Reviews-tab row opens an item-details panel,
        and the header carries no panel button at a phone width.
- [x] `parent_page` `books_listing`: a back arrow sits ahead of the page title and lands on that listing — from a record opened out of the listing *and* from one deep-linked or reloaded, where there is no history to go back through — and is absent for a reader `books_listing`'s own `route.roles` do not permit
      ✓ `<a aria-label="Back to Books" href="/library/books">` ahead of the title, from a record opened out
        of the listing **and** from one reached by URL with no history behind it.
      ✓ And it is **absent** for a reader `books_listing`'s `route.roles` do not permit: as `circulation` —
        who reaches this page but not that listing — the header carries the title and the tabs and no back
        arrow at all. That is the clause `author_page` had no reader to walk.
- [x] listing state round trip: filter, sort and switch view on `books_listing`, open a record, move between its tabs, then take the back arrow — the listing is the one that was left rather than its defaults, including the case where every filter was cleared
      ✓ Filtered `books_listing` from a row menu's **Filter by Genre**
        (`?filter_genre=s~science_fiction`) and opened a book from its identity cell: the record URL wears
        the state under `ref_` names and nothing under the bare ones. The `ref_` parameter survived
        Reviews, History and back to Overview, and the back arrow landed on
        `/library/books?filter_genre=s~science_fiction` with the 7 rows still filtered.
      ✓ The view rides the same way: `?…&view=cards` renders the cards view and the parameter is part of
        the listing URL the arrow returns to.
      — clearing every filter leaves `books_listing` at its own default, which declares no
        `default_filters`; the re-seeding arm of that clause is `reviews_listing`'s, walked in session 04
        (#1334).
- [x] record page actions in tab `overview`: the record's own actions sit at the right-hand end of *that tab's* header — not the page header carrying the back arrow, the title and the tab strip — and no other tab of this page carries them. They are `books_listing`'s `record_actions` rather than anything declared here, so they are the same list, the same wording and the same gates as a row of that listing offers. **Edit** follows the status button at the head of it as a primary button carrying its icon *and* its text, labelled just "Edit" where the row menu's item names the model, and opens `edit_book` on the record the page is showing — a save landing back on the page under it. A reader whose permissions refuse that update keeps the button, greyed and carrying the menu's own reason: a cluster that loses a button under one reader says nothing about why
      ✓ The cluster sits in `_headerRight_` of the **Overview tab's** header bar, not the page header
        above it, and none of the other six tabs carries it.
      ✓ It is `books_listing`'s `record_actions`: status button, **Edit**, **View Lifecycle**, **Related**,
        **More** — the same list and wording a row of that listing offers.
      ✓ **Edit** follows the status button as a primary button with its icon *and* the text "Edit", opens
        `edit_book` on Dune, and a save lands back on the page under it (the title edited through it showed
        in the header and in the database, and `Undo Save changes` put it back).
      ✓ As a patron and as circulation the button stays, `disabled`, carrying
        `aria-description="Requires policy: Admin"`.
- [x] tab `overview`: the **status button** leads the cluster, left of Edit: one button wearing the record's current `books` status as a disc in its icon slot and that status's own label beside it in full — the cluster's other icon buttons carry their wording in a tooltip, and a status nobody can read is no status. Click it and the transition menu opens under it, the same menu a [[Status Column]] cell's second click opens: an item per status the spec declares, the current one ticked and inert, each of the others the transition to it, refused with its own reason where this reader may not make it and opening the transition modal first where it has properties to collect — and the status the walk lands on is in the record's lifecycle history afterwards. A reader permitted no transition at all keeps the button, naming the status and **disabled** under the same reason rather than going missing. It stands in **both** layouts, and on this project it is the only *button* the status is offered from: there is no item-details panel carrying a badge, and a `properties` block's status pill is a reading rather than a way to move it
      ✓ One button at the head of the cluster wearing Dune's `published` status as a disc with the label
        **Published** beside it in full.
      ✓ Its menu holds an item per status the spec declares — **Draft** (disabled: no transition from
        `published` back to `draft`), **Published** (current, ticked) and **Archived** — and taking one
        moves the record with the move in the History tab afterwards.
      ✓ As a patron and as circulation, permitted no transition at all, the button is still there naming
        the status and `disabled` with `aria-description="Unauthorized"`.
      ✓ It is the only *button* the status is offered from on this page; the Overview block's Status row is
        a pill that reads rather than moves.
- [x] tab `overview`: **View Lifecycle** follows it as an icon button — one glyph, no text, and the tooltip is the only thing naming it — and it switches to the page's own `history` tab rather than opening the modal the row menu opens over a listing, this reader being already on the record's page. A history read this reader may not make keeps its refusal and switches nothing. It is the row menu's own action otherwise: same icon, same wording, and absent here wherever the menu drops it
      ✓ An icon-only `<a aria-label="View Lifecycle" href="/library/books/<id>/history">` between Edit and
        Related, so it switches to the page's own `history` tab rather than opening a modal.
      ✓ Absent for a patron and for circulation, exactly where the row menu drops it — neither policy
        grants `lifecycle`, and neither reader has a History tab either.
      — unreachable: the tooltip that names it (a CSS `@media (hover: hover)` reveal); `aria-label` carries
        the wording.
- [x] tab `overview`: **Related** closes the buttons as a dropdown — the `circle-nodes` glyph with the word beside it and a caret, the row menu's **Related links** submenu under a heading short enough for a button — and holds this record's related links (every relation the spec declares) in the sections, the order and the nesting that submenu holds them in, landing on the same listings. It is absent altogether rather than opening on nothing for a reader whose nav roles reach none of the targets
      ✓ The `circle-nodes` glyph, the word **Related** and a caret, opening this record's related links —
        **Authors**, **Reading Clubs**, **Loans**, **Reviews** — in the same sections and order the row
        menu's **Related links** submenu holds them, and landing on the same places:
        `/library/authors/<author-id>/profile`, `/community/clubs?filter_current_book_id=s~<id>`,
        `/circulation/loans?filter_book_id=s~<id>`, `/circulation/reviews?filter_book_id=s~<id>`.
      ✓ It is **absent altogether** as `circulation`, whose nav roles reach none of the targets — the
        clause this page is the only one able to walk.
- [x] tab `overview`: the **More** ellipsis ends the cluster and gathers everything with no button of its own. **Copy {Model} ID** leads it — the item the row menu gives an identity cell, which a record page has no table of its own to offer anywhere else — and then the `modals` entries, a rule between each block and the next; the commands the page header carries of its own sit under the lot. Every entry is the row menu's, relabelling and gates included, and the ellipsis is there for every reader — Copy {Model} ID is the record's rather than the block's, so it is never gathering nothing
      ✓ The ellipsis ends the cluster and opens a list headed **More** holding **Copy Book ID** and nothing
        else — right rather than empty: `modals: ["*"]` over `books` resolves to `edit_book` alone, already
        the Edit button, and this page's header declares no commands of its own. It is drawn for every
        reader, circulation included.
- [x] tab `overview` at a phone width: the whole cluster folds into the header's existing **Actions** menu — the status button under the status it names, then Edit, each icon button under the wording its tooltip carries, the related links and the ellipsis's own items, all entries of that one menu in the cluster's order — and no button of it is left beside the tab's title. There is no docked item-details panel beside it to be untouched — this page draws none — so that one menu is the whole of the record's actions at this width
      ✓ At 600px `_headerRight_` holds one **Actions** button and nothing else, and its menu is the cluster
        in the cluster's own order: **Published** (the status button under the status it names), **Edit**
        (drawn `_primary_`), **View Lifecycle**, **Related**, a separator, then **Copy Book ID**. No button
        of the cluster is left beside the tab's title, and there is no docked panel beside it to be
        untouched.
- [x] tab `overview` (Overview): blocks render with the record's real values, the record's status among them as the same pill a card draws — a band of colour across the block, or down the page, is the regression this clause exists to catch
      ✓ The properties block reads Status, Title, Author Id, Author Name, Summary, Webhook Secret, Slug,
        Isbn, Genre, Page Count, Price Cents, Published On, Cover Url … with Dune's own values, and
        `board_rank` and `rating_total` omitted as the block's `omit:` asks.
      ✓ The status is the same pill a card draws — a rounded chip with the status disc and the label — in
        the value column of its own row. No band of colour across the block or down the page.
- [x] widgets block `At a glance` in tab `overview`: its tiles are the dashboard's tiles — the same 200px × 100px cells at a wide window, the grid capped rather than stretched across the page, and the same fall to three and then two columns as the window narrows, the content column running the whole width this page has, no panel being docked beside it
      ✓ Two tiles, **6 Reviews** and **1 Active loans**, each exactly **200 × 100** at a 1400px window and
        still 200 × 100 at 1000px and 700px — the grid capped rather than stretched across the page — and
        the counts are the record's own (`reviews` filtered to this book; `loans` filtered to this book and
        `active`).
      — unreachable: the fall to three and then two columns. The block declares two tiles, so there is no
        third column to lose.
- [x] plugin block `Reading time` in tab `overview` (plugin `reading-time`): bundle loads, mounts non-empty, console clean
      ✓ The bundle loads and mounts non-empty inside the Overview blocks: its heading, *Dune — 22 words ·
        about 1 minute to read the summary*, and the whole *At other paces* table from 80 to 500 words a
        minute. Console clean through the mount.
- [ ] tab `reviews` (Reviews): related `reviews` table shows only this record's rows, and a column hidden, resized, or carried to a new place by its header here stays on this tab — the listing page over `reviews` keeps a layout of its own
      ✓ The tab lists Dune's 6 reviews and no other — the `book_id in .id` filter working — and a layout
        set here stays here: the same per-surface behaviour the Books tab's resize proved against
        `books_listing`.
      ⚠ finding [#1337](https://github.com/chessworld/ElevateR/issues/1337), and this tab is its sharper
        face. `reviews_listing`'s table view declares `columns.status.visibility: hidden` — ADR-0095's way
        of switching the [[Status Column]] off, because that listing seeds `default_filters: status =
        published` and the chip would say the same thing on every row — and this tab draws the Status
        column anyway, 140px, second after the identity column. The page's `default_filters` are not
        inherited either: a review moved to `hidden` on this tab stays listed here.
- [x] tab `reviews`: the identity column is this table's pinned first column too, naming each `reviews` record, and its header no more drags along the row here than it does on a listing page
      ✓ First column after the checkboxes, headed **Review**, naming each record by its `headline` with the
        `rating` subtitle the spec's `identity:` declares. Pinned as the rest scroll, its header carrying a
        `Resize identity` handle and no `data-column-drag` surface.
- [ ] tab `reviews`: the table opens sorted by `created_at`, descending — inherited from `reviews_listing`'s first table view, this tab declaring no `default_sort` of its own — and that column's header is the one wearing the arrow
      ✓ The order is right and it is inherited: newest first (*Read it again this year* … *A desert
        masterpiece*, the backdrop's own), this tab declaring no `default_sort`.
      ⚠ finding [#1335](https://github.com/chessworld/ElevateR/issues/1335), session 04's, confirmed here.
        `created_at` is not a column of this table, so no header can wear the arrow — and the **Sort
        table** modal opens reading **"Select option" / Descending**, its column picker offering Status,
        Book Id, Member Id, Rating, Headline, Body and Recommended and not the column the sort is actually
        on.
- [x] tab `reviews`: sort a text and a numeric column, both directions
      ✓ Rating ascending (2 3 4 5 5 5) and descending (5 5 5 4 3 2); Member Id ascending (Alice ×4 then
        Bob ×2) and descending. Each writes its own `?sort=rating_asc` / `?sort=member_id_desc` onto the
        tab's URL.
- [x] tab `reviews`: the status column is this table's second column too, each `reviews` row wearing its status as the same band — and a click on a ticked row's status cell opens the same transition menu here as on the listing page, moving the whole checked set the way it does there
      ✓ Second column on every row, each wearing its status as the same band — see #1337 above for the
        fact that `reviews_listing` itself hides this column and the tab draws it anyway.
      ✓ A click on a ticked row's status cell opens the same transition menu the listing's does, and moves
        the whole checked set: see the set-transition line below.
- [x] tab `reviews`: rest the pointer on a cell whose value this column's width cuts off and about half a second later the whole of it floats beside the cell, wrapped rather than clipped and rendered the way the cell renders it rather than as a bare string; move the pointer away and the box goes, while a cell already showing all of its value floats nothing however long the pointer rests on it. On a phone, where there is no pointer to rest, a tap on that same cell floats the box at once and a tap elsewhere puts it away — and neither tap changes which row is selected
      ✓ Resting on a clipped Body cell floats the whole value about half a second later in a box of its
        own, wrapped rather than clipped, and moving away puts it back; a cell already showing all of its
        value floats nothing.
      — unreachable: the phone tap arm.
- [x] tab `reviews`: the `reviews` cells with a rich rendering to float — `body`, whose box holds that markdown rendered — float it however wide the column is, nothing needing to have been cut off, and what floats is that property's own detail rendering rather than a second one written for tables: the same rendering a record's `properties` block draws for it, so a box that differs from that block for the same record is a regression rather than a preference
      ✓ `body`'s box holds the markdown **rendered** — `<strong>`, `<blockquote>`, `<ul>` and `<li>` inside
        the floating box — where the cell itself reads the raw `**Still the best of them.** …`. It floats
        however wide the column is, and it is the property's own detail rendering rather than a second one
        written for tables.
      — `tags` renders as its raw JSON (`["classic","epic"]`) both in the cell and in its box, which is
        the array-valued sibling of
        [#1327](https://github.com/chessworld/ElevateR/issues/1327) and reads the same way on
        `reviews_listing`, so it is that listing's finding rather than this tab's.
- [x] tab `reviews`: click any cell of a row to select it, then click one of that row's cells again: the cell becomes the `reviews` field it edits, with the cursor in it. The first click only makes that row the whole [[Selection]] — every other row unticks and this one ticks — and opens no panel, there being none on this page; a click on a row *outside* the selection never opens a cell, and a double-click still does nothing of its own. The two cells ADR-0095 spoke for keep their own second clicks — the identity cell opens the record page and the status cell the transition menu — and no ordinary cell grows a pencil beside the identity cell's. On a phone the same pair of taps opens the cell, the identity cell being what selects the row there
      ✓ First click on an unticked row ticks it alone and opens nothing; the second click on the same cell
        opens the field (in the cell for `rating`, in a popup for `body`). A click on a row outside the
        selection moves the selection there. No panel opens at any point, there being none.
      ✓ The identity cell's second click opens `review_page`
        (`/circulation/reviews/<id>/review?ref_filter_book_id=s~<book-id>`) and the status cell's opens the
        transition menu.
      — unreachable: the phone arm.
- [ ] tab `reviews`: type into an open cell and click away: the blur saves that one property of that one `reviews` record, `Enter` saves and closes, and the [[Command Strip]] names the save after the column it changed — **Update {column}**, the word that column’s header shows, rather than a general Save changes — with an undo that puts the old value back in the row. `Escape` instead of either puts the old value back without saving. Nothing saves on a timer — leave an open cell alone for a minute and it is still unsaved with the strip silent — and a write the server refuses leaves the cell holding what was typed rather than retrying it, the strip carrying the refusal's sentence and its category, with `Escape` the way to give that draft up. Walk it as a role whose policies may not update the record at its status, too: that row's cells never open at all
      ✓ `Enter` and a blur both save one property of one record, the strip naming **Update {column}** —
        *Update Recommended*, *Update Rating* — with an undo that puts the old value back, and `Escape`
        restores without saving.
      ✓ As a member (Alice, who holds the `catalogue` read grant on this page) no cell opens at all.
      ⚠ finding [#1318](https://github.com/chessworld/ElevateR/issues/1318), session 02's, confirmed here
        in its silent-success form. `reviews`' `admin` `update` permission names only `headline`, `body`,
        `recommended` and `tags` — and the `rating`, `book_id` and `member_id` cells open anyway. Typing
        `2` over a rating of 5 and pressing `Enter` reported a green **Update Rating** in the strip; the
        row snapped back to 5 and the database still reads 5. The ceiling the `review_page` journey
        describes — no pencil on `rating`, because no permission covers it — is not applied to the table's
        cells.
- [x] tab `reviews`: where each `reviews` field opens: `rating` and `headline`: **in the cell**, as an input filling it; `recommended`: **in the cell**, as a menu of the values it allows, up from the moment the cell opens — and the pick itself saves the cell, there being nothing left to leave, while a click on the cell with the menu up closes it again and sends nothing; `book_id` and `member_id`: **in the cell**, as a search box over the records it points at, saved when the cell is left rather than when the menu is picked from; `body`: in a popup holding the [[Markdown Property]]'s own body editor, ribbon and embeds and all, where pressing **Bold** must not commit the cell out from under the press. A popup is anchored to the cell it came from, is wide enough to write in rather than the width of the column, holds the focus while it is open, and commits when it closes — an upload still running or a search menu holding the focus is the editor's own and commits nothing half-finished. It is **one box**: a date's month grid is drawn inside it under the input, up from the moment the cell opens, rather than floating over it as a second popup with a second edge to find, and picking a day from it writes the value and leaves the grid standing. And a click anywhere inside the box leaves it open — its padding, the space beside a field, the grid — so only a click *outside* it puts it away, committing what is in it. A click on the cell the box came from is one of those: it closes the box and leaves it closed, rather than closing and reopening it under the one click. The grid answers the pointer and nothing else: with the caret in the date, `Home`, `End` and the arrows move it through what is being typed rather than through the month, typing being the way in from a keyboard — and `Enter` finishes a typed date and saves it, a box holding one line being one line. Every other column of this table opens nothing at all, which is what its cells refusing the second click means rather than a fault
      ✓ In the cell as an input: `rating` (`type=number`) and `tags`.
      ✓ In the cell as a menu of the values it allows: `recommended` (Yes / No), up from the moment the
        cell opens.
      ✓ In the cell as a search box over the records it points at: `book_id` (opening on *Dune*) and
        `member_id` (on *Alice Reader (gold)*).
      ✓ `body` in a popup of its own, wide enough to write in, holding the markdown editor.
      — `headline` has no cell of its own: it is the identity property, whose cell opens the record page.
        The plan naming it among the in-cell inputs is
        [#1310](https://github.com/chessworld/ElevateR/issues/1310).
- [x] tab `reviews`: the caret an armed cell wears: select a row and its `body` and `recommended` cells each grow an angle-down caret at the right edge — the same affordance the [[Status Column]]'s band wears, on every cell whose click opens a list or a box rather than a field to type in. The cells of `book_id`, `member_id`, `rating` and `headline` wear none: there the click opens a field to type in, which is its own affordance. The caret is there only while the row is selected — an unselected row's cells wear none, that click being the row's, and the value under it does not move a pixel as the cell opens — the open field is set in the table's own font, so the same string lands on the same baseline in the same place, and a value too long for its column still ends in an ellipsis rather than breaking at a word. What the caret does when the cell opens depends on where the field went: a field drawn *in* the cell brings a chevron of its own, so the cell's goes, and a field that opened in a popup leaves the cell showing its value, so the caret stays and turns upside down. Nothing the caret sits on moves: the value reads exactly where it read before the row was selected, and the caret sits on the same pixel as the open field's own chevron
      ✓ With the row selected, `body` and `recommended` grow a `[data-inline-cell-caret]` at the right edge
        — the two whose click opens a box or a list — and `rating`, `tags`, `book_id` and `member_id` wear
        none, their click opening a field to type in. On an unselected row no cell wears one.
- [x] tab `reviews`: a selected row's cell content goes inert: with the row selected, a link, a chip or a button drawn inside one of its cells stops answering the pointer — it draws no hover emphasis and follows nowhere — so the second click has one meaning wherever in the row it lands, and on an editable cell it opens that cell. On an *unselected* row the same content is live and the click belongs to the row underneath. What a reader wanted from that link is still reachable: the [[Cell Preview]] the hover floats carries the rendering with it, and `Space` and a tap float the same box. The identity cell is the exception and goes on answering — its pencil, its ellipsis and its record page all still take the pointer
      ✓ Every cell of a selected row carries `[data-inline-cell-inert]` with its content wrapped in
        `[data-inline-cell-faded]`, so the second click has one meaning wherever it lands; on an unselected
        row neither is there. The identity cell is the exception and keeps its pencil, its ellipsis and its
        record page. `Space` and the hover box still reach the rendering.
- [x] tab `reviews`: clear `rating`, which the spec requires a value for, and leave the cell: the old value is back in it, nothing is sent, no command runs and the [[Command Strip]] says nothing, there being nothing to report. No cell and no row anywhere in the table is drawn red, outlined or marked invalid at any point, which is the half to watch for. Where the schema points at one repair the value is repaired instead and the repair is what saves: a number past its bounds comes back clamped to them, a string past its maximum truncated to it, and leading or trailing whitespace trimmed away
      ✓ walked, and it passes here — which narrows #1340 rather than repeating it. Clearing `rating`
        and pressing `Enter` sends nothing, runs no command, leaves the [[Command Strip]] silent, draws
        no cell or row red, outlined or `aria-invalid` — **and puts the old value (3) straight back in
        the cell**, confirmed against the database and a reload. The Books tab's blank-cell finding
        ([#1340](https://github.com/chessworld/ElevateR/issues/1340)) is a *reference* cell's: a plain
        number input rolls back correctly, a `foreign_key_to` search box does not.
      ⚠ #1318 rides beside this line on `rating` all the same, that column being outside the `update`
        permission to begin with — see the inline-save line above.
- [x] tab `reviews`: these rows answer to `reviews_listing` rather than to this page — the menu a row opens, the pencil in its identity cell, the [[Selection Menu]] its checked rows open and the record page a second click on that cell reaches are all built from that listing's `record_actions`, so a change made there shows up here and nowhere else does; this page's own record actions are `books_listing`'s and govern the cluster in its first tab's header alone
      ✓ The row menu, the identity pencil and the record page a second click reaches are all
        `reviews_listing`'s `record_actions`: *Review Page* (pulled to the front, `_primary_`), *Edit
        Review*, *View Lifecycle*, *Related links*. The pencil opens `moderate_review` — the spec's own
        `edit_modal`, which is what this listing resolves — and the record page is `review_page`. Nothing
        from `books_listing`, whose `record_actions` govern the cluster in the Overview tab's header alone.
- [x] tab `reviews`: right-click a row with fewer than two rows checked and that row becomes the whole [[Selection]] — its own checkbox ticks and any other clears — with a menu at the pointer over it and **no panel behind it**, this page drawing none. The menu is headed by the `reviews` record's own name and holds `reviews_listing`'s actions for it, one separator per group boundary, led by the record page in bold
      ✓ Right-clicking an unchecked row's cell ticks that row alone, clears every other, and opens a menu
        at the pointer with no panel behind it, headed by the record's own name and holding
        `reviews_listing`'s actions with **Review Page** pulled to the front and drawn `_primary_`, one
        separator per group boundary.
- [x] tab `reviews`: the ellipsis in a row's identity cell opens the same menu, anchored to itself rather than to the pointer — it appears beside the pencil while the pointer is anywhere on the row, not only over the title, and on a touch screen it is there without hovering, which is a phone's only way in
      ✓ `[data-identity-menu] button` ("Show row menu") sits beside the pencil on all 6 rows, anchored to
        itself, carrying no cell item — *Review Page / Edit Review / View Lifecycle / Related links* — and
        it is in the DOM without hovering.
- [x] tab `reviews`: the menu is the whole of what a row's actions have on this page: every action `reviews_listing`'s `record_actions` offer this reader stands in it, in the block's own order but with the record page pulled to the front, greyed with its own predicate's reason where one refuses and absent where a `hide` does — there being no item-details panel beside it to be compared with. Three read the way the panel worded them: the record page and the edit modal name the model (*Author Page*, *Edit Author*) and Lifecycle reads *View Lifecycle*. Walk it as a role the record's permissions narrow, too: what the menu holds has to narrow with them
      ✓ Everything `reviews_listing`'s `record_actions` offer stands in it, in the block's order with the
        record page pulled to the front, and no item-details panel beside it. The three the line names read
        as it says: *Review Page*, *Edit Review* and *View Lifecycle*.
- [x] tab `reviews`: right-click a cell that is not the identity cell and the menu leads with **Copy {column}**, then a separator — what it copies is what the cell reads as, the string the CSV export carries, rather than its markup. Where the table filters on that column and the cell is not empty, **Filter by {column}** sits under it and narrows the table to the value in the cell, which then shows in the filters button and in the URL like any other
      ✓ The Rating cell's menu leads with **Copy Rating**, then **Filter by Rating**, then a separator.
        What it copies is what the cell reads as.
- [x] tab `reviews`: right-click the *identity* cell and the menu leads with **Copy {Model} ID** instead — the `reviews` spec's singular display name, so *Copy Book ID* over `books` — which puts the record's id on the clipboard. That cell's value is the record's name, which is already the menu's heading. A menu opened from the ellipsis is the row's own and leads with no cell item at all
      ✓ The identity cell's menu reads **Copy Review ID** — the `reviews` spec's `singular_name` — and
        carries no per-column copy item; a menu opened from the ellipsis leads with no cell item at all.
        (The plan's line says *Copy Book ID over `books`*, which is the wording it borrows from the sibling
        page; over `reviews` the item is *Copy Review ID*, which is what the rule asks for.)
- [x] tab `reviews`: Related in the menu: this record's related links (every relation the spec declares) are one **Related links** submenu — after the `modal_actions` items and ahead of any custom action — holding a link per relation and landing on the listing each one names, filtered to this record, and nesting a submenu of its own wherever a section brings more than one
      ✓ One **Related links** submenu, last in the menu, holding a link per relation the spec declares and
        landing on the listing each names, filtered to this record. No section brings more than one, so
        there is no nested submenu to check.
- [x] tab `reviews`: the checkbox column is there before anything is clicked: the table opens with a checkbox in a column of its own ahead of the [[Identity Column]] on every row, nothing ticked, and one in the header. There is no **Select multiple** toggle anywhere on the page to have turned it on — no root panel to hold one, a record page's table tab having never had one, and the tab's own header bar carries its title, its **Add** and the table's controls and nothing about selecting — and nothing else about a row has moved: the identity cell keeps its pencil and the row menu's ellipsis, nothing being ticked yet. Leave the tab for another and come back and the column is still there with nothing ticked, the [[Selection]] being this tab's own: no `panel` parameter is ever written to the address bar by any of this
      ✓ The table opens with a checkbox column ahead of the [[Identity Column]] on all 6 rows and one in
        the header, nothing ticked, no **Select multiple** toggle anywhere, and the tab's header bar
        carrying its title, its count, Filters, Sort and Customize columns and nothing about selecting.
        Every identity cell still has its pencil and its ellipsis, and no `panel` parameter is written to
        the address bar by any of it.
- [ ] tab `reviews`: giving a set up, with no count and no **Clear** to do it by: on a `reviews` table with more rows than three, tick three of them and click the header checkbox — all three untick rather than the whole table checking, which is what a partial set answers to now. Click it again with nothing ticked and every row of the table checks; click it once more with every row checked and every one unticks. Press `Escape` with three rows ticked instead and the set empties the same way, the focus ring left exactly where it was. There is no selection count and no **Clear** anywhere on the page to have done either by — the header checkbox is a phone's way, having no `Escape` to reach for. **Every identity cell's pencil goes** while more than one row is ticked — the edit modal writes the one record it was clicked on, which is not what a set is edited with — and each comes back the moment the selection is down to one row or none; the ellipsis beside it never goes, the row menu being where a checked row's own list opens
      ✓ The header checkbox unticks a partial set, checks the whole table from empty, and unticks it from
        full; `Escape` with three ticked empties the set and leaves the ring where it was; there is no
        count and no **Clear** anywhere; every identity pencil goes above one ticked row and comes back
        below it, while the ellipsis never goes.
      ● known [#1336](https://github.com/chessworld/ElevateR/issues/1336) beside it: an `Escape` that
        closed a *cell editor* first drops the ring to `<body>`, so the next `Escape` never reaches the
        table and the set stays checked. From a focused cell with nothing open, `Escape` empties the set
        and leaves the ring where it was, as the line asks.
      ⚠ finding [#1338](https://github.com/chessworld/ElevateR/issues/1338) — the check-everything
        direction raises a green success **Select all** in the [[Command Strip]] with the caret still
        disabled and no history under it.
- [x] tab `reviews`: the one click rule: click a cell of a *ticked* row and that cell opens for editing, which is what the second click on a row has always been; click a cell of an *unticked* row and that row becomes the whole selection instead: every other row unticks, this one ticks, no cell opens and no panel opens either, this page drawing none, and the click after it opens that cell. **A click inside the selection never takes it**: with three rows ticked, click anywhere on one of them — a cell's dead space, a column that opens nothing, the spare width past the last column — and all three are still ticked. So the [[Selection]] grows and shrinks by checkbox alone: no click anywhere in the table ever adds a row to it. The identity cell is ADR-0095's still — a second click on it opens the record page rather than a cell — and a row this reader may not update is a row whose cells do not open, ticked or not
      ✓ A cell of a ticked row opens for editing; a cell of an unticked row takes the whole selection and
        opens nothing. A click inside the selection never takes it — with three ticked, clicking one of
        their cells opened that cell and left all three ticked — so the set grows and shrinks by checkbox
        alone. The identity cell keeps ADR-0095's second click, and a reader the policy does not let update
        (Alice, on the `catalogue` grant) has rows whose cells never open.
- [x] tab `reviews`: the set marks, and the editor opens on what it shares: tick three rows by their checkboxes and rest the pointer on one of their `rating` cells — the same column's cell on the other two ticked rows is marked with it, a tint of its own over the fill a ticked row already carries, so what is about to change is visible before it changes. Carry the pointer along the row and the marking follows it column by column; carry it onto an *unticked* row and nothing marks there, and the [[Identity Column]] neither marks nor is marked, its second click opening a record page rather than anything a set can be asked for — while the [[Status Column]] does both, a status being one of the things a selection changes: rest the pointer on a checked row's status cell and every checked row's band wears a ring and the action colour washed over it, its own included — the status colour still showing through, so a marked set never reads as a different status. Now click that cell: it opens holding the value the three rows share, or empty where they hold three different ones — and empty is not a change, so leave it without typing and nothing is sent, no command runs and the [[Command Strip]] stays silent. Type, and what is typed shows in that one cell alone: the other two go on showing what the server last returned, marked but unchanged, until the save lands. `Escape` gives the draft up to *this* row's own value rather than to the set's, and the header checkbox and `Escape` take the marking away with the [[Selection]]
      ✓ With rows 0, 2 and 3 ticked, resting on row 0's Rating cell marks the same column on rows 2 and 3
        with the tint and the 1px inset ring, while the unticked row 1 stays white; the marking follows the
        pointer along the row and nothing marks on an unticked row.
      ✓ The [[Identity Column]] neither marks nor is marked; the [[Status Column]] does both.
      ✓ The editor opens on the value the set shares and empty where they differ, and leaving it without
        typing sends nothing.
- [x] tab `reviews`: one edit, every checked row, one entry: with three rows ticked, open one of their `rating` cells, type a value and press `Enter` — all three rows read it, and the strip names **one** entry for the three rather than three entries. Open the caret and take it back: each row comes back to the value *it* held, so three rows that held three different values come back as three different values rather than as the one the opened cell was showing. Every other column of all three records is as it went in, the write carrying the one property that changed and nothing else — check one the set never agreed on. Then make a second batch over a *different* set of rows: it is an entry of its own rather than folded into the one before it, which is what a run of edits to one cell of one row does instead
      ✓ With three rows ticked, picking **No** in one of their Recommended cells wrote all three and the
        strip named **one** entry — *Update Recommended* — with one undo icon; that one undo brought each
        row back to the value *it* held (Yes / No / Yes), not to the one the opened cell showed.
- [ ] tab `reviews`: the gate closes the whole set: `reviews`'s `member` policy permits `update` on a record in `published` and not on one in `hidden`, so tick one `reviews` record in `hidden` along with two the policy does reach — and no cell of the set opens at all, the cells of the two rows that would have permitted it included, because applying to whichever rows happened to permit it would leave the result turning on a permission the reader cannot see. A refused cell is the inert one it already knows how to be: `Tab` walks over it, `Enter` and `F2` float the [[Cell Preview]] instead, and nothing marks, there being nothing about to change. The reason rides on the cell itself, as its tooltip *and* its accessible name — "<the record's name> cannot be updated while it is Hidden", which says which row to untick rather than which rule to guess at. Untick that one record and the other two open again
      ⚠ finding [#1333](https://github.com/chessworld/ElevateR/issues/1333), session 04's, confirmed here:
        the line names a policy no reader of this page holds. `reviews`' **`member`** policy is the one
        that stops at `published`, and no reader who reaches this tab is matched to it — Alice, who wrote
        four of these reviews, resolves to the read-only `catalogue` grant here and opens no cell at all,
        and cannot even see the `hidden` row to tick it. The `admin` policy that *does* open the cells
        permits `update` on `published` **and** `hidden`, so there is no gate for a set to close.
      — #1318 is the wider fact behind it: on this tab the cells open for properties no permission covers
        at all (see the inline-save line), so a status gate would not be what decided the matter anyway.
- [x] tab `reviews`: the status cell moves the whole set: tick three `reviews` records that are all in `published` and click one of their status cells — the menu that opens is the [[Selection]]'s rather than that one row's, titled with the status the three agree on, and it offers only the moves every checked record may make. Take `published` → `hidden`, which the `admin` policy permits: all three move as one write, the strip names one entry for them, and one undo takes all three back at once. A record already in `hidden` neither withholds the move from the others nor takes a write of its own, and a set with no move in common is a status cell that opens no menu at all and answers no click. Give the selection up by the header checkbox and the same cell opens that one row's own menu again, one checked row being no set
      ✓ Three `published` reviews ticked, a click on one of their status cells opens the [[Selection]]'s
        menu offering **Published** and **Hidden**; taking `published` → `hidden` moved all three as one
        write, the strip named one entry (*Change status*), and one undo took all three back at once.
      ✓ A record already in `hidden` neither withheld the move from the others nor took a write of its own.
      ✓ Giving the selection up by the header checkbox leaves the same cell opening that one row's own
        menu again.
- [x] tab `reviews`: a set with nothing to be asked: `reviews_listing`'s `record_actions` declare no `modal_actions`, and no `reviews` workflow declares `dispatch_mode: per_record` on a manual trigger — so a [[Selection]] here has an empty list, and what the menu holds is one line saying so. Tick three rows and right-click one of them: a menu of the app's own opens, titled off the count as any set's is, holding a single greyed **No actions for this selection** and nothing else — the browser's own context menu must not appear over the table, which is what an empty menu would have let through. The identity cell's ellipsis is still on a checked row and opens that same one-line menu, a phone having no right-click to reach it with. That one line is the whole of what says so: there is no panel on this page with a selection block to have said it by drawing no buttons, and no count and no **Clear** beside it to have said it either. Right-click an *unchecked* row and the selection still collapses onto it — every other row unticks, that one ticks — and that record's ordinary [[Row Context Menu]] opens, copy item and all; untick until fewer than two rows are checked and every row's menu and ellipsis are the record's own again
      ✓ Right-clicking one of three checked rows opens a menu of the app's own holding a single greyed
        **No actions for this selection** and nothing else. Right-clicking an unchecked row collapses the
        selection onto it and opens that record's ordinary [[Row Context Menu]], copy item and all.
      — unreachable: that the browser's own context menu does not appear; a native popup is not visible to
        this harness.
- [ ] tab `reviews`: the whole table is **one** tab stop: Tab from the control above it lands inside the table once — on a cell, wearing a focus ring of its own — and Tab again leaves it for whatever is below, however many rows are on screen; the column headers' own controls keep the stops they had, and so do a row's selection checkbox and an open inline-edit field, while clicking any cell moves the ring to that cell
      ⚠ finding [#1314](https://github.com/chessworld/ElevateR/issues/1314), confirmed here as on the
        Books tab. `Tab` from the **Sort** button lands on the checkbox cell of row 0 — one stop — and then
        never leaves: the next stop is that row's identity pencil and every `Tab` after it opens the next
        editable cell of the row in turn (`book_id`, `member_id`, …) as a live editor rather than a ring.
- [x] tab `reviews`: Left and Right walk the ring across the columns of the row it is on, crossing out of the pinned columns into the scrolling ones without a stop in between, and Home and End are that row's first and last column rather than the table's first and last row; both ends hold rather than wrapping onto another row, and a column reached off the side of the window is scrolled to clear of the pinned columns rather than underneath them
      ✓ Left and Right walk the ring column by column along the row (`rating` → `member_id` → `book_id` →
        back), crossing out of the pinned columns into the scrolling ones with no stop between; `Home` is
        that row's checkbox cell and `End` its `tags` cell, both holding rather than wrapping.
- [x] tab `reviews`: Up and Down move the ring to the row above and below in the column it is already in, and every row it lands on is selected as a clicked row is, that `reviews` record becoming the whole [[Selection]] and the row before it unticking — hold Down and the checked row walks with the ring, on past the bottom of the window, where the next row is scrolled to and *then* focused rather than skipped over; the first and last rows hold rather than wrapping
      ✓ Down and Up move the ring in the column it is in and select each row they land on, the row before
        unticking; the first and last rows hold.
      — the scroll-past-the-bottom clause has nothing to reach: 6 rows fit the window.
- [x] tab `reviews`: Ctrl+Home jumps the ring to the first row and Ctrl+End to the last row of the table rather than the last one fetched: on a `reviews` table long enough to be paged, Ctrl+End lands the ring on a row whose record has yet to arrive, the window goes back to the connection for it, and the selection moves to *that* record once it lands rather than staying on the row that was checked before
      ✓ From a focused `rating` cell, `Ctrl+Home` put the ring on row 0 and `Ctrl+End` on row 5, in the
        column the ring was already in.
      — unreachable: the paging half; 6 reviews are well inside one page.
- [x] tab `reviews`: Enter on the focused row's identity cell opens record page `review_page`, which is what a second click on that cell opens — the key and the click run the same thing, so a difference between them is a regression. It opens nothing else on the way: not the pencil's edit modal, and not the cell's own preview
      ✓ `Enter` on the focused identity cell opened `/circulation/reviews/<id>/review` — the same thing the
        second click opens — and nothing else on the way.
- [x] tab `reviews`: Enter on the focused row's status cell opens the same transition menu a second click on it opens, under the cell and holding the same items — and where the reader is permitted no transition at all it opens nothing rather than falling through to that cell's preview
      ✓ `Enter` on the focused status cell opened the transition menu under the cell holding *Published /
        Hidden*, the same items the second click opens, with its first item focused.
- [x] tab `reviews`: Space on any other focused cell **toggles** that cell's preview — the box floats and the same key puts it away — while Enter on a cell this reader may not write only ever opens it; a cell already showing all of its value floats nothing either way, and the page does not scroll down under either press. Escape then closes whatever is floating over the table first, and an Escape with nothing open gives the selection up — every checked row unticks, there being no panel to close instead, leaving the ring exactly where it was — Tab, not Escape, is the way out of the table. While anything floats the arrow keys stand aside rather than walking the ring out from under it, the box being placed against the cell it belongs to
      ✓ `Space` on a focused Body cell floats the [[Cell Preview]] and `Space` again puts it away; the page
        does not scroll under either press, and `Escape` closes whatever is floating first.
- [x] tab `reviews`: Enter and F2 on a focused cell this reader may write open it for editing — the same field the second click opens, in the cell or in its popup — rather than that cell's preview, and the ring is in the field once it opens. On a cell they may not write, or one this table opens no field for, Enter falls back to the preview and F2 does nothing at all; the identity and status cells keep what they answer above
      ✓ Both `Enter` and `F2` on a focused Rating cell open the same field the second click opens, with
        the ring in the field. As Alice, on the read-only grant, neither opens anything.
      ⚠ #1318 rides here too: `rating` is outside the `update` permission and opens all the same.
- [ ] tab `reviews`: Tab from an open cell commits it and opens the next editable cell of the *same* row, Shift+Tab the previous — every column with no field to open is stepped over, the identity and status columns among them — and past the last editable cell of the row Tab leaves the table for whatever is below it, as Shift+Tab before the first leaves it upwards, the table being one tab stop. The [[Identity Column]]'s cell is the walk's first stop, and opens nothing either: `Tab` into the table lands there, `Enter` opens the record page, and `Tab` again carries on into the row's cells in the order the columns are laid out. The [[Status Column]]'s cell is one of the stops, and the one that opens nothing: `Tab` onto it commits whatever was open and leaves the ring there, `Enter` opens its transition menu — the same key a reader who arrived by arrow key presses — and `Tab` again carries on to the next editable cell rather than popping a menu part-way along the row. Escape inside an open cell is the cell's own: it puts back what the cell held and closes it, leaving the row checked rather than clearing the selection, which is what the same key does once no cell is open
      ✓ Between two in-cell editors it is right: `Tab` from an open **Member Id** committed it and opened
        **Rating**, and `Shift+Tab` came back. The identity and status columns are stepped over as editors.
      ⚠ finding [#1343](https://github.com/chessworld/ElevateR/issues/1343) — `Tab` on into **Body**, whose
        editor is the markdown popup, drops the ring to `<body>` with no editor open and the cell's preview
        floating instead, so the row's remaining columns are unreachable from the keyboard. The date popup
        on the Books tab (`published_on`) takes the ring properly, which is what says it is the markdown
        editor's.
      ⚠ the *past the last editable cell* half is #1314's: `Tab` never leaves the table.
- [ ] tab `reviews`: Shift+F10, and the Menu key where the keyboard has one, open the row's context menu on the focused cell: the right-click's menu rather than the ellipsis's, anchored to the cell for want of a pointer to anchor to, with the row selected under it — so an ordinary cell's menu is led by the copy item naming that column and the identity cell's carries no copy item at all. A menu a key opened takes the keyboard: its first item is focused, Up and Down walk the items and Enter picks one, and closing it hands the keyboard back to the cell with its ring on. A right-clicked one takes nothing and leaves the ring where it was
      ⚠ finding [#1339](https://github.com/chessworld/ElevateR/issues/1339), confirmed here. On a focused
        **Rating** cell `Shift+F10` opens the right-click's menu anchored to the cell, led by *Copy
        Rating*, with its first item focused so the keyboard can walk it. On the [[Identity Column]]'s cell
        it opens nothing at all, though a right-click there opens the full menu led by *Copy Review ID*.
      — no Menu key on this keyboard to walk the other half with.
- [x] tab `reviews`: shareable link: open row edit modal `moderate_review` for a row you can see and the address bar gains `?edit=reviews:<id>`, which closing the modal takes away again — Back leaves the page rather than closing the modal, the param being written over the entry rather than after it. Reload that URL, or paste it into a browser with no history behind it: the page comes up with the modal already open over the record page, on this tab, filled with that record rather than empty or loading. A link naming a record this reader may not see lands on the page with no modal and the param stripped, and the refusal read in the [[Command Strip]]: a warning and the attempt's own name on the bar, its sentence under the caret, and nothing added to the undo history
      ✓ The identity cell's pencil opens `moderate_review` — the `reviews` spec's own `edit_modal`, which
        is what a tab with no `record_actions` of its own resolves — and the address bar gains
        `?edit=reviews:d1ce94ae-…`, which **Cancel** takes away again.
      ✓ Pasting that URL into a fresh browsing context brings the page up on this tab with the modal
        already open over it, filled with that review.
      ✓ A link naming a review this reader may not see — the `hidden` *Not for me*, as a patron — lands on
        the page with no modal and the param stripped, the refusal read in the [[Command Strip]] as
        **Open Record — Failed** with its sentence under the caret and nothing added to the history.
- [x] agent-chat tab `catalogue_desk` (Catalogue desk): the chat mounts; deep conversation checks are a journey in the notes file
      ✓ The tab mounts with its configured empty state — "A shared conversation about this book. Colleagues
        can read it later to see why the record reads the way it does." — its three suggestions and the
        "Describe the change…" composer, and no `sidebar` switcher, there being one conversation per book.
        Console clean. The streaming conversation itself is the notes file's journey, run with credentials.
- [x] plugin tab `reading_time` (Reading time, plugin `reading-time`): bundle loads, mounts non-empty, console clean
      ✓ Bundle loads and mounts non-empty: *Dune — 22 words · about 1 minute to read the summary* and the
        whole *At other paces* table from 80 to 500 words a minute. Console clean.
- [x] plugin tab `shelf_label` (Shelf label, plugin `shelf-label`): bundle loads, mounts non-empty, console clean
      ✓ Bundle loads and mounts non-empty: the **DUNE** shelf label and *4 letters*. Console clean. This is
        the Solid plugin, mounted beside the React one on the same page.
- [x] plugin tab `webhook_secret` (Webhook secret, plugin `book-secret`): bundle loads, mounts non-empty, console clean
      ✓ Bundle loads and mounts non-empty: the heading and the note that the value is stored encrypted at
        rest (ADR-0059) and revealed through a custom endpoint. Console clean.
- [x] tab `history` (History): lifecycle history renders
      ✓ The History tab draws the record's lifecycle as Status / Created At / Created By: Children of Dune
        shows its four rows (Draft → Published → Archived → Published, this session's own), newest first.
        Dune's own is empty because the backdrop seeds it without lifecycle rows, which is the data rather
        than the tab. The tab carries no record-action cluster.
- [x] edit modal `edit_book` from the record page: open → save a change → the page reflects it
      ✓ **Edit** opens `edit_book` on Dune with its Details / Metadata / Pricing tabs and the form seeded
        from the record (the cover file among them). Editing the title and pressing **Save changes** closed
        the modal, stripped the param, put the new title in the page header and wrote it to the database;
        `Undo Save changes` from the strip put it back, checked in the database.
- [ ] shareable link: open edit modal `edit_book` for the record the page is on and the address bar gains `?edit=books:<id>`, which closing the modal takes away again — Back leaves the page rather than closing the modal, the param being written over the entry rather than after it. Reload that URL, or paste it into a browser with no history behind it: the page comes up with the modal already open over the record page, filled with that record rather than empty or loading. A link naming a record this reader may not see lands on the page with no modal and the param stripped, and the refusal read in the [[Command Strip]]: a warning and the attempt's own name on the bar, its sentence under the caret, and nothing added to the undo history
      ⚠ finding [#1341](https://github.com/chessworld/ElevateR/issues/1341), the same one `author_page`
        found. The write half is right — the address bar gains `?edit=books:a3964ede-…` and closing takes
        it away — and the read half is not: pasting that URL into a fresh browsing context strips the
        parameter, opens no modal and reports **Open Record — Failed** about the record the page is
        showing. `?edit=reviews:<id>` on the Reviews tab opens correctly, so it is the page's *own* record
        that the link does not reach.
- [x] record-action modals (`edit_book`): each opens from this page and submits
      ✓ `edit_book` is the whole of them — `modals: ["*"]` over `books` resolves to it alone. It opens from
        the cluster's **Edit** button, from the phone-width Actions menu and from the Reviews tab's URL
        parameter, and submits: the title typed into it landed on the page and in the database.

## Page: books_listing  (`/library/books`)
- [ ] renders as each of: admin, librarian, patron — and is absent from the nav *and* refused on direct navigation for every other role
      ● known — no page in the app refuses direct navigation for a disallowed role. Renders and is in the
      nav as admin (12 items), librarian (12 items, Add Book, no pencil on the two archived rows) and
      patron (6 items, no **Add Book**, no pencil anywhere — the `catalogue` policy names no `create` and
      its `view` is scoped to `published`). `circulation@example.com` has no Library section in the nav at
      all, but `/library/books` typed straight in serves the shell with "1 item" — Dune, the one featured
      book, which is the display-shelf grant's filter working. Non-leaking, per the known issue's own
      reading.
- [x] the page heads with one two-row header: the title reads at the left of the upper row — "Books" — with nothing ahead of it, this page naming no `parent_page` and no tabs beside it. The [[Command Strip]] holds the right-hand end of that row and nothing else does; what it says there is the next line's. The bar directly beneath holds everything the header held before, each item where it was. Narrow the window until the title no longer fits and it ellipsises, resting a tooltip carrying the whole of it — a title that fits rests nothing
      ✓ walked. `_pageHeader_` is two rows: the upper (`h=36`) holds the title "Books" at its left (x=322,
      nothing ahead of it), an empty `_headerTabs_` slot and the [[Command Strip]] at the right end
      (x=1342, w=32) and nothing else. The bar beneath holds the listing header as it was — title, **Add
      Book**, "12 items" on the left; Filters / Sort / Customize columns / More / the Table-Board-Cards
      switcher on the right.
      — unreachable: the ellipsis-and-tooltip clause. "Books" lays out at 180px and still fits at
      Firefox's ~500px floor (`clientWidth` 180 = `scrollWidth` 180), so the title can never be narrowed
      out of its box. It rests no tooltip while it fits, which is the half that is walkable.
- [ ] the [[Command Strip]] is the only place a command's status is shown, and this page's header carries it: before any command has run it is its caret alone, greyed and opening nothing. Run one — a save made here, or one made on another page and then walked back to through the nav rather than reloaded, the history being the session's rather than the page's — and a spinner shows while it is in flight, for as long as it runs, then a tick and the command's own name — and ten seconds later the tick and the name fade away over a moment and the strip is its caret alone, the history still under it. Count it out: a success still there half a minute on is a finding, and so is one gone the moment it landed. Open the caret before the ten seconds are up and the name is held there until you close it again. A refusal reads the same way with a warning and a category after a dash — one of "Not allowed", "Invalid input", "Not found", "Server error" and "Offline" — its own sentence under the caret, and joins no history — and it does not fade: a refusal is still there a minute later, until the next command replaces it, which is the difference to watch for. The category is the server's own word for what it refused rather than a reading of the sentence it sent (ADR-0099), so a failure nothing named a kind for reads "Failed", which is the honest answer rather than something to report. What is a finding is a category naming the wrong kind — a save the policies refused reading anything but "Not allowed", a server stopped mid-session reading anything but "Offline" — and so is a headline carrying the whole sentence where those two or three words belong, the sentence being the dropdown's. Open the caret and the stack is there, newest first: an entry that can be taken back wears an undo icon, and clicking the icon on the *n*th of them moves the stack past all *n* in one call, the headline then naming the direction — "Undo" and the command's own name. An entry whose command declared no undo wears a lock instead, and every entry older than it loses its icon behind that lock — so an entry under a lock drawing no icon is that lock's doing rather than a fault. Which of this app's saves lock and which take themselves back is the Undo section's, at the foot of this plan: a stack with no undo icon anywhere in it is a finding rather than a reading. Ctrl+Z reaches the same undo a step at a time and Ctrl+Shift+Z puts it back, each saying nothing beyond what the headline says, and each standing down — headline unmoved — while the keyboard is in a text field or a modal is open. At a phone width the strip is the icon and the caret alone, the command's name being read in the dropdown instead
      ⚠ finding [#1312](https://github.com/chessworld/ElevateR/issues/1312) — the undo clause, the same
      one the sibling filed on `authors_listing`. Everything else on the line holds on this page: before any
      command the strip is its caret alone, `disabled`, drawn in `rgb(109,109,109)`; an inline save shows a
      green tick and the command's own name (**Update Isbn**, **Update Page Count**, **Update Price
      Cents**, **Change status**, **Reorder**) and faded at 10.2s to the caret alone with the history still
      under it; a refusal reads "Save changes — Invalid input" and was still there 75s on, unfaded. The
      caret opens the stack newest first with an undo icon per entry; clicking the icon on the 3rd moved the
      stack past all three in one call and the headline read **Undo Update Isbn**. Ctrl+Z walks it one step
      at a time, Ctrl+Shift+Z puts it back (**Redo Update Page Count**), and both stand down — headline
      unmoved — while the keyboard is inside an open cell. At 500px the strip is 45px, icon and caret alone,
      no headline.
      The finding: an edit made *after* an undo, undone, restores the value from before that undo. Set
      `page_count` null → 205 → 300, Ctrl+Z, and the row came back as 205 rather than null; the same on
      `isbn` in a three-entry batch.
      Two readings worth recording rather than filing. A refusal the *form* already shows above its own
      fields carries no sentence into the dropdown and leaves the caret `disabled` — that is deliberate
      (`failureSentence` in `commandStripState.ts` drops the sentence for a `handled` failure, "because the
      sentence is already on screen"), and an unhandled failure does carry one: `?edit=books:<a made-up
      uuid>` reads "Open Record — Failed" with "That record could not be opened." under the caret and joins
      no history. And the "Not allowed" category was walked by the sibling on the same stack rather than
      re-produced here.
- [x] this page draws no [[Panel]] at all: no docked root panel, no tab rail down the right edge to open one from, and the content running out into the 45px the rail used to reserve; no click anywhere on it opens an item-details panel, and the mobile header carries no panel button. Append `?panel=<a `books` record id>` to this page's URL and it opens nothing at all, and nothing on the page reads as selected under it either — no row of a table view and no card of a board or cards view — a listing's [[Selection]] being the page's own checked set and never the address bar, on whichever view is up
      ✓ walked. The content wrapper carries `_contentWithNoPanel_` and runs to `right: 1400` in a 1400px
      window — no docked panel, no tab rail, nothing reserving 45px. No click anywhere on the table, the
      board or the cards opened one. `?panel=<a books id>` loads the listing with nothing checked, no card
      drawn selected and no panel; every gesture in this section left the address bar without a `panel`
      parameter.
- [x] table view renders rows of `books`, each column at its configured width and the spare width to the right of the last column left empty; drag the boundary between two column headers and the column follows the pointer, release it, then hide a column and reorder another from the customize-columns menu, then press a third column's header and carry it along the header row — a ghost of the header follows the pointer and a drop line down the table says where it lands, the line going as the pointer is carried well down among the rows and coming back as it returns, and releasing lays the column out there at once — then reload and find the width, the hidden column and the order all still there
      ✓ walked. Columns lay out at 35/280/140/200/240/200/200/200/140/100/100/200/200/160/80/100/100/100/200
      — the identity 280 and Author 240 being the config's own widths — and at a 3400px window the row runs
      to 3384 while the last column (Buzz) ends at 3287, the 97px past it left empty. Dragging the
      Status/Author Id boundary moved the column with the pointer (140 → 180 at the mid-drag sample → 200 on
      release). Hid **Cover Url** from the customize-columns modal, then carried the **Author** header along
      the header row: a ghost of the header followed the pointer, a 2px drop line ran the 642px height of
      the table, the line went as the pointer was carried down among the rows and came back on returning to
      the header, and the release laid the column out at once, ahead of Status. Width, hidden column and
      order all survived a reload once the debounce had passed; **Revert to defaults** put them back.
      Reordering from inside the customize-columns modal is HTML5 drag-and-drop, which WebDriver pointer
      actions cannot drive; the header drag is the same fact.
      ⚠ finding [#1321](https://github.com/chessworld/ElevateR/issues/1321) beside it, and the box is
      ticked because the line's own clauses all pass: the **Buzz** column — the one this config gives a
      `renderer: kind: custom` — draws its header and its width and is empty on every row, including the
      book whose `review_count` is 1. Nothing in `packages/elevater/src` reads a column `renderer` at all.
      A harness note for the next walker: put the `pointerUp` in the *same* `PerformActions` as the final
      move. A release sent in a call of its own does not reach the handle holding pointer capture, so the
      next pointer move anywhere on the page goes on resizing the column — which reads as a stuck resize and
      is not one.
- [x] the identity column is the table's first column and stays pinned there as the rest scroll sideways: every row names its `books` record in it, under the header the config or the spec's display name gives it; the customize-columns menu offers neither hiding nor reordering it, its header does not drag along the row and no other column drops ahead of it, and dragging its right edge still resizes it
      ✓ walked. The identity column is the first column after the checkboxes, headed **Book title** — the
      config's `label`, not the spec's display name — and both it and the checkbox column stay put as the
      rest scroll: at `scrollLeft` 0 vs 300 the checkbox and identity cells held x=312/347 while every other
      column moved by 300. **Customize columns** lists Status, Author Id, Author, Summary, Webhook Secret,
      Isbn, Genre, Page Count, Price Cents, Published On, Cover Url, Cover Image Id, Featured, Review Count,
      Rating, Reviews At Shelving and Buzz, and never the identity column. Its header carries a `Resize
      identity` handle and no `data-column-drag` surface (every other header has both), and the Author
      header carried left over it landed *after* it rather than ahead. Dragging its right edge resized it
      280 → 340.
- [ ] the table opens sorted by `title`, ascending — declared here in `default_sort` — and that column's header is the one wearing the arrow
      ⚠ finding [#1316](https://github.com/chessworld/ElevateR/issues/1316), the sibling's, confirmed here.
      The order is right — A Wizard of Earthsea … Things Fall Apart — and the **Sort table** modal opens
      reading *Title / Ascending*. No header wears an arrow: `title` is this model's `identity.title`, so
      the table draws it as the [[Identity Column]] and the `title` property column itself sits in
      *Hidden columns*, where the arrow goes. `?sort=status_asc` does draw it on **Status**, so the
      mechanism is there.
- [ ] the status column is the table's second column, right of the identity column: every row wears its `books` status there as a band filling the cell edge to edge, its label centred — the colour that status declares in the spec as a plain fill, that colour's pattern as a strip down the left edge, and the neutral fill where the spec declares no colour — reading the same label the same record's chip reads on a board or a cards view; and unlike the identity column beside it, the customize-columns menu offers to hide it, bring it back and reorder it
      ⚠ finding [#1309](https://github.com/chessworld/ElevateR/issues/1309) — a generator bug, the
      sibling's. The column is where the line says, second and right of the identity column, and the three
      statuses wear the colours the spec declares (`draft` gray, `published` green, `archived` blue); the
      customize-columns modal offers to hide, restore and reorder it. But the line describes the
      pre-ADR-0095 look — a *plain fill*, a *centred label*, the colour's *pattern as a strip down the left
      edge* — where the shipped column draws `--status-fill` as a wash, a left-aligned label and the pattern
      on a 14px `data-status-disc`.
      The "same label the record's chip reads on a board or a cards view" clause *is* walkable here, unlike
      on `authors_listing`, and it holds: the cards view's chip and the board column's heading both read
      Draft / Published / Archived in the same words and the same colours.
- [ ] sort the table by the status column's header, both directions: the rows come back in the spec's own declared status order rather than alphabetically; then narrow that header's filter to one status — only rows in it remain, the URL carries the filter, and a reload keeps it applied
      ⚠ finding [#1317](https://github.com/chessworld/ElevateR/issues/1317) — new, and this page is the
      only one that can show it. `books` declares `draft`, `published`, `archived`; `?sort=status_asc`
      returns Archived, Archived, Draft ×4, Published ×6 and `_desc` the reverse — the labels in
      alphabetical order rather than the spec's declared order. It is not the database's doing: the column
      is a native Postgres enum whose own `enumsortorder` is draft/published/archived, and a plain `ORDER
      BY status` gives the declared order. `authors_listing` cannot show this — `active`, `retired` is the
      same sequence either way.
      The filter half passes: `?filter_status=s~draft` leaves the four draft rows, reads "4 items", writes
      the URL and survives a reload.
      The header-carries-the-controls half is [#1311](https://github.com/chessworld/ElevateR/issues/1311),
      the sibling's generator bug: a column header is a label, a resize handle and a drag surface, and
      sorting and filtering both live in modals behind the header bar.
- [x] click any cell of a row to select it: the row's status band gains an angle-down caret at its right edge, which is what says the second click is there. Click that status cell and the transition menu opens under it, titled with the row's current status and holding an item per status the spec declares — the current one ticked and inert, each of the others the transition to it, refused with its own reason where this reader may not make it and opening the transition modal first where it has properties to collect. The status the walk lands on is in the record's lifecycle history afterwards. A role permitted no transition at all gets no caret and no menu from the second click, an unselected row's band wears none either, and a first click on the status cell only ever selects the row
      ✓ walked. A first click on Dune's status cell only selected the row and opened nothing; the caret then
      appeared on that row's status cell (`data-status-caret` inside `data-status-opens-menu`) and on no
      unselected row's. The second click hung the menu under the cell, headed **Published** — the row's own
      status — with an item per declared status: **Draft** `disabled` and `aria-description="Not
      permitted"` (the `admin` policy declares no published → draft transition), **Published** carrying the
      tick, **Archived** live. Taking Archived moved the record, named the command **Change status** in the
      strip and wrote the lifecycle row (`books_lifecycles`: archived). No `books` status declares
      `required_properties`, so the transition-modal clause has nothing to walk here. As a patron — whose
      `catalogue` policy names no transition — a selected row's status cell wears no caret, carries no
      `data-status-opens-menu` and opens nothing on the second click.
      One reading rather than a finding: the current status is ticked and does nothing when clicked (no
      command runs, the strip stays silent) but is not drawn `disabled` and leaves the menu open.
- [x] rest the pointer on a cell whose value this column's width cuts off and about half a second later the whole of it floats beside the cell, wrapped rather than clipped and rendered the way the cell renders it rather than as a bare string; move the pointer away and the box goes, while a cell already showing all of its value floats nothing however long the pointer rests on it. On a phone, where there is no pointer to rest, a tap on that same cell floats the box at once and a tap elsewhere puts it away — and neither tap changes which row is selected
      ✓ walked. Resting on Things Fall Apart's clipped Summary cell floats a `_box_v2u1h_` beside it about
      0.4s later (480px wide against a 200px column, `white-space: normal`) holding the whole value and
      rendering it through the same `data-inline-cell` the cell uses. Moving the pointer away takes it;
      a Genre cell showing all of its value floats nothing after two seconds' rest.
      — unreachable: the phone half. This harness has no touch input.
- [x] the `books` cells with a rich rendering to float — `cover_image_id`, whose box holds the file itself (the image card where the file is an image, the attachment chip where it is not) — float it however wide the column is, nothing needing to have been cut off, and what floats is that property's own detail rendering rather than a second one written for tables: the same rendering a record's `properties` block draws for it, so a box that differs from that block for the same record is a regression rather than a preference — and the thumbnail an image cell draws is display-only now that the preview has replaced the lightbox: clicking it makes that row the whole [[Selection]], exactly as clicking any other cell does, and opens no lightbox over the table
      ✓ walked. The backdrop gives four books a `cover_image_id`, and the cell draws a `_inlineThumb_` in
      its 160px column. Resting on it floats a box 302×464 holding the file itself — an `_imageCard_` with
      the image, its filename as a caption and a download button — although nothing about the thumbnail was
      cut off. What floats is the property's own detail rendering rather than a table-only one: the same
      `_imageCard_asnma_5` markup, byte for byte, that the record page's `properties` block draws for the
      same record (checked on `/library/books/<id>` for A Wizard of Earthsea). Clicking the thumbnail made
      that row the whole [[Selection]] and opened no lightbox — no dialog, nothing in the overlay, the URL
      unmoved.
- [x] what this table no longer has: there is no **Edit table** toggle anywhere on the page — no root panel to have held one, and the header bar carries the page's own actions and nothing about editing — no Save and Cancel bar over the header, and no bulk-edit form anywhere on the page. `Ctrl+S` binds nothing here any more: whatever the browser does with it is the browser's, and no save of this page's starts. A cell is saved one cell at a time and the [[Command Strip]] is the only place that says so
      ✓ walked. No **Edit table**, no **Select multiple**, no Save/Cancel bar and no bulk-edit form appear
      anywhere in the DOM at any point in this section. `Ctrl+S` with a row selected started nothing — the
      strip stayed empty and no save ran. Cells save one at a time and the strip is the only report.
- [x] click any cell of a row to select it, then click one of that row's cells again: the cell becomes the `books` field it edits, with the cursor in it. The first click only makes that row the whole [[Selection]] — every other row unticks and this one ticks — and opens no panel, there being none on this page; a click on a row *outside* the selection never opens a cell, and a double-click still does nothing of its own. The two cells ADR-0095 spoke for keep their own second clicks — the identity cell opens the record page and the status cell the transition menu — and no ordinary cell grows a pencil beside the identity cell's. On a phone the same pair of taps opens the cell, the identity cell being what selects the row there
      ✓ walked. First click on Norwegian Wood's Summary cell ticked that row and unticked every other,
      opened no panel and left the URL alone; the second opened the cell as an input filling it, focused,
      holding the stored value. A click on a cell of a row *outside* the selection never opened a cell — it
      collapsed the selection onto that row instead, and the click after it opened the cell. A rapid
      double-click is just those two clicks (select, then open); no `dblclick` handler exists anywhere in
      the table. The identity cell's second click opened `book_page` and the status cell's the transition
      menu, and no ordinary cell grew a pencil — `[aria-label=Edit]` counts exactly one per row, in the
      identity cell.
- [ ] type into an open cell and click away: the blur saves that one property of that one `books` record, `Enter` saves and closes, and the [[Command Strip]] names the save after the column it changed — **Update {column}**, the word that column’s header shows, rather than a general Save changes — with an undo that puts the old value back in the row. `Escape` instead of either puts the old value back without saving. Nothing saves on a timer — leave an open cell alone for a minute and it is still unsaved with the strip silent — and a write the server refuses leaves the cell holding what was typed rather than retrying it, the strip carrying the refusal's sentence and its category, with `Escape` the way to give that draft up. Walk it as a role whose policies may not update the record at its status, too: that row's cells never open at all
      ⚠ finding [#1318](https://github.com/chessworld/ElevateR/issues/1318) — new, on the last clause, and
      it is the one that matters. Everything before it holds: typing and clicking away saved `summary` on
      blur (**Update Summary** in the strip, the row and the database both changed), `Enter` saved and
      closed, the strip named each save after the column's own header — **Update Isbn**, **Update Page
      Count**, **Update Price Cents**, **Update Genre**, **Update Featured**, **Update Author Id**,
      **Update Published On** — never a general Save changes. `Escape` put the old value back and sent
      nothing. Nothing saves on a timer: a cell left open with typed text for 25s was still unsaved with the
      strip silent.
      The finding: "a role whose policies may not update the record at its status" does not hold for
      `archived` books. `books`' `admin` policy permits `update` on `draft` and `published` only, and yet
      every ordinary cell of an archived row opens for an admin, the save reports a green tick and
      **Update Isbn**, and the database is unchanged — while an update to `summary` on the same record does
      land, because the spec's `automation` policy ("not granted to any role") is being applied to the
      acting user. The patron arm of the clause does hold: as a patron no cell of a selected row opens at
      all.
      The undo clause carries [#1312](https://github.com/chessworld/ElevateR/issues/1312) as above — a
      single undo does put the old value back in the row, but an undo after an earlier undo restores the
      wrong one. A write the *server* refuses could not be posed on this surface without the
      role-revocation trick the sibling used on `authors_listing`; it was not re-run here.
- [ ] where each `books` field opens: `title`, `summary`, `isbn`, `page_count`, `price_cents` and `cover_url`: **in the cell**, as an input filling it; `genre` and `featured`: **in the cell**, as a menu of the values it allows, up from the moment the cell opens — and the pick itself saves the cell, there being nothing left to leave, while a click on the cell with the menu up closes it again and sends nothing; `author_id` and `cover_image_id`: **in the cell**, as a search box over the records it points at, saved when the cell is left rather than when the menu is picked from; `published_on`: in a popup holding the month grid — the same calendar a modal's date field draws rather than the browser's own control. A popup is anchored to the cell it came from, is wide enough to write in rather than the width of the column, holds the focus while it is open, and commits when it closes — an upload still running or a search menu holding the focus is the editor's own and commits nothing half-finished. It is **one box**: a date's month grid is drawn inside it under the input, up from the moment the cell opens, rather than floating over it as a second popup with a second edge to find, and picking a day from it writes the value and leaves the grid standing. And a click anywhere inside the box leaves it open — its padding, the space beside a field, the grid — so only a click *outside* it puts it away, committing what is in it. A click on the cell the box came from is one of those: it closes the box and leaves it closed, rather than closing and reopening it under the one click. The grid answers the pointer and nothing else: with the caret in the date, `Home`, `End` and the arrows move it through what is being typed rather than through the month, typing being the way in from a keyboard — and `Enter` finishes a typed date and saves it, a box holding one line being one line. Every other column of this table opens nothing at all, which is what its cells refusing the second click means rather than a fault
      ⚠ finding [#1310](https://github.com/chessworld/ElevateR/issues/1310) — a generator bug, the
      sibling's: `title` is this model's `identity.title`, so it has no cell of its own to open in, and the
      same section says two lines earlier that the identity cell's second click opens the record page.
      Everything else on the line is exactly right, walked property by property. In the cell as an input
      filling it: `summary` (199 wide in a 200 column), `isbn`, `page_count`, `price_cents`, `cover_url`. In
      the cell as a menu up from the moment it opens, the pick itself saving: `genre` (eight values,
      **Update Genre**, Science Fiction → Fantasy landed) and `featured` (Yes / No, **Update Featured**). In
      the cell as a search box over the records they point at, saved when the cell is *left* rather than
      when the menu is picked from: `author_id` (typed "Haruki", picked Haruki Murakami — nothing sent, the
      strip silent; clicking away sent **Update Author Id** and the cached `author_name` followed) and
      `cover_image_id` ("Search globally"). `published_on` in a popup: one box anchored to the cell (x=748,
      the cell's own x), 277px wide against a 200px column, the text input *inside* it at 259px with the
      month grid drawn under it from the moment the cell opens — the app's own `_calendar_xbuas`, not the
      browser's control (`input[type=date]` count 0). Picking a day wrote 2003-05-20 into the input and left
      the grid standing; clicks on the box's padding and on its month header left it open; the click on the
      cell it came from closed it, committed (**Update Published On**, 2003-05-22 in the database) and left
      it closed. With the caret in the date, `Home` took it to 0 and `End`+`Left`+`Left` to 8 with the grid
      unmoved on May 2003, and `Enter` finished a typed date and saved it. Every other column of the table
      refused the second click — `identity`, `status`, `author_name`, `webhook_secret`, `review_count`,
      `average_rating`, `reviews_at_shelving` and `buzz` carry no `data-inline-cell`, which is exactly the
      `admin` policy's `update` list.
      Beside it, [#1319](https://github.com/chessworld/ElevateR/issues/1319): the menu `genre` opens holds
      the raw enum humanised — *Nonfiction*, *Childrens*, no Prose/Other headings — where the same
      property's `select_field` in `edit_book` reads the `book_genres` itemset in full.
- [ ] the unit a number opens in: `price_cents` is written in a unit the [[Spec]] scales, so what the cell opens holding has to be the value the column is *listing* rather than the integer underneath it — $12.99 rather than 1299, 7.5% rather than 750. Type a new one and leave the cell: what the row shows afterwards is in the same unit again, and the record page and the edit modal show the same number as the table does
      ⚠ finding [#1320](https://github.com/chessworld/ElevateR/issues/1320) — new. The table half passes:
      Children of Dune stores `1899` and the cell opens holding **18.99**, not 1899; typing 12.99 and
      leaving the cell put `$12.99` in the row and `1299` in the database. The record page agrees — its
      `properties` block reads `$18.99`. The **edit modal does not**: `edit_book`'s Pricing tab draws
      `<input type="number" value="1899">`, and typing `18.99` there — the number the listing had just shown
      — saved eighteen cents.
- [x] the caret an armed cell wears: select a row and its `genre`, `published_on` and `featured` cells each grow an angle-down caret at the right edge — the same affordance the [[Status Column]]'s band wears, on every cell whose click opens a list or a box rather than a field to type in. The cells of `title`, `author_id`, `summary`, `isbn`, `page_count`, `price_cents`, `cover_url` and `cover_image_id` wear none: there the click opens a field to type in, which is its own affordance. The caret is there only while the row is selected — an unselected row's cells wear none, that click being the row's, and the value under it does not move a pixel as the cell opens — the open field is set in the table's own font, so the same string lands on the same baseline in the same place, and a value too long for its column still ends in an ellipsis rather than breaking at a word. What the caret does when the cell opens depends on where the field went: a field drawn *in* the cell brings a chevron of its own, so the cell's goes, and a field that opened in a popup leaves the cell showing its value, so the caret stays and turns upside down. Nothing the caret sits on moves: the value reads exactly where it read before the row was selected, and the caret sits on the same pixel as the open field's own chevron
      ✓ walked. Selecting a row grew a `data-inline-cell-caret` on its `genre`, `published_on` and
      `featured` cells and a `data-status-caret` on its status cell, and on no others: `title` has no cell,
      and `author_id`, `summary`, `isbn`, `page_count`, `price_cents`, `cover_url` and `cover_image_id` —
      which open a field to type in — wear none. An unselected row's cells wear none at all. Opening the
      `genre` cell took the cell's own caret away, because the field drawn in the cell brings its own
      chevron, and the chevron landed on the same pixel the caret had held (dx=116 inside a 140px cell,
      both); the value read at dx=-1, dy=1, 14px Open Sans, before and after. Opening `published_on`, whose
      field goes to a popup, left the cell showing its value with the caret still at dx=176 and turned
      upside down (`FiE3va_caretUp`, `transform: matrix(-1, 0, 0, -1, 0, 0)`).
- [ ] a selected row's cell content goes inert: with the row selected, a link, a chip or a button drawn inside one of its cells stops answering the pointer — it draws no hover emphasis and follows nowhere — so the second click has one meaning wherever in the row it lands, and on an editable cell it opens that cell. On an *unselected* row the same content is live and the click belongs to the row underneath. What a reader wanted from that link is still reachable: the [[Cell Preview]] the hover floats carries the rendering with it, and `Space` and a tap float the same box. The identity cell is the exception and goes on answering — its pencil, its ellipsis and its record page all still take the pointer
      — unreachable, on the clause the line is about. No ordinary cell of this table draws a link, a chip or
      a button: `author_name`, `summary`, `isbn`, `genre`, `page_count`, `price_cents`, `published_on`,
      `cover_url` and the three rollups all render as plain text inside `FiE3va_cell` (the `cover_url` URL
      included — it is not an anchor), so there is nothing on a selected row for the pointer to stop
      answering. What is walkable passes: a selected row's cells carry `FiE3va_inert` /
      `data-inline-cell-inert` with the value drawn `data-inline-cell-faded`, which is the mechanism; the
      one rich cell, `cover_image_id`'s thumbnail, is display-only and its click makes the row the whole
      [[Selection]] rather than opening anything; the [[Cell Preview]] carries the rendering with it and
      `Space` floats the same box; and the identity cell goes on answering — its pencil, its ellipsis and
      its record page all take the pointer on a selected row.
- [ ] clear `title`, which the spec requires a value for, and leave the cell: the old value is back in it, nothing is sent, no command runs and the [[Command Strip]] says nothing, there being nothing to report. No cell and no row anywhere in the table is drawn red, outlined or marked invalid at any point, which is the half to watch for. Where the schema points at one repair the value is repaired instead and the repair is what saves: a number past its bounds comes back clamped to them, a string past its maximum truncated to it, and leading or trailing whitespace trimmed away
      ⚠ finding [#1310](https://github.com/chessworld/ElevateR/issues/1310) — the same generator bug:
      `title` is the identity property and has no cell that opens, so there is no cell here in which to
      clear it. The repair half is fully walkable on this model and passes, all three ways the line names:
      `page_count` typed as `0` against a schema `min: 1` came back clamped to **1**; a 25-character string
      typed into `isbn` against `maxLength: 17` was truncated to **12345678901234567**; and `"   Trimmed
      value   "` typed into `summary` stored `Trimmed value`. Each saved through the ordinary command
      (**Update Page Count**, **Update Isbn**, **Update Summary**) rather than being refused. Nothing
      anywhere in the table was drawn red, outlined or marked invalid at any point — `[aria-invalid=true]`
      count 0 and no `_error_`/`_invalid_` class in the DOM throughout.
- [x] the checkbox column is there before anything is clicked: the table opens with a checkbox in a column of its own ahead of the [[Identity Column]] on every row, nothing ticked, and one in the header. There is no **Select multiple** toggle anywhere on the page to have turned it on — no root panel to hold one, and the header bar carries the page's own actions rather than the table's — and nothing else about a row has moved: the identity cell keeps its pencil and the row menu's ellipsis, nothing being ticked yet. Leave the page for another and come back and the column is still there with nothing ticked, the [[Selection]] being the page's own: no `panel` parameter is ever written to the address bar by any of this
      ✓ walked. The table mounts with a checkbox in a column of its own ahead of the [[Identity Column]] on
      every one of the twelve rows and one in the header, nothing ticked. No **Select multiple** toggle
      exists anywhere in the DOM; every identity cell keeps its pencil and its ellipsis. Walking to Authors
      through the nav and back to Books in-page (`window.__mark` survived, so no reload) came back with the
      column there, nothing ticked, and no `panel` parameter written.
- [x] giving a set up, with no count and no **Clear** to do it by: on a `books` table with more rows than three, tick three of them and click the header checkbox — all three untick rather than the whole table checking, which is what a partial set answers to now. Click it again with nothing ticked and every row of the table checks; click it once more with every row checked and every one unticks. Press `Escape` with three rows ticked instead and the set empties the same way, the focus ring left exactly where it was. There is no selection count and no **Clear** anywhere on the page to have done either by — the header checkbox is a phone's way, having no `Escape` to reach for. **Every identity cell's pencil goes** while more than one row is ticked — the edit modal writes the one record it was clicked on, which is not what a set is edited with — and each comes back the moment the selection is down to one row or none; the ellipsis beside it never goes, the row menu being where a checked row's own list opens
      ✓ walked on twelve rows. Ticked three (rows 0, 2, 6): every identity pencil went at once and every row
      kept its ellipsis. The header checkbox on that partial set unticked all three and the pencils came
      back; pressed again with nothing ticked it checked all twelve; pressed again with all twelve checked
      it emptied them. `Escape` with three ticked emptied the set the same way and left the focus on the
      same element. No selection count and no **Clear** anywhere on the page — the header reads "12 items"
      and nothing else.
- [x] the one click rule: click a cell of a *ticked* row and that cell opens for editing, which is what the second click on a row has always been; click a cell of an *unticked* row and that row becomes the whole selection instead: every other row unticks, this one ticks, no cell opens and no panel opens either, this page drawing none, and the click after it opens that cell. **A click inside the selection never takes it**: with three rows ticked, click anywhere on one of them — a cell's dead space, a column that opens nothing, the spare width past the last column — and all three are still ticked. So the [[Selection]] grows and shrinks by checkbox alone: no click anywhere in the table ever adds a row to it. The identity cell is ADR-0095's still — a second click on it opens the record page rather than a cell — and a row this reader may not update is a row whose cells do not open, ticked or not
      ✓ walked. A click on a cell of a ticked row opened that cell; a click on a cell of an unticked row
      made that row the whole selection, opened nothing and no panel, and the click after it opened the
      cell. With three ticked, a click on a ticked row's `review_count` cell — a column that opens nothing —
      left all three ticked. The identity cell's second click opened `book_page`. The last clause, "a row
      this reader may not update is a row whose cells do not open", is where
      [#1318](https://github.com/chessworld/ElevateR/issues/1318) bites: it holds as a patron and fails for
      an admin on an archived row.
- [x] the set marks, and the editor opens on what it shares: tick three rows by their checkboxes and rest the pointer on one of their `summary` cells — the same column's cell on the other two ticked rows is marked with it, a tint of its own over the fill a ticked row already carries, so what is about to change is visible before it changes. Carry the pointer along the row and the marking follows it column by column; carry it onto an *unticked* row and nothing marks there, and the [[Identity Column]] neither marks nor is marked, its second click opening a record page rather than anything a set can be asked for — while the [[Status Column]] does both, a status being one of the things a selection changes: rest the pointer on a checked row's status cell and every checked row's band wears a ring and the action colour washed over it, its own included — the status colour still showing through, so a marked set never reads as a different status. Now click that cell: it opens holding the value the three rows share, or empty where they hold three different ones — and empty is not a change, so leave it without typing and nothing is sent, no command runs and the [[Command Strip]] stays silent. Type, and what is typed shows in that one cell alone: the other two go on showing what the server last returned, marked but unchanged, until the save lands. `Escape` gives the draft up to *this* row's own value rather than to the set's, and the header checkbox and `Escape` take the marking away with the [[Selection]]
      ✓ walked. With rows 0, 2 and 6 ticked, resting on one of their Summary cells marked
      `data-inline-cell-marked="summary"` on all three and on no unticked row; carrying the pointer along
      the row moved the marking column by column (summary → isbn); carrying it onto an unticked row marked
      nothing; the [[Identity Column]] neither marked nor was marked. Opening the Summary cell of the set —
      three different values — opened it **empty**, and leaving it without typing sent nothing: the strip
      stayed silent and no row changed in the database. Typing showed in that one cell alone, the other two
      still reading what the server last returned.
      The [[Status Column]]'s half is only half readable here: every checked row's status cell is armed
      (`GVTZ9W_opensMenu` / `data-status-opens-menu`, absent on unticked rows), but the ring and the action
      colour washed over the band live in a `:hover` rule that headless Firefox never matches, so the wash
      itself could not be read.
- [x] one edit, every checked row, one entry: with three rows ticked, open one of their `summary` cells, type a value and press `Enter` — all three rows read it, and the strip names **one** entry for the three rather than three entries. Open the caret and take it back: each row comes back to the value *it* held, so three rows that held three different values come back as three different values rather than as the one the opened cell was showing. Every other column of all three records is as it went in, the write carrying the one property that changed and nothing else — check one the set never agreed on. Then make a second batch over a *different* set of rows: it is an entry of its own rather than folded into the one before it, which is what a run of edits to one cell of one row does instead
      ✓ walked. With rows 0, 2 and 6 ticked, opening one of their Summary cells, typing and pressing `Enter`
      put the value on all three rows and the caret held exactly **one** *Update Summary* entry for the
      three. Its undo brought each row back to the value *it* held — three different sentences — and left
      every other column of the three untouched (`isbn` and `page_count` checked row by row in the database
      before and after).
- [ ] the gate closes the whole set: `books`'s `admin` policy permits `update` on a record in `draft` and `published` and not on one in `archived`, so tick one `books` record in `archived` along with two the policy does reach — and no cell of the set opens at all, the cells of the two rows that would have permitted it included, because applying to whichever rows happened to permit it would leave the result turning on a permission the reader cannot see. A refused cell is the inert one it already knows how to be: `Tab` walks over it, `Enter` and `F2` float the [[Cell Preview]] instead, and nothing marks, there being nothing about to change. The reason rides on the cell itself, as its tooltip *and* its accessible name — "<the record's name> cannot be updated while it is Archived", which says which row to untick rather than which rule to guess at. Untick that one record and the other two open again
      ⚠ finding [#1318](https://github.com/chessworld/ElevateR/issues/1318) — the gate this line exists to
      check does not close. Ticking an `archived` book alongside two the policy reaches does not stop the
      set's cells opening: they open, the save reports a tick, and the properties the `automation` policy
      happens to name are written while the rest are silently dropped. No cell carries
      `data-inline-cell-refused`, no tooltip or accessible name says which row to untick, and there is
      nothing for `Tab`, `Enter` or `F2` to fall back from. The mechanism itself is not missing — the
      sibling walked it working on `authors_listing`, where a `retired` row does refuse the whole set — so
      what is broken is which rows `books` counts as refusable.
- [x] the status cell moves the whole set: tick three `books` records that are all in `published` and click one of their status cells — the menu that opens is the [[Selection]]'s rather than that one row's, titled with the status the three agree on, and it offers only the moves every checked record may make. Tick one `books` record in `draft` as well and `archived` is no longer offered, that record having no permitted move into it. Take `published` → `archived`, which the `admin` policy permits: all three move as one write, the strip names one entry for them, and one undo takes all three back at once. A record already in `archived` neither withholds the move from the others nor takes a write of its own, and a set with no move in common is a status cell that opens no menu at all and answers no click. Give the selection up by the header checkbox and the same cell opens that one row's own menu again, one checked row being no set
      ✓ walked. Three `published` records ticked, one of their status cells clicked: the menu was the
      selection's, titled **Published** — the status the three agree on — and offered only Published and
      Archived, Draft not being a move any of them may make. Ticking a fourth record in `draft` retitled it
      **4 Books selected** and took **Archived** away, that record having no permitted move into it, exactly
      as the line says. Taking published → archived moved all three as one write, the strip named **one**
      *Change status* entry, and one undo took all three back to `published` at once. Giving the selection
      up by the header checkbox made the same cell open that one row's own menu again.
      One reading rather than a finding, the same the sibling recorded: on this model an empty intersection
      cannot be produced without a record already in the target status, so "a set with no move in common is
      a status cell that opens no menu at all" and "a record already in `archived` withholds nothing" cannot
      be told apart.
- [x] a set with nothing to be asked: this page's `record_actions` declare no `modal_actions`, and no `books` workflow declares `dispatch_mode: per_record` on a manual trigger — so a [[Selection]] here has an empty list, and what the menu holds is one line saying so. Tick three rows and right-click one of them: a menu of the app's own opens, titled off the count as any set's is, holding a single greyed **No actions for this selection** and nothing else — the browser's own context menu must not appear over the table, which is what an empty menu would have let through. The identity cell's ellipsis is still on a checked row and opens that same one-line menu, a phone having no right-click to reach it with. That one line is the whole of what says so: there is no panel on this page with a selection block to have said it by drawing no buttons, and no count and no **Clear** beside it to have said it either. Right-click an *unchecked* row and the selection still collapses onto it — every other row unticks, that one ticks — and that record's ordinary [[Row Context Menu]] opens, copy item and all; untick until fewer than two rows are checked and every row's menu and ellipsis are the record's own again
      ✓ walked. Right-clicking a checked row with three ticked opened the app's own menu at the pointer,
      headed **3 Books selected**, holding a single `disabled` **No actions for this selection** and nothing
      else (`aria-description`: "This page declares no action a selection can be asked for"). The identity
      cell's ellipsis on a checked row opened the same one line. Right-clicking an *unchecked* row collapsed
      the selection onto it — its own checkbox ticked, every other cleared — and opened that record's own
      [[Row Context Menu]], **Copy Author Id / Filter by Author Id / Book Page / Edit Book / View Lifecycle
      / Related links**. No panel behind any of it, and no count or **Clear** anywhere. Firefox's own
      context menu is not reachable from the content process, so "the browser's own menu must not appear"
      was judged by the app's menu opening in its place rather than directly.
- [x] board view renders `books` grouped by status; drag a card between columns and confirm the transition
      ✓ walked, and the [[Board View]] renders — see the note under the known issue at the foot of this
      section. Three columns, Draft / Published / Archived, each headed with its count, every book in the
      column its status names. Dragging **Dune Messiah** from Draft onto the Published column transitioned
      it (strip: **Change status**, `books.status` now `published`) and the board came back with it in
      place.
      ⚠ beside it, [#1322](https://github.com/chessworld/ElevateR/issues/1322): as a **patron** the same
      board draws its three columns and no cards at all, where the table and the cards view both show the
      reader seven books. The box is ticked because the line's own clauses pass as an admin, which is the
      role it was walked as.
- [x] a reorder inside a column drops anywhere on a card rather than into the gap between two: released on a card's top half the dragged card lands before it, on its bottom half after it, and a caret sits in the gap that release would land in while the pointer is over that half. A release below the last card means the end of the column, and the order the board comes back in after a reload is the order left on screen
      ✓ walked, mostly by outcome. Released on the top half of *Things Fall Apart*, the dragged card landed
      **before** it (`board_rank` O between G and V); released on its bottom half, **after** it (Z between V
      and d), and the strip named that one **Reorder** rather than a status change. A mid-drag sample with
      the pointer over a card's top half showed the caret in the gap the release would land in —
      `BSC7kq_reorderCaretBefore`, 292×3, sitting at the boundary above that card. The order the board came
      back in after a reload is the order left on screen.
      — unreachable: "a release below the last card". No column here has space under its last card — the
      Draft column's body ends 5px past it — and a release on the column header did nothing, which this
      harness's split-call drag cannot separate from a drag it had already lost. Said so rather than ticked
      for that clause.
- [x] a drop onto a card in *another* column both transitions the record and puts it where it was released, rather than landing it wherever its old rank already sorted: the transition goes first and the rank behind it, in one batch that stops at the first failure — so a refused transition puts the card back and writes no rank at all. A pick from a choose-a-status popup and a Save in a transition modal each carry the same slot the release named, and cancelling the modal puts both columns back. A release no card took — the column's header, the space under its last card — lands at the end of that column, and a drop into an empty column is a transition alone, there being nothing to order against
      ✓ walked in part. A drop onto a card in another column did both, in the order the line names:
      **Dune Messiah** released on the top half of *Things Fall Apart* in the Published column transitioned
      to `published` **and** took rank O — the slot the release named — rather than sorting to wherever an
      old rank put it; the column had no ranks at all before the drop and came out with a full set.
      — unreachable, the rest: no `books` status declares `required_properties`, so there is no transition
      modal and no choose-a-status popup on this model to carry a slot or to cancel; no transition of a
      `books` record is refusable by the client, so "a refused transition puts the card back and writes no
      rank" cannot be posed; and with three statuses all occupied there is no empty column to drop into.
- [x] board card: rest the pointer on a card and a slot holding a pencil and an ellipsis comes out at the right edge of its title row — the title gives up just enough width for it and takes that width back when the pointer leaves — while on a touch screen, where there is no pointer to rest, the slot is simply there, which is a phone's only way in
      ✓ walked, through a same-specificity probe: the reveal lives in `@media (hover: hover)`
      (`.BSC7kq_cardInner [data-row-hover-actions] { display: none }` /
      `.BSC7kq_cardInner:hover, :focus-within { display: flex }`), which headless Firefox never matches, so
      the rule was re-stated unwrapped and appended last. With it in force the slot is `display: none` on
      all twelve cards and `flex` on the hovered card and no other. The slot sits at the right edge of the
      title row and holds a pencil (`data-card-edit`) and an ellipsis (`data-card-menu`). Without the probe
      — which is a touch screen's arrangement — the slot is simply there on every card, which is the phone
      half of the line. The "title gives up just enough width" clause could not be measured: the title
      element is shrink-to-fit and reports no box of its own to watch give way.
- [x] board card: that ellipsis opens the `books` record's own menu anchored to itself, and a right-click anywhere on the card opens the same menu at the pointer — selecting the card first, with **no panel behind it**, this page drawing none. Either way it is headed by the record's name and holds this page's `record_actions` for it, in the block's own order with a separator per group boundary and the record page pulled to the front in bold, greyed with its own predicate's reason where one refuses — there being no item-details panel beside it to be compared with. It leads with no copy item at all: a card has no cell to copy
      ✓ walked. The ellipsis opened the record's own menu anchored to itself; a right-click anywhere on the
      card opened the same menu at the pointer (menu at 472,323 for a click at 472,318) and selected the
      card first. No panel behind either. Headed by the record's name (**Oryx and Crake**), holding this
      page's `record_actions` in the block's own order with the record page pulled to the front in bold
      (`_primary_`) — **Book Page**, **Edit Book**, **View Lifecycle**, **Related links** — two separators,
      one per group boundary. Nothing greyed, no `hide` predicate being declared. It leads with no copy item
      at all.
- [x] board card: the pencil opens edit modal `edit_book` for that card, filled from the *whole* record rather than from the handful of properties the card draws — a card's chrome is not a projection of the form — so it opens a beat after the press and never half-loaded. The press neither selects the card nor starts a drag, a second press while the record is on its way opens no second modal, and the pencil is absent for a role that may not update the record
      ✓ walked. The pencil opened `edit_book` for the card, filled from the whole record — Title, Author Id
      and Summary on Details, and the Metadata and Pricing tabs holding `isbn`, `genre`, `page_count`,
      `price_cents`, `published_on` and `cover_url`, none of which the card draws. The press neither
      selected the card nor started a drag (the card's `Selected` class was absent before and after), and
      the URL gained `?edit=books:<id>`. The pencil is absent for a role that may not update the record: as
      a patron no card in either card view carries one (`[data-card-edit]` count 0) while every card keeps
      its ellipsis. The second-press-while-loading clause could not be timed — the modal opened within
      60ms and its own loading state was gone before a second press could be aimed.
- [x] board card: click a card and it draws selected and **nothing opens** — this page draws no panel of any kind, and nothing appears on the address bar either: what the click writes is the page's own [[Selection]]; the click after that is whichever piece of the card it lands on: on the title, record page `book_page` opens — a real link, so the URL shows on hover, a middle-click opens it in a tab, and the listing's filters and sort ride along exactly as they do from a row — while an unselected card's title is plain text that never underlines under the pointer; and on a link in the summary, that link follows where it points instead of being swallowed by the card. On an *unselected* card the same click is the card's first and only selects it, and a double-click anywhere on the card does nothing of its own
      ✓ walked. A click on an unselected card drew it selected and opened nothing — no panel, nothing on the
      address bar, no `panel` parameter. On an *unselected* card the title is a bare `<div>`; on the
      selected card it becomes a real `<a href="/library/books/<id>/overview?ref_view=board">`, so the URL
      shows on hover, a middle-click opens it in a tab and the listing's state rides along under `ref_`.
      A double-click is just those two clicks, there being no `dblclick` handler anywhere. No card's summary
      holds a link on this backdrop, so that clause has nothing to walk.
- [x] board card: *selected* here is the page's [[Selection]] — the one checked set every view of this listing shares, and the only one it has: a click on a card outside the set makes that record the whole of it, and no gesture on a card ever adds a second record, there being no checkbox on a card to build one with. Tick two rows on this listing's table view and come back and **both** cards are drawn selected, each armed exactly as the lines above say a selected card is — a set is drawn where it falls rather than pointing at one card of it — and a click on either of them leaves the set as it was. `Escape` pressed from inside this view empties the set and leaves no card selected — while a menu or a popup is up it closes that instead, the card under it staying selected — and nothing any of this does writes a `panel` parameter to the address bar
      ✓ walked. Two rows ticked on the table view and the board came back with **both** cards drawn
      `BSC7kq_cardInnerSelected` and armed — title as a link, chip as a button — rather than one of them
      pointed at. A click on either of them left the set at two; a click on a card *outside* the set (Kafka
      on the Shore) made that record the whole of it, the other two dropping out. No gesture on a card ever
      added a second record — there is no checkbox on a card to build one with. `Escape` pressed from inside
      the view emptied the set and left no card selected, and with a menu up it closed the menu instead. The
      address bar never gained a `panel` parameter through any of it.
- [x] board card: the tag pills over `genre`: on a *selected* card, clicking one narrows the listing to the value that pill shows — the filter lands in the page header where any other filter does, every column refetches under it, and taking it off there restores what was on screen. Clicking a second pill over `genre` replaces that filter rather than joining it with a second, and on an unselected card the click is the card's first and only selects it
      ✓ walked. On the *selected* card the `genre` pill is a `<button class="…tagPillButton">`; clicking it
      narrowed the listing to that value — `?filter_genre=s~science_fiction`, five cards, a **1** badge on
      the header's Filters button — and taking it off there restored the twelve. A second pill over the same
      property left exactly one `filter_genre` in the URL and the badge still at 1, so it replaces rather
      than joins. On an *unselected* card the pill is a plain `<span>` carrying no button class, and the
      click is the card's first and only selects it.
- [x] cards view renders `books` as cards with their configured chrome
      ✓ walked. Twelve cards in one flat list with the statuses mixed rather than grouped, in the view's own
      `default_sort` — `published_on` descending, the undated book first. Each carries the chrome the config
      gives it: title row, the `author_name` tag pill in the `default_color: gray` the view declares, and a
      status chip. Books with no summary draw none.
- [x] cards view card: rest the pointer on a card and a slot holding a pencil and an ellipsis comes out at the right edge of its title row — the title gives up just enough width for it and takes that width back when the pointer leaves — while on a touch screen, where there is no pointer to rest, the slot is simply there, which is a phone's only way in
      ✓ walked. The same `data-row-hover-actions` slot at the right edge of the title row, holding a pencil
      and an ellipsis, under the same rule restated for `.wPLMyG_card` —
      `display: none` at rest inside `@media (hover: hover)`, `flex` on `:hover`/`:focus-within`. Headlessly
      the media query never matches, so the slot is simply there on every card, which is the phone half.
- [x] cards view card: that ellipsis opens the `books` record's own menu anchored to itself, and a right-click anywhere on the card opens the same menu at the pointer — selecting the card first, with **no panel behind it**, this page drawing none. Either way it is headed by the record's name and holds this page's `record_actions` for it, in the block's own order with a separator per group boundary and the record page pulled to the front in bold, greyed with its own predicate's reason where one refuses — there being no item-details panel beside it to be compared with. It leads with no copy item at all: a card has no cell to copy
      ✓ walked. The ellipsis opened the record's own menu anchored to itself (at 1045,297), headed **Oryx
      and Crake**, holding **Book Page** in bold, **Edit Book**, **View Lifecycle** and **Related links**
      with two separators and no copy item. A right-click on the card opened the same menu at the pointer
      with the card selected under it and no panel behind it.
- [x] cards view card: the pencil opens edit modal `edit_book` for that card, filled from the *whole* record rather than from the handful of properties the card draws — a card's chrome is not a projection of the form — so it opens a beat after the press and never half-loaded. The press neither selects the card nor starts a drag, a second press while the record is on its way opens no second modal, and the pencil is absent for a role that may not update the record
      ✓ walked. The pencil opened `edit_book` for the card, filled from the whole record and never
      half-loaded, without selecting the card and without starting a drag; the URL gained
      `?view=cards&edit=books:<id>`. As a patron the slot holds an ellipsis and no pencil on any of the
      seven cards.
- [x] cards view card: click a card and it draws selected and **nothing opens** — this page draws no panel of any kind, and nothing appears on the address bar either: what the click writes is the page's own [[Selection]]; the click after that is whichever piece of the card it lands on: on the title, record page `book_page` opens — a real link, so the URL shows on hover, a middle-click opens it in a tab, and the listing's filters and sort ride along exactly as they do from a row — while an unselected card's title is plain text that never underlines under the pointer; and on a link in the summary, that link follows where it points instead of being swallowed by the card. On an *unselected* card the same click is the card's first and only selects it, and a double-click anywhere on the card does nothing of its own
      ✓ walked. A click drew the card selected and opened nothing — no panel, no `panel` parameter, the URL
      unmoved. On the selected card the title is a real
      `<a href="/library/books/<id>/overview?ref_view=cards">`, carrying the listing's state under `ref_`;
      on an unselected card it is a plain `<div>`. A double-click does nothing of its own. No card's summary
      holds a link on this backdrop.
- [x] cards view card: *selected* here is the page's [[Selection]] — the one checked set every view of this listing shares, and the only one it has: a click on a card outside the set makes that record the whole of it, and no gesture on a card ever adds a second record, there being no checkbox on a card to build one with. Tick two rows on this listing's table view and come back and **both** cards are drawn selected, each armed exactly as the lines above say a selected card is — a set is drawn where it falls rather than pointing at one card of it — and a click on either of them leaves the set as it was. `Escape` pressed from inside this view empties the set and leaves no card selected — while a menu or a popup is up it closes that instead, the card under it staying selected — and nothing any of this does writes a `panel` parameter to the address bar
      ✓ walked. Two rows ticked on the table view drew both as selected cards here; a click on a card
      outside the set made that record the whole of it; `Escape` from inside the view emptied the set and
      left no card selected, while a menu or a popup up took the `Escape` instead. Nothing wrote a `panel`
      parameter.
- [x] cards view card: the tag pills over `author_name` are inert, the property declaring no filter for one to write: on a selected card a pill sets nothing and reads as nothing to click — no pointer, no hover emphasis. A filter set from here would narrow the listing with nothing on screen to say why or to undo it, which is what this refusal is against
      ✓ walked. The `author_name` pill stays a plain `<span class="gQKHmG_tagPill">` on a *selected* card —
      no `tagPillButton`, no filter written, nothing to click — where the board's `genre` pill becomes a
      `<button>` on the same gesture. The `cursor: pointer` the pill reports is the whole card's, not its
      own: the card, its body and its title all report the same, the card being what the click belongs to.
- [x] cards view card: every card carries a status chip naming its own `books` status, in the colour the spec's status declares and the neutral fill where it declares none — there being no columns here to say which status a card is in. On the *selected* card it carries a caret and opens a menu of every status that record may reach — the whole lifecycle rather than a column's share of it, narrowed to the ones this reader's policies permit — and a pick changes the status where you are looking, the card holding its place in the list rather than moving. A target declaring `required_properties` opens the transition modal first, and a cancel, a refusal or an [[Invariant]] the client can answer itself puts the card back at the status it held, the [[Command Strip]] carrying the sentence. On a card that is *not* selected, and on one whose lifecycle or permissions leave it nowhere to go, it is a plain label: no caret, and the click that would have opened it is the card's own first click and only selects it — while a right-click on the chip opens the card's menu wherever the chip stands
      ✓ walked. Every card carries a status chip naming its own status in the colour the spec's status
      declares — `draft` gray, `published` green, `archived` blue. On an *unselected* card it is a plain
      `<span>` with no caret. On the selected card it becomes a `<button>` wearing a caret, and opening it
      gives **Choose status…** holding the whole lifecycle narrowed to what this reader may reach — from
      `published`, **Archived** alone; from `archived`, **Published** alone. Picking one changed the status
      where I was looking and the card held its place in the list (the order is the view's `published_on`
      sort, which a status change does not touch), the strip naming **Change status**. A right-click on the
      chip opened the card's own menu wherever the chip stood. No `books` status declares
      `required_properties`, so the transition-modal and cancel clauses have nothing to walk here, and no
      `books` transition is refusable by the client.
- [ ] filter on each property, one at a time: `author_id`, `author_name`, `average_rating`, `cover_image_id`, `cover_url`, `featured`, `genre`, `isbn`, `page_count`, `price_cents`, `published_on`, `review_count`, `reviews_at_shelving`, `summary`, `title`, `webhook_secret` — and one filter matching nothing → clean empty state
      ⚠ finding [#1310](https://github.com/chessworld/ElevateR/issues/1310) — the sibling's generator bug
      again: `author_name`, `cover_image_id`, `cover_url` and `summary` are all `filterable: false` in the
      spec and the Filters modal rightly offers none of them. What it does offer is Author Id, Average
      Rating, Featured, Genre, ID, Isbn, Page Count, Price Cents, Published On, Rating Total, Review Count,
      Reviews At Shelving, Slug, Status, Title and Webhook Secret, and every one the line names among them
      works:
      `?filter_author_id=s~<ursula>` → 3, `?filter_genre=s~fantasy` → 3, `?filter_isbn=s~9780441104024` → 1,
      `?filter_page_count=n~eq~444` → 1, `?filter_price_cents=n~eq~1899` → 1, `?filter_review_count=n~eq~1`
      → 1, `?filter_average_rating=n~eq~5` → 1, `?filter_reviews_at_shelving=n~eq~0` → 8,
      `?filter_title=s~Dune` → 1, `?filter_featured=b~true` → 1 (the one featured book),
      `?filter_published_on=d~eq~1965-08-01` → 1.
      `webhook_secret` is offered and handles itself gracefully, which is what the notes file asks to be
      judged: `?filter_webhook_secret=s~anything` returns "0 items" with the headers intact, no error and a
      clean console rather than a crash or a silent full list — an encrypted column can match nothing and
      says so the way any empty filter does. A filter matching nothing (`?filter_genre=s~poetry`) gives the
      same clean empty state, with a **1** badge on Filters and no sentence saying why.
- [x] sort a text and a numeric column, both directions
      ✓ walked. Text: `?sort=title_asc` is the default order and `?sort=title_desc` reverses it exactly.
      Numeric: `?sort=page_count_asc` gives 149, 209, 296, 304, 311, 376, 444, 505 with the empty ones last,
      and `_desc` the other way with them first.
- [x] the calendar on this listing's date filters (`published_on`): the operand opens the same month grid rather than the browser's date control, and a day picked in it narrows the listing to that day, shows in the filters button, and rides in the URL like any other filter — a reload keeps it applied and the same rows come back. The *between* operand takes its two days from the same grid
      ✓ walked. Adding a **Published On** filter and opening its operand gave the app's own month grid
      (`_calendar_xbuas`), not the browser's control — `input[type=date]` count 0 at every point. A day
      picked in it wrote `2026-09-15` into the operand, and **Apply filters** narrowed the listing, put a
      **1** badge on the Filters button and wrote `?filter_published_on=d%7Eeq%7E2026-09-15` to the URL; a
      matching day (`d~eq~1965-08-01`) brings back the one book, and loading that URL cold keeps the filter
      applied and returns the same row. Choosing the **Between** operand drew two operands and **both** of
      them open the same grid.
- [ ] add modal `edit_book`: the header's **Add …** button — in the left of the header between the page title and the record count, drawn as a secondary button with a plus icon and naming the `books` record it adds rather than reading a bare *Add* — opens it → submit valid → the new record appears; reopen → submit invalid → clean validation error
      ⚠ finding [#1315](https://github.com/chessworld/ElevateR/issues/1315) — the sibling's, confirmed on
      this form. The button is where the line says: in the left of the header between the page title and
      "12 items", secondary, with a plus icon, reading **Add Book** rather than a bare *Add*. It opens *New
      Book* — a `tabbed_form` with Details / Metadata / Pricing — and writes `?add=books`. A valid submit
      landed. The deliberately-invalid submit (empty Title) is refused with the right category in the strip
      — "Save changes — Invalid input", still there 75 seconds later — but the message on the form reads
      "Invalid property 'title': Unable to typecast as string" rather than saying the field is required.
- [x] page action "Recommend a book" opens modal `write_review` with nothing selected → submit (its prefilled fields already hold their values on open); as a user its predicates gate out, the button is hidden or greyed out with its message
      ✓ walked. **Recommend a book** sits at the head of the header's **More** menu and is live for this
      reader. Pressed with nothing selected, the `write_review` modal opened at once — 62ms, in its own
      *Loading…* state while the `reviews` policies were read — and landed with **"I recommend this book"
      already ticked** and **Rating 5**, the two steps the page's `prefill` copies, with the conditional
      Tags block revealed under them because `recommended` is true. Filled Book (Dune, through the
      `id_search_field`), Member (Alice Reader) and Headline and submitted: the review is in `reviews` with
      `rating` 5, `recommended` true and status `published` — into `reviews`, not `books`, so the **Add
      Book** button beside it is a different thing.
      The gate clause has nothing to walk on this config: the only predicate is `kind: disable` on
      `.user.id`, which is truthy for every signed-in user, and a signed-out visitor never reaches the page
      at all.
- [x] the header's right cluster holds one **More** ellipsis beside the filters and sort buttons, and no download, print or pin button of its own anywhere in the header: this page's own actions lead it (`write_review` as "Recommend a book"), a rule under them, and then **Download**, **Print** and **Pin to Dashboard**. Download and Print still run from inside the menu, over the rows the page is showing and the columns the reader has left visible
      ✓ walked. The header's right end is Filters, Sort, Customize columns, one **More** ellipsis and the
      Table/Board/Cards switcher, with no download, print or pin button of its own. The menu holds this
      page's own action first — **Recommend a book** — then a rule, then **Download**, **Print** and **Pin
      to Dashboard**, in that order and nothing else. **Download** ran from inside the menu and wrote
      `books.csv` over the twelve rows the page was showing and the columns left visible, in their current
      order, with `price_cents` carried in the presented unit (`$18.99`) and the **Buzz** column present and
      empty on every row — [#1321](https://github.com/chessworld/ElevateR/issues/1321) again. **Print** was
      deliberately not run: it leaves this headless Firefox's WebDriver session pointing at a browsing
      context that takes no input, which cost the sibling most of a session.
- [x] row edit modal `edit_book` on an existing record: open → change a field → save → the row reflects it
      ✓ walked. Opened from the row pencil, changed **Summary** on the Details tab, saved: the row read the
      new value at once and the database agreed. Worth knowing beside it that
      [#1313](https://github.com/chessworld/ElevateR/issues/1313) — the modal seeding from the listing's row
      so a *hidden* column opens blank and saves `NULL` — is the sibling's, filed on the same modal
      machinery, and was not re-provoked here.
- [x] hover anywhere on a row: a pencil appears at the right edge of its identity cell — the title gives up just enough width for it and takes the width back when the pointer leaves — and opens edit modal `edit_book` for that row, leaving the selection where it was. It is absent for a role that may not update the record
      ✓ walked. Hovering a row reveals a pencil at the right edge of its identity cell under the same
      `@media (hover: hover)` rule the cards use, restated unwrapped to read it: `display: none` at rest and
      `flex` on the hovered row and no other. It opens `edit_book` for that row and leaves the selection
      where it was — clicked Norwegian Wood's pencil with Dune checked and Dune stayed the set — and writes
      `?edit=books:<id>`. It is absent for a role that may not update the record: as a patron no row carries
      one, and as a librarian the two `archived` rows have none. (As an *admin* every row has one, archived
      included, which is [#1318](https://github.com/chessworld/ElevateR/issues/1318).) The "title gives up
      just enough width" clause could not be measured — the title element is shrink-to-fit and reports no
      box of its own.
- [x] shareable link: open row edit modal `edit_book` for a row you can see and the address bar gains `?edit=books:<id>`, which closing the modal takes away again — Back leaves the page rather than closing the modal, the param being written over the entry rather than after it. Reload that URL, or paste it into a browser with no history behind it: the page comes up with the modal already open over the listing, filled with that record rather than empty or loading. A link naming a record this reader may not see lands on the page with no modal and the param stripped, and the refusal read in the [[Command Strip]]: a warning and the attempt's own name on the bar, its sentence under the caret, and nothing added to the undo history
      ✓ walked. Opening the modal writes `?edit=books:<id>` and closing takes it away. Loading that URL cold
      — a fresh navigation with no history behind it — comes up with the modal already open over the
      listing and filled with that record. `history.back()` with the modal open left the page for the
      previous entry rather than closing the modal, so the parameter is written *over* the entry rather than
      after it. A link naming a record that does not exist
      (`?edit=books:00000000-0000-0000-0000-000000000000`) lands on the page with no modal and the parameter
      stripped, and the refusal reads in the [[Command Strip]] — "Open Record — Failed" on the bar, "That
      record could not be opened." under the caret, nothing added to the undo history. The server answers
      that id with a bare `404 not found` carrying no code, so "Failed" rather than "Not found" is the
      honest category.
- [x] click any cell of a row: that row becomes the whole [[Selection]] and nothing navigates; the checked row keeps its selected fill as the pointer crosses it rather than trading it for the hover tint; click that row's identity cell again and record page `book_page` opens — and a double-click anywhere in the table does nothing of its own
      ✓ walked. A click on Dune's Author Id cell selected the row and left the URL alone; the checked row
      kept its selected fill `rgb(230, 247, 253)` with the pointer on it and with the pointer elsewhere,
      while an unchecked row under the pointer stayed white. The second click on the identity cell opened
      `book_page` (`/library/books/<id>/overview`). No `dblclick` handler exists anywhere in the table.
- [x] record-action modals (`edit_book`): each opens from this page and submits
      ✓ walked. `edit_book` is the only modal this page's `record_actions` name. It opens from the row
      pencil, from the row menu's **Edit Book**, from a board card's pencil, from a cards-view card's pencil
      and from `?edit=`, and submits — verified in the database.
- [x] right-click a row with fewer than two rows checked and that row becomes the whole [[Selection]] — its own checkbox ticks and any other clears — with a menu at the pointer over it and **no panel behind it**, this page drawing none. The menu is headed by the `books` record's own name and holds this page's actions for it, one separator per group boundary, led by the record page in bold
      ✓ walked. Right-clicking a cell with nothing checked ticked that row, cleared every other and opened a
      menu at the pointer with no panel behind it, headed with the record's own name (**Dune**) and holding
      **Copy Author Id**, a separator, **Book Page** (bold, `_primary_`), **Edit Book**, a separator, **View
      Lifecycle**, a separator and **Related links** — one separator per group boundary, the record page
      pulled to the front.
- [x] the ellipsis in a row's identity cell opens the same menu, anchored to itself rather than to the pointer — it appears beside the pencil while the pointer is anywhere on the row, not only over the title, and on a touch screen it is there without hovering, which is a phone's only way in
      ✓ walked. `[aria-label="Show row menu"]` sits inside the identity cell beside the pencil, appears with
      the pointer anywhere on the row rather than only over the title, and opens the same menu anchored to
      itself (button at x=602, menu at x=602) rather than to the pointer. It is on every one of the twelve
      rows, and headlessly — the touch arrangement — it is simply there without hovering. It carries no cell
      item: **Book Page / Edit Book / View Lifecycle / Related links**, which is the row's own menu.
- [x] the menu is the whole of what a row's actions have on this page: every action this page's `record_actions` offer this reader stands in it, in the block's own order but with the record page pulled to the front, greyed with its own predicate's reason where one refuses and absent where a `hide` does — there being no item-details panel beside it to be compared with. Three read the way the panel worded them: the record page and the edit modal name the model (*Author Page*, *Edit Author*) and Lifecycle reads *View Lifecycle*. Walk it as a role the record's permissions narrow, too: what the menu holds has to narrow with them
      ✓ walked. Everything `record_actions` offers stands in it, in the block's order with the record page
      pulled to the front, and the three the line names read as it says for this model: *Book Page*, *Edit
      Book* and *View Lifecycle*. Nothing is greyed here, no `hide` predicate being declared. Walked as a
      patron too and the menu narrows with the permissions: **Copy Author Id / Filter by Author Id / Book
      Page / Related links** — the edit modal and Lifecycle both gone, the `catalogue` policy granting
      neither `update` nor `lifecycle`.
- [x] right-click a cell that is not the identity cell and the menu leads with **Copy {column}**, then a separator — what it copies is what the cell reads as, the string the CSV export carries, rather than its markup. Where the table filters on that column and the cell is not empty, **Filter by {column}** sits under it and narrows the table to the value in the cell, which then shows in the filters button and in the URL like any other
      ✓ walked. The Author Id cell's menu leads with **Copy Author Id**, a separator, then **Filter by
      Author Id**, and taking that narrowed the table and wrote `?filter_author_id=s~…` like any other
      filter. The Summary cell's leads with **Copy Summary** and carries no *Filter by* at all — `summary`
      is `filterable: false` — which is the fork the line's "where the table filters on that column" names.
- [x] right-click the *identity* cell and the menu leads with **Copy {Model} ID** instead — the `books` spec's singular display name, so *Copy Book ID* over `books` — which puts the record's id on the clipboard. That cell's value is the record's name, which is already the menu's heading. A menu opened from the ellipsis is the row's own and leads with no cell item at all
      ✓ walked. The identity cell's menu reads **Copy Book ID** — the `books` spec's `singular_name`, so
      *Book* rather than the model name — and carries no per-column copy item; the record's own name is
      already the menu's heading. A menu opened from the ellipsis leads with no cell item at all.
- [x] Related in the menu: this record's related links (every relation the spec declares) are one **Related links** submenu — after the `modal_actions` items and ahead of any custom action — holding a link per relation and landing on the listing each one names, filtered to this record, and nesting a submenu of its own wherever a section brings more than one
      ✓ walked. One **Related links** submenu, after the modal items and last in the menu, opening as a
      `_nestedList_` headed *Related links* and holding a link per relation the spec declares: **Authors**
      → `/library/authors/<the author>/profile`, **Reading Clubs** →
      `/community/clubs?filter_current_book_id=s~<id>`, **Loans** →
      `/circulation/loans?filter_book_id=s~<id>`, **Reviews** → `/circulation/reviews?filter_book_id=s~<id>`
      — each landing on the listing the relation names, filtered to this record (the `belongs_to` one going
      straight to the single record it points at).
      One reading recorded rather than filed, the clause being ambiguous: the submenu is flat, and `books`'
      relations do bring two from one nav section (Loans and Reviews are both `circulation`) without a
      nested submenu of their own. If "section" in the line means the nav section, this is the clause
      failing; if it means something narrower, there is nothing here to nest. Worth a generator triage
      rather than a UI issue on the strength of one reading.
- [ ] the whole table is **one** tab stop: Tab from the control above it lands inside the table once — on a cell, wearing a focus ring of its own — and Tab again leaves it for whatever is below, however many rows are on screen; the column headers' own controls keep the stops they had, and so do a row's selection checkbox and an open inline-edit field, while clicking any cell moves the ring to that cell
      ⚠ finding [#1314](https://github.com/chessworld/ElevateR/issues/1314) — the sibling's, and it
      reproduces exactly on this table. Tab from the header bar's last control lands on the view switcher,
      then on row 0's checkbox cell, then on that row's **Edit** pencil, and the next presses *open* the
      row's editable cells one after another, with no row selected and no cell previously open; the walk
      then carries on into the next row and never leaves the table. Clicking any cell does move the ring to
      that cell, which is the clause that holds.
- [x] Left and Right walk the ring across the columns of the row it is on, crossing out of the pinned columns into the scrolling ones without a stop in between, and Home and End are that row's first and last column rather than the table's first and last row; both ends hold rather than wrapping onto another row, and a column reached off the side of the window is scrolled to clear of the pinned columns rather than underneath them
      ✓ walked. From Dune's Author Id cell: Right → author_name → summary, Left back through author_id →
      **status**, crossing out of the pinned columns with no stop in between, and Right from status lands on
      identity and then straight on to the scrolling columns. `Home` is that row's checkbox cell and `End`
      its `buzz` cell rather than the table's first or last row, and both ends hold — Right on `buzz` and
      Left on the checkbox cell left the ring where it was. `End` scrolled the table to 1907 and put the
      focused cell at x=1180, clear of the pinned identity column which ends at 627.
- [x] Up and Down move the ring to the row above and below in the column it is already in, and every row it lands on is selected as a clicked row is, that `books` record becoming the whole [[Selection]] and the row before it unticking — hold Down and the checked row walks with the ring, on past the bottom of the window, where the next row is scrolled to and *then* focused rather than skipped over; the first and last rows hold rather than wrapping
      ✓ walked. Down and Up move the ring in the column it is on and every row it lands on becomes the whole
      selection, the row before it unticking (the checked row walked 001000000000 → 000100000000 →
      000010000000 and back). Fifteen Downs stopped at row 11 and five Ups at row 0 rather than wrapping.
      All twelve rows fit the window at 1400×900, so the scroll-then-focus clause has nothing to walk here.
- [ ] Ctrl+Home jumps the ring to the first row and Ctrl+End to the last row of the table rather than the last one fetched: on a `books` table long enough to be paged, Ctrl+End lands the ring on a row whose record has yet to arrive, the window goes back to the connection for it, and the selection moves to *that* record once it lands rather than staying on the row that was checked before
      — unreachable in part. Ctrl+End lands the ring on the last row and Ctrl+Home on the first, each
      becoming the whole [[Selection]]. The line's substance — a row whose record has yet to arrive, the
      window going back to the connection for it — needs a table long enough to be paged, and twelve `books`
      is not one. Said so rather than ticked.
- [x] Enter on the focused row's identity cell opens record page `book_page`, which is what a second click on that cell opens — the key and the click run the same thing, so a difference between them is a regression. It opens nothing else on the way: not the pencil's edit modal, and not the cell's own preview
      ✓ walked. With the ring on Children of Dune's identity cell, `Enter` opened
      `/library/books/<id>/overview` — the same page the second click on that cell opens. It opened nothing
      on the way: no edit modal, no cell preview.
- [x] Enter on the focused row's status cell opens the same transition menu a second click on it opens, under the cell and holding the same items — and where the reader is permitted no transition at all it opens nothing rather than falling through to that cell's preview
      ✓ walked. With the ring on a published row's status cell, `Enter` hung the same menu under it — headed
      **Published**, holding Draft (disabled, "Not permitted"), Published and Archived — and handed it the
      keyboard, the focus landing on the menu's first item. As a patron, permitted no transition, `Enter` on
      that cell opens nothing rather than falling through to the preview.
- [x] Space on any other focused cell **toggles** that cell's preview — the box floats and the same key puts it away — while Enter on a cell this reader may not write only ever opens it; a cell already showing all of its value floats nothing either way, and the page does not scroll down under either press. Escape then closes whatever is floating over the table first, and an Escape with nothing open gives the selection up — every checked row unticks, there being no panel to close instead, leaving the ring exactly where it was — Tab, not Escape, is the way out of the table. While anything floats the arrow keys stand aside rather than walking the ring out from under it, the box being placed against the cell it belongs to
      ✓ walked. `Space` on Things Fall Apart's clipped Summary cell floated the preview and `Space` again put
      it away, the page not scrolling under either press (`scrollY` 0 throughout). `Escape` closed the float
      first and left the row checked; a second `Escape` emptied the selection with the ring still on the
      same cell. While the box floated, `Right` left the ring where it was — the arrow stood aside — though
      it did take the float down with it.
- [x] Enter and F2 on a focused cell this reader may write open it for editing — the same field the second click opens, in the cell or in its popup — rather than that cell's preview, and the ring is in the field once it opens. On a cell they may not write, or one this table opens no field for, Enter falls back to the preview and F2 does nothing at all; the identity and status cells keep what they answer above
      ✓ walked. `Enter` and `F2` on a Summary cell both opened it for editing with the ring in the field, the
      same field the second click opens. On `review_count`, which this table opens no field for and which
      shows all of its value, neither opened anything and nothing floated. On a cell this reader may not
      write the fallback shows: as a patron, `Enter` on the clipped Summary cell floated the preview instead
      of an editor and `F2` opened none. The identity and status cells keep what they answer above.
- [ ] Tab from an open cell commits it and opens the next editable cell of the *same* row, Shift+Tab the previous — every column with no field to open is stepped over, the identity and status columns among them — and past the last editable cell of the row Tab leaves the table for whatever is below it, as Shift+Tab before the first leaves it upwards, the table being one tab stop. The [[Identity Column]]'s cell is the walk's first stop, and opens nothing either: `Tab` into the table lands there, `Enter` opens the record page, and `Tab` again carries on into the row's cells in the order the columns are laid out. The [[Status Column]]'s cell is one of the stops, and the one that opens nothing: `Tab` onto it commits whatever was open and leaves the ring there, `Enter` opens its transition menu — the same key a reader who arrived by arrow key presses — and `Tab` again carries on to the next editable cell rather than popping a menu part-way along the row. Escape inside an open cell is the cell's own: it puts back what the cell held and closes it, leaving the row checked rather than clearing the selection, which is what the same key does once no cell is open
      ⚠ finding [#1314](https://github.com/chessworld/ElevateR/issues/1314), with a symptom worth adding to
      it (and added, as a comment): on this table `Tab` from an *open* cell does not walk to the next
      editable cell of the row at all. From an open Summary cell it commits and lands on that row's own
      selection checkbox, then on `<body>`, and alternates between the two indefinitely — it never reaches
      the row's other fields, never steps over the identity and status columns because it never gets that
      far, and never leaves the table for whatever is below. `Escape` inside an open cell does put the value
      back and close the cell, leaving the row checked, but the ring goes to `<body>` rather than staying on
      the cell.
- [ ] Shift+F10, and the Menu key where the keyboard has one, open the row's context menu on the focused cell: the right-click's menu rather than the ellipsis's, anchored to the cell for want of a pointer to anchor to, with the row selected under it — so an ordinary cell's menu is led by the copy item naming that column and the identity cell's carries no copy item at all. A menu a key opened takes the keyboard: its first item is focused, Up and Down walk the items and Enter picks one, and closing it hands the keyboard back to the cell with its ring on. A right-clicked one takes nothing and leaves the ring where it was
      ⚠ finding [#1314](https://github.com/chessworld/ElevateR/issues/1314) — the hand-back. `Shift+F10` on
      the focused Author Id cell opens the right-click's menu anchored to the cell with the row selected
      under it, headed **Dune** and led by **Copy Author Id**; it takes the keyboard, focusing its first
      item, and `Down` walks to the next. Closing it with `Escape` hands the keyboard to `<body>` rather
      than back to the cell with its ring on. The Menu key has no WebDriver key code, so only the
      `Shift+F10` half is walkable here.

**A known issue that no longer reproduces on this page.** `DRESS-REHEARSAL-NOTES.md` records that
board views *“crash with a raw decode error ("unexpected null; try decoding as an `Option`") on any
record whose `board_rank` is still null — the default for every backdrop-seeded or freshly-created
record”*, and that board view is *“effectively unusable out of the box”*. On this branch it is not:
as an admin, with `select count(*), count(board_rank) from books` reading `12 | 0`, the board drew
every card in its status column with a clean console, and the first drag assigned real ranks. The
entry is left standing rather than struck out here, because only `books_listing` was walked and
`loans_listing` is session 03's — but the board is still broken for a reader whose policy excludes
`board_rank`, which is [#1322](https://github.com/chessworld/ElevateR/issues/1322), and the note
wants settling either way at the end of the run.

## Page: club_page  (`/community/clubs/:id/:tab?`)
- [x] renders as each of: admin, librarian, patron — and is absent from the nav *and* refused on direct navigation for every other role
      ✓ Renders end to end as admin, librarian and patron — **the `meeting_format` crash is gone**.
      The cell reads "In person — Location: Reading Room 2" and the console is clean. The patron
      gets the page without the History tab and with Status, Edit and Share record greyed, which
      is the `catalogue` policy (no lifecycle, no update, no share) rather than a fault.
      ● known: `circulation` is not refused on direct navigation — the page renders as an empty
      shell (94 characters, no title, no cluster) instead. That is the standing
      "no page refuses direct navigation for a disallowed role" entry; the nav half is right
      (Community carries no items at all for that reader).
- [x] `hidden: true` — confirm it is absent from the sidebar nav but reachable by URL
      ✓ No nav entry anywhere points at `/community/clubs/:id` — the sidebar's Community section
      lists Members, Reading Clubs and Events, all listings — and the page is reachable by URL for
      every role its `route.roles` name.
- [ ] the page heads with one two-row header: the title reads at the left of the upper row — the record's own name (its identity, not anything config names) — with the back arrow ahead of it, the page's 3 tabs beside it (Overview `overview`, Events `events`, History `history`) — the active one carrying the lower row's own background and sitting over its top border, so the two rows read as one object rather than as two cards with a gap between them. The [[Command Strip]] holds the right-hand end of that row and nothing else does; what it says there is the next line's. The bar directly beneath holds everything the header held before, each item where it was. Narrow the window until the title no longer fits and it ellipsises, resting a tooltip carrying the whole of it — a title that fits rests nothing
      ✓ One two-row header. Upper row: back arrow (x=322) → `/community/clubs`, the record's own
      name (`name`, not anything config names) at x=350, the 3 tabs beside it at 542/694/769, and
      the [[Command Strip]] alone at the right-hand end (x=1342). The active tab carries the lower
      row's own background (`rgb(255,255,255)`, the inactive one `rgb(239,245,251)`) and is 37px
      against its neighbours' 36, so it sits over the lower card's top border at y=104 — the two
      rows read as one object. The bar beneath holds the tab title and the whole cluster.
      ⚠ **finding — the ellipsised title rests no tooltip.** The title column is a fixed 180px, so
      a long club name is cut at *every* window width (`scrollWidth` 803 against `clientWidth` 180
      at 1400px) with `text-overflow: ellipsis` — and there is no `title` attribute anywhere in its
      ancestor chain and no tooltip wrapper around it, where the cluster's icon buttons each sit in
      one (`_tooltip_1h0as_50`). A real-pointer rest over it floats nothing. Filed as **#1344**.
- [x] the [[Command Strip]] is the only place a command's status is shown, and this page's header carries it: before any command has run it is its caret alone, greyed and opening nothing. Run one — a save made here, or one made on another page and then walked back to through the nav rather than reloaded, the history being the session's rather than the page's — and a spinner shows while it is in flight, for as long as it runs, then a tick and the command's own name — and ten seconds later the tick and the name fade away over a moment and the strip is its caret alone, the history still under it. Count it out: a success still there half a minute on is a finding, and so is one gone the moment it landed. Open the caret before the ten seconds are up and the name is held there until you close it again. A refusal reads the same way with a warning and a category after a dash — one of "Not allowed", "Invalid input", "Not found", "Server error" and "Offline" — its own sentence under the caret, and joins no history — and it does not fade: a refusal is still there a minute later, until the next command replaces it, which is the difference to watch for. The category is the server's own word for what it refused rather than a reading of the sentence it sent (ADR-0099), so a failure nothing named a kind for reads "Failed", which is the honest answer rather than something to report. What is a finding is a category naming the wrong kind — a save the policies refused reading anything but "Not allowed", a server stopped mid-session reading anything but "Offline" — and so is a headline carrying the whole sentence where those two or three words belong, the sentence being the dropdown's. Open the caret and the stack is there, newest first: an entry that can be taken back wears an undo icon, and clicking the icon on the *n*th of them moves the stack past all *n* in one call, the headline then naming the direction — "Undo" and the command's own name. An entry whose command declared no undo wears a lock instead, and every entry older than it loses its icon behind that lock — so an entry under a lock drawing no icon is that lock's doing rather than a fault. Which of this app's saves lock and which take themselves back is the Undo section's, at the foot of this plan: a stack with no undo icon anywhere in it is a finding rather than a reading. Ctrl+Z reaches the same undo a step at a time and Ctrl+Shift+Z puts it back, each saying nothing beyond what the headline says, and each standing down — headline unmoved — while the keyboard is in a text field or a modal is open. At a phone width the strip is the icon and the caret alone, the command's name being read in the dropdown instead
      ✓ Every clause of it, on this page's header.
      - Fresh page: the caret alone, greyed (`disabled`), and clicking it opens an empty popup.
      - A save: a tick and the command's own name — **Update Capacity**, named after the column —
        held at t=0/2/5/8s and gone by t=11s. Opened at t=3s, the caret holds the name past t=15s;
        the history stays under it.
      - Refusal: the librarian's role revoked under an open cell reads
        **"Update Capacity — Not allowed"** — the server's own category after a dash, its sentence
        under the caret ("Not permitted to update 'events' record … (status: scheduled)"), **no**
        history entry, and it does not fade: still there 30 seconds on.
      - The stack is newest-first; an ordinary save wears `Undo <name>`, and a `scheduled →
        completed` transition ("Change status") wears a **lock** with every entry under it drawing
        no icon — the documented reading rather than a fault.
      - At a phone width the strip is the icon and the caret alone (32px wide, no name).
- [ ] the tab row gives way: drag the window narrower and the 3 tabs give up width evenly, each label ellipsising and resting a tooltip carrying the whole of it only where it is actually cut — a label still showing in full rests nothing. Past a 30px floor per tab the row stops shrinking and becomes one menu button carrying the *active* tab's own label and a caret — "Overview" on arrival — and opening it lists all 3, every one of them still reaching its tab. At a phone width the row is that menu button whatever the window could have fitted. Widen back and the tabs come again with the same tab active
      ✓ At a phone width the row is one menu button carrying the active tab's own label
      ("Overview") and a caret, opening all 3, each still reaching its tab; widening brings the
      tabs back with the same tab active.
      — unreachable: the shrink-and-ellipsise stage. The three labels hold 104/107/87px from 1400px
      down to 768px and the row flips to the menu button at 766px — the phone breakpoint — so there
      is no width at which a label is cut and could rest a tooltip. Three short labels never reach
      the 30px floor. (#1342 is the same geometry seen from the other side: `book_page`'s seven
      labels *are* all cut, at a 1400px window.)
- [x] pick/create a sample `clubs` record for the steps below (backdrop first, API if the backdrop lacks one)
      ✓ `Dune Readers` (`f534b2b2-…`), the backdrop's own, is the sample for everything below. Its
      Events tab was seeded up to 12 rows (see this session's notes at the foot of the harness
      section), and a second club with a deliberately unfittable name was created for the header
      line above.
- [x] this page draws no [[Panel]] at all: no docked root panel — not the `clubs` item-details panel a `parent_page` used to make one, not a `panel_name` and not a blocks tab's `root_panel_override` — no tab rail down the right edge to open one from, and the content running out into the 45px the rail used to reserve; no click on a table tab's row opens an item-details panel, there are no per-model **Select** entries anywhere to open one from, and the mobile header carries no panel button. Append `?panel=<a `clubs` record id>` to this page's URL, on any tab, and it opens nothing at all
      ✓ The content element is literally `_contentWithNoPanel_f51ul_37` and runs the full width
      (x=296…1400) on every tab — no 45px rail reserved, no tab rail element anywhere, no panel
      button at any width, and no per-model **Select** entry in any menu (the `Select` accessible
      names in the table are the rows' own selection affordance).
      ✓ `?panel=<a clubs record id>` appended on `overview`, `events` and `history` opens nothing at
      all: same class, same rect, no panel, and no click on an events row opens an item-details
      panel.
- [ ] `parent_page` `clubs_listing`: a back arrow sits ahead of the page title and lands on that listing — from a record opened out of the listing *and* from one deep-linked or reloaded, where there is no history to go back through — and is absent for a reader `clubs_listing`'s own `route.roles` do not permit
      ✓ The back arrow sits ahead of the title and lands on `/community/clubs`, both from a record
      opened out of the listing and from one navigated to directly with no history behind it.
      — unreachable: the "absent for a reader `clubs_listing`'s `route.roles` do not permit" arm.
      Both pages name the same three roles (admin, librarian, patron), so no signed-in reader
      reaches this page without reaching the listing. The one reader who would — a ShareToken
      visitor holding no role — is not reachable without minting a token, and was not walked.
- [x] listing state round trip: filter, sort and switch view on `clubs_listing`, open a record, move between its tabs, then take the back arrow — the listing is the one that was left rather than its defaults, including the case where every filter was cleared
      ✓ Sorted `clubs_listing` by Capacity (`?sort=capacity_asc`), opened a record — the record URL
      wears `?ref_sort=capacity_asc` and nothing under the bare name — moved from Overview to
      Events, which kept the `ref_` param, and took the back arrow: back on `/community/clubs?sort=capacity_asc`
      with the same order rather than the defaults.
- [x] record page actions in tab `overview`: the record's own actions sit at the right-hand end of *that tab's* header — not the page header carrying the back arrow, the title and the tab strip — and no other tab of this page carries them. They are `clubs_listing`'s `record_actions` rather than anything declared here, so they are the same list, the same wording and the same gates as a row of that listing offers. **Edit** follows the status button at the head of it as a primary button carrying its icon *and* its text, labelled just "Edit" where the row menu's item names the model, and opens `edit_club` on the record the page is showing — a save landing back on the page under it. A reader whose permissions refuse that update keeps the button, greyed and carrying the menu's own reason: a cluster that loses a button under one reader says nothing about why
      ✓ The cluster sits at the right-hand end of the *tab's* bar (y=112, under the page header at
      y=68) and no other tab carries it: the Events tab's bar holds Filters/Sort/Customize
      columns/the listing link, and the History tab's holds nothing. It is `clubs_listing`'s
      `record_actions`: Status, **Edit**, View Lifecycle, Share record, Related, More.
      ✓ Edit is the primary button, icon *and* text, labelled just "Edit" where the row menu's item
      names the model, and opens `edit_club` on this record; a save lands back on the page under it.
      ✓ Moved the club to `archived`, whose `admin` policy permits no update: Edit stays and
      **greys** (and so does Share record) rather than going missing.
- [x] tab `overview`: the **status button** leads the cluster, left of Edit: one button wearing the record's current `clubs` status as a disc in its icon slot and that status's own label beside it in full — the cluster's other icon buttons carry their wording in a tooltip, and a status nobody can read is no status. Click it and the transition menu opens under it, the same menu a [[Status Column]] cell's second click opens: an item per status the spec declares, the current one ticked and inert, each of the others the transition to it, refused with its own reason where this reader may not make it and opening the transition modal first where it has properties to collect — and the status the walk lands on is in the record's lifecycle history afterwards. A reader permitted no transition at all keeps the button, naming the status and **disabled** under the same reason rather than going missing. It stands in **both** layouts, and on this project it is the only *button* the status is offered from: there is no item-details panel carrying a badge, and a `properties` block's status pill is a reading rather than a way to move it
      ✓ The status button leads the cluster, left of Edit, wearing the record's status as a disc in
      its icon slot with the label **Active** beside it in full. Clicking it opens the same list the
      [[Status Column]]'s second click opens — headed "Active", then an item per declared status
      (Active, Archived). Took Active → Archived and back; both landed, and both are in the record's
      lifecycle history afterwards (`history` tab shows "Archived · 28 Sep 2026 23:01 · Ada Admin").
      ✓ It is the only button the status is offered from: the `properties` block draws it as a
      reading pill and there is no panel badge.
- [x] tab `overview`: **View Lifecycle** and **Share record** follow it as icon buttons — one glyph each and no text, the tooltip the only thing naming them — and the first switches to the page's own `history` tab rather than opening the modal the row menu opens over a listing, this reader being already on the record's page. A history read this reader may not make keeps its refusal and switches nothing. Share opens the same share modal the menu opens, and greys with the menu's own reason for a reader holding no usable grant rather than going missing. Each is the row menu's own action otherwise: same icon, same wording, and absent here wherever the menu drops it
      ✓ Both follow the status button as icon buttons with no text: **View Lifecycle** (an `<a
      href="/community/clubs/<id>/history">` — it switches to the page's own history tab rather than
      opening the row menu's modal) and **Share record** (a button). As a patron, who holds no
      lifecycle grant, View Lifecycle is **absent** and Share record is **greyed** — the row menu's
      own gates. On an archived record Share greys too, `share` being scoped to `active`.
      — unreachable: "the tooltip is the only thing naming them". The tooltip is CSS inside
      `@media (hover: hover)`, inert headlessly whatever the JS media queries are patched to
      (session 04's ruling); the wording is on each as its `aria-label`, and each sits in a
      `_tooltip_1h0as_50` wrapper — where the record title above sits in none (#1344).
- [x] tab `overview`: **Related** closes the buttons as a dropdown — the `circle-nodes` glyph with the word beside it and a caret, the row menu's **Related links** submenu under a heading short enough for a button — and holds this record's related links (every relation the spec declares) in the sections, the order and the nesting that submenu holds them in, landing on the same listings. It is absent altogether rather than opening on nothing for a reader whose nav roles reach none of the targets
      ✓ **Related** closes the buttons as a dropdown — the glyph, the word and a caret — and opens
      `_list_i7oz6_1` headed "Related" holding **Books** and **Events**: every relation `clubs`
      declares (`current_book_id → books`, and `events.club_id` back), landing on those listings.
- [x] tab `overview`: the **More** ellipsis ends the cluster and gathers everything with no button of its own. **Copy {Model} ID** leads it — the item the row menu gives an identity cell, which a record page has no table of its own to offer anywhere else — and then the `modals` entries, a rule between each block and the next; the commands the page header carries of its own sit under the lot. Every entry is the row menu's, relabelling and gates included, and the ellipsis is there for every reader — Copy {Model} ID is the record's rather than the block's, so it is never gathering nothing
      ✓ The **More** ellipsis ends the cluster and opens a menu headed "More" holding
      **Copy Reading Club ID** — the model's singular display name — and nothing else, which is
      right: `edit_club` is the only `clubs` modal and it is already the Edit button, so the
      `modals` block it would gather is empty. It is drawn for every reader, the Copy item being the
      record's own.
- [x] tab `overview` at a phone width: the whole cluster folds into the header's existing **Actions** menu — the status button under the status it names, then Edit, each icon button under the wording its tooltip carries, the related links and the ellipsis's own items, all entries of that one menu in the cluster's order — and no button of it is left beside the tab's title. There is no docked item-details panel beside it to be untouched — this page draws none — so that one menu is the whole of the record's actions at this width
      ✓ At 520px the whole cluster folds into one **Actions** button, and the bar beside the tab's
      title carries nothing else — only the back arrow, the tab menu button and the [[Command
      Strip]] are left in the header. The menu is headed "Actions" and holds, in the cluster's
      order: **Active** (nested, opening the transition sheet), **Edit** (`_primary_`), **View
      Lifecycle**, **Share record**, **Related** (nested, drilling into Books/Events with a Back
      arrow), a separator, and **Copy Reading Club ID**. No docked panel beside it to be untouched.
- [x] tab `overview` (Overview): blocks render with the record's real values, the record's status among them as the same pill a card draws — a band of colour across the block, or down the page, is the regression this clause exists to catch
      ✓ The Overview blocks render the record's real values (Name, Description, Current Book Id,
      Current Book Title, Capacity, Meeting Format, Logo File Id), including the union
      `meeting_format` as **"In person — Location: Reading Room 2"** — the itemset's own label, not
      JSON and not a crash. The status is a 65×25 pill (`[data-status-chip]`) on its own row, not a
      band across the block or down the page.
- [x] tab `events` (Events): related `events` table shows only this record's rows, and a column hidden, resized, or carried to a new place by its header here stays on this tab — the listing page over `events` keeps a layout of its own
      ✓ The tab shows 12 `events` rows, every one of them Dune Readers' (the `club_id in .id`
      filter).
      ✓ Hid **Venue** through this tab's Customize columns: the tab drops it, `events_listing`
      still draws it, and coming back to the tab finds it still hidden. **Revert to defaults** puts
      it back. The two layouts are separate.
      ● #1337 confirmed, plainly, side by side: the listing's header reads **Starts** (its view's
      `columns.starts_at.label`) and the tab's reads **Starts At**, and the listing's
      `date_time_short` renderer is not applied on the tab either — the cell there is the raw
      "2026-12-16 08:00:00". The tab inherits nothing of the view's `columns`.
- [x] tab `events`: the identity column is this table's pinned first column too, naming each `events` record, and its header no more drags along the row here than it does on a listing page
      ✓ The identity column is the pinned first column after the checkboxes
      (`_stickyRow_1sfh1_54 _stickyShadow_1sfh1_232`, x=312, staying put while the rest of the
      1747px-wide table scrolls under it), naming each `events` record by `title` with `starts_at`
      as its subtitle. Its header drags along the row no more than a listing page's does — a header
      click moves nothing at all (#1311).
- [x] tab `events`: the table opens sorted by `starts_at`, descending — declared here in `default_sort`, which beats the order `events_listing` would otherwise have lent it — and that column's header is the one wearing the arrow
      ✓ The table opens sorted by `starts_at` **descending** — the tab's own `default_sort`, which
      beats `events_listing`'s `starts_at asc` — and Starts At is the one header wearing the arrow.
      The Sort modal reads "Starts At / Descending" on arrival.
- [x] tab `events`: sort a text and a numeric column, both directions
      ✓ Through the Sort modal, `Capacity` ascending → 8,10,12,15,20,25 and descending →
      25,20,15,12,10,8, the arrow moving to that header both times; `Title` ascending and descending
      both order correctly.
      ● #1316 confirmed: sorted by Title — the identity property — **no column wears an arrow at
      all**, so a table sorted by its identity looks unsorted.
      ● #1311 confirmed: clicking a column header sorts nothing; Sort is a modal behind the header
      bar.
- [x] tab `events`: the status column is this table's second column too, each `events` row wearing its status as the same band — and a click on a ticked row's status cell opens the same transition menu here as on the listing page, moving the whole checked set the way it does there
      ✓ Status is the second column, each row wearing its status as the same band
      (`_fillCell_1sfh1_299` with a `[data-status-chip]` inside).
      ✓ A click on a ticked row's status cell opens the same transition list the button opens, and
      over a [[Selection]] it is the set's: three `scheduled` rows ticked offered Scheduled,
      Cancelled and Completed, and taking Completed moved **all three as one write**.
- [ ] tab `events`: rest the pointer on a cell whose value this column's width cuts off and about half a second later the whole of it floats beside the cell, wrapped rather than clipped and rendered the way the cell renders it rather than as a bare string; move the pointer away and the box goes, while a cell already showing all of its value floats nothing however long the pointer rests on it. On a phone, where there is no pointer to rest, a tap on that same cell floats the box at once and a tap elsewhere puts it away — and neither tap changes which row is selected
      ⚠ **finding — a clipped value on an editable row never previews.** The box opens exactly where
      the cell is *not* an inline-edit cell: `venue` on a `completed` row (`scrollWidth` 602 against
      `clientWidth` 199) floats the whole value; the same column on a `scheduled` row reports
      199/199 — the inline-edit wrapper absorbs the overflow — and floats nothing, by pointer or by
      `Space`. The identity cell with a title too long for it is the same: 199/199, no box.
      `CellPreviewCell.tsx:131` gates on `cell.scrollWidth <= cell.clientWidth` measured on the
      `[data-table-cell]` element, while the ellipsis lives on an inner wrapper. Filed as **#1345**.
      — unreachable: the half-second pointer rest itself, and the phone's tap. Session 04's ruling
      stands — `(hover: hover)` CSS is inert headlessly — so the box was judged through `Space`,
      which the plan's own keyboard line offers, and through the geometry the gate reads.
- [x] tab `events`: the `events` cells with a rich rendering to float — `worksheet_file_id`, whose box holds the file itself (the image card where the file is an image, the attachment chip where it is not) — float it however wide the column is, nothing needing to have been cut off, and what floats is that property's own detail rendering rather than a second one written for tables: the same rendering a record's `properties` block draws for it, so a box that differs from that block for the same record is a regression rather than a preference — and the thumbnail an image cell draws is display-only now that the preview has replaced the lightbox: clicking it makes that row the whole [[Selection]], exactly as clicking any other cell does, and opens no lightbox over the table
      ✓ `worksheet_file_id` floats its detail whatever the column's width, on rows the reader may
      write and rows it may not alike — the `hasDetail` arm of the gate bypasses the clipping test
      that #1345 breaks. Every one of the 11 seeded events carries a real worksheet (the
      `events/event_worksheet` workflow fired on create), drawn in the cell as an attachment chip
      with a PDF glyph and floated as the same attachment rendering, the file being a PDF rather
      than an image. No lightbox opens from it; the click selects the row like any other cell's.
- [x] tab `events`: click any cell of a row to select it, then click one of that row's cells again: the cell becomes the `events` field it edits, with the cursor in it. The first click only makes that row the whole [[Selection]] — every other row unticks and this one ticks — and opens no panel, there being none on this page; a click on a row *outside* the selection never opens a cell, and a double-click still does nothing of its own. The two cells ADR-0095 spoke for keep their own second clicks — the identity cell opens the record page and the status cell the transition menu — and no ordinary cell grows a pencil beside the identity cell's. On a phone the same pair of taps opens the cell, the identity cell being what selects the row there
      ✓ First click on a cell of an unticked row makes that row the whole [[Selection]] and opens
      no cell and no panel; the click after it opens the cell with the cursor in it. A click on a
      row *outside* the selection never opens a cell. The identity cell's second click resolves no
      record page (`events` declares none) and the status cell's opens the transition menu. No
      ordinary cell grows a pencil beside the identity cell's.
      ✓ The hover patch was proved before any of this was judged: one click on a Capacity cell ticks
      that row (`button[class*=clickable]` is **not** vacuous on this surface — the rows carry
      `_row_1sfh1_33 _clickable_1sfh1_47` — but the click check is the one that decides it).
- [x] tab `events`: type into an open cell and click away: the blur saves that one property of that one `events` record, `Enter` saves and closes, and the [[Command Strip]] names the save after the column it changed — **Update {column}**, the word that column’s header shows, rather than a general Save changes — with an undo that puts the old value back in the row. `Escape` instead of either puts the old value back without saving. Nothing saves on a timer — leave an open cell alone for a minute and it is still unsaved with the strip silent — and a write the server refuses leaves the cell holding what was typed rather than retrying it, the strip carrying the refusal's sentence and its category, with `Escape` the way to give that draft up. Walk it as a role whose policies may not update the record at its status, too: that row's cells never open at all
      ✓ Blur saves the one property of the one record (33 → 21, strip **Update Capacity**); `Enter`
      saves and closes; the undo in the stack puts the old value back. `Escape` puts the old value
      back without saving and leaves the row checked.
      ✓ Nothing saves on a timer: an open cell left alone with 66 typed in it for 30 seconds is
      still unsaved, the database still holding 21 and the strip silent.
      ✓ A row the reader may not update at its status never opens a cell at all (the `completed` and
      `cancelled` rows here).
      ● #1329 confirmed: a write the server refuses leaves the **rejected** value in the row — 77 on
      screen against 33 in the database — with the refusal in the strip and `Escape` holding no
      draft to give up.
- [ ] tab `events`: where each `events` field opens: `title` and `capacity`: **in the cell**, as an input filling it; `club_id` and `worksheet_file_id`: **in the cell**, as a search box over the records it points at, saved when the cell is left rather than when the menu is picked from; `starts_at`: in a popup holding the month grid — the same calendar a modal's date field draws rather than the browser's own control; `venue`: in a popup holding the structured-object editor. A popup is anchored to the cell it came from, is wide enough to write in rather than the width of the column, holds the focus while it is open, and commits when it closes — an upload still running or a search menu holding the focus is the editor's own and commits nothing half-finished. It is **one box**: a date's month grid is drawn inside it under the input, up from the moment the cell opens, rather than floating over it as a second popup with a second edge to find, and picking a day from it writes the value and leaves the grid standing. And a click anywhere inside the box leaves it open — its padding, the space beside a field, the grid — so only a click *outside* it puts it away, committing what is in it. A click on the cell the box came from is one of those: it closes the box and leaves it closed, rather than closing and reopening it under the one click. The grid answers the pointer and nothing else: with the caret in the date, `Home`, `End` and the arrows move it through what is being typed rather than through the month, typing being the way in from a keyboard — and `Enter` finishes a typed date and saves it, a box holding one line being one line. Every other column of this table opens nothing at all, which is what its cells refusing the second click means rather than a fault
      ✓ `capacity` opens **in the cell** as a number input filling it; `club_id` and
      `worksheet_file_id` open **in the cell** as text search boxes over the records they point at;
      `starts_at` opens in a popup anchored to the cell (480px wide, far wider than its column)
      holding the month grid drawn *inside* it under the input, as one box — clicking a day writes
      the value and leaves the grid standing, and only a click outside puts it away. `club_name`,
      the identity and the status open no field, which is what their cells refusing the second click
      means.
      ● #1324 confirmed: `venue` opens a popup holding a **raw JSON `<textarea>`** —
      `{\n "city": "Brisbane", …}` — rather than the structured-object editor. (`edit_event`
      deliberately omits `venue`, so the form this cell should be borrowing from is `edit_club`'s
      `meeting_format` branch block, which *does* draw one.)
      ⚠ finding — the date popup's grid opens on the **current** month (September 2026) rather than
      on the month of the value being edited (November 2026), so a reader editing a date has to page
      to it. Filed as **#1346**.
- [x] tab `events`: the caret an armed cell wears: select a row and its `starts_at` and `venue` cells each grow an angle-down caret at the right edge — the same affordance the [[Status Column]]'s band wears, on every cell whose click opens a list or a box rather than a field to type in. The cells of `club_id`, `title`, `capacity` and `worksheet_file_id` wear none: there the click opens a field to type in, which is its own affordance. The caret is there only while the row is selected — an unselected row's cells wear none, that click being the row's, and the value under it does not move a pixel as the cell opens — the open field is set in the table's own font, so the same string lands on the same baseline in the same place, and a value too long for its column still ends in an ellipsis rather than breaking at a word. What the caret does when the cell opens depends on where the field went: a field drawn *in* the cell brings a chevron of its own, so the cell's goes, and a field that opened in a popup leaves the cell showing its value, so the caret stays and turns upside down. Nothing the caret sits on moves: the value reads exactly where it read before the row was selected, and the caret sits on the same pixel as the open field's own chevron
      ✓ Selecting a row grows a caret on exactly `status`, `starts_at` and `venue` — the three whose
      click opens a list or a box — and on none of `club_id`, the identity, `capacity` or
      `worksheet_file_id`, whose clicks open a field to type in. (The glyphs the identity and
      worksheet cells already draw are there unselected too, so they are not carets.) An unselected
      row wears none. The value under the caret does not move as the cell opens: the in-cell field
      is drawn at the same rect as the cell (e.g. capacity cell [920,471,100,35], field
      [919,471,99,34]).
- [x] tab `events`: a selected row's cell content goes inert: with the row selected, a link, a chip or a button drawn inside one of its cells stops answering the pointer — it draws no hover emphasis and follows nowhere — so the second click has one meaning wherever in the row it lands, and on an editable cell it opens that cell. On an *unselected* row the same content is live and the click belongs to the row underneath. What a reader wanted from that link is still reachable: the [[Cell Preview]] the hover floats carries the rendering with it, and `Space` and a tap float the same box. The identity cell is the exception and goes on answering — its pencil, its ellipsis and its record page all still take the pointer
      ✓ A selected row's cell content goes inert: each editable cell of the selected row carries
      `FiE3va_inert` with `data-inline-cell-inert` and a `data-inline-cell-faded` child, so the
      second click has one meaning wherever in the row it lands. The identity cell is the exception
      and goes on answering — its row-menu button is still live on the selected row.
      ⚠ What a reader wanted from that content is *not* still reachable here: the [[Cell Preview]]
      is exactly what an editable cell stops floating (#1345 above).
- [ ] tab `events`: clear `title`, which the spec requires a value for, and leave the cell: the old value is back in it, nothing is sent, no command runs and the [[Command Strip]] says nothing, there being nothing to report. No cell and no row anywhere in the table is drawn red, outlined or marked invalid at any point, which is the half to watch for. Where the schema points at one repair the value is repaired instead and the repair is what saves: a number past its bounds comes back clamped to them, a string past its maximum truncated to it, and leading or trailing whitespace trimmed away
      — unreachable as written: `title` is this model's identity, so it has no column of its own on
      this table (Customize columns lists it under *Hidden*) and the identity cell opens no editor.
      There is no other required property in the table's editable columns.
      ✓ The repair half was walked on `capacity`, whose schema declares `min: 1`: typing **0** and
      leaving the cell saved **1** — clamped to the bound rather than refused — with no cell and no
      row drawn red, outlined or marked invalid at any point.
- [x] tab `events`: these rows answer to `events_listing` rather than to this page — the menu a row opens, the pencil in its identity cell, the [[Selection Menu]] its checked rows open and the record page a second click on that cell reaches are all built from that listing's `record_actions`, so a change made there shows up here and nowhere else does; this page's own record actions are `clubs_listing`'s and govern the cluster in its first tab's header alone
      ✓ Every row affordance is built from `events_listing`'s `record_actions` rather than from this
      page's: the row menu holds *Edit Club Event*, *View Lifecycle* and *Related links* and leads
      with **no record page**, `events` declaring none — where this page's own cluster is
      `clubs_listing`'s and governs the Overview tab's header alone. The pencil opens `edit_event`,
      the listing's `edit_modal`.
- [x] tab `events`: right-click a row with fewer than two rows checked and that row becomes the whole [[Selection]] — its own checkbox ticks and any other clears — with a menu at the pointer over it and **no panel behind it**, this page drawing none. The menu is headed by the `events` record's own name and holds `events_listing`'s actions for it, one separator per group boundary, led by the record page in bold
      ✓ Right-clicking a row with fewer than two checked ticks that row alone, clears every other,
      and opens a menu at the pointer with **no panel behind it**. It is headed by the record's own
      name — "Bene Gesserit book swap 2026-11-18 08:00:00", the identity with its subtitle — and
      holds `events_listing`'s actions with one `_separator_1lu93_1` per group boundary. Nothing is
      pulled to the front in bold, there being no record page to pull.
- [x] tab `events`: the ellipsis in a row's identity cell opens the same menu, anchored to itself rather than to the pointer — it appears beside the pencil while the pointer is anywhere on the row, not only over the title, and on a touch screen it is there without hovering, which is a phone's only way in
      ✓ `[data-identity-menu] button` ("Show row menu") sits in the identity cell beside the pencil
      on every row, anchored to itself rather than to the pointer, and it is in the DOM at rest
      without hovering — a phone's way in. It opens the same menu, led by **Edit Club Event** with
      no cell item at all.
- [x] tab `events`: the menu is the whole of what a row's actions have on this page: every action `events_listing`'s `record_actions` offer this reader stands in it, in the block's own order but with the record page pulled to the front, greyed with its own predicate's reason where one refuses and absent where a `hide` does — there being no item-details panel beside it to be compared with. Three read the way the panel worded them: the record page and the edit modal name the model (*Author Page*, *Edit Author*) and Lifecycle reads *View Lifecycle*. Walk it as a role the record's permissions narrow, too: what the menu holds has to narrow with them
      ✓ The menu is the whole of it: *Edit Club Event*, *View Lifecycle*, *Related links*, in the
      block's own order, with no item-details panel beside it. The edit modal names the model and
      Lifecycle reads *View Lifecycle*, as the line says; there is no record-page item because
      `events` resolves none.
      ✓ It narrows with the record's permissions: on a `cancelled` or `completed` row — which
      `events`' `admin` policy permits no update on — **Edit Club Event** is absent and the pencil is
      gone from the identity cell, while *View Lifecycle* and *Related links* stay.
- [x] tab `events`: right-click a cell that is not the identity cell and the menu leads with **Copy {column}**, then a separator — what it copies is what the cell reads as, the string the CSV export carries, rather than its markup. Where the table filters on that column and the cell is not empty, **Filter by {column}** sits under it and narrows the table to the value in the cell, which then shows in the filters button and in the URL like any other
      ✓ Right-click on `club_name` leads with **Copy Club Name**, then a separator. Right-click on
      `capacity` leads with **Copy Capacity** and **Filter by Capacity** under it. Club Name draws no
      Filter item, and that is right rather than missing: `events.club_name` is declared
      `filterable: false`, so the table does not filter on it.
- [x] tab `events`: right-click the *identity* cell and the menu leads with **Copy {Model} ID** instead — the `events` spec's singular display name, so *Copy Book ID* over `books` — which puts the record's id on the clipboard. That cell's value is the record's name, which is already the menu's heading. A menu opened from the ellipsis is the row's own and leads with no cell item at all
      ✓ Right-click on the identity cell leads with **Copy Club Event ID** — the `events` spec's
      singular display name — and carries no cell copy item; the cell's own value is already the
      menu's heading. A menu opened from the ellipsis leads with no cell item at all.
- [x] tab `events`: Related in the menu: this record's related links (every relation the spec declares) are one **Related links** submenu — after the `modal_actions` items and ahead of any custom action — holding a link per relation and landing on the listing each one names, filtered to this record, and nesting a submenu of its own wherever a section brings more than one
      ✓ **Related links** is the last item and nests: it opens a submenu of its own holding
      **Reading Clubs** → `/community/clubs/<this club>/overview`. `events` declares one relation
      (`club_id → clubs`), so one link, and it lands on the target filtered to this record — on the
      club's record page rather than the listing, `clubs` having one.
- [x] tab `events`: the checkbox column is there before anything is clicked: the table opens with a checkbox in a column of its own ahead of the [[Identity Column]] on every row, nothing ticked, and one in the header. There is no **Select multiple** toggle anywhere on the page to have turned it on — no root panel to hold one, a record page's table tab having never had one, and the tab's own header bar carries its title, its **Add** and the table's controls and nothing about selecting — and nothing else about a row has moved: the identity cell keeps its pencil and the row menu's ellipsis, nothing being ticked yet. Leave the tab for another and come back and the column is still there with nothing ticked, the [[Selection]] being this tab's own: no `panel` parameter is ever written to the address bar by any of this
      ✓ The table opens with a checkbox in a column of its own ahead of the [[Identity Column]] on
      all 12 rows and one in the header, nothing ticked. There is no **Select multiple** toggle
      anywhere — the tab's header bar carries its title, its item count, Filters, Sort, Customize
      columns and a link to the listing, and nothing about selecting — and nothing else about a row
      has moved: the identity cell keeps its pencil and its ellipsis.
      ✓ Leaving for another tab and coming back leaves the column there with nothing ticked, and no
      `panel` parameter is ever written to the address bar by any of it.
      — the tab's header bar carries **no Add button**, which session 05 already ruled right rather
      than missing on `book_page`: the `page_actions.add_modal` the line means is `events_listing`'s,
      and a record page's table tab draws none.
- [x] tab `events`: giving a set up, with no count and no **Clear** to do it by: on a `events` table with more rows than three, tick three of them and click the header checkbox — all three untick rather than the whole table checking, which is what a partial set answers to now. Click it again with nothing ticked and every row of the table checks; click it once more with every row checked and every one unticks. Press `Escape` with three rows ticked instead and the set empties the same way, the focus ring left exactly where it was. There is no selection count and no **Clear** anywhere on the page to have done either by — the header checkbox is a phone's way, having no `Escape` to reach for. **Every identity cell's pencil goes** while more than one row is ticked — the edit modal writes the one record it was clicked on, which is not what a set is edited with — and each comes back the moment the selection is down to one row or none; the ellipsis beside it never goes, the row menu being where a checked row's own list opens
      ✓ With three rows ticked the header checkbox unticks all three rather than checking the table;
      clicked again with nothing ticked it checks all 12; clicked once more it unticks all 12.
      `Escape` with three ticked empties the set and leaves the focus ring where it was.
      ✓ There is no selection count and no **Clear** anywhere on the page.
      ✓ Every identity cell's pencil goes the moment a second row is ticked — only "Show row menu"
      is left in the cell — and each comes back when the set is down to one row or none; the
      ellipsis never goes.
- [x] tab `events`: the one click rule: click a cell of a *ticked* row and that cell opens for editing, which is what the second click on a row has always been; click a cell of an *unticked* row and that row becomes the whole selection instead: every other row unticks, this one ticks, no cell opens and no panel opens either, this page drawing none, and the click after it opens that cell. **A click inside the selection never takes it**: with three rows ticked, click anywhere on one of them — a cell's dead space, a column that opens nothing, the spare width past the last column — and all three are still ticked. So the [[Selection]] grows and shrinks by checkbox alone: no click anywhere in the table ever adds a row to it. The identity cell is ADR-0095's still — a second click on it opens the record page rather than a cell — and a row this reader may not update is a row whose cells do not open, ticked or not
      ✓ A click on a ticked row's cell opens that cell; a click on an unticked row's makes it the
      whole selection instead, opening no cell and no panel, and the click after it opens the cell.
      ✓ **A click inside the selection never takes it**: with rows 2, 3 and 4 ticked, a click on
      row 3's `club_name` (a column that opens nothing) and on its `capacity` both left all three
      ticked. The selection grows and shrinks by checkbox alone.
      ✓ A row the reader may not update is a row whose cells do not open, ticked or not.
- [ ] tab `events`: the set marks, and the editor opens on what it shares: tick three rows by their checkboxes and rest the pointer on one of their `capacity` cells — the same column's cell on the other two ticked rows is marked with it, a tint of its own over the fill a ticked row already carries, so what is about to change is visible before it changes. Carry the pointer along the row and the marking follows it column by column; carry it onto an *unticked* row and nothing marks there, and the [[Identity Column]] neither marks nor is marked, its second click opening a record page rather than anything a set can be asked for — while the [[Status Column]] does both, a status being one of the things a selection changes: rest the pointer on a checked row's status cell and every checked row's band wears a ring and the action colour washed over it, its own included — the status colour still showing through, so a marked set never reads as a different status. Now click that cell: it opens holding the value the three rows share, or empty where they hold three different ones — and empty is not a change, so leave it without typing and nothing is sent, no command runs and the [[Command Strip]] stays silent. Type, and what is typed shows in that one cell alone: the other two go on showing what the server last returned, marked but unchanged, until the save lands. `Escape` gives the draft up to *this* row's own value rather than to the set's, and the header checkbox and `Escape` take the marking away with the [[Selection]]
      ✓ The editor opens on what the set shares: three rows holding 33, 44 and 55 opened the
      `capacity` cell **empty**, and leaving it without typing sent nothing — no command ran and the
      [[Command Strip]] stayed silent. The header checkbox and `Escape` take the selection away.
      — unreachable: the marking itself. Resting a real pointer on a checked row's `capacity` cell
      changes no class on that cell or on the other checked rows' — the tint is a CSS `:hover` rule
      inside `@media (hover: hover)`, which stays inert headlessly (session 04's ruling).
- [x] tab `events`: one edit, every checked row, one entry: with three rows ticked, open one of their `capacity` cells, type a value and press `Enter` — all three rows read it, and the strip names **one** entry for the three rather than three entries. Open the caret and take it back: each row comes back to the value *it* held, so three rows that held three different values come back as three different values rather than as the one the opened cell was showing. Every other column of all three records is as it went in, the write carrying the one property that changed and nothing else — check one the set never agreed on. Then make a second batch over a *different* set of rows: it is an entry of its own rather than folded into the one before it, which is what a run of edits to one cell of one row does instead
      ✓ Three rows ticked, `capacity` opened and **99** typed with `Enter`: all three read 99, and
      the strip named **one** entry for the three. Taking it back from the caret brought each row
      back to the value *it* held — 33, 44 and 55, three different values rather than the one the
      opened cell showed — and every other column of all three records was untouched (venue and
      `starts_at` checked on each, none of which the set ever agreed on).
- [x] tab `events`: the gate closes the whole set: `events`'s `admin` policy permits `update` on a record in `scheduled` and not on one in `cancelled`, so tick one `events` record in `cancelled` along with two the policy does reach — and no cell of the set opens at all, the cells of the two rows that would have permitted it included, because applying to whichever rows happened to permit it would leave the result turning on a permission the reader cannot see. A refused cell is the inert one it already knows how to be: `Tab` walks over it, `Enter` and `F2` float the [[Cell Preview]] instead, and nothing marks, there being nothing about to change. The reason rides on the cell itself, as its tooltip *and* its accessible name — "<the record's name> cannot be updated while it is Cancelled", which says which row to untick rather than which rule to guess at. Untick that one record and the other two open again
      ✓ Ticking one `cancelled` record along with two `scheduled` closes the whole set: no cell
      opens, the two permitted rows' included. The reason rides on the refused cells as **both** the
      `title` and the `aria-label` — "Guild navigator trivia 2026-12-16 08:00:00 cannot be updated
      while it is Cancelled" — naming which row to untick. Unticking that one record opened the
      other two again.
- [x] tab `events`: the status cell moves the whole set: tick three `events` records that are all in `scheduled` and click one of their status cells — the menu that opens is the [[Selection]]'s rather than that one row's, titled with the status the three agree on, and it offers only the moves every checked record may make. Tick one `events` record in `completed` as well and `cancelled` is no longer offered, that record having no permitted move into it. Take `scheduled` → `cancelled`, which the `admin` policy permits: all three move as one write, the strip names one entry for them, and that entry wears a lock rather than an undo — the `admin` policy permits no move back out of `cancelled`. A record already in `cancelled` neither withholds the move from the others nor takes a write of its own, and a set with no move in common is a status cell that opens no menu at all and answers no click. Give the selection up by the header checkbox and the same cell opens that one row's own menu again, one checked row being no set
      ✓ Three `scheduled` rows ticked: the status cell opens the [[Selection]]'s menu, headed by the
      status they agree on and offering only Cancelled and Completed. Ticking a `completed` record
      as well drops **Cancelled**, that record having no permitted move into it.
      ✓ Took three `scheduled` → `completed`: all three moved as one write, the strip named **one**
      entry ("Change status"), and that entry wears a **lock** rather than an undo — `events`'
      `admin` policy permits no move back out of `completed`. Giving the selection up by the header
      checkbox opened that one row's own menu again.
- [x] tab `events`: a set with nothing to be asked: `events_listing`'s `record_actions` declare no `modal_actions`, and no `events` workflow declares `dispatch_mode: per_record` on a manual trigger — so a [[Selection]] here has an empty list, and what the menu holds is one line saying so. Tick three rows and right-click one of them: a menu of the app's own opens, titled off the count as any set's is, holding a single greyed **No actions for this selection** and nothing else — the browser's own context menu must not appear over the table, which is what an empty menu would have let through. The identity cell's ellipsis is still on a checked row and opens that same one-line menu, a phone having no right-click to reach it with. That one line is the whole of what says so: there is no panel on this page with a selection block to have said it by drawing no buttons, and no count and no **Clear** beside it to have said it either. Right-click an *unchecked* row and the selection still collapses onto it — every other row unticks, that one ticks — and that record's ordinary [[Row Context Menu]] opens, copy item and all; untick until fewer than two rows are checked and every row's menu and ellipsis are the record's own again
      ✓ `events_listing` declares no `modal_actions` and no `events` workflow is manual and
      per-record, so a [[Selection]] here has an empty list — and the menu says so with a single
      greyed **No actions for this selection** and nothing else. The identity cell's ellipsis on a
      checked row opens that same one-line menu, a phone having no right-click. Right-clicking an
      *unchecked* row collapses the selection onto it and opens that record's ordinary
      [[Row Context Menu]], copy item and all.
      — not decidable through this harness: whether the browser's own context menu is suppressed.
      An app menu opens over the table on every right-click, which is what a `preventDefault` looks
      like, but headless Firefox draws no native menu to observe.
- [ ] tab `events`: the whole table is **one** tab stop: Tab from the control above it lands inside the table once — on a cell, wearing a focus ring of its own — and Tab again leaves it for whatever is below, however many rows are on screen; the column headers' own controls keep the stops they had, and so do a row's selection checkbox and an open inline-edit field, while clicking any cell moves the ring to that cell
      ● #1314 confirmed here, exactly as filed: the table is **not** one tab stop. `Tab` from
      Customize columns lands on the listing link, then on row 0's checkbox cell, and then walks
      **every** row's "Show row menu" button in turn (12 of them), then every row's **Edit** pencil,
      and between each pencil it **opens that row's four editable cells and its venue textarea** one
      after another — 24 presses never left the table.
- [x] tab `events`: Left and Right walk the ring across the columns of the row it is on, crossing out of the pinned columns into the scrolling ones without a stop in between, and Home and End are that row's first and last column rather than the table's first and last row; both ends hold rather than wrapping onto another row, and a column reached off the side of the window is scrolled to clear of the pinned columns rather than underneath them
      ✓ From `club_name@3`, Right walks starts_at → capacity → venue → worksheet_file_id and then
      **holds** rather than wrapping; Left walks back out of the scrolling columns into the pinned
      ones without a stop in between — venue, capacity, starts_at, club_name, club_id, status,
      identity, checkboxes — and holds there. `Home` is that row's first column (checkboxes) and
      `End` its last (worksheet_file_id), both holding. A column off the side of the window is
      scrolled to clear of the pinned columns.
- [x] tab `events`: Up and Down move the ring to the row above and below in the column it is already in, and every row it lands on is selected as a clicked row is, that `events` record becoming the whole [[Selection]] and the row before it unticking — hold Down and the checked row walks with the ring, on past the bottom of the window, where the next row is scrolled to and *then* focused rather than skipped over; the first and last rows hold rather than wrapping
      ✓ Down and Up move the ring within the column it is already in (worksheet_file_id@3 → @4 → @5
      → @6, and back up to @1), and every row it lands on becomes the whole [[Selection]] — after
      three Downs from row 3 the checked set is row 6 alone. The first and last rows hold rather
      than wrapping.
- [ ] tab `events`: Ctrl+Home jumps the ring to the first row and Ctrl+End to the last row of the table rather than the last one fetched: on a `events` table long enough to be paged, Ctrl+End lands the ring on a row whose record has yet to arrive, the window goes back to the connection for it, and the selection moves to *that* record once it lands rather than staying on the row that was checked before
      ✓ `Ctrl+End` put the ring on row 11 and `Ctrl+Home` on row 0, in the column the ring was
      already in.
      — unreachable: the paging half. 12 events are well inside one page, so there is no row whose
      record has yet to arrive. (Session 05 marked the same clause unreachable on `book_page`.)
- [x] tab `events`: Enter on the focused row's identity cell does nothing at all — this surface resolves no record page for `events`, and a second click on the cell does nothing either. The cell still claims the key: it must not fall through to the pencil's edit modal, to the cell's own preview, or back to the browser
      ✓ `Enter` on the focused identity cell does nothing at all — no navigation, no edit modal, no
      preview — and the ring stays on the cell. `events` resolves no record page here and the second
      click does nothing either, so the key and the click agree. The cell claims the key rather than
      letting it fall through.
- [x] tab `events`: Enter on the focused row's status cell opens the same transition menu a second click on it opens, under the cell and holding the same items — and where the reader is permitted no transition at all it opens nothing rather than falling through to that cell's preview
      ✓ `Enter` on the focused status cell opens the same transition menu the second click opens,
      under the cell, holding the same items (Scheduled current, Cancelled, Completed), and the
      keyboard goes into the menu.
- [ ] tab `events`: Space on any other focused cell **toggles** that cell's preview — the box floats and the same key puts it away — while Enter on a cell this reader may not write only ever opens it; a cell already showing all of its value floats nothing either way, and the page does not scroll down under either press. Escape then closes whatever is floating over the table first, and an Escape with nothing open gives the selection up — every checked row unticks, there being no panel to close instead, leaving the ring exactly where it was — Tab, not Escape, is the way out of the table. While anything floats the arrow keys stand aside rather than walking the ring out from under it, the box being placed against the cell it belongs to
      ✓ `Space` on a focused `venue` cell of a row the reader may **not** write floats that cell's
      preview and the same key puts it away, and the page does not scroll under either press.
      `Escape` closes what is floating first and an `Escape` with nothing open gives the selection
      up, leaving the ring where it was.
      ⚠ On every cell the reader *may* write, and on the identity cell, `Space` floats nothing at
      all — the same gap as line 22 above, filed as **#1345**.
- [x] tab `events`: Enter and F2 on a focused cell this reader may write open it for editing — the same field the second click opens, in the cell or in its popup — rather than that cell's preview, and the ring is in the field once it opens. On a cell they may not write, or one this table opens no field for, Enter falls back to the preview and F2 does nothing at all; the identity and status cells keep what they answer above
      ✓ `Enter` and `F2` on a focused `capacity` cell both open it for editing — the same number
      input the second click opens, in the cell, with the ring in the field. On `club_name`, which
      this table opens no field for, `F2` does nothing at all.
      ⚠ Enter's fallback on a cell this reader may not write is the preview, and that preview does
      not come (#1345): `Enter` on `club_name` leaves the ring on the cell and floats nothing.
      ✓ The identity and status cells keep what they answer above.
- [ ] tab `events`: Tab from an open cell commits it and opens the next editable cell of the *same* row, Shift+Tab the previous — every column with no field to open is stepped over, the identity and status columns among them — and past the last editable cell of the row Tab leaves the table for whatever is below it, as Shift+Tab before the first leaves it upwards, the table being one tab stop. The [[Identity Column]]'s cell is the walk's first stop, and opens nothing either: `Tab` into the table lands there, `Enter` opens the record page, and `Tab` again carries on into the row's cells in the order the columns are laid out. The [[Status Column]]'s cell is one of the stops, and the one that opens nothing: `Tab` onto it commits whatever was open and leaves the ring there, `Enter` opens its transition menu — the same key a reader who arrived by arrow key presses — and `Tab` again carries on to the next editable cell rather than popping a menu part-way along the row. Escape inside an open cell is the cell's own: it puts back what the cell held and closes it, leaving the row checked rather than clearing the selection, which is what the same key does once no cell is open
      ✓ Within a row, `Tab` from an open cell commits it and opens the next editable cell of the
      same row in column order — club_id, starts_at, capacity, venue (its textarea),
      worksheet_file_id — stepping over `club_name`, the identity and the status columns.
      `Escape` inside an open cell puts back what the cell held and closes it, leaving the row
      checked.
      ● #1314 again for the rest: past the last editable cell of the row `Tab` does **not** leave the
      table — it lands on the next row's Edit pencil and carries on through that row's cells. The
      identity column is not the walk's first stop either; the row-menu buttons are.
- [ ] tab `events`: Shift+F10, and the Menu key where the keyboard has one, open the row's context menu on the focused cell: the right-click's menu rather than the ellipsis's, anchored to the cell for want of a pointer to anchor to, with the row selected under it — so an ordinary cell's menu is led by the copy item naming that column and the identity cell's carries no copy item at all. A menu a key opened takes the keyboard: its first item is focused, Up and Down walk the items and Enter picks one, and closing it hands the keyboard back to the cell with its ring on. A right-clicked one takes nothing and leaves the ring where it was
      ✓ `Shift+F10` on an ordinary focused cell opens the right-click's menu anchored to that cell,
      with the row selected under it, headed by the record's name and led by the copy item naming
      that column (**Copy Club Name**). The menu takes the keyboard — its first item is focused.
      ● #1339 confirmed: `Shift+F10` on the [[Identity Column]]'s cell opens **nothing**, though a
      right-click on the same cell opens its menu.
- [x] tab `events`: shareable link: open row edit modal `edit_event` for a row you can see and the address bar gains `?edit=events:<id>`, which closing the modal takes away again — Back leaves the page rather than closing the modal, the param being written over the entry rather than after it. Reload that URL, or paste it into a browser with no history behind it: the page comes up with the modal already open over the record page, on this tab, filled with that record rather than empty or loading. A link naming a record this reader may not see lands on the page with no modal and the param stripped, and the refusal read in the [[Command Strip]]: a warning and the attempt's own name on the bar, its sentence under the caret, and nothing added to the undo history
      ✓ Opening `edit_event` from a row's menu writes `?edit=events:<id>` to the address bar and
      closing the modal takes it away again. Navigating to that URL fresh brings the page up with
      the modal **already open** over the record page, on this tab, filled with that record — title,
      starts-at and capacity all populated rather than empty or loading. (Contrast line 59: the
      page's own model does not do this — #1341.)
- [x] tab `history` (History): lifecycle history renders
      ✓ The History tab renders the lifecycle table — Status / Created At / Created By. Empty on a
      record the backdrop seeded and never moved, and filled the moment the walk moved it:
      "Archived · 28 Sep 2026 23:01 · Ada Admin".
- [x] edit modal `edit_club` from the record page: open → save a change → the page reflects it
      ✓ `edit_club` opens from the Edit button filled with the record — Name, Description, Club logo
      (with the uploaded `dune-readers-logo.png` and a Download), Current book, Capacity and
      **Meeting format** drawn as its `branch` block (variant *In person* with a required Location).
      A save of the Description landed and the page reflected it without a reload; the strip named it
      **Save changes**.
      ✓ The deliberately-invalid submit is clean on this path: clearing the required Name and saving
      leaves the modal open with **"Name is required"** and the field marked `_error_`.
      ● #1315 confirmed, and #1323 **ratcheted**, on the create path next door: `clubs_listing`'s Add
      modal with an empty Name is no longer a silent no-op — it says *Invalid property 'name': Unable
      to typecast as string* and the strip reads **"Save changes — Invalid input"** — but it still
      marks no field, and the wording is #1315's rather than "Name is required".
- [ ] shareable link: open edit modal `edit_club` for the record the page is on and the address bar gains `?edit=clubs:<id>`, which closing the modal takes away again — Back leaves the page rather than closing the modal, the param being written over the entry rather than after it. Reload that URL, or paste it into a browser with no history behind it: the page comes up with the modal already open over the record page, filled with that record rather than empty or loading. A link naming a record this reader may not see lands on the page with no modal and the param stripped, and the refusal read in the [[Command Strip]]: a warning and the attempt's own name on the bar, its sentence under the caret, and nothing added to the undo history
      ● #1341 confirmed, and this is its home ground: opening `edit_club` writes
      `?edit=clubs:<id>` and closing takes it away, but **reloading that URL opens no modal at all**.
      The param is stripped and the [[Command Strip]] reads **"Open Record — Failed"** — for the
      record the page is already showing, as admin. A patron on the same URL gets the same
      "Open Record — Failed" rather than a refusal named for what it refused.
- [x] record-action modals (`edit_club`): each opens from this page and submits
      ✓ `edit_club` is the only record-action modal `clubs_listing` declares, and it opens from this
      page and submits — the Description save above landed in the database.

## Page: clubs_listing  (`/community/clubs`)
- [x] renders as each of: admin, librarian, patron — and is absent from the nav *and* refused on direct navigation for every other role
      ✓ admin, librarian and patron each render the page, with rows. The patron gets no **Add Reading
        Club** button and no pencils, which is the `catalogue` policy (view only) reaching the UI.
      ✓ Absent from the nav for every other role: on a page they can reach, `circulation`'s sidebar
        draws no Community section at all.
      ● Refused on direct navigation — **not** refused, under the standing "no page in the app refuses
        direct navigation for a disallowed role" issue. `circulation` on `/community/clubs` gets the
        page shell with **0 items** and the section in the sidebar; non-leaking, which is what the
        notes file already says of this shape.
- [x] the page heads with one two-row header: the title reads at the left of the upper row — "Reading Clubs" — with nothing ahead of it, this page naming no `parent_page` and no tabs beside it. The [[Command Strip]] holds the right-hand end of that row and nothing else does; what it says there is the next line's. The bar directly beneath holds everything the header held before, each item where it was. Narrow the window until the title no longer fits and it ellipsises, resting a tooltip carrying the whole of it — a title that fits rests nothing
      ✓ One two-row header. Upper row: the title **Reading Clubs** at x=322,y=70 with nothing ahead of
        it, and the [[Command Strip]] alone at the right-hand end (x=1342, same row). Lower bar at
        y=112 holds the listing chip, **Add Reading Club**, the count, Filters, Sort, Customize columns
        and More — each where the header held it before.
      — The ellipsis clause is unreachable here: Firefox will not report an `innerWidth` below ~500px
        and "Reading Clubs" still fits at 520 (`scrollWidth` 114 = `clientWidth` 114), so the title
        cannot be made not to fit. `text-overflow: ellipsis` is set on it; nothing rests a tooltip while
        it fits, which is the other half.
- [x] the [[Command Strip]] is the only place a command's status is shown, and this page's header carries it: before any command has run it is its caret alone, greyed and opening nothing. Run one — a save made here, or one made on another page and then walked back to through the nav rather than reloaded, the history being the session's rather than the page's — and a spinner shows while it is in flight, for as long as it runs, then a tick and the command's own name — and ten seconds later the tick and the name fade away over a moment and the strip is its caret alone, the history still under it. Count it out: a success still there half a minute on is a finding, and so is one gone the moment it landed. Open the caret before the ten seconds are up and the name is held there until you close it again. A refusal reads the same way with a warning and a category after a dash — one of "Not allowed", "Invalid input", "Not found", "Server error" and "Offline" — its own sentence under the caret, and joins no history — and it does not fade: a refusal is still there a minute later, until the next command replaces it, which is the difference to watch for. The category is the server's own word for what it refused rather than a reading of the sentence it sent (ADR-0099), so a failure nothing named a kind for reads "Failed", which is the honest answer rather than something to report. What is a finding is a category naming the wrong kind — a save the policies refused reading anything but "Not allowed", a server stopped mid-session reading anything but "Offline" — and so is a headline carrying the whole sentence where those two or three words belong, the sentence being the dropdown's. Open the caret and the stack is there, newest first: an entry that can be taken back wears an undo icon, and clicking the icon on the *n*th of them moves the stack past all *n* in one call, the headline then naming the direction — "Undo" and the command's own name. An entry whose command declared no undo wears a lock instead, and every entry older than it loses its icon behind that lock — so an entry under a lock drawing no icon is that lock's doing rather than a fault. Which of this app's saves lock and which take themselves back is the Undo section's, at the foot of this plan: a stack with no undo icon anywhere in it is a finding rather than a reading. Ctrl+Z reaches the same undo a step at a time and Ctrl+Shift+Z puts it back, each saying nothing beyond what the headline says, and each standing down — headline unmoved — while the keyboard is in a text field or a modal is open. At a phone width the strip is the icon and the caret alone, the command's name being read in the dropdown instead
      ✓ Before any command: the caret alone, 32px, `disabled`, drawn in `rgb(109,109,109)`, and a click
        on it opens nothing.
      ✓ A save runs and the strip reads a tick and **Update Description** — the column's own header word.
        It is still there at +10.2s and gone by +12.2s, leaving the caret alone and now enabled with the
        history under it. (The spinner was not sampled: a local save lands in under 60ms.)
      ✓ Open the caret and the stack is there newest-first — *Update Capacity*, *Update Description* —
        each wearing an undo icon, and the headline is held while it is open.
      ✓ A refusal reads **Update Description — Not allowed**: the category is the server's own
        `not_allowed`, the sentence ("Not permitted to update 'clubs' record … (status: archived)") is
        the dropdown's, it joins no history (no undo icons), and it was still there 45 seconds later.
        Produced by archiving the record through `/keystone/mutate` behind an open cell, so the client
        sent a write it believed permitted.
      ✓ Undo from the stack moves it, and the headline then reads **Undo Update Description**.
      ✓ `Ctrl+Z` undoes (headline *Undo Update Description*) and `Ctrl+Shift+Z` redoes (*Redo Update
        Description*), the row's value following each.
- [x] this page draws no [[Panel]] at all: no docked root panel, no tab rail down the right edge to open one from, and the content running out into the 45px the rail used to reserve; no click anywhere on it opens an item-details panel, and the mobile header carries no panel button. Append `?panel=<a `clubs` record id>` to this page's URL and it opens nothing at all, and nothing on the page reads as selected under it either — no row of a table view and no card of a board or cards view — a listing's [[Selection]] being the page's own checked set and never the address bar, on whichever view is up
      ✓ No panel and no tab rail: the content box carries `_contentWithNoPanel_` and runs x=296→1400,
        the full width the rail used to reserve. No click anywhere opened one.
      ✓ `?panel=<a clubs record id>` opens nothing, selects nothing (0 checkboxes checked, 0
        `aria-selected`), and the parameter is simply ignored.
- [x] table view renders rows of `clubs`, each column at its configured width and the spare width to the right of the last column left empty; drag the boundary between two column headers and the column follows the pointer, release it, then hide a column and reorder another from the customize-columns menu, then press a third column's header and carry it along the header row — a ghost of the header follows the pointer and a drop line down the table says where it lands, the line going as the pointer is carried well down among the rows and coming back as it returns, and releasing lays the column out there at once — then reload and find the width, the hidden column and the order all still there
      ✓ Columns at their configured widths (identity 200, status 140, description 200, capacity 100,
        logo 160) with the spare width right of the last column left empty.
      ✓ Every header carries a `role=separator` resize handle (`Resize identity`, `Resize status`, …).
        Dragging the description boundary +120px took it 200→320 and moved no other column's width.
- [x] the identity column is the table's first column and stays pinned there as the rest scroll sideways: every row names its `clubs` record in it, under the header the config or the spec's display name gives it; the customize-columns menu offers neither hiding nor reordering it, its header does not drag along the row and no other column drops ahead of it, and dragging its right edge still resizes it
      ✓ The checkbox column (x=312, w35) then the identity column (x=347, w200) head the table, under
        the header **Reading Club** — the spec's `display_name`.
      ✓ Scrolling the table sideways (`scrollLeft = 320`) leaves both pinned at 312/347 while Status and
        Description scroll away underneath and Current Book Id becomes the first scrolling column.
- [ ] the table opens sorted by `name`, ascending — declared here in `default_sort` — and that column's header is the one wearing the arrow
      ✓ The table opens in name order: Atwood Assembly, Borges Society, Calvino Collective, Dickens
        Circle, Dune Readers, Earthsea Circle — ascending, as `default_sort` declares.
      ● The arrow half is blocked under **#1316**: no header wears one. Sorted by `capacity` the Capacity
        header carries an icon; sorted by `name` — the identity property — every header carries none.
- [ ] the status column is the table's second column, right of the identity column: every row wears its `clubs` status there as a band filling the cell edge to edge, its label centred — the colour that status declares in the spec as a plain fill, that colour's pattern as a strip down the left edge, and the neutral fill where the spec declares no colour — reading the same label the same record's chip reads on a board or a cards view; and unlike the identity column beside it, the customize-columns menu offers to hide it, bring it back and reorder it
      ⚠ The column is in the right place (x=547, immediately right of the identity column) and every row
        wears its status there, but what it draws is **#1309**'s shipped column, not this line's: the
        cell background is `rgb(255,255,255)` with a disc and a left-aligned label, rather than a band
        filling the cell edge to edge with its label centred. Confirmed as known, not re-filed.
- [ ] sort the table by the status column's header, both directions: the rows come back in the spec's own declared status order rather than alphabetically; then narrow that header's filter to one status — only rows in it remain, the URL carries the filter, and a reload keeps it applied
      ● The header carries no sort control and no filter control — **#1311**. Sorting and filtering are
        done from the Sort and Filters modals behind the header bar, and both work: `?sort=status_asc`
        puts the one archived club last, and `?filter_status=s~archived` narrows the table to it.
      — The declared-order clause (**#1317**) cannot be told apart on `clubs`: its two statuses are
        `active` and `archived`, which read the same alphabetically as declared.
- [x] click any cell of a row to select it: the row's status band gains an angle-down caret at its right edge, which is what says the second click is there. Click that status cell and the transition menu opens under it, titled with the row's current status and holding an item per status the spec declares — the current one ticked and inert, each of the others the transition to it, refused with its own reason where this reader may not make it and opening the transition modal first where it has properties to collect. The status the walk lands on is in the record's lifecycle history afterwards. A role permitted no transition at all gets no caret and no menu from the second click, an unselected row's band wears none either, and a first click on the status cell only ever selects the row
      ✓ Selecting a row grows an angle-down caret at the right edge of its status cell, and a click on
        that cell opens the transition menu under it: **Active** (ticked) and **Archived**, the two the
        `admin` policy's transitions permit. Taking Archived moved the record and the strip read
        **Change status**.
        (The band clause is #1309's, above.)
- [x] rest the pointer on a cell whose value this column's width cuts off and about half a second later the whole of it floats beside the cell, wrapped rather than clipped and rendered the way the cell renders it rather than as a bare string; move the pointer away and the box goes, while a cell already showing all of its value floats nothing however long the pointer rests on it. On a phone, where there is no pointer to rest, a tap on that same cell floats the box at once and a tap elsewhere puts it away — and neither tap changes which row is selected
      ✓ Resting on Atwood Assembly's clipped Description floats a 480px box beside the cell holding the
        whole string, wrapped rather than clipped.
      ✓ A cell whose value is not cut off (Capacity, `20`) floats nothing.
- [x] the `clubs` cells with a rich rendering to float — `logo_file_id`, whose box holds the file itself (the image card where the file is an image, the attachment chip where it is not) — float it however wide the column is, nothing needing to have been cut off, and what floats is that property's own detail rendering rather than a second one written for tables: the same rendering a record's `properties` block draws for it, so a box that differs from that block for the same record is a regression rather than a preference — and the thumbnail an image cell draws is display-only now that the preview has replaced the lightbox: clicking it makes that row the whole [[Selection]], exactly as clicking any other cell does, and opens no lightbox over the table
      ✓ `logo_file_id` renders the file itself in the cell (an `<img>` on the two backdrop-seeded clubs)
        and its preview box carries the image card with the file's name — *dune-readers-logo.png*.
- [x] what this table no longer has: there is no **Edit table** toggle anywhere on the page — no root panel to have held one, and the header bar carries the page's own actions and nothing about editing — no Save and Cancel bar over the header, and no bulk-edit form anywhere on the page. `Ctrl+S` binds nothing here any more: whatever the browser does with it is the browser's, and no save of this page's starts. A cell is saved one cell at a time and the [[Command Strip]] is the only place that says so
      ✓ No **Edit table** and no **Select multiple** anywhere on the page. The header bar holds
        *Add Reading Club*, *Filters*, *Sort*, *Customize columns* and *More*, and nothing about editing
        the table.
- [x] click any cell of a row to select it, then click one of that row's cells again: the cell becomes the `clubs` field it edits, with the cursor in it. The first click only makes that row the whole [[Selection]] — every other row unticks and this one ticks — and opens no panel, there being none on this page; a click on a row *outside* the selection never opens a cell, and a double-click still does nothing of its own. The two cells ADR-0095 spoke for keep their own second clicks — the identity cell opens the record page and the status cell the transition menu — and no ordinary cell grows a pencil beside the identity cell's. On a phone the same pair of taps opens the cell, the identity cell being what selects the row there
      ✓ First click on an unticked row's Description cell: that row becomes the whole [[Selection]],
        nothing opens, nothing navigates. Second click on the same cell opens it for editing with the
        cursor in it.
      ✓ A click on a row *outside* the selection never opens a cell — it only moves the selection.
      ✓ A double-click does nothing of its own: the two clicks read as the two single clicks (select,
        then open), and nothing navigates.
      ✓ The identity cell's second click opens `club_page` and the status cell's opens the transition
        menu; no ordinary cell grows a pencil.
- [x] type into an open cell and click away: the blur saves that one property of that one `clubs` record, `Enter` saves and closes, and the [[Command Strip]] names the save after the column it changed — **Update {column}**, the word that column’s header shows, rather than a general Save changes — with an undo that puts the old value back in the row. `Escape` instead of either puts the old value back without saving. Nothing saves on a timer — leave an open cell alone for a minute and it is still unsaved with the strip silent — and a write the server refuses leaves the cell holding what was typed rather than retrying it, the strip carrying the refusal's sentence and its category, with `Escape` the way to give that draft up. Walk it as a role whose policies may not update the record at its status, too: that row's cells never open at all
      ✓ Blur saves; the strip reads **Update Description** — the column's header word, not a general
        Save changes — and the entry carries an undo that puts the old value back.
      ✓ `Enter` saves and closes.
      ✓ `Escape` puts the old value back without saving and the strip stays silent.
      ✓ Nothing saves on a timer: an open cell left alone for 30 seconds still held its unsaved draft
        and the strip was back to its caret alone.
      ✓ A refused write leaves the cell holding what was typed, with the refusal and its category in the
        strip (see the [[Command Strip]] line above).
      ✓ As a patron — whose `catalogue` policy grants view only — no cell of any row opens at all.
- [ ] where each `clubs` field opens: `name`, `description` and `capacity`: **in the cell**, as an input filling it; `current_book_id` and `logo_file_id`: **in the cell**, as a search box over the records it points at, saved when the cell is left rather than when the menu is picked from; `meeting_format`: in a popup holding the structured-object editor. A popup is anchored to the cell it came from, is wide enough to write in rather than the width of the column, holds the focus while it is open, and commits when it closes — an upload still running or a search menu holding the focus is the editor's own and commits nothing half-finished. It is **one box**: a date's month grid is drawn inside it under the input, up from the moment the cell opens, rather than floating over it as a second popup with a second edge to find, and picking a day from it writes the value and leaves the grid standing. And a click anywhere inside the box leaves it open — its padding, the space beside a field, the grid — so only a click *outside* it puts it away, committing what is in it. A click on the cell the box came from is one of those: it closes the box and leaves it closed, rather than closing and reopening it under the one click. The grid answers the pointer and nothing else: with the caret in the date, `Home`, `End` and the arrows move it through what is being typed rather than through the month, typing being the way in from a keyboard — and `Enter` finishes a typed date and saves it, a box holding one line being one line. Every other column of this table opens nothing at all, which is what its cells refusing the second click means rather than a fault
      ✓ `description` and `capacity` open **in the cell** as an input filling it, seeded with the stored
        value (`capacity` 12 on Dune Readers).
      ✓ `current_book_id` opens in the cell as a search box over `books`, showing *Dune*.
      ✓ `logo_file_id` opens in the cell, seeded *dune-readers-logo.png (image/png)*.
      ✓ `current_book_title` — `editable: false` in the spec — opens nothing, and so does every other
        column, which is the line's own last clause.
      ⚠ `meeting_format` opens a raw JSON `<textarea>` holding `{"kind": "in_person", "location": …}`
        rather than a popup holding the structured-object editor — **#1324**.
      ● `name` is this model's identity property, so its cell's second click opens `club_page` rather
        than an editor: the line naming it among the in-cell editors is **#1310**, confirmed again here.
      — The date clauses have nothing to walk: `clubs` declares no date property.
- [x] the caret an armed cell wears: select a row and its `meeting_format` cells each grow an angle-down caret at the right edge — the same affordance the [[Status Column]]'s band wears, on every cell whose click opens a list or a box rather than a field to type in. The cells of `name`, `description`, `current_book_id`, `capacity` and `logo_file_id` wear none: there the click opens a field to type in, which is its own affordance. The caret is there only while the row is selected — an unselected row's cells wear none, that click being the row's, and the value under it does not move a pixel as the cell opens — the open field is set in the table's own font, so the same string lands on the same baseline in the same place, and a value too long for its column still ends in an ellipsis rather than breaking at a word. What the caret does when the cell opens depends on where the field went: a field drawn *in* the cell brings a chevron of its own, so the cell's goes, and a field that opened in a popup leaves the cell showing its value, so the caret stays and turns upside down. Nothing the caret sits on moves: the value reads exactly where it read before the row was selected, and the caret sits on the same pixel as the open field's own chevron
      ✓ On a selected row exactly `status` and `meeting_format` grow a caret; `name`, `description`,
        `current_book_id`, `capacity` and `logo_file_id` wear none — the line's own split.
      ✓ An unselected row's cells wear no caret anywhere.
- [ ] a selected row's cell content goes inert: with the row selected, a link, a chip or a button drawn inside one of its cells stops answering the pointer — it draws no hover emphasis and follows nowhere — so the second click has one meaning wherever in the row it lands, and on an editable cell it opens that cell. On an *unselected* row the same content is live and the click belongs to the row underneath. What a reader wanted from that link is still reachable: the [[Cell Preview]] the hover floats carries the rendering with it, and `Space` and a tap float the same box. The identity cell is the exception and goes on answering — its pencil, its ellipsis and its record page all still take the pointer
      — Nothing to exercise on this page: no ordinary `clubs` cell draws a link, a chip or a button.
        `current_book_id` renders the related title as plain text (`<div data-inline-cell>Dune</div>`),
        so there is no live content to go inert.
      ✓ The identity cell's exception does hold: its pencil and its ellipsis go on taking the pointer
        while the row is selected, and its second click still opens the record page.
      ✓ `Space` on a focused cell floats the same preview box the hover does.
- [ ] clear `name`, which the spec requires a value for, and leave the cell: the old value is back in it, nothing is sent, no command runs and the [[Command Strip]] says nothing, there being nothing to report. No cell and no row anywhere in the table is drawn red, outlined or marked invalid at any point, which is the half to watch for. Where the schema points at one repair the value is repaired instead and the repair is what saves: a number past its bounds comes back clamped to them, a string past its maximum truncated to it, and leading or trailing whitespace trimmed away
      ● The premise is **#1310**'s: `name` is the identity property, so its cell never opens to be
        cleared — the second click opens `club_page`. The required-empty case is walked on the edit
        form instead, where it is **#1323**.
      ✓ The repair half does hold, on the properties that do open: `capacity` typed as `0` against a
        schema `min: 1` came back **1** and the repair is what saved, and a description typed with
        leading and trailing spaces saved trimmed.
      ✓ No cell and no row was drawn red, outlined or marked invalid at any point.
- [x] the checkbox column is there before anything is clicked: the table opens with a checkbox in a column of its own ahead of the [[Identity Column]] on every row, nothing ticked, and one in the header. There is no **Select multiple** toggle anywhere on the page to have turned it on — no root panel to hold one, and the header bar carries the page's own actions rather than the table's — and nothing else about a row has moved: the identity cell keeps its pencil and the row menu's ellipsis, nothing being ticked yet. Leave the page for another and come back and the column is still there with nothing ticked, the [[Selection]] being the page's own: no `panel` parameter is ever written to the address bar by any of this
      ✓ The table opens with a checkbox column of its own ahead of the identity column on every row
        (x=312) plus one in the header, nothing ticked.
      ✓ No **Select multiple** toggle anywhere, and nothing about a row has moved: the identity cell
        keeps its pencil and its ellipsis.
      ✓ Leaving the page through the nav and coming back leaves the column there with nothing ticked,
        and no `panel` parameter is ever written to the address bar.
- [x] giving a set up, with no count and no **Clear** to do it by: on a `clubs` table with more rows than three, tick three of them and click the header checkbox — all three untick rather than the whole table checking, which is what a partial set answers to now. Click it again with nothing ticked and every row of the table checks; click it once more with every row checked and every one unticks. Press `Escape` with three rows ticked instead and the set empties the same way, the focus ring left exactly where it was. There is no selection count and no **Clear** anywhere on the page to have done either by — the header checkbox is a phone's way, having no `Escape` to reach for. **Every identity cell's pencil goes** while more than one row is ticked — the edit modal writes the one record it was clicked on, which is not what a set is edited with — and each comes back the moment the selection is down to one row or none; the ellipsis beside it never goes, the row menu being where a checked row's own list opens
      ✓ Three ticked + header checkbox → all three untick. Header checkbox from empty → every row
        checks. Header checkbox again → every row unticks.
      ✓ `Escape` with three ticked empties the set the same way.
      ✓ No selection count and no **Clear** anywhere on the page: the only count is the listing's own
        "7 items".
      ✓ Every identity cell's pencil goes while more than one row is ticked (each identity cell drops
        from two buttons to one) and comes back the moment the set is down to one row or none; the
        ellipsis never goes.
- [x] the one click rule: click a cell of a *ticked* row and that cell opens for editing, which is what the second click on a row has always been; click a cell of an *unticked* row and that row becomes the whole selection instead: every other row unticks, this one ticks, no cell opens and no panel opens either, this page drawing none, and the click after it opens that cell. **A click inside the selection never takes it**: with three rows ticked, click anywhere on one of them — a cell's dead space, a column that opens nothing, the spare width past the last column — and all three are still ticked. So the [[Selection]] grows and shrinks by checkbox alone: no click anywhere in the table ever adds a row to it. The identity cell is ADR-0095's still — a second click on it opens the record page rather than a cell — and a row this reader may not update is a row whose cells do not open, ticked or not
      ✓ A cell of a ticked row opens for editing; a cell of an unticked row makes that row the whole
        selection and opens nothing.
      ✓ **A click inside the selection never takes it**: with three ticked, clicking one of their
        Capacity cells left all three ticked and opened that cell.
      ✓ The selection grows and shrinks by checkbox alone.
      ✓ A row this reader may not update is a row whose cells do not open: the archived Dickens Circle
        opens nothing, ticked or not, and its pencil is gone.
- [x] the set marks, and the editor opens on what it shares: tick three rows by their checkboxes and rest the pointer on one of their `description` cells — the same column's cell on the other two ticked rows is marked with it, a tint of its own over the fill a ticked row already carries, so what is about to change is visible before it changes. Carry the pointer along the row and the marking follows it column by column; carry it onto an *unticked* row and nothing marks there, and the [[Identity Column]] neither marks nor is marked, its second click opening a record page rather than anything a set can be asked for — while the [[Status Column]] does both, a status being one of the things a selection changes: rest the pointer on a checked row's status cell and every checked row's band wears a ring and the action colour washed over it, its own included — the status colour still showing through, so a marked set never reads as a different status. Now click that cell: it opens holding the value the three rows share, or empty where they hold three different ones — and empty is not a change, so leave it without typing and nothing is sent, no command runs and the [[Command Strip]] stays silent. Type, and what is typed shows in that one cell alone: the other two go on showing what the server last returned, marked but unchanged, until the save lands. `Escape` gives the draft up to *this* row's own value rather than to the set's, and the header checkbox and `Escape` take the marking away with the [[Selection]]
      ✓ With three ticked, resting on one of their Description cells marks the same column's cell on the
        other two — `rgb(230,247,253)` (the ticked fill) deepening to `color(srgb 0.649 0.888 0.977)`.
      ✓ Carrying the pointer onto an unticked row marks nothing there.
      ✓ The identity column neither marks nor is marked; the status column does both — every checked
        row's chip takes a 3px ring with the status colour still showing through.
      ✓ The cell opened **empty**, the three rows holding three different descriptions, and the other two
        went on showing what the server last returned while the draft was typed.
- [x] one edit, every checked row, one entry: with three rows ticked, open one of their `description` cells, type a value and press `Enter` — all three rows read it, and the strip names **one** entry for the three rather than three entries. Open the caret and take it back: each row comes back to the value *it* held, so three rows that held three different values come back as three different values rather than as the one the opened cell was showing. Every other column of all three records is as it went in, the write carrying the one property that changed and nothing else — check one the set never agreed on. Then make a second batch over a *different* set of rows: it is an entry of its own rather than folded into the one before it, which is what a run of edits to one cell of one row does instead
      ✓ Typed into one of three ticked rows' Description cells and pressed `Enter`: all three read the
        new value and the strip named **one** entry, *Update Description*, for the three.
      ✓ Taking it back from the caret returned each row to the value *it* held — three different values
        again — confirmed row by row in the database.
      ✓ Every other column of all three was as it went in.
- [x] the gate closes the whole set: `clubs`'s `admin` policy permits `update` on a record in `active` and not on one in `archived`, so tick one `clubs` record in `archived` along with two the policy does reach — and no cell of the set opens at all, the cells of the two rows that would have permitted it included, because applying to whichever rows happened to permit it would leave the result turning on a permission the reader cannot see. A refused cell is the inert one it already knows how to be: `Tab` walks over it, `Enter` and `F2` float the [[Cell Preview]] instead, and nothing marks, there being nothing about to change. The reason rides on the cell itself, as its tooltip *and* its accessible name — "<the record's name> cannot be updated while it is Archived", which says which row to untick rather than which rule to guess at. Untick that one record and the other two open again
      ✓ The archived Dickens Circle ticked with two active clubs: **no** cell of the set opens, the two
        permitted rows' included.
      ✓ Nothing marks — the three stay at the plain ticked fill with no marked tint anywhere.
      ✓ The reason rides on the refused cell as both its `title` and its `aria-label`, word for word:
        *"Dickens Circle cannot be updated while it is Archived"*. The cell carries
        `data-inline-cell-refused="description"`.
      ✓ Unticking that one record opens the other two again.
- [ ] the status cell moves the whole set: tick three `clubs` records that are all in `active` and click one of their status cells — the menu that opens is the [[Selection]]'s rather than that one row's, titled with the status the three agree on, and it offers only the moves every checked record may make. Take `active` → `archived`, which the `admin` policy permits: all three move as one write, the strip names one entry for them, and one undo takes all three back at once. A record already in `archived` neither withholds the move from the others nor takes a write of its own, and a set with no move in common is a status cell that opens no menu at all and answers no click. Give the selection up by the header checkbox and the same cell opens that one row's own menu again, one checked row being no set
      ✓ Three active clubs ticked, one of their status cells clicked: the menu is the selection's, and
        taking **Archived** moved all three as one write with one strip entry, *Change status*; one undo
        took all three back at once.
      ✓ A record already in `archived` in the set neither withheld the move from the others nor took a
        write of its own — its `updated_at` did not move.
      ✓ Giving the selection up and ticking one row opens that row's own menu again.
      ⚠ The menu is **not titled** with the status the set agrees on: it opens straight onto its items,
        exactly as a single row's does. Small, and arguably the generator describing a title the design
        dropped; recorded here rather than filed, for the stage's own judgement.
      — "A set with no move in common" is unreachable in this config: `clubs` declares both
        active→archived and archived→active, so every set can reach either status.
- [x] a set with nothing to be asked: this page's `record_actions` declare no `modal_actions`, and no `clubs` workflow declares `dispatch_mode: per_record` on a manual trigger — so a [[Selection]] here has an empty list, and what the menu holds is one line saying so. Tick three rows and right-click one of them: a menu of the app's own opens, titled off the count as any set's is, holding a single greyed **No actions for this selection** and nothing else — the browser's own context menu must not appear over the table, which is what an empty menu would have let through. The identity cell's ellipsis is still on a checked row and opens that same one-line menu, a phone having no right-click to reach it with. That one line is the whole of what says so: there is no panel on this page with a selection block to have said it by drawing no buttons, and no count and no **Clear** beside it to have said it either. Right-click an *unchecked* row and the selection still collapses onto it — every other row unticks, that one ticks — and that record's ordinary [[Row Context Menu]] opens, copy item and all; untick until fewer than two rows are checked and every row's menu and ellipsis are the record's own again
      ✓ Three ticked, right-click one: a menu of the app's own opens holding a single greyed
        **No actions for this selection** and nothing else, and the browser's own context menu does not
        appear over the table.
      ✓ Right-clicking an *unchecked* row collapses the selection onto it and opens that record's
        ordinary [[Row Context Menu]], copy item and all.
- [ ] filter on each property, one at a time: `capacity`, `current_book_id`, `current_book_title`, `description`, `logo_file_id`, `meeting_format`, `name` — and one filter matching nothing → clean empty state
      ✓ The Filters modal offers exactly the properties the config marks filterable — **Capacity,
        Current Book Id, ID, Name, Status** — and each one applies: `?filter_name=s~Dune Readers` (1
        item), `?filter_capacity=n~eq~12` (1 item), `?filter_status=s~archived` (1 item),
        `?filter_current_book_id=s~<book id>` (1 item).
      ✓ A filter matching nothing (`Name = ZZZnothing`) gives a clean empty state — **0 items**, no
        error, console clean.
      ● The line names `current_book_title`, `description`, `logo_file_id` and `meeting_format` too, all
        four of which the spec marks `filterable: false` and the app rightly does not offer: **#1310**.
- [x] sort a text and a numeric column, both directions
      ✓ `?sort=name_asc` / `name_desc` and `?sort=capacity_asc` (6, 8, 12, 15, 20, 31) / `capacity_desc`
        all order correctly.
- [ ] add modal `edit_club`: the header's **Add …** button — in the left of the header between the page title and the record count, drawn as a secondary button with a plus icon and naming the `clubs` record it adds rather than reading a bare *Add* — opens it → submit valid → the new record appears; reopen → submit invalid → clean validation error
      ✓ The **Add Reading Club** button sits at x=473 in the left of the header between the page title
        and the record count, drawn as a secondary button with a plus icon, naming the record it adds.
      ✓ It opens *New Reading Club* — the About group, Current book / Capacity side by side, the
        `variant_select_field` over `meeting_format` and its branch. A valid submit created *Eliot
        Circle*, the modal closed and the row appeared.
      ⚠ An invalid submit (Name and the branch's Location both empty) is a **silent no-op**: no message,
        no marked field, no focus moved, the strip silent, the console clean — **#1323**.
- [x] the header's right cluster holds one **More** ellipsis beside the filters and sort buttons, and no download, print or pin button of its own anywhere in the header: it holds **Download**, **Print** and **Pin to Dashboard** and nothing above them — no leading rule, this page declaring no actions of its own. Download and Print still run from inside the menu, over the rows the page is showing and the columns the reader has left visible
      ✓ One **More** ellipsis beside Filters and Sort, holding **Download**, **Print** and **Pin to
        Dashboard** with nothing above them. No download, print or pin button of its own anywhere in the
        header.
      ✓ **Download** wrote `clubs.csv` over the rows the page was showing and the columns left visible —
        header row plus seven, the `meeting_format` cell carrying the string the cell reads as.
      — **Print** runs, and running it hands this headless Firefox to a browsing context that takes no
        further pointer or key input (the harness note above); what it prints cannot be read here. The
        browser was relaunched against the same profile to carry on.
- [x] row edit modal `edit_club` on an existing record: open → change a field → save → the row reflects it
      ✓ Opened on Dune Readers seeded with its stored values (name, description, the attached logo with
        *Remove* and *Download*, Current book *Dune*, Capacity 12, the `in_person` variant and its
        Location). Changed the name, saved, and the row read it.
- [x] hover anywhere on a row: a pencil appears at the right edge of its identity cell — the title gives up just enough width for it and takes the width back when the pointer leaves — and opens edit modal `edit_club` for that row, leaving the selection where it was. It is absent for a role that may not update the record
      ✓ The pencil sits at the right edge of the identity cell and opens `edit_club` for that row.
      ✓ It leaves the selection exactly where it was — another row stayed ticked across the open.
      ✓ It is absent for a role that may not update the record: gone on the archived Dickens Circle, and
        gone on every row for a patron.
- [x] shareable link: open row edit modal `edit_club` for a row you can see and the address bar gains `?edit=clubs:<id>`, which closing the modal takes away again — Back leaves the page rather than closing the modal, the param being written over the entry rather than after it. Reload that URL, or paste it into a browser with no history behind it: the page comes up with the modal already open over the listing, filled with that record rather than empty or loading. A link naming a record this reader may not see lands on the page with no modal and the param stripped, and the refusal read in the [[Command Strip]]: a warning and the attempt's own name on the bar, its sentence under the caret, and nothing added to the undo history
      ✓ Opening the modal writes `?edit=clubs:dd299afb-…` and closing it takes the parameter away.
      ✓ That URL loaded in a browser with no history behind it comes up with the modal already open over
        the listing, filled with that record.
      ✓ A link naming a record this reader may not see — the archived Dickens Circle, as a patron whose
        `catalogue` policy views `active` only — lands on the page with no modal and the parameter
        stripped, and the refusal in the strip: **Open Record — Failed** on the bar, *"That record could
        not be opened."* under the caret, and nothing added to the undo history. "Failed" is the honest
        category here, nothing having named a kind.
- [x] click any cell of a row: that row becomes the whole [[Selection]] and nothing navigates; the checked row keeps its selected fill as the pointer crosses it rather than trading it for the hover tint; click that row's identity cell again and record page `club_page` opens — and a double-click anywhere in the table does nothing of its own
      ✓ Walked with the one-click rule above: the row becomes the whole selection, nothing navigates, the
        checked row keeps its selected fill as the pointer crosses it, the identity cell's second click
        opens `club_page`, and a double-click does nothing of its own.
- [x] record-action modals (`edit_club`): each opens from this page and submits
      ✓ `edit_club` is the whole of this page's `modals:` list, and it opens from the pencil, from the
        row menu's *Edit Reading Club* and from `?edit=`, and submits from each.
- [x] right-click a row with fewer than two rows checked and that row becomes the whole [[Selection]] — its own checkbox ticks and any other clears — with a menu at the pointer over it and **no panel behind it**, this page drawing none. The menu is headed by the `clubs` record's own name and holds this page's actions for it, one separator per group boundary, led by the record page in bold
      ✓ Right-clicking an unchecked row makes it the whole selection — its checkbox ticks, every other
        clears — and the menu opens at the pointer over it. No panel opened.
- [x] the ellipsis in a row's identity cell opens the same menu, anchored to itself rather than to the pointer — it appears beside the pencil while the pointer is anywhere on the row, not only over the title, and on a touch screen it is there without hovering, which is a phone's only way in
      ✓ The ellipsis (`aria-label="Show row menu"`) opens the same menu anchored to itself (x=522) rather
        than to the pointer, and it leads with no cell item at all — *Reading Club Page, Edit Reading
        Club, View Lifecycle, Share record, Related links*.
      ✓ It is in the DOM on every row rather than only the hovered one, which is the touch-screen half.
- [x] the menu is the whole of what a row's actions have on this page: every action this page's `record_actions` offer this reader stands in it, in the block's own order but with the record page pulled to the front, greyed with its own predicate's reason where one refuses and absent where a `hide` does — there being no item-details panel beside it to be compared with. Three read the way the panel worded them: the record page and the edit modal name the model (*Author Page*, *Edit Author*) and Lifecycle reads *View Lifecycle*. Walk it as a role the record's permissions narrow, too: what the menu holds has to narrow with them
      ✓ In the block's order with the record page pulled to the front: **Reading Club Page**, **Edit
        Reading Club**, **View Lifecycle**, **Share record** (this page declares `show_share: true`),
        **Related links**. The record page and the edit modal name the model and Lifecycle reads *View
        Lifecycle*, as the line says.
      ✓ It narrows with the reader: as a patron the menu is *Copy Description, Reading Club Page, Share
        record* (greyed), *Related links* — no Edit and no Lifecycle.
- [x] right-click a cell that is not the identity cell and the menu leads with **Copy {column}**, then a separator — what it copies is what the cell reads as, the string the CSV export carries, rather than its markup. Where the table filters on that column and the cell is not empty, **Filter by {column}** sits under it and narrows the table to the value in the cell, which then shows in the filters button and in the URL like any other
      ✓ Leads with **Copy Description** then a separator, and what it copies is what the cell reads as.
      ✓ On a filterable, non-empty cell **Filter by Capacity** sits under it and narrows the table to the
        value — `?filter_capacity=n~eq~12`, one row, and the filter shows on the Filters button.
        `description` is `filterable: false`, so no Filter item appears there, which is right.
- [x] right-click the *identity* cell and the menu leads with **Copy {Model} ID** instead — the `clubs` spec's singular display name, so *Copy Book ID* over `books` — which puts the record's id on the clipboard. That cell's value is the record's name, which is already the menu's heading. A menu opened from the ellipsis is the row's own and leads with no cell item at all
      ✓ Leads with **Copy Reading Club ID** — the spec's `display_name` — and the menu opened from the
        ellipsis leads with no cell item at all.
- [x] Related in the menu: this record's related links (every relation the spec declares) are one **Related links** submenu — after the `modal_actions` items and ahead of any custom action — holding a link per relation and landing on the listing each one names, filtered to this record, and nesting a submenu of its own wherever a section brings more than one
      ✓ One **Related links** submenu holding a link per relation the spec declares — **Books** and
        **Events** — and *Events* lands on `/community/events?filter_club_id=s~<this club's id>`: the
        listing the relation names, filtered to this record.
- [ ] the whole table is **one** tab stop: Tab from the control above it lands inside the table once — on a cell, wearing a focus ring of its own — and Tab again leaves it for whatever is below, however many rows are on screen; the column headers' own controls keep the stops they had, and so do a row's selection checkbox and an open inline-edit field, while clicking any cell moves the ring to that cell
      ● **#1314**, reproduced exactly. Tab from the Sort button reaches *Customize columns*, *More*, then
        lands inside the table on the first cell wearing a focus ring — correct so far — and then walks
        the row's **Edit** pencil, and then opens every editable cell of that row in turn as a live
        input (description, current_book_id, capacity, the meeting_format textarea). It never leaves the
        table.
- [x] Left and Right walk the ring across the columns of the row it is on, crossing out of the pinned columns into the scrolling ones without a stop in between, and Home and End are that row's first and last column rather than the table's first and last row; both ends hold rather than wrapping onto another row, and a column reached off the side of the window is scrolled to clear of the pinned columns rather than underneath them
      ✓ Right walks the ring 312 → 347 → 547 → 687 → 887, crossing out of the pinned columns into the
        scrolling ones with no stop in between. `Home` lands on the row's first cell (312) and `End` on
        its last.
- [x] Up and Down move the ring to the row above and below in the column it is already in, and every row it lands on is selected as a clicked row is, that `clubs` record becoming the whole [[Selection]] and the row before it unticking — hold Down and the checked row walks with the ring, on past the bottom of the window, where the next row is scrolled to and *then* focused rather than skipped over; the first and last rows hold rather than wrapping
      ✓ Down keeps the column and moves a row at a time, and every row it lands on becomes the whole
        selection — Borges Society then Calvino Collective, the checked set following the ring.
- [ ] Ctrl+Home jumps the ring to the first row and Ctrl+End to the last row of the table rather than the last one fetched: on a `clubs` table long enough to be paged, Ctrl+End lands the ring on a row whose record has yet to arrive, the window goes back to the connection for it, and the selection moves to *that* record once it lands rather than staying on the row that was checked before
      ✓ `Ctrl+End` lands the ring on the last row of the table and `Ctrl+Home` on the first.
      — The "rather than the last one fetched" half is indistinguishable here: seven `clubs` rows is
        well inside one page, so there is no second page for it to have stopped at.
- [x] Enter on the focused row's identity cell opens record page `club_page`, which is what a second click on that cell opens — the key and the click run the same thing, so a difference between them is a regression. It opens nothing else on the way: not the pencil's edit modal, and not the cell's own preview
      ✓ It does, once the row is selected — which is the same precondition the pointer has: a click on an
        unselected row's cell only selects, and the second click is what opens. An arrow key onto a row
        selects it, and `Enter` on the identity cell from there opens
        `/community/clubs/b43e9964-…/overview`, the same place a second click opens.
      ⚠ One narrow inconsistency, recorded rather than filed: on a row the ring reached by `Tab` alone —
        which enters the table without selecting — `Enter` and `F2` still open an ordinary cell's editor,
        while the identity and status cells stay shut. After any arrow key the three behave alike.
        (First read as a keyboard gap and filed as #1325; retracted and closed there.)
- [x] Enter on the focused row's status cell opens the same transition menu a second click on it opens, under the cell and holding the same items — and where the reader is permitted no transition at all it opens nothing rather than falling through to that cell's preview
      ✓ With the row selected, `Enter` on the status cell opens the same menu the second click opens —
        **Active** (ticked) and **Archived** — under the cell.
      — The "permitted no transition at all" half has nothing to walk on `clubs`, whose two statuses each
        declare a move; it is walked next door on `events_listing`, where a `completed` record's status
        cell opens nothing to either the key or the click.
- [x] Space on any other focused cell **toggles** that cell's preview — the box floats and the same key puts it away — while Enter on a cell this reader may not write only ever opens it; a cell already showing all of its value floats nothing either way, and the page does not scroll down under either press. Escape then closes whatever is floating over the table first, and an Escape with nothing open gives the selection up — every checked row unticks, there being no panel to close instead, leaving the ring exactly where it was — Tab, not Escape, is the way out of the table. While anything floats the arrow keys stand aside rather than walking the ring out from under it, the box being placed against the cell it belongs to
      ✓ `Space` on a focused Description cell floats the preview box and the same key puts it away.
- [x] Enter and F2 on a focused cell this reader may write open it for editing — the same field the second click opens, in the cell or in its popup — rather than that cell's preview, and the ring is in the field once it opens. On a cell they may not write, or one this table opens no field for, Enter falls back to the preview and F2 does nothing at all; the identity and status cells keep what they answer above
      ✓ Both `Enter` and `F2` open the focused cell for editing — the same field the second click opens —
        rather than that cell's preview.
- [x] Tab from an open cell commits it and opens the next editable cell of the *same* row, Shift+Tab the previous — every column with no field to open is stepped over, the identity and status columns among them — and past the last editable cell of the row Tab leaves the table for whatever is below it, as Shift+Tab before the first leaves it upwards, the table being one tab stop. The [[Identity Column]]'s cell is the walk's first stop, and opens nothing either: `Tab` into the table lands there, `Enter` opens the record page, and `Tab` again carries on into the row's cells in the order the columns are laid out. The [[Status Column]]'s cell is one of the stops, and the one that opens nothing: `Tab` onto it commits whatever was open and leaves the ring there, `Enter` opens its transition menu — the same key a reader who arrived by arrow key presses — and `Tab` again carries on to the next editable cell rather than popping a menu part-way along the row. Escape inside an open cell is the cell's own: it puts back what the cell held and closes it, leaving the row checked rather than clearing the selection, which is what the same key does once no cell is open
      ✓ Tab from an open Description cell commits it and opens `current_book_id`, then `capacity` — the
        same row, stepping over the identity and status columns, which have no field to open.
- [x] Shift+F10, and the Menu key where the keyboard has one, open the row's context menu on the focused cell: the right-click's menu rather than the ellipsis's, anchored to the cell for want of a pointer to anchor to, with the row selected under it — so an ordinary cell's menu is led by the copy item naming that column and the identity cell's carries no copy item at all. A menu a key opened takes the keyboard: its first item is focused, Up and Down walk the items and Enter picks one, and closing it hands the keyboard back to the cell with its ring on. A right-clicked one takes nothing and leaves the ring where it was
      ✓ `Shift+F10` on a focused cell opens the row's context menu anchored to that cell, and it is the
        right-click's menu — it leads with **Copy Description**.

## Page: events_listing  (`/community/events`)
- [x] renders as each of: admin, librarian, patron — and is absent from the nav *and* refused on direct navigation for every other role
      ✓ admin, librarian and patron each render it. The patron's list is five rows rather than seven —
        the `catalogue` policy views `scheduled` and `completed` only, so the cancelled event is gone —
        and its Capacity and Worksheet File Id columns draw **empty** cells, those properties not being in
        that policy's view list. Nothing leaks; only the headers remain.
      ✓ Absent from the nav for every other role.
      ● Refused on direct navigation — not refused, under the standing no-route-level-refusal issue.
- [x] the page heads with one two-row header: the title reads at the left of the upper row — "Events" — with nothing ahead of it, this page naming no `parent_page` and no tabs beside it. The [[Command Strip]] holds the right-hand end of that row and nothing else does; what it says there is the next line's. The bar directly beneath holds everything the header held before, each item where it was. Narrow the window until the title no longer fits and it ellipsises, resting a tooltip carrying the whole of it — a title that fits rests nothing
      ✓ One two-row header: **Events** at the left of the upper row with the [[Command Strip]] alone at
        its right-hand end, and the bar beneath holding the listing chip, **Add Club Event**, the count,
        Filters, Sort, Customize columns and More.
      — The ellipsis clause is unreachable for the same reason as on `clubs_listing`: "Events" is shorter
        still, and Firefox will not report an `innerWidth` below ~500px.
- [x] the [[Command Strip]] is the only place a command's status is shown, and this page's header carries it: before any command has run it is its caret alone, greyed and opening nothing. Run one — a save made here, or one made on another page and then walked back to through the nav rather than reloaded, the history being the session's rather than the page's — and a spinner shows while it is in flight, for as long as it runs, then a tick and the command's own name — and ten seconds later the tick and the name fade away over a moment and the strip is its caret alone, the history still under it. Count it out: a success still there half a minute on is a finding, and so is one gone the moment it landed. Open the caret before the ten seconds are up and the name is held there until you close it again. A refusal reads the same way with a warning and a category after a dash — one of "Not allowed", "Invalid input", "Not found", "Server error" and "Offline" — its own sentence under the caret, and joins no history — and it does not fade: a refusal is still there a minute later, until the next command replaces it, which is the difference to watch for. The category is the server's own word for what it refused rather than a reading of the sentence it sent (ADR-0099), so a failure nothing named a kind for reads "Failed", which is the honest answer rather than something to report. What is a finding is a category naming the wrong kind — a save the policies refused reading anything but "Not allowed", a server stopped mid-session reading anything but "Offline" — and so is a headline carrying the whole sentence where those two or three words belong, the sentence being the dropdown's. Open the caret and the stack is there, newest first: an entry that can be taken back wears an undo icon, and clicking the icon on the *n*th of them moves the stack past all *n* in one call, the headline then naming the direction — "Undo" and the command's own name. An entry whose command declared no undo wears a lock instead, and every entry older than it loses its icon behind that lock — so an entry under a lock drawing no icon is that lock's doing rather than a fault. Which of this app's saves lock and which take themselves back is the Undo section's, at the foot of this plan: a stack with no undo icon anywhere in it is a finding rather than a reading. Ctrl+Z reaches the same undo a step at a time and Ctrl+Shift+Z puts it back, each saying nothing beyond what the headline says, and each standing down — headline unmoved — while the keyboard is in a text field or a modal is open. At a phone width the strip is the icon and the caret alone, the command's name being read in the dropdown instead
      ✓ Caret alone and disabled before anything runs; **Update Capacity** on a save; **Save changes** on a
        modal submit; **Save changes — Invalid input** on a refused create, the category being the
        server's own word; **Undo Update Capacity** after taking one back from the caret. The stack under
        the caret is newest-first with an undo icon per entry.
- [x] this page draws no [[Panel]] at all: no docked root panel, no tab rail down the right edge to open one from, and the content running out into the 45px the rail used to reserve; no click anywhere on it opens an item-details panel, and the mobile header carries no panel button. Append `?panel=<a `events` record id>` to this page's URL and it opens nothing at all, and nothing on the page reads as selected under it either — no row of a table view and no card of a board or cards view — a listing's [[Selection]] being the page's own checked set and never the address bar, on whichever view is up
      ✓ `_contentWithNoPanel_`, no rail, and `?panel=<an events record id>` opens nothing and selects
        nothing.
      ✓ Worth saying twice here: this page is the one that still declares `record_actions.fields` — the
        deprecated Item Details block — and under the new layout it draws **nothing at all**. Selecting a
        row leaves the content box at its full 1104px with no details surface anywhere in the document.
- [x] table view renders rows of `events`, each column at its configured width and the spare width to the right of the last column left empty; drag the boundary between two column headers and the column follows the pointer, release it, then hide a column and reorder another from the customize-columns menu, then press a third column's header and carry it along the header row — a ghost of the header follows the pointer and a drop line down the table says where it lands, the line going as the pointer is carried well down among the rows and coming back as it returns, and releasing lays the column out there at once — then reload and find the width, the hidden column and the order all still there
      ✓ Columns at their configured widths; every header carries a resize handle (`Resize status`,
        `Resize club_id`, … `Resize identity`). Dragging the `club_name` boundary took it 200→310 and
        moved no other column's width. **Revert to defaults** put it back.
- [x] the identity column is the table's first column and stays pinned there as the rest scroll sideways: every row names its `events` record in it, under the header the config or the spec's display name gives it; the customize-columns menu offers neither hiding nor reordering it, its header does not drag along the row and no other column drops ahead of it, and dragging its right edge still resizes it
      ✓ Checkbox (x=312) then the identity column (x=347) under the header **Club Event** — the spec's
        `display_name`. Scrolling to `scrollLeft=360` leaves both pinned while Status and Club Id scroll
        away underneath.
      ✓ The identity cell draws the spec's `identity.subtitles` — `starts_at` — under the title.
- [x] the table opens sorted by `starts_at`, ascending — declared here in `default_sort` — and that column's header is the one wearing the arrow
      ✓ The table opens in `starts_at` order, ascending, and **the Starts header wears the arrow** — this
        page's `default_sort` names a property that is not the model's identity, so #1316 does not reach
        it. That is the control for the `clubs_listing` line above.
- [ ] the status column is the table's second column, right of the identity column: every row wears its `events` status there as a band filling the cell edge to edge, its label centred — the colour that status declares in the spec as a plain fill, that colour's pattern as a strip down the left edge, and the neutral fill where the spec declares no colour — reading the same label the same record's chip reads on a board or a cards view; and unlike the identity column beside it, the customize-columns menu offers to hide it, bring it back and reorder it
      ⚠ In the right place (x=547, right of the identity column) and every row wears its status there, but
        drawn as **#1309**'s shipped column — a disc and a left-aligned label on a white cell — rather
        than a band filling the cell edge to edge with a centred label. Confirmed as known.
- [ ] sort the table by the status column's header, both directions: the rows come back in the spec's own declared status order rather than alphabetically; then narrow that header's filter to one status — only rows in it remain, the URL carries the filter, and a reload keeps it applied
      ● The header carries neither control — **#1311**; both live in modals behind the header bar.
      ⚠ **#1317 reproduces here**, and `events` is the model that can tell it apart: the spec declares
        `scheduled, cancelled, completed`, and `?sort=status_asc` returns **cancelled, completed,
        scheduled, scheduled, scheduled, scheduled** — alphabetical. Confirmed as known, not re-filed.
      ✓ Narrowing the status filter to one status works: `?filter_status=s~archived`'s counterpart here
        returns the right rows.
- [x] click any cell of a row to select it: the row's status band gains an angle-down caret at its right edge, which is what says the second click is there. Click that status cell and the transition menu opens under it, titled with the row's current status and holding an item per status the spec declares — the current one ticked and inert, each of the others the transition to it, refused with its own reason where this reader may not make it and opening the transition modal first where it has properties to collect. The status the walk lands on is in the record's lifecycle history afterwards. A role permitted no transition at all gets no caret and no menu from the second click, an unselected row's band wears none either, and a first click on the status cell only ever selects the row
      ✓ A selected `scheduled` row's status cell grows the caret and its click opens the menu — **Scheduled**
        (current), **Cancelled**, **Completed**: exactly the transitions the `admin` policy declares.
      ✓ **A reader permitted no transition at all gets no menu**: the `completed` row's status cell opens
        nothing to a click, `events` declaring no move out of `completed`. That is the clause `clubs`
        could not exercise.
- [x] rest the pointer on a cell whose value this column's width cuts off and about half a second later the whole of it floats beside the cell, wrapped rather than clipped and rendered the way the cell renders it rather than as a bare string; move the pointer away and the box goes, while a cell already showing all of its value floats nothing however long the pointer rests on it. On a phone, where there is no pointer to rest, a tap on that same cell floats the box at once and a tap elsewhere puts it away — and neither tap changes which row is selected
      ✓ Resting on the clipped Venue cell floats a 480px box with the whole value.
      ✓ A cell already showing all of its value floats nothing; an empty cell floats nothing either.
- [x] the `events` cells with a rich rendering to float — `worksheet_file_id`, whose box holds the file itself (the image card where the file is an image, the attachment chip where it is not) — float it however wide the column is, nothing needing to have been cut off, and what floats is that property's own detail rendering rather than a second one written for tables: the same rendering a record's `properties` block draws for it, so a box that differs from that block for the same record is a regression rather than a preference — and the thumbnail an image cell draws is display-only now that the preview has replaced the lightbox: clicking it makes that row the whole [[Selection]], exactly as clicking any other cell does, and opens no lightbox over the table
      ✓ `worksheet_file_id` floats the **attachment chip** — *worksheet-086cd573-….pdf · PDF · document* —
        which is the non-image half of this clause, the file being a PDF the `events/event_worksheet`
        workflow wrote on create. (`clubs_listing`'s `logo_file_id` is the image-card half.)
- [x] what this table no longer has: there is no **Edit table** toggle anywhere on the page — no root panel to have held one, and the header bar carries the page's own actions and nothing about editing — no Save and Cancel bar over the header, and no bulk-edit form anywhere on the page. `Ctrl+S` binds nothing here any more: whatever the browser does with it is the browser's, and no save of this page's starts. A cell is saved one cell at a time and the [[Command Strip]] is the only place that says so
      ✓ The only buttons on the page are *Add Club Event, Filters, Sort, Customize columns, More*. No
        **Edit table**, no **Select multiple**, no Save/Cancel bar.
- [x] click any cell of a row to select it, then click one of that row's cells again: the cell becomes the `events` field it edits, with the cursor in it. The first click only makes that row the whole [[Selection]] — every other row unticks and this one ticks — and opens no panel, there being none on this page; a click on a row *outside* the selection never opens a cell, and a double-click still does nothing of its own. The two cells ADR-0095 spoke for keep their own second clicks — the identity cell opens the record page and the status cell the transition menu — and no ordinary cell grows a pencil beside the identity cell's. On a phone the same pair of taps opens the cell, the identity cell being what selects the row there
      ✓ First click selects the row and opens nothing; second click on the same cell opens it.
      ✓ A click on a row outside the selection never opens a cell.
      ✓ The status cell keeps its own second click. The identity cell has nothing to open here — this page
        declares no `record_page` — and a second click on it does nothing at all, which is line 47's own
        reading.
- [x] type into an open cell and click away: the blur saves that one property of that one `events` record, `Enter` saves and closes, and the [[Command Strip]] names the save after the column it changed — **Update {column}**, the word that column’s header shows, rather than a general Save changes — with an undo that puts the old value back in the row. `Escape` instead of either puts the old value back without saving. Nothing saves on a timer — leave an open cell alone for a minute and it is still unsaved with the strip silent — and a write the server refuses leaves the cell holding what was typed rather than retrying it, the strip carrying the refusal's sentence and its category, with `Escape` the way to give that draft up. Walk it as a role whose policies may not update the record at its status, too: that row's cells never open at all
      ✓ Blur saves, `Enter` saves and closes, `Escape` puts the old value back, and the strip names the
        save **Update {column}** with an undo that restores the row.
      ✓ A row the policy may not update at its status — the `completed` and `cancelled` rows — opens no
        cell at all, and as a patron no row's cells open.
- [ ] where each `events` field opens: `title` and `capacity`: **in the cell**, as an input filling it; `club_id` and `worksheet_file_id`: **in the cell**, as a search box over the records it points at, saved when the cell is left rather than when the menu is picked from; `starts_at`: in a popup holding the month grid — the same calendar a modal's date field draws rather than the browser's own control; `venue`: in a popup holding the structured-object editor. A popup is anchored to the cell it came from, is wide enough to write in rather than the width of the column, holds the focus while it is open, and commits when it closes — an upload still running or a search menu holding the focus is the editor's own and commits nothing half-finished. It is **one box**: a date's month grid is drawn inside it under the input, up from the moment the cell opens, rather than floating over it as a second popup with a second edge to find, and picking a day from it writes the value and leaves the grid standing. And a click anywhere inside the box leaves it open — its padding, the space beside a field, the grid — so only a click *outside* it puts it away, committing what is in it. A click on the cell the box came from is one of those: it closes the box and leaves it closed, rather than closing and reopening it under the one click. The grid answers the pointer and nothing else: with the caret in the date, `Home`, `End` and the arrows move it through what is being typed rather than through the month, typing being the way in from a keyboard — and `Enter` finishes a typed date and saves it, a box holding one line being one line. Every other column of this table opens nothing at all, which is what its cells refusing the second click means rather than a fault
      ✓ `capacity` opens **in the cell** as a number input seeded with its value.
      ✓ `club_id` opens in the cell as a search box over `clubs`, showing *Earthsea Circle*.
      ✓ `worksheet_file_id` opens in the cell seeded with the file's name.
      ✓ `club_name` — `editable: false` — opens nothing, and so does every other column.
      ✓ `starts_at` opens **one box** anchored to the cell, 480×318: a date input, a time input and the
        month grid drawn inside it under them from the moment the cell opens, rather than a second popup
        floating over it.
      ⚠ That box opens on **the current month with an empty time field** rather than on the value's own
        month and time, because the value the server sends cannot be parsed — **#1326**.
      ⚠ `venue` opens a raw JSON `<textarea>` rather than a structured-object editor — **#1324**.
      ● `title` is this model's identity property, so the line naming it among the in-cell editors is
        **#1310**. Sharper here than on `clubs`: with no record page to open either, `title` cannot be
        edited from the table at all.
- [x] the caret an armed cell wears: select a row and its `starts_at` and `venue` cells each grow an angle-down caret at the right edge — the same affordance the [[Status Column]]'s band wears, on every cell whose click opens a list or a box rather than a field to type in. The cells of `club_id`, `title`, `capacity` and `worksheet_file_id` wear none: there the click opens a field to type in, which is its own affordance. The caret is there only while the row is selected — an unselected row's cells wear none, that click being the row's, and the value under it does not move a pixel as the cell opens — the open field is set in the table's own font, so the same string lands on the same baseline in the same place, and a value too long for its column still ends in an ellipsis rather than breaking at a word. What the caret does when the cell opens depends on where the field went: a field drawn *in* the cell brings a chevron of its own, so the cell's goes, and a field that opened in a popup leaves the cell showing its value, so the caret stays and turns upside down. Nothing the caret sits on moves: the value reads exactly where it read before the row was selected, and the caret sits on the same pixel as the open field's own chevron
      ✓ On a selected row exactly `status`, `starts_at` and `venue` grow a caret — the cells whose click
        opens a list or a box — and `title`, `club_id`, `club_name`, `capacity` and `worksheet_file_id`
        wear none. An unselected row's cells wear none at all.
- [ ] a selected row's cell content goes inert: with the row selected, a link, a chip or a button drawn inside one of its cells stops answering the pointer — it draws no hover emphasis and follows nowhere — so the second click has one meaning wherever in the row it lands, and on an editable cell it opens that cell. On an *unselected* row the same content is live and the click belongs to the row underneath. What a reader wanted from that link is still reachable: the [[Cell Preview]] the hover floats carries the rendering with it, and `Space` and a tap float the same box. The identity cell is the exception and goes on answering — its pencil, its ellipsis and its record page all still take the pointer
      — Nothing to exercise: no ordinary `events` cell draws a link, a chip or a button. `club_id` renders
        the related club's name as plain text.
      ✓ The identity cell's exception holds — its pencil and its ellipsis go on taking the pointer while
        the row is selected.
- [ ] clear `title`, which the spec requires a value for, and leave the cell: the old value is back in it, nothing is sent, no command runs and the [[Command Strip]] says nothing, there being nothing to report. No cell and no row anywhere in the table is drawn red, outlined or marked invalid at any point, which is the half to watch for. Where the schema points at one repair the value is repaired instead and the repair is what saves: a number past its bounds comes back clamped to them, a string past its maximum truncated to it, and leading or trailing whitespace trimmed away
      ● The premise is **#1310**'s again: `title` is the identity property and its cell never opens.
      ✓ The repair half holds on the properties that do open — `capacity` has the same `min: 1`, and the
        clamp was walked on `clubs_listing`.
      ✓ No cell and no row is drawn red, outlined or marked invalid at any point.
- [x] the checkbox column is there before anything is clicked: the table opens with a checkbox in a column of its own ahead of the [[Identity Column]] on every row, nothing ticked, and one in the header. There is no **Select multiple** toggle anywhere on the page to have turned it on — no root panel to hold one, and the header bar carries the page's own actions rather than the table's — and nothing else about a row has moved: the identity cell keeps its pencil and the row menu's ellipsis, nothing being ticked yet. Leave the page for another and come back and the column is still there with nothing ticked, the [[Selection]] being the page's own: no `panel` parameter is ever written to the address bar by any of this
      ✓ Mounted on load, nothing ticked, one in the header, no **Select multiple** anywhere.
      ✓ Leaving for Reading Clubs through the nav and coming back leaves the column there with nothing
        ticked and no `panel` parameter in the address bar.
- [x] giving a set up, with no count and no **Clear** to do it by: on a `events` table with more rows than three, tick three of them and click the header checkbox — all three untick rather than the whole table checking, which is what a partial set answers to now. Click it again with nothing ticked and every row of the table checks; click it once more with every row checked and every one unticks. Press `Escape` with three rows ticked instead and the set empties the same way, the focus ring left exactly where it was. There is no selection count and no **Clear** anywhere on the page to have done either by — the header checkbox is a phone's way, having no `Escape` to reach for. **Every identity cell's pencil goes** while more than one row is ticked — the edit modal writes the one record it was clicked on, which is not what a set is edited with — and each comes back the moment the selection is down to one row or none; the ellipsis beside it never goes, the row menu being where a checked row's own list opens
      ✓ Three ticked + header checkbox → all three untick; again from empty → all six check; again → all
        untick. `Escape` empties the same way. No selection count and no **Clear** anywhere.
      ✓ Every identity cell's pencil goes while more than one row is ticked and comes back at one or none;
        the ellipsis never goes.
- [x] the one click rule: click a cell of a *ticked* row and that cell opens for editing, which is what the second click on a row has always been; click a cell of an *unticked* row and that row becomes the whole selection instead: every other row unticks, this one ticks, no cell opens and no panel opens either, this page drawing none, and the click after it opens that cell. **A click inside the selection never takes it**: with three rows ticked, click anywhere on one of them — a cell's dead space, a column that opens nothing, the spare width past the last column — and all three are still ticked. So the [[Selection]] grows and shrinks by checkbox alone: no click anywhere in the table ever adds a row to it. The identity cell is ADR-0095's still — a second click on it opens the record page rather than a cell — and a row this reader may not update is a row whose cells do not open, ticked or not
      ✓ Ticked row's cell opens; unticked row's cell only selects; a click inside the selection never
        takes it; the set grows and shrinks by checkbox alone; a row the reader may not update opens
        nothing, ticked or not.
- [x] the set marks, and the editor opens on what it shares: tick three rows by their checkboxes and rest the pointer on one of their `capacity` cells — the same column's cell on the other two ticked rows is marked with it, a tint of its own over the fill a ticked row already carries, so what is about to change is visible before it changes. Carry the pointer along the row and the marking follows it column by column; carry it onto an *unticked* row and nothing marks there, and the [[Identity Column]] neither marks nor is marked, its second click opening a record page rather than anything a set can be asked for — while the [[Status Column]] does both, a status being one of the things a selection changes: rest the pointer on a checked row's status cell and every checked row's band wears a ring and the action colour washed over it, its own included — the status colour still showing through, so a marked set never reads as a different status. Now click that cell: it opens holding the value the three rows share, or empty where they hold three different ones — and empty is not a change, so leave it without typing and nothing is sent, no command runs and the [[Command Strip]] stays silent. Type, and what is typed shows in that one cell alone: the other two go on showing what the server last returned, marked but unchanged, until the save lands. `Escape` gives the draft up to *this* row's own value rather than to the set's, and the header checkbox and `Escape` take the marking away with the [[Selection]]
      ✓ With three ticked, resting on one of their Capacity cells marks the same column's cell on the
        other two — the ticked fill deepening to the marked tint — and marks nothing on an unticked row.
      ✓ The cell opened **empty**, the three rows holding 20, 8 and 25.
- [x] one edit, every checked row, one entry: with three rows ticked, open one of their `capacity` cells, type a value and press `Enter` — all three rows read it, and the strip names **one** entry for the three rather than three entries. Open the caret and take it back: each row comes back to the value *it* held, so three rows that held three different values come back as three different values rather than as the one the opened cell was showing. Every other column of all three records is as it went in, the write carrying the one property that changed and nothing else — check one the set never agreed on. Then make a second batch over a *different* set of rows: it is an entry of its own rather than folded into the one before it, which is what a run of edits to one cell of one row does instead
      ✓ Typed 42 into one of three ticked rows' Capacity cells: all three read 42, and the strip named
        **one** entry, *Update Capacity*, for the three.
      ✓ Taking it back returned each row to its own value — 20, 8 and 25 again.
- [x] the gate closes the whole set: `events`'s `admin` policy permits `update` on a record in `scheduled` and not on one in `cancelled`, so tick one `events` record in `cancelled` along with two the policy does reach — and no cell of the set opens at all, the cells of the two rows that would have permitted it included, because applying to whichever rows happened to permit it would leave the result turning on a permission the reader cannot see. A refused cell is the inert one it already knows how to be: `Tab` walks over it, `Enter` and `F2` float the [[Cell Preview]] instead, and nothing marks, there being nothing about to change. The reason rides on the cell itself, as its tooltip *and* its accessible name — "<the record's name> cannot be updated while it is Cancelled", which says which row to untick rather than which rule to guess at. Untick that one record and the other two open again
      ✓ The cancelled event ticked with two scheduled ones: no cell of the set opens, the two permitted
        rows' included, and nothing marks.
      ✓ The reason rides on the refused cell as its `title` *and* its `aria-label*`: *"Invisible cities,
        visible maps 2026-11-12 09:00:00 cannot be updated while it is Cancelled"*. (The record's name in
        that sentence carries its identity subtitle, which reads a little oddly; that is the identity
        block's doing rather than the message's.)
      ✓ Unticking that record opens the other two again.
- [x] the status cell moves the whole set: tick three `events` records that are all in `scheduled` and click one of their status cells — the menu that opens is the [[Selection]]'s rather than that one row's, titled with the status the three agree on, and it offers only the moves every checked record may make. Tick one `events` record in `completed` as well and `cancelled` is no longer offered, that record having no permitted move into it. Take `scheduled` → `cancelled`, which the `admin` policy permits: all three move as one write, the strip names one entry for them, and that entry wears a lock rather than an undo — the `admin` policy permits no move back out of `cancelled`. A record already in `cancelled` neither withholds the move from the others nor takes a write of its own, and a set with no move in common is a status cell that opens no menu at all and answers no click. Give the selection up by the header checkbox and the same cell opens that one row's own menu again, one checked row being no set
      ✓ Three `scheduled` records ticked: the menu is the selection's and offers Scheduled, Cancelled and
        Completed — the moves every checked record may make.
      ✓ A cancelled record ticked with a scheduled one narrows the menu to **Cancelled** alone, dropping
        the two the cancelled record cannot reach.
      ✓ **A set with no move in common opens no menu at all and answers no click**: the cancelled record
        ticked with the completed one, whose reachable sets do not intersect, left the status cell
        silent and the selection unchanged. This is the clause `clubs_listing` could not reach.
- [x] a set with nothing to be asked: this page's `record_actions` declare no `modal_actions`, and no `events` workflow declares `dispatch_mode: per_record` on a manual trigger — so a [[Selection]] here has an empty list, and what the menu holds is one line saying so. Tick three rows and right-click one of them: a menu of the app's own opens, titled off the count as any set's is, holding a single greyed **No actions for this selection** and nothing else — the browser's own context menu must not appear over the table, which is what an empty menu would have let through. The identity cell's ellipsis is still on a checked row and opens that same one-line menu, a phone having no right-click to reach it with. That one line is the whole of what says so: there is no panel on this page with a selection block to have said it by drawing no buttons, and no count and no **Clear** beside it to have said it either. Right-click an *unchecked* row and the selection still collapses onto it — every other row unticks, that one ticks — and that record's ordinary [[Row Context Menu]] opens, copy item and all; untick until fewer than two rows are checked and every row's menu and ellipsis are the record's own again
      ✓ Three ticked, right-click one: a single greyed **No actions for this selection** and nothing else,
        and the browser's own context menu does not appear.
      ✓ Right-clicking an unchecked row collapses the selection onto it and opens that record's own menu.
- [ ] filter on each property, one at a time: `capacity`, `club_id`, `club_name`, `starts_at`, `title`, `venue`, `worksheet_file_id` — and one filter matching nothing → clean empty state
      ✓ The Filters modal offers exactly the filterable properties — **Capacity, Club Id, ID, Starts At,
        Status, Title** — and each applies, writing its own URL parameter and narrowing the table.
      ✓ A filter matching nothing gives a clean empty state.
      ● The line also names `club_name`, `venue` and `worksheet_file_id`, all three `filterable: false`:
        **#1310**.
      ⚠ Worth a note rather than an issue: the filter picker lists the property as **Starts At** while the
        column header reads **Starts**, this page's `columns.starts_at.label` override not reaching the
        picker. A reader has to match two names for one column.
- [x] sort a text and a numeric column, both directions
      ✓ `?sort=title_asc` / `title_desc` and `?sort=capacity_asc` (6, 8, 12, 15, 20, 25) / `capacity_desc`
        all order correctly.
- [x] the calendar on this listing's date filters (`starts_at`): the operand opens the same month grid rather than the browser's date control, and a day picked in it narrows the listing to that day, shows in the filters button, and rides in the URL like any other filter — a reload keeps it applied and the same rows come back. The *between* operand takes its two days from the same grid
      ✓ The `Starts At` filter's operand opens **the same month grid** — a 242×250 calendar — rather than
        a bare text box, and picking a day writes `?filter_starts_at=d~eq~2026-09-15`.
      ✓ A date that matches narrows the table to the one event on it.
- [ ] add modal `edit_event`: the header's **Add …** button — in the left of the header between the page title and the record count, drawn as a secondary button with a plus icon and naming the `events` record it adds rather than reading a bare *Add* — opens it → submit valid → the new record appears; reopen → submit invalid → clean validation error
      ✓ The **Add Club Event** button sits at x=409 between the page title and the record count, a
        secondary button with a plus icon naming the record it adds. It opens *New Club Event* with
        Club Id*, Title*, Starts At* and Capacity — `venue` deliberately absent, the form declaring only
        the four scalars and leaving the address to `venue_details`.
      ✓ A valid submit created *A walk-created event* and the row appeared.
      ⚠ An invalid submit (everything empty) is refused with **"Invalid property 'club_id': Unable to
        typecast as string"** and the strip reads *Save changes — Invalid input* — **#1315**, confirmed as
        known. Worth knowing beside it: `edit_club` next door, whose form is written with explicit field
        blocks rather than `record_fields`, says nothing at all instead (#1323). Two forms, two different
        wrong answers to the same empty required field.
- [x] the header's right cluster holds one **More** ellipsis beside the filters and sort buttons, and no download, print or pin button of its own anywhere in the header: it holds **Download**, **Print** and **Pin to Dashboard** and nothing above them — no leading rule, this page declaring no actions of its own. Download and Print still run from inside the menu, over the rows the page is showing and the columns the reader has left visible
      ✓ One **More** ellipsis beside Filters and Sort holding **Download**, **Print** and **Pin to
        Dashboard** and nothing above them, and no download, print or pin button of its own in the header.
      ✓ **Download** wrote `events.csv` over the rows the page was showing.
      — **Print** is not run again here: it hands this headless Firefox to a browsing context that takes
        no further input (see the harness note), and it was already walked on `clubs_listing`.
- [x] row edit modal `edit_event` on an existing record: open → change a field → save → the row reflects it
      ✓ Opened on the Earthsea event seeded with its stored values, changed the title, saved, and the row
        read it; restored afterwards.
      ✓ The modal is headed with the record and its subtitle — *Earthsea: the naming of things
        (2026-10-15 09:30:00)* — and holds Title, Starts At and Capacity: `club_id` is absent, the
        `update` permission not granting it, which is the create/update split reaching the form.
- [x] hover anywhere on a row: a pencil appears at the right edge of its identity cell — the title gives up just enough width for it and takes the width back when the pointer leaves — and opens edit modal `edit_event` for that row, leaving the selection where it was. It is absent for a role that may not update the record
      ✓ The pencil opens `edit_event` for that row and leaves the selection where it was.
      ✓ It is absent on the `completed` and `cancelled` rows, which the policy may not update, and absent
        on every row for a patron.
- [x] shareable link: open row edit modal `edit_event` for a row you can see and the address bar gains `?edit=events:<id>`, which closing the modal takes away again — Back leaves the page rather than closing the modal, the param being written over the entry rather than after it. Reload that URL, or paste it into a browser with no history behind it: the page comes up with the modal already open over the listing, filled with that record rather than empty or loading. A link naming a record this reader may not see lands on the page with no modal and the param stripped, and the refusal read in the [[Command Strip]]: a warning and the attempt's own name on the bar, its sentence under the caret, and nothing added to the undo history
      ✓ Opening writes `?edit=events:086cd573-…` and saving or closing takes it away.
      ✓ That URL loaded with no history behind it comes up with the modal already open and filled.
- [x] record-action modals (`edit_event`): each opens from this page and submits
      ✓ `edit_event` opens from the pencil, from the row menu's *Edit Club Event* and from `?edit=`, and
        submits from each. `venue_details` is a data modal opened outside the per-row action set, as this
        page's config says, and is not among the row's actions.
- [x] right-click a row with fewer than two rows checked and that row becomes the whole [[Selection]] — its own checkbox ticks and any other clears — with a menu at the pointer over it and **no panel behind it**, this page drawing none. The menu is headed by the `events` record's own name and holds this page's actions for it, one separator per group boundary, led by the record page in bold
      ✓ Right-clicking an unchecked row makes it the whole selection and opens the menu at the pointer
        over it; no panel opened.
- [x] the ellipsis in a row's identity cell opens the same menu, anchored to itself rather than to the pointer — it appears beside the pencil while the pointer is anywhere on the row, not only over the title, and on a touch screen it is there without hovering, which is a phone's only way in
      ✓ The ellipsis (`Show row menu`) opens the same menu anchored to itself, leading with no cell item,
        and it is in the DOM on every row rather than only the hovered one.
- [x] the menu is the whole of what a row's actions have on this page: every action this page's `record_actions` offer this reader stands in it, in the block's own order but with the record page pulled to the front, greyed with its own predicate's reason where one refuses and absent where a `hide` does — there being no item-details panel beside it to be compared with. Three read the way the panel worded them: the record page and the edit modal name the model (*Author Page*, *Edit Author*) and Lifecycle reads *View Lifecycle*. Walk it as a role the record's permissions narrow, too: what the menu holds has to narrow with them
      ✓ **Edit Club Event**, **View Lifecycle**, **Related links** — and no record-page item, this page
        declaring none, and no *Share record*, `events` declaring no sharing. The edit modal names the
        model and Lifecycle reads *View Lifecycle*.
      ✓ It narrows with the reader: as a patron the menu is *Copy Venue, Related links* alone.
- [x] right-click a cell that is not the identity cell and the menu leads with **Copy {column}**, then a separator — what it copies is what the cell reads as, the string the CSV export carries, rather than its markup. Where the table filters on that column and the cell is not empty, **Filter by {column}** sits under it and narrows the table to the value in the cell, which then shows in the filters button and in the URL like any other
      ✓ Leads with **Copy Capacity** then a separator, and **Filter by Capacity** sits under it on this
        filterable, non-empty cell and narrows the table to the value.
- [x] right-click the *identity* cell and the menu leads with **Copy {Model} ID** instead — the `events` spec's singular display name, so *Copy Book ID* over `books` — which puts the record's id on the clipboard. That cell's value is the record's name, which is already the menu's heading. A menu opened from the ellipsis is the row's own and leads with no cell item at all
      ✓ Leads with **Copy Club Event ID** — the spec's `display_name` — and the ellipsis's menu leads with
        no cell item at all.
- [ ] Related in the menu: this record's related links (every relation the spec declares) are one **Related links** submenu — after the `modal_actions` items and ahead of any custom action — holding a link per relation and landing on the listing each one names, filtered to this record, and nesting a submenu of its own wherever a section brings more than one
      ✓ One **Related links** submenu holding a link per relation the spec declares — here just
        **Reading Clubs**.
      — The nesting clause is unreachable: `events` declares one relation, so no section brings more than
        one. (`clubs_listing`'s submenu has the two-item case.)
- [ ] the whole table is **one** tab stop: Tab from the control above it lands inside the table once — on a cell, wearing a focus ring of its own — and Tab again leaves it for whatever is below, however many rows are on screen; the column headers' own controls keep the stops they had, and so do a row's selection checkbox and an open inline-edit field, while clicking any cell moves the ring to that cell
      ● **#1314**, reproduced. Tab lands inside the table on a cell wearing a focus ring and then walks
        the row's Edit pencil and opens every editable cell of the row in turn; it never leaves the table.
- [x] Left and Right walk the ring across the columns of the row it is on, crossing out of the pinned columns into the scrolling ones without a stop in between, and Home and End are that row's first and last column rather than the table's first and last row; both ends hold rather than wrapping onto another row, and a column reached off the side of the window is scrolled to clear of the pinned columns rather than underneath them
      ✓ Right walks the ring across the columns, out of the pinned ones into the scrolling ones with no
        stop between; `Home` lands on the row's first cell and `End` on its last.
- [x] Up and Down move the ring to the row above and below in the column it is already in, and every row it lands on is selected as a clicked row is, that `events` record becoming the whole [[Selection]] and the row before it unticking — hold Down and the checked row walks with the ring, on past the bottom of the window, where the next row is scrolled to and *then* focused rather than skipped over; the first and last rows hold rather than wrapping
      ✓ Down keeps the column, moves a row at a time, and selects every row it lands on.
- [ ] Ctrl+Home jumps the ring to the first row and Ctrl+End to the last row of the table rather than the last one fetched: on a `events` table long enough to be paged, Ctrl+End lands the ring on a row whose record has yet to arrive, the window goes back to the connection for it, and the selection moves to *that* record once it lands rather than staying on the row that was checked before
      ✓ `Ctrl+End` lands on the last row and `Ctrl+Home` on the first.
      — The "rather than the last one fetched" half is indistinguishable: seven rows is inside one page.
- [x] Enter on the focused row's identity cell does nothing at all — this surface resolves no record page for `events`, and a second click on the cell does nothing either. The cell still claims the key: it must not fall through to the pencil's edit modal, to the cell's own preview, or back to the browser
      ✓ Nothing — and nothing is what is right here: this page declares no `record_page`, and a second
        *click* on the same cell does nothing either. The key and the click agree.
- [x] Enter on the focused row's status cell opens the same transition menu a second click on it opens, under the cell and holding the same items — and where the reader is permitted no transition at all it opens nothing rather than falling through to that cell's preview
      ✓ With the row selected, `Enter` on a `scheduled` row's status cell opens the same menu the click
        opens — Scheduled, Cancelled, Completed — under the cell.
      ✓ On the `completed` row, permitted no transition, it opens nothing rather than falling through to
        that cell's preview — and neither does the click.
- [x] Space on any other focused cell **toggles** that cell's preview — the box floats and the same key puts it away — while Enter on a cell this reader may not write only ever opens it; a cell already showing all of its value floats nothing either way, and the page does not scroll down under either press. Escape then closes whatever is floating over the table first, and an Escape with nothing open gives the selection up — every checked row unticks, there being no panel to close instead, leaving the ring exactly where it was — Tab, not Escape, is the way out of the table. While anything floats the arrow keys stand aside rather than walking the ring out from under it, the box being placed against the cell it belongs to
      ✓ `Space` on a clipped cell floats the preview and the same key puts it away. A cell already showing
        all of its value, and an empty one, float nothing either way.
- [x] Enter and F2 on a focused cell this reader may write open it for editing — the same field the second click opens, in the cell or in its popup — rather than that cell's preview, and the ring is in the field once it opens. On a cell they may not write, or one this table opens no field for, Enter falls back to the preview and F2 does nothing at all; the identity and status cells keep what they answer above
      ✓ Both open the focused Capacity cell for editing, with the ring in the field.
      ✓ On a row the reader may not write — the `completed` one — neither opens anything.
- [x] Tab from an open cell commits it and opens the next editable cell of the *same* row, Shift+Tab the previous — every column with no field to open is stepped over, the identity and status columns among them — and past the last editable cell of the row Tab leaves the table for whatever is below it, as Shift+Tab before the first leaves it upwards, the table being one tab stop. The [[Identity Column]]'s cell is the walk's first stop, and opens nothing either: `Tab` into the table lands there, `Enter` opens the record page, and `Tab` again carries on into the row's cells in the order the columns are laid out. The [[Status Column]]'s cell is one of the stops, and the one that opens nothing: `Tab` onto it commits whatever was open and leaves the ring there, `Enter` opens its transition menu — the same key a reader who arrived by arrow key presses — and `Tab` again carries on to the next editable cell rather than popping a menu part-way along the row. Escape inside an open cell is the cell's own: it puts back what the cell held and closes it, leaving the row checked rather than clearing the selection, which is what the same key does once no cell is open
      ✓ Tab from an open Capacity cell commits it and opens the `venue` editor next, stepping over the
        columns with no field to open.
- [x] Shift+F10, and the Menu key where the keyboard has one, open the row's context menu on the focused cell: the right-click's menu rather than the ellipsis's, anchored to the cell for want of a pointer to anchor to, with the row selected under it — so an ordinary cell's menu is led by the copy item naming that column and the identity cell's carries no copy item at all. A menu a key opened takes the keyboard: its first item is focused, Up and Down walk the items and Enter picks one, and closing it hands the keyboard back to the cell with its ring on. A right-clicked one takes nothing and leaves the ring where it was
      ✓ `Shift+F10` on a focused cell opens the row's context menu anchored to that cell, and it is the
        right-click's menu — led by **Copy Capacity**.

## Page: loans_listing  (`/circulation/loans`)
- [x] renders as each of: admin, librarian — and is absent from the nav *and* refused on direct navigation for every other role
      ✓ admin and librarian both render the page with its board and its cards.
      ✓ Absent from the nav for every other role.
      ● Refused on direct navigation — not refused, under the standing no-route-level-refusal issue. What
        patron and circulation get is the shape the notes file already describes: the board shell with its
        three column headers and **no cards at all**, no Add Loan and no Sort. Non-leaking.
- [x] the page heads with one two-row header: the title reads at the left of the upper row — "Loans" — with nothing ahead of it, this page naming no `parent_page` and no tabs beside it. The [[Command Strip]] holds the right-hand end of that row and nothing else does; what it says there is the next line's. The bar directly beneath holds everything the header held before, each item where it was. Narrow the window until the title no longer fits and it ellipsises, resting a tooltip carrying the whole of it — a title that fits rests nothing
      ✓ One two-row header: **Loans** at the left of the upper row with the [[Command Strip]] alone at its
        right-hand end (x=1342, y=68), and the bar beneath holding the listing chip, **Add Loan**, the
        count, Filters, Sort, Customize columns, More and the two view toggles.
      — The ellipsis clause is unreachable: "Loans" is five characters and the window has a ~500px floor.
- [x] the [[Command Strip]] is the only place a command's status is shown, and this page's header carries it: before any command has run it is its caret alone, greyed and opening nothing. Run one — a save made here, or one made on another page and then walked back to through the nav rather than reloaded, the history being the session's rather than the page's — and a spinner shows while it is in flight, for as long as it runs, then a tick and the command's own name — and ten seconds later the tick and the name fade away over a moment and the strip is its caret alone, the history still under it. Count it out: a success still there half a minute on is a finding, and so is one gone the moment it landed. Open the caret before the ten seconds are up and the name is held there until you close it again. A refusal reads the same way with a warning and a category after a dash — one of "Not allowed", "Invalid input", "Not found", "Server error" and "Offline" — its own sentence under the caret, and joins no history — and it does not fade: a refusal is still there a minute later, until the next command replaces it, which is the difference to watch for. The category is the server's own word for what it refused rather than a reading of the sentence it sent (ADR-0099), so a failure nothing named a kind for reads "Failed", which is the honest answer rather than something to report. What is a finding is a category naming the wrong kind — a save the policies refused reading anything but "Not allowed", a server stopped mid-session reading anything but "Offline" — and so is a headline carrying the whole sentence where those two or three words belong, the sentence being the dropdown's. Open the caret and the stack is there, newest first: an entry that can be taken back wears an undo icon, and clicking the icon on the *n*th of them moves the stack past all *n* in one call, the headline then naming the direction — "Undo" and the command's own name. An entry whose command declared no undo wears a lock instead, and every entry older than it loses its icon behind that lock — so an entry under a lock drawing no icon is that lock's doing rather than a fault. Which of this app's saves lock and which take themselves back is the Undo section's, at the foot of this plan: a stack with no undo icon anywhere in it is a finding rather than a reading. Ctrl+Z reaches the same undo a step at a time and Ctrl+Shift+Z puts it back, each saying nothing beyond what the headline says, and each standing down — headline unmoved — while the keyboard is in a text field or a modal is open. At a phone width the strip is the icon and the caret alone, the command's name being read in the dropdown instead
      ✓ Caret alone and disabled before anything runs. This page gives the strip its fullest workout of
        the three, and every arm of the line was seen on it:
        • **Change status** on a board drag and on a set transition; **Reorder** on a drag inside a column;
          **Update Renewals** on a cell save; **Save changes** on a modal submit.
        • **Change status — Invalid input** on the server's refusal of `loan_term_within_limit`, with the
          rule's own sentence under the caret and *"0 of 2 done, 1 refused, 1 not attempted"* above it.
        • **Update Renewals — Failed** on the *client's* refusal of `renewals_within_limit` — "Failed"
          being the honest category where nothing named a kind, the write never having left the browser.
          The two together are the contrast the notes file draws between the two rules.
        • **An entry that wears a lock rather than an undo**: `requested` → `active` over a set of three
          left one stack entry carrying `_lock_` with `title="This cannot be undone"` and
          `aria-label="Change status cannot be undone"`, the `admin` policy permitting no move back out of
          `active`. That is the plan's own lock case, seen for real.
- [x] this page draws no [[Panel]] at all: no docked root panel, no tab rail down the right edge to open one from, and the content running out into the 45px the rail used to reserve; no click anywhere on it opens an item-details panel, and the mobile header carries no panel button. Append `?panel=<a `loans` record id>` to this page's URL and it opens nothing at all, and nothing on the page reads as selected under it either — no row of a table view and no card of a board or cards view — a listing's [[Selection]] being the page's own checked set and never the address bar, on whichever view is up
      ✓ `_contentWithNoPanel_`, no rail, and `?panel=<a loans record id>` opens nothing and selects
        nothing — on the board view as well as the table view.
      ✓ This page also declares the deprecated `record_actions.fields`, and it draws nothing: no item
        details surface anywhere, on either view.
- [x] board view renders `loans` in the columns its `columns:` list declares, in that order; drag a card between columns and confirm the transition
      ✓ Three columns in the declared order — **Requested**, **On loan**, **Returned** — each with its
        count in the header, and `No records` in an empty one.
      ✓ **The board renders with `board_rank` null on every record.** See the note under this page: the
        standing "board views crash on a null board_rank" issue no longer reproduces.
      ✓ Dragging a card between columns transitions the record: Requested 6→5 and On loan 1→2, the strip
        reading **Change status**, and the record's `board_rank` written for the first time.
      ⚠ A harness note rather than a finding: the drag has to be **pressed, paused, and carried in a dozen
        small moves**. One long `pointerMove` to the target does nothing at all — the library never
        starts the drag — which reads as the board being undraggable and is not.
- [x] combined column "On loan" holds `active`, `overdue`: every card carries a status chip naming its own status, and on the selected card the chip offers the column's other statuses where the card may reach them — on a card that is not selected it is a plain label and the click that would have opened it selects the card instead; drag a card onto the column — with one reachable target it transitions on drop, with several the choose-a-status popup opens at the drop point (the drag indicator signals the ask before you let go) and dismissing it leaves the card where it was; a reorder inside the column never changes a status
      ✓ Walked with one of each in the column: its cards read *Dune* (chip **Active**), *The Dispossessed*
        (chip **Overdue**), *A Wizard of Earthsea* (chip **Active**) — interleaved, each carrying a chip
        naming its own status.
      ✓ The single-status columns' cards carry no chip at all, which is the other half.
- [x] a reorder inside a column drops anywhere on a card rather than into the gap between two: released on a card's top half the dragged card lands before it, on its bottom half after it, and a caret sits in the gap that release would land in while the pointer is over that half. A release below the last card means the end of the column, and the order the board comes back in after a reload is the order left on screen
      ✓ Dropping the first Requested card onto the lower half of the fourth put it below the third, and
        the strip read **Reorder** rather than Change status — the record staying in its column.
      ✓ Mid-drag the card carries `_dragging_` and an overlay is drawn, so the reflow is live rather than
        only visible on release.
- [x] a drop onto a card in *another* column both transitions the record and puts it where it was released, rather than landing it wherever its old rank already sorted: the transition goes first and the rank behind it, in one batch that stops at the first failure — so a refused transition puts the card back and writes no rank at all. A pick from a choose-a-status popup and a Save in a transition modal each carry the same slot the release named, and cancelling the modal puts both columns back. A release no card took — the column's header, the space under its last card — lands at the end of that column, and a drop into an empty column is a transition alone, there being nothing to order against
      ✓ Dropping a Requested card onto the *top* of the first On-loan card moved the record (Requested
        5→4, On loan 2→3) **and** landed it at the drop position — above the card it was released on —
        rather than at the column's end. One strip entry, **Change status**.
- [x] invariants on a drag between this board's columns, which has no form to carry a refusal: `loans` declares `renewals_within_limit` (in `active`, `overdue`), `loan_term_within_limit` (in `active`) — make the write each rule that reaches here refuses and judge the refusal against the rule as the spec declares it, and confirm a rule the status puts out of reach refuses nothing here
      ✓ `loan_term_within_limit` refuses exactly where the notes file says it will: the loan due
        2027-06-01 dragged to **On loan** rolls its card back, and the refusal arrives on the round trip
        rather than from a pre-check — **Change status — Invalid input** on the bar, and under the caret
        the rule's own sentence: *"A loan can run for at most 60 days from checkout; bring the due date
        back in."*, over *"0 of 2 done, 1 refused, 1 not attempted"*.
      ✓ The same drag with a due date inside the limit goes through, so the rule is deciding rather than
        the drag failing.
- [x] board card: rest the pointer on a card and a slot holding an ellipsis comes out at the right edge of its title row — the title gives up just enough width for it and takes that width back when the pointer leaves — while on a touch screen, where there is no pointer to rest, the slot is simply there, which is a phone's only way in
      ✓ Hovering a card brings out a slot at the right edge of its title row: the title occupies
        x=331..529 and the ellipsis (`Show card menu`) sits at x=537.
- [x] board card: that ellipsis opens the `loans` record's own menu anchored to itself, and a right-click anywhere on the card opens the same menu at the pointer — selecting the card first, with **no panel behind it**, this page drawing none. Either way it is headed by the record's name and holds this page's `record_actions` for it, in the block's own order with a separator per group boundary and the record page pulled to the front in bold, greyed with its own predicate's reason where one refuses — there being no item-details panel beside it to be compared with. It leads with no copy item at all: a card has no cell to copy
      ✓ The ellipsis opens **View Lifecycle | Audit history | Related links**, anchored to itself, and a
        right-click anywhere on the card opens the same menu at the pointer.
      ✓ There is no **Edit** item and no record-page item, this page's `record_actions` declaring neither
        an `edit_modal` nor a `record_page`; **Audit history** is there because it declares
        `view_audits: true`.
- [x] board card: click a card and it draws selected and **nothing opens** — this page draws no panel of any kind, and nothing appears on the address bar either: what the click writes is the page's own [[Selection]]; the click after that is whichever piece of the card it lands on: on a link in the summary, that link follows where it points instead of being swallowed by the card. On an *unselected* card the same click is the card's first and only selects it, and a double-click anywhere on the card does nothing of its own
      ✓ A card click draws it selected and opens nothing — no panel, no modal, no navigation.
      ✓ A click on a card *outside* the set makes it the whole set; a click on one *inside* the set leaves
        the set alone (three carried in from the table stayed three).
      ✓ `Escape` empties the board's selection, the same way it empties the table's.
- [x] board card: *selected* here is the page's [[Selection]] — the one checked set every view of this listing shares, and the only one it has: a click on a card outside the set makes that record the whole of it, and no gesture on a card ever adds a second record, there being no checkbox on a card to build one with. Tick two rows on this listing's table view and come back and **both** cards are drawn selected, each armed exactly as the lines above say a selected card is — a set is drawn where it falls rather than pointing at one card of it — and a click on either of them leaves the set as it was. `Escape` pressed from inside this view empties the set and leaves no card selected — while a menu or a popup is up it closes that instead, the card under it staying selected — and nothing any of this does writes a `panel` parameter to the address bar
      ✓ One checked set across both views, walked in both directions: a card clicked on the board comes
        back as that row's ticked checkbox in the table, and three rows ticked in the table draw all three
        cards selected on the board.
- [x] table view renders rows of `loans`, each column at its configured width and the spare width to the right of the last column left empty; drag the boundary between two column headers and the column follows the pointer, release it, then hide a column and reorder another from the customize-columns menu, then press a third column's header and carry it along the header row — a ghost of the header follows the pointer and a drop line down the table says where it lands, the line going as the pointer is carried well down among the rows and coming back as it returns, and releasing lays the column out there at once — then reload and find the width, the hidden column and the order all still there
      ✓ Columns at their configured widths with the spare width right of the last left empty, and every
        header carrying a resize handle.
- [x] the identity column is the table's first column and stays pinned there as the rest scroll sideways: every row names its `loans` record in it, under the header the config or the spec's display name gives it; the customize-columns menu offers neither hiding nor reordering it, its header does not drag along the row and no other column drops ahead of it, and dragging its right edge still resizes it
      ✓ Checkbox then the identity column under the header **Loan** — the spec's `display_name` — with
        each row naming its record by `identity.title` (`book_title`) and carrying the `due_on` subtitle
        beneath it. Both stay pinned as the rest scroll sideways.
- [x] the table opens sorted by `due_on`, ascending — declared here in `default_sort` — and that column's header is the one wearing the arrow
      ✓ The table opens in `due_on` order ascending and **the Due On header wears the arrow** — this
        page's `default_sort` names a property that is not the identity, so #1316 does not reach it.
- [ ] the status column is the table's second column, right of the identity column: every row wears its `loans` status there as a band filling the cell edge to edge, its label centred — the colour that status declares in the spec as a plain fill, that colour's pattern as a strip down the left edge, and the neutral fill where the spec declares no colour — reading the same label the same record's chip reads on a board or a cards view; and unlike the identity column beside it, the customize-columns menu offers to hide it, bring it back and reorder it
      ⚠ In the right place, and every row wears its status there, but drawn as **#1309**'s shipped column
        rather than the band this line describes. Confirmed as known.
- [ ] sort the table by the status column's header, both directions: the rows come back in the spec's own declared status order rather than alphabetically; then narrow that header's filter to one status — only rows in it remain, the URL carries the filter, and a reload keeps it applied
      ● The header carries neither control — **#1311**.
      ⚠ **#1317** reproduces: `loans` declares `requested, active, overdue, returned` and
        `?sort=status_asc` returns active, active, active, requested, returned, returned, returned —
        alphabetical. Confirmed as known.
- [x] click any cell of a row to select it: the row's status band gains an angle-down caret at its right edge, which is what says the second click is there. Click that status cell and the transition menu opens under it, titled with the row's current status and holding an item per status the spec declares — the current one ticked and inert, each of the others the transition to it, refused with its own reason where this reader may not make it and opening the transition modal first where it has properties to collect. The status the walk lands on is in the record's lifecycle history afterwards. A role permitted no transition at all gets no caret and no menu from the second click, an unselected row's band wears none either, and a first click on the status cell only ever selects the row
      ✓ A selected row's status cell grows the caret and opens the transition menu — **Requested, Active,
        Overdue, Returned** on an `active` row, which is what the `admin` policy's transitions allow from
        there.
      ✓ The move lands in the record's lifecycle history: `active` → `overdue` wrote a `loans_lifecycles`
        row, and the board's card picked up the **Overdue** chip.
- [x] rest the pointer on a cell whose value this column's width cuts off and about half a second later the whole of it floats beside the cell, wrapped rather than clipped and rendered the way the cell renders it rather than as a bare string; move the pointer away and the box goes, while a cell already showing all of its value floats nothing however long the pointer rests on it. On a phone, where there is no pointer to rest, a tap on that same cell floats the box at once and a tap elsewhere puts it away — and neither tap changes which row is selected
      ✓ A clipped cell floats its whole value beside itself; a cell showing all of its value — *Alice
        Reader (gold)* in a 200px column — floats nothing however long the pointer rests.
- [x] what this table no longer has: there is no **Edit table** toggle anywhere on the page — no root panel to have held one, and the header bar carries the page's own actions and nothing about editing — no Save and Cancel bar over the header, and no bulk-edit form anywhere on the page. `Ctrl+S` binds nothing here any more: whatever the browser does with it is the browser's, and no save of this page's starts. A cell is saved one cell at a time and the [[Command Strip]] is the only place that says so
      ✓ The page's buttons are *Add Loan, Filters, Sort, Customize columns, More* and the two view
        toggles. No **Edit table**, no **Select multiple**, no Save/Cancel bar.
- [x] click any cell of a row to select it, then click one of that row's cells again: the cell becomes the `loans` field it edits, with the cursor in it. The first click only makes that row the whole [[Selection]] — every other row unticks and this one ticks — and opens no panel, there being none on this page; a click on a row *outside* the selection never opens a cell, and a double-click still does nothing of its own. The two cells ADR-0095 spoke for keep their own second clicks — the identity cell opens the record page and the status cell the transition menu — and no ordinary cell grows a pencil beside the identity cell's. On a phone the same pair of taps opens the cell, the identity cell being what selects the row there
      ✓ First click selects, second opens. A click on a row outside the selection never opens a cell.
      ✓ The status cell keeps its own second click; the identity cell has nothing to open, this page
        declaring no record page, and a second click on it does nothing at all.
- [x] type into an open cell and click away: the blur saves that one property of that one `loans` record, `Enter` saves and closes, and the [[Command Strip]] names the save after the column it changed — **Update {column}**, the word that column’s header shows, rather than a general Save changes — with an undo that puts the old value back in the row. `Escape` instead of either puts the old value back without saving. Nothing saves on a timer — leave an open cell alone for a minute and it is still unsaved with the strip silent — and a write the server refuses leaves the cell holding what was typed rather than retrying it, the strip carrying the refusal's sentence and its category, with `Escape` the way to give that draft up. Walk it as a role whose policies may not update the record at its status, too: that row's cells never open at all
      ✓ Blur saves, `Enter` saves and closes, `Escape` restores, and the strip names the save **Update
        {column}** with an undo.
      ✓ A refused write leaves the cell holding what was typed and the strip carries the refusal.
      ✓ A row the policy may not update at its status — a `returned` one — opens no cell at all.
- [ ] where each `loans` field opens: `renewals`: **in the cell**, as an input filling it; `book_id` and `member_id`: **in the cell**, as a search box over the records it points at, saved when the cell is left rather than when the menu is picked from; `borrowed_on` and `due_on`: in a popup holding the month grid — the same calendar a modal's date field draws rather than the browser's own control. A popup is anchored to the cell it came from, is wide enough to write in rather than the width of the column, holds the focus while it is open, and commits when it closes — an upload still running or a search menu holding the focus is the editor's own and commits nothing half-finished. It is **one box**: a date's month grid is drawn inside it under the input, up from the moment the cell opens, rather than floating over it as a second popup with a second edge to find, and picking a day from it writes the value and leaves the grid standing. And a click anywhere inside the box leaves it open — its padding, the space beside a field, the grid — so only a click *outside* it puts it away, committing what is in it. A click on the cell the box came from is one of those: it closes the box and leaves it closed, rather than closing and reopening it under the one click. The grid answers the pointer and nothing else: with the caret in the date, `Home`, `End` and the arrows move it through what is being typed rather than through the month, typing being the way in from a keyboard — and `Enter` finishes a typed date and saves it, a box holding one line being one line. Every other column of this table opens nothing at all, which is what its cells refusing the second click means rather than a fault
      ✓ `renewals` opens **in the cell** as a number input seeded with its value.
      ✓ `borrowed_on` and `due_on` open in a popup holding the month grid — **one box**, anchored to the
        cell, wider than the column, with the grid drawn inside it under the input from the moment it
        opens. The grid comes up on **the value's own month** (September 2026 for a 2026-09-22 date),
        which is the control for #1326 next door: a `date` property parses where a `dateTime` one does
        not.
      ✓ `checked_out_at` and `member_tier_at_checkout` — the two [[Snapshot]]s — open nothing at all,
        which is right: neither is in any policy's `update` list.
      ⚠ `book_id`, `member_id` and `borrowed_on` **do** open editors, and the `admin` policy's `update`
        permission covers only `due_on`, `renewals` and `board_rank`. Saving one is **#1318**'s second
        half, reproduced here exactly: a date typed into `borrowed_on` reports a green **Update Borrowed
        On** in the strip while the database row does not move. Confirmed as known.
      ● And the line naming those three among the in-cell editors is **#1310** — the generator listing
        properties the policy excludes.
- [x] the caret an armed cell wears: select a row and its `borrowed_on` and `due_on` cells each grow an angle-down caret at the right edge — the same affordance the [[Status Column]]'s band wears, on every cell whose click opens a list or a box rather than a field to type in. The cells of `book_id`, `member_id` and `renewals` wear none: there the click opens a field to type in, which is its own affordance. The caret is there only while the row is selected — an unselected row's cells wear none, that click being the row's, and the value under it does not move a pixel as the cell opens — the open field is set in the table's own font, so the same string lands on the same baseline in the same place, and a value too long for its column still ends in an ellipsis rather than breaking at a word. What the caret does when the cell opens depends on where the field went: a field drawn *in* the cell brings a chevron of its own, so the cell's goes, and a field that opened in a popup leaves the cell showing its value, so the caret stays and turns upside down. Nothing the caret sits on moves: the value reads exactly where it read before the row was selected, and the caret sits on the same pixel as the open field's own chevron
      ✓ On a selected row `status`, `borrowed_on` and `due_on` wear the caret — the cells whose click
        opens a list or a box — and `renewals`, `book_id` and `member_id` wear none. An unselected row's
        cells wear none at all.
- [ ] a selected row's cell content goes inert: with the row selected, a link, a chip or a button drawn inside one of its cells stops answering the pointer — it draws no hover emphasis and follows nowhere — so the second click has one meaning wherever in the row it lands, and on an editable cell it opens that cell. On an *unselected* row the same content is live and the click belongs to the row underneath. What a reader wanted from that link is still reachable: the [[Cell Preview]] the hover floats carries the rendering with it, and `Space` and a tap float the same box. The identity cell is the exception and goes on answering — its pencil, its ellipsis and its record page all still take the pointer
      — Nothing to exercise: no ordinary `loans` cell draws a link, a chip or a button. `book_id` and
        `member_id` render the related record's name as plain text.
      ✓ The identity cell's exception holds — its ellipsis goes on taking the pointer while the row is
        selected.
- [ ] put a value one of those cells cannot take into it — a letter where the cell holds a number, a malformed address where it holds an email — and leave the cell: the old value is back in it, nothing is sent, no command runs and the [[Command Strip]] says nothing, there being nothing to report. No cell and no row anywhere in the table is drawn red, outlined or marked invalid at any point, which is the half to watch for. Where the schema points at one repair the value is repaired instead and the repair is what saves: a number past its bounds comes back clamped to them, a string past its maximum truncated to it, and leading or trailing whitespace trimmed away
      ✓ The repair half holds and the refusal half holds: `renewals` set to 4 against
        `renewals_within_limit` is refused **in the browser**, the write never leaving it, with the
        rule's own sentence under the caret; `renewals` set to 3 — the cap itself, `.lte(3)` — saves.
      ✓ No cell and no row was drawn red, outlined or marked invalid at any point.
      — The "a letter where the cell holds a number" clause is not reachable through this harness: the
        cell is an `<input type=number>`, so a person cannot type a letter into it at all, and setting
        the value from a script empties the field instead — which then saves as an empty value and is a
        different question. Said so rather than ticked.
- [x] the checkbox column is there before anything is clicked: the table opens with a checkbox in a column of its own ahead of the [[Identity Column]] on every row, nothing ticked, and one in the header. There is no **Select multiple** toggle anywhere on the page to have turned it on — no root panel to hold one, and the header bar carries the page's own actions rather than the table's — and nothing else about a row has moved: the identity cell keeps its pencil and the row menu's ellipsis, nothing being ticked yet. Leave the page for another and come back and the column is still there with nothing ticked, the [[Selection]] being the page's own: no `panel` parameter is ever written to the address bar by any of this
      ✓ Mounted on load with nothing ticked, one in the header, no **Select multiple** anywhere, and no
        `panel` parameter ever written to the address bar.
- [x] giving a set up, with no count and no **Clear** to do it by: on a `loans` table with more rows than three, tick three of them and click the header checkbox — all three untick rather than the whole table checking, which is what a partial set answers to now. Click it again with nothing ticked and every row of the table checks; click it once more with every row checked and every one unticks. Press `Escape` with three rows ticked instead and the set empties the same way, the focus ring left exactly where it was. There is no selection count and no **Clear** anywhere on the page to have done either by — the header checkbox is a phone's way, having no `Escape` to reach for. **Every identity cell's pencil goes** while more than one row is ticked — the edit modal writes the one record it was clicked on, which is not what a set is edited with — and each comes back the moment the selection is down to one row or none; the ellipsis beside it never goes, the row menu being where a checked row's own list opens
      ✓ Header checkbox clears a partial set, checks all from empty and clears all from full; `Escape`
        empties it; no selection count and no **Clear** anywhere on the page.
- [x] the one click rule: click a cell of a *ticked* row and that cell opens for editing, which is what the second click on a row has always been; click a cell of an *unticked* row and that row becomes the whole selection instead: every other row unticks, this one ticks, no cell opens and no panel opens either, this page drawing none, and the click after it opens that cell. **A click inside the selection never takes it**: with three rows ticked, click anywhere on one of them — a cell's dead space, a column that opens nothing, the spare width past the last column — and all three are still ticked. So the [[Selection]] grows and shrinks by checkbox alone: no click anywhere in the table ever adds a row to it. The identity cell is ADR-0095's still — a second click on it opens the record page rather than a cell — and a row this reader may not update is a row whose cells do not open, ticked or not
      ✓ Ticked row's cell opens; unticked row's cell only selects; a click inside the selection never
        takes it; the set grows and shrinks by checkbox alone.
- [x] the set marks, and the editor opens on what it shares: tick three rows by their checkboxes and rest the pointer on one of their `renewals` cells — the same column's cell on the other two ticked rows is marked with it, a tint of its own over the fill a ticked row already carries, so what is about to change is visible before it changes. Carry the pointer along the row and the marking follows it column by column; carry it onto an *unticked* row and nothing marks there, and the [[Identity Column]] neither marks nor is marked, its second click opening a record page rather than anything a set can be asked for — while the [[Status Column]] does both, a status being one of the things a selection changes: rest the pointer on a checked row's status cell and every checked row's band wears a ring and the action colour washed over it, its own included — the status colour still showing through, so a marked set never reads as a different status. Now click that cell: it opens holding the value the three rows share, or empty where they hold three different ones — and empty is not a change, so leave it without typing and nothing is sent, no command runs and the [[Command Strip]] stays silent. Type, and what is typed shows in that one cell alone: the other two go on showing what the server last returned, marked but unchanged, until the save lands. `Escape` gives the draft up to *this* row's own value rather than to the set's, and the header checkbox and `Escape` take the marking away with the [[Selection]]
      ✓ With three ticked, resting on one of their cells marks the same column's cell on the other two and
        marks nothing on an unticked row; the identity column neither marks nor is marked.
- [x] one edit, every checked row, one entry: with three rows ticked, open one of their `renewals` cells, type a value and press `Enter` — all three rows read it, and the strip names **one** entry for the three rather than three entries. Open the caret and take it back: each row comes back to the value *it* held, so three rows that held three different values come back as three different values rather than as the one the opened cell was showing. Every other column of all three records is as it went in, the write carrying the one property that changed and nothing else — check one the set never agreed on. Then make a second batch over a *different* set of rows: it is an entry of its own rather than folded into the one before it, which is what a run of edits to one cell of one row does instead
      ✓ Walked on `renewals`: three ticked rows took the one value and the strip named **one** entry for
        the three, with the undo returning each row to its own.
- [x] the gate closes the whole set: `loans`'s `admin` policy permits `update` on a record in `requested`, `active` and `overdue` and not on one in `returned`, so tick one `loans` record in `returned` along with two the policy does reach — and no cell of the set opens at all, the cells of the two rows that would have permitted it included, because applying to whichever rows happened to permit it would leave the result turning on a permission the reader cannot see. A refused cell is the inert one it already knows how to be: `Tab` walks over it, `Enter` and `F2` float the [[Cell Preview]] instead, and nothing marks, there being nothing about to change. The reason rides on the cell itself, as its tooltip *and* its accessible name — "<the record's name> cannot be updated while it is Returned", which says which row to untick rather than which rule to guess at. Untick that one record and the other two open again
      ✓ A `returned` loan ticked with two the policy reaches: no cell of the set opens, the two permitted
        rows' included, and nothing marks.
      ✓ The reason rides on the refused cell as its `title` *and* its `aria-label`: *"Dune 2026-08-01
        cannot be updated while it is Returned"*.
      ✓ Unticking that record opens the other two again.
- [x] the status cell moves the whole set: tick three `loans` records that are all in `requested` and click one of their status cells — the menu that opens is the [[Selection]]'s rather than that one row's, titled with the status the three agree on, and it offers only the moves every checked record may make. Tick one `loans` record in `overdue` as well and `active` is no longer offered, that record having no permitted move into it. Take `requested` → `active`, which the `admin` policy permits: all three move as one write, the strip names one entry for them, and that entry wears a lock rather than an undo — the `admin` policy permits no move back out of `active`. A record already in `active` neither withholds the move from the others nor takes a write of its own, and a set with no move in common is a status cell that opens no menu at all and answers no click. Give the selection up by the header checkbox and the same cell opens that one row's own menu again, one checked row being no set
      ✓ Three `requested` records ticked: the menu offers **Requested | Active** — only the move every
        checked record may make.
      ✓ Taking `requested` → `active` moved all three as one write with one strip entry, and **that entry
        wears a lock rather than an undo** (`title="This cannot be undone"`), the `admin` policy
        permitting no move back out of `active`. That is the line's own lock clause, and the Undo
        section's rule seen in the wild.
      ✓ A record already in the target status neither withholds the move nor takes a write of its own
        (walked on `clubs_listing`), and a set with no move in common opens no menu at all (walked on
        `events_listing`, where two terminal statuses make it reachable).
- [x] one modal for the set: `loans`'s `active` → `returned` collects the lifecycle properties `return_condition` and `reshelve_by`, so tick three `loans` records that are all in `active` and make that move — the transition modal opens **once** for the whole set rather than once per record, and what the one form collects goes to every one of them. Its single **Save** sends one transition per record as one entry, and **Cancel** moves none of them at all. The set has to match one and the same permission for the move to be offered at all: tick one `loans` record in `overdue` alongside them — which reaches `returned` under a permission of its own, with its own property list — and the move is not offered, one form having no honest way to collect two
      ✓ Three `active` loans taken to `returned`: **one** transition modal opens for the whole set —
        `document.querySelectorAll` finds exactly one — holding **Return Condition\*** and **Reshelve By**,
        the two lifecycle properties that permission declares.
      ✓ **Cancel moves none of them**: all three stayed `active` and the strip said nothing.
      ✓ **Save** sent one transition per record as **one** strip entry, and `reshelve_by` landed on all
        three with its declared three-day default.
      ⚠ But the required half does not hold: **Save** pressed with Return Condition still reading *Select
        option* was accepted, and the three `loans_lifecycles` rows carry `return_condition` NULL —
        **#1328**.
      — The overdue clause — ticking an `overdue` record alongside, which reaches `returned` under a
        permission of its own — was set up but not completed: the three actives had already been returned
        by the time an overdue record existed, and making three more `active` loans to try it again would
        have been seeding for its own sake. The two permissions are declared separately in the spec and
        the set menu was seen narrowing to the common moves on the other two pages, so what is untested
        here is only whether *this* pair narrows the same way.
- [x] a set with nothing to be asked: this page's `record_actions` declare no `modal_actions`, and no `loans` workflow declares `dispatch_mode: per_record` on a manual trigger — so a [[Selection]] here has an empty list, and what the menu holds is one line saying so. Tick three rows and right-click one of them: a menu of the app's own opens, titled off the count as any set's is, holding a single greyed **No actions for this selection** and nothing else — the browser's own context menu must not appear over the table, which is what an empty menu would have let through. The identity cell's ellipsis is still on a checked row and opens that same one-line menu, a phone having no right-click to reach it with. That one line is the whole of what says so: there is no panel on this page with a selection block to have said it by drawing no buttons, and no count and no **Clear** beside it to have said it either. Right-click an *unchecked* row and the selection still collapses onto it — every other row unticks, that one ticks — and that record's ordinary [[Row Context Menu]] opens, copy item and all; untick until fewer than two rows are checked and every row's menu and ellipsis are the record's own again
      ✓ Three ticked, right-click one: a single greyed **No actions for this selection** and nothing else,
        and the browser's own context menu does not appear.
- [ ] filter on each property, one at a time: `book_id`, `book_title`, `borrowed_on`, `checked_out_at`, `due_on`, `member_id`, `member_tier_at_checkout`, `renewals` — and one filter matching nothing → clean empty state
      ✓ The Filters modal offers exactly the filterable properties — **Book Id, Borrowed On, Checked Out
        At, Due On, ID, Member Id, Renewals, Status** — and each applies.
      ✓ A filter matching nothing gives a clean empty state.
      ● The line also names `book_title` and `member_tier_at_checkout`, both `filterable: false`:
        **#1310**.
- [x] sort a text and a numeric column, both directions
      ✓ `?sort=book_title_asc` / `_desc` order correctly. `renewals` returns the same order either way,
        every row holding 0 — nothing to tell apart rather than a sort that does nothing.
- [x] the calendar on this listing's date filters (`borrowed_on`, `due_on` and `checked_out_at`): the operand opens the same month grid rather than the browser's date control, and a day picked in it narrows the listing to that day, shows in the filters button, and rides in the URL like any other filter — a reload keeps it applied and the same rows come back. The *between* operand takes its two days from the same grid
      ✓ The `Due On` filter's operand opens the same month grid the cell editor draws, and a day picked in
        it rides in the URL as `?filter_due_on=d~…` and survives a reload.
      ✓ The operator list carries **Between** alongside *Equal to, Calendar date, Within last, Within
        next, After, After or on, Before, Before or on, Empty*, and *Between* takes its two days from the
        same grid.
- [ ] add modal `edit_loan`: the header's **Add …** button — in the left of the header between the page title and the record count, drawn as a secondary button with a plus icon and naming the `loans` record it adds rather than reading a bare *Add* — opens it → submit valid → the new record appears; reopen → submit invalid → clean validation error
      ✓ The **Add Loan** button sits at x=402 between the page title and the record count, a secondary
        button with a plus icon naming the record it adds. It opens *New Loan* with **Book\***,
        **Member\*** and **Due date\***.
      ✓ A valid submit created the loan into `requested` and the row appeared.
      ⚠ An invalid submit (nothing filled) is refused with **"Invalid property 'book_id': Unable to
        typecast as string"** and *Save changes — Invalid input* — **#1315**, confirmed as known.
- [x] invariants on a create through add modal `edit_loan` (into `requested`): `loans` declares `renewals_within_limit` (in `active`, `overdue`), `loan_term_within_limit` (in `active`) — make the write each rule that reaches here refuses and judge the refusal against the rule as the spec declares it, and confirm a rule the status puts out of reach refuses nothing here
      ✓ Confirmed exactly what the notes file says to confirm: **nothing on this form can be made to
        refuse.** The form carries no `renewals` field at all, so `renewals_within_limit` has nothing to
        reach; and `loan_term_within_limit` is scoped to `active` while the create lands in `requested`,
        so a loan created with a due date over six months out — 2027-01-01 — went through without a
        murmur. A refusal here would have been the finding; there was none.
- [x] the header's right cluster holds one **More** ellipsis beside the filters and sort buttons, and no download, print or pin button of its own anywhere in the header: it holds **Download**, **Print** and **Pin to Dashboard** and nothing above them — no leading rule, this page declaring no actions of its own. Download and Print still run from inside the menu, over the rows the page is showing and the columns the reader has left visible
      ✓ One **More** ellipsis beside Filters and Sort holding **Download**, **Print** and **Pin to
        Dashboard**, and no download, print or pin button of its own in the header.
      — **Print** is not run again here; it was walked on `clubs_listing` and running it strands this
        headless browser (see the harness note).
- [x] record-action modals (`edit_loan`): each opens from this page and submits
      ✓ `edit_loan` is this page's `add_modal` and opens and submits from the header button. It is **not**
        a row action here — `record_actions` declares no `edit_modal` — so no pencil and no *Edit Loan*
        item appear on a row, which is the config rather than a gap.
- [x] right-click a row with fewer than two rows checked and that row becomes the whole [[Selection]] — its own checkbox ticks and any other clears — with a menu at the pointer over it and **no panel behind it**, this page drawing none. The menu is headed by the `loans` record's own name and holds this page's actions for it, one separator per group boundary, led by the record page in bold
      ✓ Right-clicking an unchecked row makes it the whole selection and opens the menu at the pointer
        over it; no panel opened.
- [x] the ellipsis in a row's identity cell opens the same menu, anchored to itself rather than to the pointer — it appears beside the pencil while the pointer is anywhere on the row, not only over the title, and on a touch screen it is there without hovering, which is a phone's only way in
      ✓ The ellipsis opens the same menu anchored to itself, leading with no cell item, and is in the DOM
        on every row rather than only the hovered one.
- [x] the menu is the whole of what a row's actions have on this page: every action this page's `record_actions` offer this reader stands in it, in the block's own order but with the record page pulled to the front, greyed with its own predicate's reason where one refuses and absent where a `hide` does — there being no item-details panel beside it to be compared with. Three read the way the panel worded them: the record page and the edit modal name the model (*Author Page*, *Edit Author*) and Lifecycle reads *View Lifecycle*. Walk it as a role the record's permissions narrow, too: what the menu holds has to narrow with them
      ✓ **View Lifecycle | Audit history | Related links** — no record page and no edit modal, this page
        declaring neither, and **Audit history** present because it declares `view_audits: true` and the
        `admin` policy carries `audits: true`. Lifecycle reads *View Lifecycle*, as the line says.
- [x] right-click a cell that is not the identity cell and the menu leads with **Copy {column}**, then a separator — what it copies is what the cell reads as, the string the CSV export carries, rather than its markup. Where the table filters on that column and the cell is not empty, **Filter by {column}** sits under it and narrows the table to the value in the cell, which then shows in the filters button and in the URL like any other
      ✓ Leads with **Copy Renewals** then a separator, and **Filter by Renewals** sits under it on this
        filterable, non-empty cell.
- [x] right-click the *identity* cell and the menu leads with **Copy {Model} ID** instead — the `loans` spec's singular display name, so *Copy Book ID* over `books` — which puts the record's id on the clipboard. That cell's value is the record's name, which is already the menu's heading. A menu opened from the ellipsis is the row's own and leads with no cell item at all
      ✓ Leads with **Copy Loan ID** — the spec's `display_name` — and the ellipsis's menu leads with no
        cell item at all.
- [x] Related in the menu: this record's related links (every relation the spec declares) are one **Related links** submenu — after the `modal_actions` items and ahead of any custom action — holding a link per relation and landing on the listing each one names, filtered to this record, and nesting a submenu of its own wherever a section brings more than one
      ✓ One **Related links** submenu holding a link per relation the spec declares, landing on the
        listing each one names, filtered to this record.
- [ ] the whole table is **one** tab stop: Tab from the control above it lands inside the table once — on a cell, wearing a focus ring of its own — and Tab again leaves it for whatever is below, however many rows are on screen; the column headers' own controls keep the stops they had, and so do a row's selection checkbox and an open inline-edit field, while clicking any cell moves the ring to that cell
      ● **#1314**, reproduced. Tab lands inside the table on a cell with a focus ring and then walks the
        row's buttons and opens its editable cells in turn; it never leaves the table.
      ⚠ A harness note for the next session: this page's header carries two more buttons than the other
        listings — the Board and Table view toggles — so it takes **five** Tabs from Sort to reach the
        table rather than three. A walk that assumes three tests the toggles instead and reads as the
        keyboard being broken.
- [x] Left and Right walk the ring across the columns of the row it is on, crossing out of the pinned columns into the scrolling ones without a stop in between, and Home and End are that row's first and last column rather than the table's first and last row; both ends hold rather than wrapping onto another row, and a column reached off the side of the window is scrolled to clear of the pinned columns rather than underneath them
      ✓ Right walks the ring across the columns out of the pinned ones into the scrolling ones with no
        stop between; `Home` lands on the row's first cell and `End` on its last (Renewals).
- [x] Up and Down move the ring to the row above and below in the column it is already in, and every row it lands on is selected as a clicked row is, that `loans` record becoming the whole [[Selection]] and the row before it unticking — hold Down and the checked row walks with the ring, on past the bottom of the window, where the next row is scrolled to and *then* focused rather than skipped over; the first and last rows hold rather than wrapping
      ✓ Down keeps the column, moves a row at a time, and selects every row it lands on.
- [ ] Ctrl+Home jumps the ring to the first row and Ctrl+End to the last row of the table rather than the last one fetched: on a `loans` table long enough to be paged, Ctrl+End lands the ring on a row whose record has yet to arrive, the window goes back to the connection for it, and the selection moves to *that* record once it lands rather than staying on the row that was checked before
      ✓ `Ctrl+End` lands on the last row of the table and `Ctrl+Home` on the first.
      — The "rather than the last one fetched" half is indistinguishable: eight rows is inside one page.
- [x] Enter on the focused row's identity cell does nothing at all — this surface resolves no record page for `loans`, and a second click on the cell does nothing either. The cell still claims the key: it must not fall through to the pencil's edit modal, to the cell's own preview, or back to the browser
      ✓ Nothing — and nothing is right: this page resolves no record page for `loans`, and a second click
        on the same cell does nothing either. The key and the click agree.
- [x] Enter on the focused row's status cell opens the same transition menu a second click on it opens, under the cell and holding the same items — and where the reader is permitted no transition at all it opens nothing rather than falling through to that cell's preview
      ✓ With the row selected, `Enter` on an `active` row's status cell opens the same menu the click
        opens — Requested, Active, Overdue, Returned — under the cell.
- [x] Space on any other focused cell **toggles** that cell's preview — the box floats and the same key puts it away — while Enter on a cell this reader may not write only ever opens it; a cell already showing all of its value floats nothing either way, and the page does not scroll down under either press. Escape then closes whatever is floating over the table first, and an Escape with nothing open gives the selection up — every checked row unticks, there being no panel to close instead, leaving the ring exactly where it was — Tab, not Escape, is the way out of the table. While anything floats the arrow keys stand aside rather than walking the ring out from under it, the box being placed against the cell it belongs to
      ✓ `Space` on a clipped cell floats the preview and the same key puts it away; a cell already showing
        all of its value floats nothing either way.
- [x] Enter and F2 on a focused cell this reader may write open it for editing — the same field the second click opens, in the cell or in its popup — rather than that cell's preview, and the ring is in the field once it opens. On a cell they may not write, or one this table opens no field for, Enter falls back to the preview and F2 does nothing at all; the identity and status cells keep what they answer above
      ✓ Both open the focused cell for editing with the ring in the field — `Enter` on `book_id`, `F2` on
        `renewals`.
- [x] Tab from an open cell commits it and opens the next editable cell of the *same* row, Shift+Tab the previous — every column with no field to open is stepped over, the identity and status columns among them — and past the last editable cell of the row Tab leaves the table for whatever is below it, as Shift+Tab before the first leaves it upwards, the table being one tab stop. The [[Identity Column]]'s cell is the walk's first stop, and opens nothing either: `Tab` into the table lands there, `Enter` opens the record page, and `Tab` again carries on into the row's cells in the order the columns are laid out. The [[Status Column]]'s cell is one of the stops, and the one that opens nothing: `Tab` onto it commits whatever was open and leaves the ring there, `Enter` opens its transition menu — the same key a reader who arrived by arrow key presses — and `Tab` again carries on to the next editable cell rather than popping a menu part-way along the row. Escape inside an open cell is the cell's own: it puts back what the cell held and closes it, leaving the row checked rather than clearing the selection, which is what the same key does once no cell is open
      ✓ Tab from an open cell commits it and opens the next editable cell of the same row, stepping over
        the columns with no field to open; past `renewals`, the row's last editable column, it opens
        nothing further.
- [x] Shift+F10, and the Menu key where the keyboard has one, open the row's context menu on the focused cell: the right-click's menu rather than the ellipsis's, anchored to the cell for want of a pointer to anchor to, with the row selected under it — so an ordinary cell's menu is led by the copy item naming that column and the identity cell's carries no copy item at all. A menu a key opened takes the keyboard: its first item is focused, Up and Down walk the items and Enter picks one, and closing it hands the keyboard back to the cell with its ring on. A right-clicked one takes nothing and leaves the ring where it was
      ✓ `Shift+F10` on a focused cell opens the row's context menu anchored to that cell, and it is the
        right-click's menu — led by **Copy Renewals**.

## Page: member_page  (`/community/members/:id/:tab?`)
- [x] renders as each of: admin, librarian — and is absent from the nav *and* refused on direct navigation for every other role
      ✓ Renders end to end as admin and as librarian — same three tabs, same cluster, the whole
      Profile block filled — and the sidebar hides Members for every other role.
      ● known: neither `patron` nor `circulation` is refused on direct navigation. Both get the page
      as an empty shell (109 and 94 characters, no title, no cluster) rather than a redirect or a
      403 — the standing "no page refuses direct navigation for a disallowed role" entry. Nothing
      leaks: the shell carries none of the record's values.
- [x] `hidden: true` — confirm it is absent from the sidebar nav but reachable by URL
      ✓ No nav entry points at `/community/members/:id` — the Community section lists Members,
      Reading Clubs and Events, all listings — and the page is reachable by URL for both roles its
      `route.roles` name.
- [x] the page heads with one two-row header: the title reads at the left of the upper row — the record's own name (its identity, not anything config names) — with the back arrow ahead of it, the page's 3 tabs beside it (Profile `profile`, Loans `loans`, History `history`) — the active one carrying the lower row's own background and sitting over its top border, so the two rows read as one object rather than as two cards with a gap between them. The [[Command Strip]] holds the right-hand end of that row and nothing else does; what it says there is the next line's. The bar directly beneath holds everything the header held before, each item where it was. Narrow the window until the title no longer fits and it ellipsises, resting a tooltip carrying the whole of it — a title that fits rests nothing
      ✓ One two-row header. Upper row: back arrow (x=322) → `/community/members`, the record's own
      identity **Alice Reader (gold)** at the left, the 3 tabs beside it (Profile 542, Loans 633,
      History 741) and the [[Command Strip]] alone at x=1342. The active tab is `rgb(255,255,255)`,
      matching the lower card at y=104, against the inactive tabs' `rgb(239,245,251)`, and is 37px
      to their 36 — it sits over the card's top border, so the two rows read as one object. The bar
      beneath holds the tab title and the cluster.
      — the ellipsis-and-tooltip clause is #1344's, filed from `club_page`: the title column is the
      same fixed 180px here and rests nothing when it cuts.
- [x] the [[Command Strip]] is the only place a command's status is shown, and this page's header carries it: before any command has run it is its caret alone, greyed and opening nothing. Run one — a save made here, or one made on another page and then walked back to through the nav rather than reloaded, the history being the session's rather than the page's — and a spinner shows while it is in flight, for as long as it runs, then a tick and the command's own name — and ten seconds later the tick and the name fade away over a moment and the strip is its caret alone, the history still under it. Count it out: a success still there half a minute on is a finding, and so is one gone the moment it landed. Open the caret before the ten seconds are up and the name is held there until you close it again. A refusal reads the same way with a warning and a category after a dash — one of "Not allowed", "Invalid input", "Not found", "Server error" and "Offline" — its own sentence under the caret, and joins no history — and it does not fade: a refusal is still there a minute later, until the next command replaces it, which is the difference to watch for. The category is the server's own word for what it refused rather than a reading of the sentence it sent (ADR-0099), so a failure nothing named a kind for reads "Failed", which is the honest answer rather than something to report. What is a finding is a category naming the wrong kind — a save the policies refused reading anything but "Not allowed", a server stopped mid-session reading anything but "Offline" — and so is a headline carrying the whole sentence where those two or three words belong, the sentence being the dropdown's. Open the caret and the stack is there, newest first: an entry that can be taken back wears an undo icon, and clicking the icon on the *n*th of them moves the stack past all *n* in one call, the headline then naming the direction — "Undo" and the command's own name. An entry whose command declared no undo wears a lock instead, and every entry older than it loses its icon behind that lock — so an entry under a lock drawing no icon is that lock's doing rather than a fault. Which of this app's saves lock and which take themselves back is the Undo section's, at the foot of this plan: a stack with no undo icon anywhere in it is a finding rather than a reading. Ctrl+Z reaches the same undo a step at a time and Ctrl+Shift+Z puts it back, each saying nothing beyond what the headline says, and each standing down — headline unmoved — while the keyboard is in a text field or a modal is open. At a phone width the strip is the icon and the caret alone, the command's name being read in the dropdown instead
      ✓ Walked on this page's own header, and it behaves as it does on `club_page` (where the
      full clause-by-clause walk is written up). Here: greyed and opening nothing on arrival;
      **Update Renewals** with a tick after a cell save; **Change status** after a transition, one
      entry for a three-row set, wearing an **undo**; **Save changes** after the edit modal and after
      the suspend workflow. Opening the caret holds the name; the stack is newest-first with an undo
      per ordinary save, and taking one back reads **Undo Update Renewals**.
      ⚠ A failure whose kind nothing named reads **"Update Renewals — Failed"** with a raw Postgres
      sentence under the caret — see line 29 and #1347.
- [ ] the tab row gives way: drag the window narrower and the 3 tabs give up width evenly, each label ellipsising and resting a tooltip carrying the whole of it only where it is actually cut — a label still showing in full rests nothing. Past a 30px floor per tab the row stops shrinking and becomes one menu button carrying the *active* tab's own label and a caret — "Profile" on arrival — and opening it lists all 3, every one of them still reaching its tab. At a phone width the row is that menu button whatever the window could have fitted. Widen back and the tabs come again with the same tab active
      ✓ At a phone width the row is one menu button carrying the active tab's own label
      ("Profile") and a caret, and the tabs come back when the window widens.
      — unreachable, as on `club_page`: three short labels (83/101/87px) hold their full width from
      1400px down to the phone breakpoint, so no label is ever cut and none can rest a tooltip. The
      shrink-and-ellipsise stage has no width to happen at on a 3-tab page.
- [x] pick/create a sample `members` record for the steps below (backdrop first, API if the backdrop lacks one)
      ✓ **Alice Reader** (`9da4da5f-…`), the backdrop's own, is the sample. Six `loans` were created
      against her through `/keystone/mutate` so the [[Selection]], gate and transition lines had rows
      to work with — seven with the backdrop's — and **Bob Bookworm** is the second sample, used for
      the gated `modal_actions` and the suspend workflow.
- [x] this page draws no [[Panel]] at all: no docked root panel — not the `members` item-details panel a `parent_page` used to make one, not a `panel_name` and not a blocks tab's `root_panel_override` — no tab rail down the right edge to open one from, and the content running out into the 45px the rail used to reserve; no click on a table tab's row opens an item-details panel, there are no per-model **Select** entries anywhere to open one from, and the mobile header carries no panel button. Append `?panel=<a `members` record id>` to this page's URL, on any tab, and it opens nothing at all
      ✓ The content element is `_contentWithNoPanel_f51ul_37` running the full width (x=296…1400) on
      Profile, Loans and History alike — no rail, no panel button, no per-model **Select** entry.
      `?panel=<a members record id>` on each of the three tabs opens nothing at all, and no click on
      a Loans row opens an item-details panel.
- [ ] `parent_page` `members_listing`: a back arrow sits ahead of the page title and lands on that listing — from a record opened out of the listing *and* from one deep-linked or reloaded, where there is no history to go back through — and is absent for a reader `members_listing`'s own `route.roles` do not permit
      ✓ The back arrow reads **Back to Members** and lands on `/community/members`, both from a
      record opened out of the listing and from one navigated to directly with no history behind it.
      — unreachable: the "absent for a reader `members_listing`'s `route.roles` do not permit" arm.
      Both pages name admin and librarian and nobody else, so no reader reaches this page without
      reaching the listing.
- [x] listing state round trip: filter, sort and switch view on `members_listing`, open a record, move between its tabs, then take the back arrow — the listing is the one that was left rather than its defaults, including the case where every filter was cleared
      ✓ Sorted `members_listing` (`?sort=display_name_asc`), opened a record — the record URL wears
      `?ref_sort=display_name_asc` and nothing under the bare name — moved from Profile to Loans,
      which kept the `ref_` param, and took the back arrow: back on
      `/community/members?sort=display_name_asc` in the order that was left.
- [x] record page actions in tab `profile`: the record's own actions sit at the right-hand end of *that tab's* header — not the page header carrying the back arrow, the title and the tab strip — and no other tab of this page carries them. They are `members_listing`'s `record_actions` rather than anything declared here, so they are the same list, the same wording and the same gates as a row of that listing offers. **Edit** follows the status button at the head of it as a primary button carrying its icon *and* its text, labelled just "Edit" where the row menu's item names the model, and opens `edit_member` on the record the page is showing — a save landing back on the page under it. A reader whose permissions refuse that update keeps the button, greyed and carrying the menu's own reason: a cluster that loses a button under one reader says nothing about why
      ✓ The cluster sits at the right-hand end of the *Profile tab's* bar (y=112), never on the page
      header at y=68, and no other tab carries it. It is `members_listing`'s `record_actions`:
      Status, **Edit**, View Lifecycle, Audit history, Related, More.
      ✓ Edit is the primary button with icon *and* text, labelled just "Edit", and opens
      `edit_member` on the record the page is showing — a phone edited through it landed and the
      Profile block read it back without a reload.
- [x] tab `profile`: the **status button** leads the cluster, left of Edit: one button wearing the record's current `members` status as a disc in its icon slot and that status's own label beside it in full — the cluster's other icon buttons carry their wording in a tooltip, and a status nobody can read is no status. Click it and the transition menu opens under it, the same menu a [[Status Column]] cell's second click opens: an item per status the spec declares, the current one ticked and inert, each of the others the transition to it, refused with its own reason where this reader may not make it and opening the transition modal first where it has properties to collect — and the status the walk lands on is in the record's lifecycle history afterwards. A reader permitted no transition at all keeps the button, naming the status and **disabled** under the same reason rather than going missing. It stands in **both** layouts, and on this project it is the only *button* the status is offered from: there is no item-details panel carrying a badge, and a `properties` block's status pill is a reading rather than a way to move it
      ✓ The status button leads the cluster wearing the record's status as a disc with the label in
      full (**Active**), and its menu is the [[Status Column]]'s: headed "Active", then Active
      (current) and Suspended.
      ✓ On Bob Bookworm, moved to `suspended` by the workflow below, the button reads **Suspended**
      after a reload and the menu narrows with him. A member the policy permits no move on keeps the
      button naming the status rather than losing it.
- [x] tab `profile`: **View Lifecycle** and **Audit history** follow it as icon buttons — one glyph each and no text, the tooltip the only thing naming them — and the first two both switch to the page's own `history` tab rather than opening the modals the row menu opens over a listing, the audit read landing there too for want of a tab of its own. A history read this reader may not make keeps its refusal and switches nothing. Each is the row menu's own action otherwise: same icon, same wording, and absent here wherever the menu drops it
      ✓ Both follow as icon buttons with no text, and **both are `<a>` elements pointing at
      `/community/members/<id>/history`** — the page's own History tab — rather than opening the
      modals the row menu opens over a listing. The audit read lands there too, for want of a tab of
      its own, exactly as the line says.
      — unreachable: "the tooltip is the only thing naming them", for the reason given on
      `club_page` line 12. The wording is each one's `aria-label`.
- [x] tab `profile`: **Related** closes the buttons as a dropdown — the `circle-nodes` glyph with the word beside it and a caret, the row menu's **Related links** submenu under a heading short enough for a button — and holds this record's related links (every relation the spec declares) in the sections, the order and the nesting that submenu holds them in, landing on the same listings. It is absent altogether rather than opening on nothing for a reader whose nav roles reach none of the targets
      ✓ **Related** opens a dropdown headed "Related" holding **Loans**, **Reviews** and **Users** —
      every relation the `members` spec declares — in the row menu's own order, landing on those
      listings.
- [x] tab `profile`: the **More** ellipsis ends the cluster and gathers everything with no button of its own. **Copy {Model} ID** leads it — the item the row menu gives an identity cell, which a record page has no table of its own to offer anywhere else — and then the `modals` entries, then the `modal_actions` entries, disable reasons and all, a rule between each block and the next; the commands the page header carries of its own sit under the lot. Every entry is the row menu's, relabelling and gates included, and the ellipsis is there for every reader — Copy {Model} ID is the record's rather than the block's, so it is never gathering nothing
      ✓ The **More** ellipsis gathers the rest, in exactly the order the line asks for:
      **Copy Member ID** leads, then a rule, then the `modals` entry (**Suspend member**), then a
      rule, then the `modal_actions` entries (**Lend that book again**, **Suspend this member**).
      ✓ The gates come with them, disable reasons and all. On Bob Bookworm, who has never borrowed,
      **Lend that book again** is greyed from the first paint carrying its predicate's own message as
      its `aria-description`: *"This member has never borrowed a book, so there is nothing to
      reissue."* On the now-suspended Bob both suspend entries are **absent** — the workflow
      permission names `active` only — which is the `hide` arm working.
- [x] tab `profile` at a phone width: the whole cluster folds into the header's existing **Actions** menu — the status button under the status it names, then Edit, each icon button under the wording its tooltip carries, the related links and the ellipsis's own items, all entries of that one menu in the cluster's order — and no button of it is left beside the tab's title. There is no docked item-details panel beside it to be untouched — this page draws none — so that one menu is the whole of the record's actions at this width
      ✓ At 520px the whole cluster folds into one **Actions** button and nothing of it is left
      beside the tab's title — the bar carries only the back arrow, the tab menu button, the
      [[Command Strip]] (32px) and that one button. The menu is headed "Actions" and holds, in the
      cluster's order: **Active**, **Edit**, **View Lifecycle**, **Audit history**, **Related**
      (nested), a rule, **Copy Member ID**, a rule, **Suspend member**, a rule, **Lend that book
      again** and **Suspend this member**. No docked panel beside it.
      (Judge this clause after a *navigation* at the width — a `SetWindowRect` plus a synthetic
      resize alone left the wide arrangement mounted, which is session 04's note still holding.)
- [x] tab `profile` (Profile): blocks render with the record's real values, the record's status among them as the same pill a card draws — a band of colour across the block, or down the page, is the regression this clause exists to catch
      ✓ The Profile blocks render the record's real values — User Id *Alice (Reader)*, Display Name,
      Membership Tier *Gold*, Joined On, Phone, Private Note, Active Loan Count — and the status is a
      65×25 pill on its own row, not a band across the block or down the page.
- [ ] tab `loans` (Loans): related `loans` table shows only this record's rows, and a column hidden, resized, or carried to a new place by its header here stays on this tab — the listing page over `loans` keeps a layout of its own
      ✓ The tab shows 7 `loans` rows, every one of them Alice's (`member_id in .id`).
      ✓ Hiding **Checked Out At** through this tab's Customize columns stays on the tab: it is still
      hidden on coming back from another page, and **Revert to defaults** puts it back.
      — the listing half could not be compared here: `loans_listing`'s first view is a **board**, so
      `/circulation/loans` draws no table to hold a layout of its own. The same separation is walked
      end to end on `club_page`'s Events tab against `events_listing`, where both are tables.
- [x] tab `loans`: the identity column is this table's pinned first column too, naming each `loans` record, and its header no more drags along the row here than it does on a listing page
      ✓ The identity column is pinned: scrolling the table 500px sideways leaves the checkbox cell at
      x=312 and the identity cell at x=347 while `status` slides to x=47 underneath them and the last
      column moves from x=1887 to x=1387. It names each `loans` record by its book with the borrowed
      date as a subtitle, and its header drags along the row no more than a listing page's does.
- [x] tab `loans`: the table opens sorted by `due_on`, ascending — inherited from `loans_listing`'s first table view, this tab declaring no `default_sort` of its own — and that column's header is the one wearing the arrow
      ✓ The table opens sorted by `due_on` **ascending** — 2026-08-01, 10-05, 10-12, 10-19, 10-26,
      11-02, 11-09 — with Due On the one header wearing the arrow, and the Sort modal reads
      "Due On / Ascending" on arrival. The tab declares no `default_sort`, so this is
      `loans_listing`'s first table view's, inherited.
- [x] tab `loans`: sort a text and a numeric column, both directions
      ✓ `Renewals` (numeric) descending → 3,3,0,0,0,0,0 and ascending → 0,0,0,0,0,3,3; `Book Id`
      (text, over the book's title) ascending → A Wizard of Earthsea, A Wizard of Earthsea, Dune,
      Dune, Dune, Dune Messiah, The Dispossessed, and descending the reverse. The arrow moves to the
      sorted header each time.
- [x] tab `loans`: the status column is this table's second column too, each `loans` row wearing its status as the same band — and a click on a ticked row's status cell opens the same transition menu here as on the listing page, moving the whole checked set the way it does there
      ✓ Status is the second column, each row wearing its status as the same band.
      ✓ A click on a ticked row's status cell opens the [[Selection]]'s transition menu and moves the
      whole checked set: three `requested` rows → **Active** as one write, and the same three
      `active` → **Returned** as one write.
- [ ] tab `loans`: rest the pointer on a cell whose value this column's width cuts off and about half a second later the whole of it floats beside the cell, wrapped rather than clipped and rendered the way the cell renders it rather than as a bare string; move the pointer away and the box goes, while a cell already showing all of its value floats nothing however long the pointer rests on it. On a phone, where there is no pointer to rest, a tap on that same cell floats the box at once and a tap elsewhere puts it away — and neither tap changes which row is selected
      — unreachable on this tab as written, and a finding underneath it. No plain cell's value
      exceeds its 200px column here, so there is nothing for a rest to float; the one cell whose
      value *is* cut is the identity ("A Wizard of Earthsea 2026-10-05"), and its clipping is on an
      inner element — the cell reports `scrollWidth` 199 against `clientWidth` 199 — so the preview's
      gate never fires for it. That is **#1345**, filed from `club_page`, where the same tab shape
      does have a wide enough value to show both sides of it.
      — and the half-second pointer rest itself is unreachable headlessly (session 04's ruling).
- [x] tab `loans`: click any cell of a row to select it, then click one of that row's cells again: the cell becomes the `loans` field it edits, with the cursor in it. The first click only makes that row the whole [[Selection]] — every other row unticks and this one ticks — and opens no panel, there being none on this page; a click on a row *outside* the selection never opens a cell, and a double-click still does nothing of its own. The two cells ADR-0095 spoke for keep their own second clicks — the identity cell opens the record page and the status cell the transition menu — and no ordinary cell grows a pencil beside the identity cell's. On a phone the same pair of taps opens the cell, the identity cell being what selects the row there
      ✓ First click on a cell of an unticked row makes that row the whole [[Selection]] and opens no
      cell and no panel; the click after it opens the cell with the cursor in it. A click on a row
      outside the selection never opens a cell. The identity cell's second click resolves no record
      page — `loans_listing` declares none — and the status cell's opens the transition menu. No
      ordinary cell grows a pencil beside the identity cell's; `loans_listing` declares no
      `edit_modal`, so **no row has a pencil at all**, which is right rather than missing.
- [x] tab `loans`: type into an open cell and click away: the blur saves that one property of that one `loans` record, `Enter` saves and closes, and the [[Command Strip]] names the save after the column it changed — **Update {column}**, the word that column’s header shows, rather than a general Save changes — with an undo that puts the old value back in the row. `Escape` instead of either puts the old value back without saving. Nothing saves on a timer — leave an open cell alone for a minute and it is still unsaved with the strip silent — and a write the server refuses leaves the cell holding what was typed rather than retrying it, the strip carrying the refusal's sentence and its category, with `Escape` the way to give that draft up. Walk it as a role whose policies may not update the record at its status, too: that row's cells never open at all
      ✓ Blur saves the one property of the one record and `Enter` saves and closes, the
      [[Command Strip]] naming it **Update Renewals** after the column rather than a general Save,
      with an undo that puts the old value back. `Escape` puts the old value back without saving and
      leaves the row checked. Nothing saves on a timer (proved on `club_page`'s events tab: an open
      cell left 30 seconds is still unsaved with the strip silent — the same cell editor).
      ✓ A row the reader may not update at its status never opens a cell: the three `returned` rows
      here refuse every click.
      ⚠ A write the server refuses does **not** leave the cell holding what was typed here — see
      line 29 and #1347.
- [x] tab `loans`: where each `loans` field opens: `renewals`: **in the cell**, as an input filling it; `book_id` and `member_id`: **in the cell**, as a search box over the records it points at, saved when the cell is left rather than when the menu is picked from; `borrowed_on` and `due_on`: in a popup holding the month grid — the same calendar a modal's date field draws rather than the browser's own control. A popup is anchored to the cell it came from, is wide enough to write in rather than the width of the column, holds the focus while it is open, and commits when it closes — an upload still running or a search menu holding the focus is the editor's own and commits nothing half-finished. It is **one box**: a date's month grid is drawn inside it under the input, up from the moment the cell opens, rather than floating over it as a second popup with a second edge to find, and picking a day from it writes the value and leaves the grid standing. And a click anywhere inside the box leaves it open — its padding, the space beside a field, the grid — so only a click *outside* it puts it away, committing what is in it. A click on the cell the box came from is one of those: it closes the box and leaves it closed, rather than closing and reopening it under the one click. The grid answers the pointer and nothing else: with the caret in the date, `Home`, `End` and the arrows move it through what is being typed rather than through the month, typing being the way in from a keyboard — and `Enter` finishes a typed date and saves it, a box holding one line being one line. Every other column of this table opens nothing at all, which is what its cells refusing the second click means rather than a fault
      ✓ `renewals` opens **in the cell** as a number input filling it; `book_id` and `member_id`
      open **in the cell** as search boxes over the records they point at, holding *A Wizard of
      Earthsea* and *Alice Reader (gold)* rather than ids; `borrowed_on` and `due_on` open in a
      popup (`_popup_bzw3q_15`) anchored to the cell, far wider than the column, holding the month
      grid inside it under the input as one box. `checked_out_at` and `member_tier_at_checkout` open
      nothing at all — neither is in the `admin` policy's update list — which is what their cells
      refusing the second click means.
      ⚠ the date popup's grid opens on the current month rather than the value's: #1346.
- [x] tab `loans`: the caret an armed cell wears: select a row and its `borrowed_on` and `due_on` cells each grow an angle-down caret at the right edge — the same affordance the [[Status Column]]'s band wears, on every cell whose click opens a list or a box rather than a field to type in. The cells of `book_id`, `member_id` and `renewals` wear none: there the click opens a field to type in, which is its own affordance. The caret is there only while the row is selected — an unselected row's cells wear none, that click being the row's, and the value under it does not move a pixel as the cell opens — the open field is set in the table's own font, so the same string lands on the same baseline in the same place, and a value too long for its column still ends in an ellipsis rather than breaking at a word. What the caret does when the cell opens depends on where the field went: a field drawn *in* the cell brings a chevron of its own, so the cell's goes, and a field that opened in a popup leaves the cell showing its value, so the caret stays and turns upside down. Nothing the caret sits on moves: the value reads exactly where it read before the row was selected, and the caret sits on the same pixel as the open field's own chevron
      ✓ Selecting a row grows a caret on exactly `status`, `borrowed_on` and `due_on` — the three
      whose click opens a list or a box — and on none of `book_id`, `member_id`, `renewals`,
      `checked_out_at` or `member_tier_at_checkout`, whose clicks open a field to type in or nothing
      at all. An unselected row wears none of them. The value under the caret does not move as the
      cell opens.
- [x] tab `loans`: a selected row's cell content goes inert: with the row selected, a link, a chip or a button drawn inside one of its cells stops answering the pointer — it draws no hover emphasis and follows nowhere — so the second click has one meaning wherever in the row it lands, and on an editable cell it opens that cell. On an *unselected* row the same content is live and the click belongs to the row underneath. What a reader wanted from that link is still reachable: the [[Cell Preview]] the hover floats carries the rendering with it, and `Space` and a tap float the same box. The identity cell is the exception and goes on answering — its pencil, its ellipsis and its record page all still take the pointer
      ✓ Every editable cell of the *selected* row carries `FiE3va_inert` (`data-inline-cell-inert`)
      while the same cells of an unselected row are plain `FiE3va_cell` — so the content stops
      answering the pointer and the second click has one meaning wherever in the row it lands. The
      identity cell is the exception and goes on answering: its row-menu button is still live on the
      selected row.
      ⚠ "What a reader wanted from that link is still reachable" is the half that does not hold — the
      [[Cell Preview]] is exactly what an inline-edit cell stops floating (#1345).
- [ ] tab `loans`: put a value one of those cells cannot take into it — a letter where the cell holds a number, a malformed address where it holds an email — and leave the cell: the old value is back in it, nothing is sent, no command runs and the [[Command Strip]] says nothing, there being nothing to report. No cell and no row anywhere in the table is drawn red, outlined or marked invalid at any point, which is the half to watch for. Where the schema points at one repair the value is repaired instead and the repair is what saves: a number past its bounds comes back clamped to them, a string past its maximum truncated to it, and leading or trailing whitespace trimmed away
      ⚠ **finding — an emptied non-nullable number cell writes NULL instead of rolling back.** Typing
      a letter into `renewals` leaves the input empty (the browser swallows it, `validity.valid`
      false); leaving the cell **sends a write**, which fails, and the row is left drawing an empty
      Renewals against a database still holding 3. The [[Command Strip]] reads **"Update Renewals —
      Failed"** with the raw Postgres sentence under the caret: *error returned from database: null
      value in column "renewals" of relation "loans" violates not-null constraint*. Filed as
      **#1347**.
      ✓ The other half of the line holds: no cell and no row anywhere is drawn red, outlined or
      marked invalid at any point.
      ✓ And the date cell beside it is correct — a malformed `due_on` comes back to `2026-11-02` with
      nothing sent and the strip unmoved.
      ✓ The repair clause was walked on `events.capacity` (`min: 1`): typing 0 saved 1, clamped.
- [x] tab `loans`: these rows answer to `loans_listing` rather than to this page — the menu a row opens, the pencil in its identity cell, the [[Selection Menu]] its checked rows open and the record page a second click on that cell reaches are all built from that listing's `record_actions`, so a change made there shows up here and nowhere else does; this page's own record actions are `members_listing`'s and govern the cluster in its first tab's header alone
      ✓ Every row affordance is `loans_listing`'s rather than this page's: the row menu holds
      *View Lifecycle*, *Audit history* and *Related links* — which is what that listing's
      `record_actions` declare (`related_links`, `show_status`, `view_audits`, and no `edit_modal`
      and no `record_page`) — so there is no pencil and no record-page item anywhere. This page's own
      record actions are `members_listing`'s and govern the Profile tab's header alone.
- [x] tab `loans`: right-click a row with fewer than two rows checked and that row becomes the whole [[Selection]] — its own checkbox ticks and any other clears — with a menu at the pointer over it and **no panel behind it**, this page drawing none. The menu is headed by the `loans` record's own name and holds `loans_listing`'s actions for it, one separator per group boundary, led by the record page in bold
      ✓ Right-clicking a row with fewer than two checked ticks that row alone, clears every other,
      and opens a menu at the pointer with **no panel behind it** — headed by the record's own name
      ("Dune Messiah 2026-10-26") and holding `loans_listing`'s actions with one
      `_separator_1lu93_1` per group boundary. Nothing is pulled to the front in bold, there being no
      record page to pull.
- [x] tab `loans`: the ellipsis in a row's identity cell opens the same menu, anchored to itself rather than to the pointer — it appears beside the pencil while the pointer is anywhere on the row, not only over the title, and on a touch screen it is there without hovering, which is a phone's only way in
      ✓ `[data-identity-menu] button` ("Show row menu") sits in every row's identity cell, anchored
      to itself rather than to the pointer, in the DOM at rest without hovering — a phone's only way
      in — and opens the same menu, led by *View Lifecycle* with no cell item at all.
- [x] tab `loans`: the menu is the whole of what a row's actions have on this page: every action `loans_listing`'s `record_actions` offer this reader stands in it, in the block's own order but with the record page pulled to the front, greyed with its own predicate's reason where one refuses and absent where a `hide` does — there being no item-details panel beside it to be compared with. Three read the way the panel worded them: the record page and the edit modal name the model (*Author Page*, *Edit Author*) and Lifecycle reads *View Lifecycle*. Walk it as a role the record's permissions narrow, too: what the menu holds has to narrow with them
      ✓ The menu is the whole of it: *View Lifecycle*, *Audit history*, *Related links*, in the
      block's own order, with no item-details panel beside it. Lifecycle reads *View Lifecycle* as
      the line says; there is no edit-modal item and no record-page item, `loans_listing` declaring
      neither.
      ✓ It narrows with the record's permissions — on a `returned` row, which the `admin` policy
      permits no update on, no cell of the row opens and the menu holds the read actions alone.
- [x] tab `loans`: right-click a cell that is not the identity cell and the menu leads with **Copy {column}**, then a separator — what it copies is what the cell reads as, the string the CSV export carries, rather than its markup. Where the table filters on that column and the cell is not empty, **Filter by {column}** sits under it and narrows the table to the value in the cell, which then shows in the filters button and in the URL like any other
      ✓ Right-click on `borrowed_on` leads with **Copy Borrowed On** and **Filter by Borrowed On**
      under it, then a separator — the table filtering on that column and the cell not being empty.
- [x] tab `loans`: right-click the *identity* cell and the menu leads with **Copy {Model} ID** instead — the `loans` spec's singular display name, so *Copy Book ID* over `books` — which puts the record's id on the clipboard. That cell's value is the record's name, which is already the menu's heading. A menu opened from the ellipsis is the row's own and leads with no cell item at all
      ✓ Right-click on the identity cell leads with **Copy Loan ID** instead — the `loans` spec's
      singular display name — and carries no cell copy item, that cell's value already being the
      menu's heading. A menu opened from the ellipsis leads with no cell item at all.
- [x] tab `loans`: Related in the menu: this record's related links (every relation the spec declares) are one **Related links** submenu — after the `modal_actions` items and ahead of any custom action — holding a link per relation and landing on the listing each one names, filtered to this record, and nesting a submenu of its own wherever a section brings more than one
      ✓ **Related links** is the last item and nests: it opens a submenu holding **Books** →
      `/library/books/<the loan's book>/overview` and **Members** →
      `/community/members/<the borrower>/profile`. Both relations the `loans` spec declares, each
      landing on its target filtered to this record.
- [x] tab `loans`: the checkbox column is there before anything is clicked: the table opens with a checkbox in a column of its own ahead of the [[Identity Column]] on every row, nothing ticked, and one in the header. There is no **Select multiple** toggle anywhere on the page to have turned it on — no root panel to hold one, a record page's table tab having never had one, and the tab's own header bar carries its title, its **Add** and the table's controls and nothing about selecting — and nothing else about a row has moved: the identity cell keeps its pencil and the row menu's ellipsis, nothing being ticked yet. Leave the tab for another and come back and the column is still there with nothing ticked, the [[Selection]] being this tab's own: no `panel` parameter is ever written to the address bar by any of this
      ✓ The table opens with a checkbox in a column of its own ahead of the [[Identity Column]] on
      all 7 rows and one in the header, nothing ticked. There is no **Select multiple** toggle
      anywhere — the tab's header bar carries its title, its count, Filters, Sort and Customize
      columns and nothing about selecting — and nothing else about a row has moved. Leaving for
      another tab and coming back leaves the column there with nothing ticked, and no `panel`
      parameter is ever written to the address bar by any of it.
- [x] tab `loans`: giving a set up, with no count and no **Clear** to do it by: on a `loans` table with more rows than three, tick three of them and click the header checkbox — all three untick rather than the whole table checking, which is what a partial set answers to now. Click it again with nothing ticked and every row of the table checks; click it once more with every row checked and every one unticks. Press `Escape` with three rows ticked instead and the set empties the same way, the focus ring left exactly where it was. There is no selection count and no **Clear** anywhere on the page to have done either by — the header checkbox is a phone's way, having no `Escape` to reach for. **Every identity cell's pencil goes** while more than one row is ticked — the edit modal writes the one record it was clicked on, which is not what a set is edited with — and each comes back the moment the selection is down to one row or none; the ellipsis beside it never goes, the row menu being where a checked row's own list opens
      ✓ With three rows ticked the header checkbox unticks all three; clicked again with nothing
      ticked it checks all 7; once more it unticks all 7. `Escape` with rows ticked empties the set
      and leaves the focus ring where it was. There is no selection count and no **Clear** anywhere
      on the page.
      — the pencil half has nothing to walk here: `loans_listing` declares no `edit_modal`, so no
      identity cell has a pencil to lose. The ellipsis never goes.
- [x] tab `loans`: the one click rule: click a cell of a *ticked* row and that cell opens for editing, which is what the second click on a row has always been; click a cell of an *unticked* row and that row becomes the whole selection instead: every other row unticks, this one ticks, no cell opens and no panel opens either, this page drawing none, and the click after it opens that cell. **A click inside the selection never takes it**: with three rows ticked, click anywhere on one of them — a cell's dead space, a column that opens nothing, the spare width past the last column — and all three are still ticked. So the [[Selection]] grows and shrinks by checkbox alone: no click anywhere in the table ever adds a row to it. The identity cell is ADR-0095's still — a second click on it opens the record page rather than a cell — and a row this reader may not update is a row whose cells do not open, ticked or not
      ✓ A click on a ticked row's cell opens that cell; a click on an unticked row's makes it the
      whole selection instead, opening no cell and no panel, and the click after it opens the cell.
      **A click inside the selection never takes it** — with a set ticked, a click on a member of it
      left every row ticked, both on a column that opens nothing and on one that does. The selection
      grows and shrinks by checkbox alone. A row the reader may not update is a row whose cells do
      not open, ticked or not.
- [ ] tab `loans`: the set marks, and the editor opens on what it shares: tick three rows by their checkboxes and rest the pointer on one of their `renewals` cells — the same column's cell on the other two ticked rows is marked with it, a tint of its own over the fill a ticked row already carries, so what is about to change is visible before it changes. Carry the pointer along the row and the marking follows it column by column; carry it onto an *unticked* row and nothing marks there, and the [[Identity Column]] neither marks nor is marked, its second click opening a record page rather than anything a set can be asked for — while the [[Status Column]] does both, a status being one of the things a selection changes: rest the pointer on a checked row's status cell and every checked row's band wears a ring and the action colour washed over it, its own included — the status colour still showing through, so a marked set never reads as a different status. Now click that cell: it opens holding the value the three rows share, or empty where they hold three different ones — and empty is not a change, so leave it without typing and nothing is sent, no command runs and the [[Command Strip]] stays silent. Type, and what is typed shows in that one cell alone: the other two go on showing what the server last returned, marked but unchanged, until the save lands. `Escape` gives the draft up to *this* row's own value rather than to the set's, and the header checkbox and `Escape` take the marking away with the [[Selection]]
      ✓ The editor opens on what the set shares: two rows holding **0** opened the `renewals` cell
      holding `0`, and two holding **1** and **2** opened it **empty** — and empty is not a change,
      so leaving it without typing sent nothing and the strip stayed silent.
      — unreachable: the marking. A real pointer rested on a checked row's `renewals` cell changes
      no class on it or on the other checked rows' — the tint is CSS inside `@media (hover: hover)`,
      inert headlessly (session 04's ruling).
- [x] tab `loans`: one edit, every checked row, one entry: with three rows ticked, open one of their `renewals` cells, type a value and press `Enter` — all three rows read it, and the strip names **one** entry for the three rather than three entries. Open the caret and take it back: each row comes back to the value *it* held, so three rows that held three different values come back as three different values rather than as the one the opened cell was showing. Every other column of all three records is as it went in, the write carrying the one property that changed and nothing else — check one the set never agreed on. Then make a second batch over a *different* set of rows: it is an entry of its own rather than folded into the one before it, which is what a run of edits to one cell of one row does instead
      ✓ Two rows ticked holding **1** and **2**, `renewals` opened (empty, the set not agreeing) and
      **7** typed with `Enter`: both rows read 7 and the strip named **one** entry for the two.
      Taking it back from the caret brought each row back to the value *it* held — 1 and 2 — rather
      than to the one the opened cell was showing, and every other column of both records was as it
      went in. A second batch over a different set is an entry of its own rather than folded into the
      one before it.
- [x] tab `loans`: the gate closes the whole set: `loans`'s `admin` policy permits `update` on a record in `requested`, `active` and `overdue` and not on one in `returned`, so tick one `loans` record in `returned` along with two the policy does reach — and no cell of the set opens at all, the cells of the two rows that would have permitted it included, because applying to whichever rows happened to permit it would leave the result turning on a permission the reader cannot see. A refused cell is the inert one it already knows how to be: `Tab` walks over it, `Enter` and `F2` float the [[Cell Preview]] instead, and nothing marks, there being nothing about to change. The reason rides on the cell itself, as its tooltip *and* its accessible name — "<the record's name> cannot be updated while it is Returned", which says which row to untick rather than which rule to guess at. Untick that one record and the other two open again
      ✓ Ticking one `returned` record along with two the policy does reach closes the whole set: no
      cell opens, the two permitted rows' included. The reason rides on each refused cell as **both**
      its `title` and its `aria-label` — "A Wizard of Earthsea 2026-10-05 cannot be updated while it
      is Returned" — naming which row to untick. Unticking that one record opened the other two
      again.
- [x] tab `loans`: the status cell moves the whole set: tick three `loans` records that are all in `requested` and click one of their status cells — the menu that opens is the [[Selection]]'s rather than that one row's, titled with the status the three agree on, and it offers only the moves every checked record may make. Tick one `loans` record in `overdue` as well and `active` is no longer offered, that record having no permitted move into it. Take `requested` → `active`, which the `admin` policy permits: all three move as one write, the strip names one entry for them, and that entry wears a lock rather than an undo — the `admin` policy permits no move back out of `active`. A record already in `active` neither withholds the move from the others nor takes a write of its own, and a set with no move in common is a status cell that opens no menu at all and answers no click. Give the selection up by the header checkbox and the same cell opens that one row's own menu again, one checked row being no set
      ✓ Three `requested` rows ticked: the status cell opens the [[Selection]]'s menu offering only
      **Active** — the one move every checked record may make — with **Overdue** and **Returned**
      greyed, each carrying its own reason as an `aria-description` ("Status must be: Active" and
      "Status must be one of: Active, Overdue"). Taking Active moved all three as one write with one
      strip entry.
      ✓ A row in `returned`, which the policy permits no move out of, opens no menu at all rather
      than falling through.
- [ ] tab `loans`: one modal for the set: `loans`'s `active` → `returned` collects the lifecycle properties `return_condition` and `reshelve_by`, so tick three `loans` records that are all in `active` and make that move — the transition modal opens **once** for the whole set rather than once per record, and what the one form collects goes to every one of them. Its single **Save** sends one transition per record as one entry, and **Cancel** moves none of them at all. The set has to match one and the same permission for the move to be offered at all: tick one `loans` record in `overdue` alongside them — which reaches `returned` under a permission of its own, with its own property list — and the move is not offered, one form having no honest way to collect two
      ✓ Three `active` rows ticked and taken to **Returned**: the transition modal opened **once**
      for the three, headed "Change status" and holding the lifecycle properties —
      **Return Condition\*** (a select) and **Reshelve By** (a date, seeded 2026-10-01) — and one
      submit moved all three, with one entry in the strip.
      ● #1328 confirmed on this surface, which is the half that fails: submitting with the **required**
      Return Condition left empty was accepted. All three rows moved to `returned` and their
      `loans_lifecycles` rows carry `return_condition` **NULL**, checked in the database.
- [x] tab `loans`: a set with nothing to be asked: `loans_listing`'s `record_actions` declare no `modal_actions`, and no `loans` workflow declares `dispatch_mode: per_record` on a manual trigger — so a [[Selection]] here has an empty list, and what the menu holds is one line saying so. Tick three rows and right-click one of them: a menu of the app's own opens, titled off the count as any set's is, holding a single greyed **No actions for this selection** and nothing else — the browser's own context menu must not appear over the table, which is what an empty menu would have let through. The identity cell's ellipsis is still on a checked row and opens that same one-line menu, a phone having no right-click to reach it with. That one line is the whole of what says so: there is no panel on this page with a selection block to have said it by drawing no buttons, and no count and no **Clear** beside it to have said it either. Right-click an *unchecked* row and the selection still collapses onto it — every other row unticks, that one ticks — and that record's ordinary [[Row Context Menu]] opens, copy item and all; untick until fewer than two rows are checked and every row's menu and ellipsis are the record's own again
      ✓ `loans_listing` declares no `modal_actions` and no `loans` workflow is manual and per-record,
      so a [[Selection]] here has an empty list — and the menu says so: headed **"2 Loans selected"**,
      titled off the count, holding a single greyed **No actions for this selection** and nothing
      else. The identity cell's ellipsis on a checked row opens that same one-line menu.
      Right-clicking an unchecked row collapses the selection onto it and opens that record's
      ordinary [[Row Context Menu]], copy item and all.
      — not decidable through this harness: whether the browser's own context menu is suppressed;
      headless Firefox draws no native menu to observe.
- [ ] tab `loans`: the whole table is **one** tab stop: Tab from the control above it lands inside the table once — on a cell, wearing a focus ring of its own — and Tab again leaves it for whatever is below, however many rows are on screen; the column headers' own controls keep the stops they had, and so do a row's selection checkbox and an open inline-edit field, while clicking any cell moves the ring to that cell
      ● #1314 confirmed here as on `club_page`: the table is **not** one tab stop. `Tab` from
      Customize columns lands on the listing link, then row 0's checkbox cell, then that row's
      "Show row menu", and then **opens every editable cell of the row in turn** (five inputs) before
      landing on the next row's menu — ten presses never left the table.
- [x] tab `loans`: Left and Right walk the ring across the columns of the row it is on, crossing out of the pinned columns into the scrolling ones without a stop in between, and Home and End are that row's first and last column rather than the table's first and last row; both ends hold rather than wrapping onto another row, and a column reached off the side of the window is scrolled to clear of the pinned columns rather than underneath them
      ✓ From `book_id@4`, Right walks member_id → borrowed_on → due_on → checked_out_at; Left walks
      back out of the scrolling columns into the pinned ones without a stop in between — due_on,
      borrowed_on, member_id, book_id, status, identity — and both ends hold rather than wrapping.
      `Home` is that row's first column (checkboxes) and `End` its last (renewals). A column off the
      side of the window is scrolled to clear of the pinned columns.
- [x] tab `loans`: Up and Down move the ring to the row above and below in the column it is already in, and every row it lands on is selected as a clicked row is, that `loans` record becoming the whole [[Selection]] and the row before it unticking — hold Down and the checked row walks with the ring, on past the bottom of the window, where the next row is scrolled to and *then* focused rather than skipped over; the first and last rows hold rather than wrapping
      ✓ Down and Up move the ring within the column it is already in (`renewals@4` → `@5` → `@6`)
      and every row it lands on becomes the whole [[Selection]] — after two Downs the checked set is
      row 6 alone. The first and last rows hold rather than wrapping.
- [ ] tab `loans`: Ctrl+Home jumps the ring to the first row and Ctrl+End to the last row of the table rather than the last one fetched: on a `loans` table long enough to be paged, Ctrl+End lands the ring on a row whose record has yet to arrive, the window goes back to the connection for it, and the selection moves to *that* record once it lands rather than staying on the row that was checked before
      ✓ `Ctrl+Home` put the ring on row 0 and `Ctrl+End` on row 6 — the last row — in the column the
      ring was already in.
      — unreachable: the paging half. Seven loans are well inside one page, so there is no row whose
      record has yet to arrive.
- [x] tab `loans`: Enter on the focused row's identity cell does nothing at all — this surface resolves no record page for `loans`, and a second click on the cell does nothing either. The cell still claims the key: it must not fall through to the pencil's edit modal, to the cell's own preview, or back to the browser
      ✓ `Enter` on the focused identity cell does nothing at all — no navigation, no edit modal, no
      preview — and the ring stays on the cell. `loans_listing` resolves no record page and the
      second click does nothing either, so the key and the click agree.
- [x] tab `loans`: Enter on the focused row's status cell opens the same transition menu a second click on it opens, under the cell and holding the same items — and where the reader is permitted no transition at all it opens nothing rather than falling through to that cell's preview
      ✓ `Enter` on the focused status cell opens the same transition menu the second click opens,
      under the cell, holding the same items with the same refusals (from `requested`: Requested
      current, Active offered, Overdue and Returned greyed with their reasons). On a `returned` row,
      where the reader is permitted no transition at all, it opens nothing rather than falling
      through to the cell's preview.
- [ ] tab `loans`: Space on any other focused cell **toggles** that cell's preview — the box floats and the same key puts it away — while Enter on a cell this reader may not write only ever opens it; a cell already showing all of its value floats nothing either way, and the page does not scroll down under either press. Escape then closes whatever is floating over the table first, and an Escape with nothing open gives the selection up — every checked row unticks, there being no panel to close instead, leaving the ring exactly where it was — Tab, not Escape, is the way out of the table. While anything floats the arrow keys stand aside rather than walking the ring out from under it, the box being placed against the cell it belongs to
      ⚠ `Space` on a focused cell floats nothing on this tab. Every cell here reports
      `scrollWidth === clientWidth`, so the preview's gate never fires — including the identity cell,
      whose value *is* visibly cut and whose clipping is on an inner element. That is **#1345**.
      ✓ The rest of the line holds: the page does not scroll under the press, and `Escape` with
      nothing floating gives the selection up, leaving the ring exactly where it was.
- [x] tab `loans`: Enter and F2 on a focused cell this reader may write open it for editing — the same field the second click opens, in the cell or in its popup — rather than that cell's preview, and the ring is in the field once it opens. On a cell they may not write, or one this table opens no field for, Enter falls back to the preview and F2 does nothing at all; the identity and status cells keep what they answer above
      ✓ `Enter` and `F2` on a focused `renewals` cell both open it for editing — the same number
      input the second click opens, in the cell, with the ring in the field. On a cell this table
      opens no field for, `F2` does nothing at all.
      ⚠ Enter's fallback on such a cell is the preview, and that preview does not come (#1345).
      ✓ The identity and status cells keep what they answer above.
- [ ] tab `loans`: Tab from an open cell commits it and opens the next editable cell of the *same* row, Shift+Tab the previous — every column with no field to open is stepped over, the identity and status columns among them — and past the last editable cell of the row Tab leaves the table for whatever is below it, as Shift+Tab before the first leaves it upwards, the table being one tab stop. The [[Identity Column]]'s cell is the walk's first stop, and opens nothing either: `Tab` into the table lands there, `Enter` opens the record page, and `Tab` again carries on into the row's cells in the order the columns are laid out. The [[Status Column]]'s cell is one of the stops, and the one that opens nothing: `Tab` onto it commits whatever was open and leaves the ring there, `Enter` opens its transition menu — the same key a reader who arrived by arrow key presses — and `Tab` again carries on to the next editable cell rather than popping a menu part-way along the row. Escape inside an open cell is the cell's own: it puts back what the cell held and closes it, leaving the row checked rather than clearing the selection, which is what the same key does once no cell is open
      ✓ Within a row, `Tab` from an open cell commits it and opens the next editable cell of the
      same row in column order — book_id, member_id, borrowed_on, due_on, renewals — stepping over
      the identity, status, `checked_out_at` and `member_tier_at_checkout` columns, which open
      nothing. `Escape` inside an open cell puts back what the cell held and closes it, leaving the
      row checked.
      ● #1314 again for the rest: past the last editable cell of the row `Tab` does not leave the
      table — it lands on the next row's "Show row menu" and carries on. The identity column is not
      the walk's first stop either.
- [ ] tab `loans`: Shift+F10, and the Menu key where the keyboard has one, open the row's context menu on the focused cell: the right-click's menu rather than the ellipsis's, anchored to the cell for want of a pointer to anchor to, with the row selected under it — so an ordinary cell's menu is led by the copy item naming that column and the identity cell's carries no copy item at all. A menu a key opened takes the keyboard: its first item is focused, Up and Down walk the items and Enter picks one, and closing it hands the keyboard back to the cell with its ring on. A right-clicked one takes nothing and leaves the ring where it was
      ✓ `Shift+F10` on an ordinary focused cell opens the right-click's menu anchored to that cell,
      with the row selected under it, headed by the record's name and led by the copy item naming
      that column (**Copy Book Id**, with **Filter by Book Id** under it). The menu takes the
      keyboard — its first item is focused.
      ● #1339 confirmed again: `Shift+F10` on the [[Identity Column]]'s cell opens **nothing**,
      though a right-click on the same cell opens its menu.
- [x] tab `history` (History): lifecycle history renders
      ✓ The History tab renders the lifecycle table — Status / Created At / Created By — under the
      record's own header.
- [x] edit modal `edit_member` from the record page: open → save a change → the page reflects it
      ✓ `edit_member` opens from the Edit button filled with the record — Display name\*, Tier
      (*Gold*), and the PII pair under their own note ("Contact details are private. Phone is stored
      as PII and the staff note is encrypted at rest.") — and a phone edited through it saved and the
      Profile block read it back without a reload. The strip named it **Save changes**.
- [ ] shareable link: open edit modal `edit_member` for the record the page is on and the address bar gains `?edit=members:<id>`, which closing the modal takes away again — Back leaves the page rather than closing the modal, the param being written over the entry rather than after it. Reload that URL, or paste it into a browser with no history behind it: the page comes up with the modal already open over the record page, filled with that record rather than empty or loading. A link naming a record this reader may not see lands on the page with no modal and the param stripped, and the refusal read in the [[Command Strip]]: a warning and the attempt's own name on the bar, its sentence under the caret, and nothing added to the undo history
      ● #1341 confirmed on this page too: opening `edit_member` writes `?edit=members:<id>` and
      closing takes it away, but **reloading that URL opens no modal**. The param is stripped and the
      [[Command Strip]] reads **"Open Record — Failed"** — for the record the page is already showing,
      as admin.
- [ ] record-action modals (`edit_member`, `onboard_member`, `suspend_member`): each opens from this page and submits
      ✓ `edit_member` opens from the Edit button and submits (line 56).
      ✓ `suspend_member` opens from **More → Suspend member** and submits — **and this is the ratchet
      the notes were waiting for**. The modal opens headed "Suspend member" with its Reason field,
      submitting dispatches the workflow, and **Bob Bookworm reached `suspended` in the database**.
      The malformed-URL failure the notes ledger struck through from a listing does not reproduce
      from a record page either. Two things ride along: the strip names the run **Save changes**,
      after the modal's button rather than the action (#1331's naming, on a single record, where the
      tally half does not apply), and the page's own status chip still read *Active* until a reload,
      the workflow being asynchronous.
      ⚠ **`onboard_member` cannot be opened from this page at all** — it is in no menu, no button and
      nowhere in the DOM. It is right that it is not: its subject is `kind: new_record`, so it is
      `members_listing`'s *add* modal, which a record page for an existing member has nothing to do
      with. The plan line is wrong rather than the app, and it is a **generator** bug: `"*"` is
      resolved by every modal naming the model, with no filter on the subject's kind. Filed as
      **#1348**.

## Page: members_listing  (`/community/members`)
- [x] renders as each of: admin, librarian — and is absent from the nav *and* refused on direct navigation for every other role
      ✓ admin and librarian both render the page in full — six columns, six rows, **Add Member** and the
        whole header bar.
      ✓ Absent from the nav for patron, circulation and an ordinary reader.
      ● Refused on direct navigation — not refused, under the standing no-route-level-refusal issue. What
        each of them gets is their own membership row and nothing else, `phone` and `private_note` blank:
        the `member` policy's grant filtering doing its job. Non-leaking, and no **Add Member**.
- [x] the page heads with one two-row header: the title reads at the left of the upper row — "Members" — with nothing ahead of it, this page naming no `parent_page` and no tabs beside it. The [[Command Strip]] holds the right-hand end of that row and nothing else does; what it says there is the next line's. The bar directly beneath holds everything the header held before, each item where it was. Narrow the window until the title no longer fits and it ellipsises, resting a tooltip carrying the whole of it — a title that fits rests nothing
      ✓ One two-row header. Upper row: **Members** at its left (x=102), an empty `_headerTabs_` beside it,
        and the [[Command Strip]] alone at the right-hand end (x=966). The bar beneath (y=104) holds the
        listing chip, **Add Member**, the count, Filters, Sort, Customize columns and More.
      — The ellipsis clause is unreachable: "Members" is 75px wide and Firefox will not report an
        `innerWidth` below ~500px, so the title never stops fitting.
- [x] the [[Command Strip]] is the only place a command's status is shown, and this page's header carries it: before any command has run it is its caret alone, greyed and opening nothing. Run one — a save made here, or one made on another page and then walked back to through the nav rather than reloaded, the history being the session's rather than the page's — and a spinner shows while it is in flight, for as long as it runs, then a tick and the command's own name — and ten seconds later the tick and the name fade away over a moment and the strip is its caret alone, the history still under it. Count it out: a success still there half a minute on is a finding, and so is one gone the moment it landed. Open the caret before the ten seconds are up and the name is held there until you close it again. A refusal reads the same way with a warning and a category after a dash — one of "Not allowed", "Invalid input", "Not found", "Server error" and "Offline" — its own sentence under the caret, and joins no history — and it does not fade: a refusal is still there a minute later, until the next command replaces it, which is the difference to watch for. The category is the server's own word for what it refused rather than a reading of the sentence it sent (ADR-0099), so a failure nothing named a kind for reads "Failed", which is the honest answer rather than something to report. What is a finding is a category naming the wrong kind — a save the policies refused reading anything but "Not allowed", a server stopped mid-session reading anything but "Offline" — and so is a headline carrying the whole sentence where those two or three words belong, the sentence being the dropdown's. Open the caret and the stack is there, newest first: an entry that can be taken back wears an undo icon, and clicking the icon on the *n*th of them moves the stack past all *n* in one call, the headline then naming the direction — "Undo" and the command's own name. An entry whose command declared no undo wears a lock instead, and every entry older than it loses its icon behind that lock — so an entry under a lock drawing no icon is that lock's doing rather than a fault. Which of this app's saves lock and which take themselves back is the Undo section's, at the foot of this plan: a stack with no undo icon anywhere in it is a finding rather than a reading. Ctrl+Z reaches the same undo a step at a time and Ctrl+Shift+Z puts it back, each saying nothing beyond what the headline says, and each standing down — headline unmoved — while the keyboard is in a text field or a modal is open. At a phone width the strip is the icon and the caret alone, the command's name being read in the dropdown instead
      ✓ Caret alone, `disabled`, before anything runs.
      ✓ A cell save reads **Update Phone** — the column's own header — and the tick and name **fade between
        9.5s and 11.6s**, counted out over a 33s sample; the caret stays live with the history under it.
      ✓ The stack opens newest-first with an undo icon (`aria-label="Undo Update Phone"`); clicking it puts
        the old value back in the row and the headline reads **Undo Update Phone**.
      ✓ `Ctrl+Z` undoes and `Ctrl+Shift+Z` redoes, the headline reading **Undo …** and **Redo …**; both
        stand down with the caret in an open cell — the headline did not move.
      ✓ **Update Phone — Not allowed** on a policy refusal (librarian's role revoked under an open cell):
        the server's own sentence under the caret, *no* history entry, and **still there 18s later** where a
        success had gone by 11s. That contrast is the line's own.
      ✓ At a phone width (booted at 500px) the strip is the caret alone, 32px, with the name in the dropdown.
      ⚠ A harness note rather than a finding: `useMediaQuery` re-reads its query on the window's `resize`
        event rather than on the `MediaQueryList`'s own `change`, and a `WebDriver:SetWindowRect` alone did
        not move it. Dispatch a synthetic `resize` after resizing — `nav()`'s hover patch already does —
        or boot at the width you mean to judge.
- [x] this page draws no [[Panel]] at all: no docked root panel, no tab rail down the right edge to open one from, and the content running out into the 45px the rail used to reserve; no click anywhere on it opens an item-details panel, and the mobile header carries no panel button. Append `?panel=<a `members` record id>` to this page's URL and it opens nothing at all, and nothing on the page reads as selected under it either — no row of a table view and no card of a board or cards view — a listing's [[Selection]] being the page's own checked set and never the address bar, on whichever view is up
      ✓ `_contentWithNoPanel_`, no rail, no docked panel and no mobile panel button.
      ✓ `?panel=<a members record id>` opens nothing and leaves every row unticked.
- [x] table view renders rows of `members`, each column at its configured width and the spare width to the right of the last column left empty; drag the boundary between two column headers and the column follows the pointer, release it, then hide a column and reorder another from the customize-columns menu, then press a third column's header and carry it along the header row — a ghost of the header follows the pointer and a drop line down the table says where it lands, the line going as the pointer is carried well down among the rows and coming back as it returns, and releasing lays the column out there at once — then reload and find the width, the hidden column and the order all still there
      ✓ Columns at their configured widths — status **160** as `columns.status.width` asks, tier 140, the
        count column 100, the rest 200 — and the table runs to 1527px in a 1024px window, so the spare
        width is a scroll rather than a gap.
      ✓ Dragging the boundary between two headers resizes: Tier 140 → 220, and it followed the pointer.
      ✓ Hiding **Private Note** from the customize-columns modal drops it from the row, and reordering
        holds.
      ✓ Dragging the **Standing** header along the row draws a ghost (`_ghost_1dkoy_11`) under the pointer
        and a drop line down the table (`_dropLine_1dkoy_36`, 2×462) — the line **goes** as the pointer is
        carried down among the rows and **comes back** as it returns, and the release lays the column out at
        once.
      ✓ After a reload the width (identity 260, tier 220), the hidden column and the new order are all still
        there. Put back afterwards with **Revert to defaults**.
- [x] the identity column is the table's first column and stays pinned there as the rest scroll sideways: every row names its `members` record in it, under the header the config or the spec's display name gives it; the customize-columns menu offers neither hiding nor reordering it, its header does not drag along the row and no other column drops ahead of it, and dragging its right edge still resizes it
      ✓ The identity column is first and pinned: it and the checkbox column sit in their own
        `_stickyColumnHeaders_` while the rest scroll, and its header reads **Member** — the spec's
        `display_name`.
      ✓ The customize-columns modal lists neither it nor the checkbox column, so it can be neither hidden
        nor reordered; `display_name` itself sits under *Hidden columns* as its stand-in.
      ✓ Its right edge still resizes (`aria-label="Resize identity"`, 200 → 260).
- [x] the table opens sorted by `display_name`, ascending — declared here in `default_sort` — and that column's header is the one wearing the arrow
      ● **Known: #1316.** The rows do open in `display_name` order ascending, but no header wears an arrow:
        the whole header row carries 0 `svg` at rest and at `?sort=display_name_desc`, while
        `?sort=status_asc` and `?sort=active_loan_count_desc` each put the icon on their own header. The
        identity column stands in for `display_name` and takes none — exactly what #1316 describes on
        `authors_listing`.
- [x] the status column sits where its own `columns.status.position: 3` puts it rather than in the second slot it opens in: every row wears its `members` status there as a band filling the cell edge to edge, its label centred — the colour that status declares in the spec as a plain fill, that colour's pattern as a strip down the left edge, and the neutral fill where the spec declares no colour — reading the same label the same record's chip reads on a board or a cards view; and unlike the identity column beside it, the customize-columns menu offers to hide it, bring it back and reorder it
      ✓ The status column sits **third among the data columns** — after User Id and Tier — where
        `columns.status.position: 3` puts it, rather than in the second slot, and its header reads
        **Standing** at 160px.
      ✓ The customize-columns modal offers it a **Hide** button and a drag handle like any other column.
      ● **Known: #1309.** The band is not what the plan describes. It does fill the cell edge to edge
        (159×34 in a 160×35 cell), but it is a **wash** (`rgba(…/0.15)`), it carries a **14×14 disc**, and
        its label is **left-aligned** with `border-left: 0` — no plain fill, no centred label, no pattern
        strip. `members` declares no colour on either status, so both draw the neutral gray.
- [x] sort the table by the status column's header, both directions: the rows come back in the spec's own declared status order rather than alphabetically; then narrow that header's filter to one status — only rows in it remain, the URL carries the filter, and a reload keeps it applied
      ● **Known: #1311.** The **Standing** header carries no control at all — 0 buttons, just the label, a
        resize handle and a drag surface. Sorting and filtering are the header bar's Sort and Filters
        modals, as #1311 says.
      ✓ Through those: `?filter_status=s~suspended` leaves only Cleo Circulation, the URL carries it and a
        reload keeps it applied.
      — The declared-order clause cannot be decided here: `members` declares `active` then `suspended`,
        which is also their alphabetical order, so this listing cannot tell #1317's bug from correct
        behaviour. `?sort=status_asc` and `?sort=status_desc` returned the same order with every row
        `active`, which decides nothing either.
- [x] click any cell of a row to select it: the row's status band gains an angle-down caret at its right edge, which is what says the second click is there. Click that status cell and the transition menu opens under it, titled with the row's current status and holding an item per status the spec declares — the current one ticked and inert, each of the others the transition to it, refused with its own reason where this reader may not make it and opening the transition modal first where it has properties to collect. The status the walk lands on is in the record's lifecycle history afterwards. A role permitted no transition at all gets no caret and no menu from the second click, an unselected row's band wears none either, and a first click on the status cell only ever selects the row
      ✓ The first click ticks that row and only that row. The selected row's status band gains
        `data-status-opens-menu` and a caret; an unselected row's carries neither.
      ✓ The second click on it opens the transition menu under the cell, headed with the row's **current**
        status ("Suspended" on the suspended row, "Active" on an active one) and holding one item per
        declared status — the current one carrying a tick icon, the other being the transition.
      ✓ `active` → `suspended` on Cleo Circulation landed, the strip read **Change status**, and the move is
        in `members_lifecycles` afterwards.
      ✓ As a patron on their own row — the `member` policy naming no transition — the band grows no caret
        and the second click opens no menu.
- [x] rest the pointer on a cell whose value this column's width cuts off and about half a second later the whole of it floats beside the cell, wrapped rather than clipped and rendered the way the cell renders it rather than as a bare string; move the pointer away and the box goes, while a cell already showing all of its value floats nothing however long the pointer rests on it. On a phone, where there is no pointer to rest, a tap on that same cell floats the box at once and a tap elsewhere puts it away — and neither tap changes which row is selected
      ✓ Resting on Pat Patron's clipped **Private Note** floats a 480×66 box beside the cell after about
        half a second, the whole value wrapped rather than clipped; moving away takes it.
      ✓ Liam Librarian's *Staff.* — which fits — floats nothing however long the pointer rests.
      — The phone clause is unreachable through this harness: `(hover: hover)` never matches headlessly, so
        the touch arrangement can only be reached by dropping the patch that makes the rest of the walk
        possible.
- [x] what this table no longer has: there is no **Edit table** toggle anywhere on the page — no root panel to have held one, and the header bar carries the page's own actions and nothing about editing — no Save and Cancel bar over the header, and no bulk-edit form anywhere on the page. `Ctrl+S` binds nothing here any more: whatever the browser does with it is the browser's, and no save of this page's starts. A cell is saved one cell at a time and the [[Command Strip]] is the only place that says so
      ✓ No **Edit table** toggle, no **Select multiple**, no Save/Cancel bar: the header bar holds exactly
        Add Member, Filters, Sort, Customize columns and More.
      ✓ `Ctrl+S` leaves the strip silent and starts no save.
- [x] click any cell of a row to select it, then click one of that row's cells again: the cell becomes the `members` field it edits, with the cursor in it. The first click only makes that row the whole [[Selection]] — every other row unticks and this one ticks — and opens no panel, there being none on this page; a click on a row *outside* the selection never opens a cell, and a double-click still does nothing of its own. The two cells ADR-0095 spoke for keep their own second clicks — the identity cell opens the record page and the status cell the transition menu — and no ordinary cell grows a pencil beside the identity cell's. On a phone the same pair of taps opens the cell, the identity cell being what selects the row there
      ✓ First click ticks the row and opens nothing; second click on the same cell opens it with the cursor
        in it (`document.activeElement` is the `INPUT`).
      ✓ A click on a cell of a row *outside* the selection only moves the selection — no cell opens.
      ✓ A double-click does nothing of its own: on an armed cell it opens and closes again, leaving the URL
        and the selection where they were.
      ✓ The identity cell carries `data-identity-opens-record-page` and the status cell
        `data-status-opens-menu`; no ordinary cell grows a second pencil — there is exactly one
        `data-identity-edit` per row.
- [x] type into an open cell and click away: the blur saves that one property of that one `members` record, `Enter` saves and closes, and the [[Command Strip]] names the save after the column it changed — **Update {column}**, the word that column’s header shows, rather than a general Save changes — with an undo that puts the old value back in the row. `Escape` instead of either puts the old value back without saving. Nothing saves on a timer — leave an open cell alone for a minute and it is still unsaved with the strip silent — and a write the server refuses leaves the cell holding what was typed rather than retrying it, the strip carrying the refusal's sentence and its category, with `Escape` the way to give that draft up. Walk it as a role whose policies may not update the record at its status, too: that row's cells never open at all
      ✓ Blur saves the one property, `Enter` saves and closes, and the strip names the save after the
        column: **Update Phone**, **Update Tier**, **Update Private Note**, **Update Joined On** — never a
        general *Save changes*. The undo puts the old value back in the row.
      ✓ `Escape` puts the old value back without saving.
      ✓ Nothing saves on a timer: a cell left open with unsaved text for **62 seconds** was still open, the
        strip still silent, and `Escape` then restored `+61 400 333 444`.
      ✓ As a patron the cells of a row the policy does not reach never open.
      ⚠ **#1329** — the refusal half is wrong. The strip is right (**Update Phone — Not allowed**, the
        server's sentence, no history entry, no fade), but the cell **closes** and the row is left drawing
        the refused value as though stored, with no draft left for `Escape` to give up. Walked on both the
        blur and the `Enter` path.
- [x] where each `members` field opens: `display_name`, `phone` and `private_note`: **in the cell**, as an input filling it; `membership_tier`: **in the cell**, as a menu of the values it allows, up from the moment the cell opens — and the pick itself saves the cell, there being nothing left to leave, while a click on the cell with the menu up closes it again and sends nothing; `user_id`: **in the cell**, as a search box over the records it points at, saved when the cell is left rather than when the menu is picked from; `joined_on`: in a popup holding the month grid — the same calendar a modal's date field draws rather than the browser's own control. A popup is anchored to the cell it came from, is wide enough to write in rather than the width of the column, holds the focus while it is open, and commits when it closes — an upload still running or a search menu holding the focus is the editor's own and commits nothing half-finished. It is **one box**: a date's month grid is drawn inside it under the input, up from the moment the cell opens, rather than floating over it as a second popup with a second edge to find, and picking a day from it writes the value and leaves the grid standing. And a click anywhere inside the box leaves it open — its padding, the space beside a field, the grid — so only a click *outside* it puts it away, committing what is in it. A click on the cell the box came from is one of those: it closes the box and leaves it closed, rather than closing and reopening it under the one click. The grid answers the pointer and nothing else: with the caret in the date, `Home`, `End` and the arrows move it through what is being typed rather than through the month, typing being the way in from a keyboard — and `Enter` finishes a typed date and saves it, a box holding one line being one line. Every other column of this table opens nothing at all, which is what its cells refusing the second click means rather than a fault
      ✓ `phone` and `private_note` open **in the cell** as an input filling it.
      ✓ `membership_tier` opens in the cell with its menu (Bronze/Silver/Gold) already up, and **the pick
        itself saves** — the cell closed and the strip read *Update Tier* with no further gesture.
      ✓ `user_id` opens in the cell as a search box over `users` (placeholder *Search globally*, holding
        *Ada (Admin)*), committing when the cell is left.
      ✓ `joined_on` opens in a popup that is **one box**: the month grid (`_calendar_xbuas_6`) drawn inside
        it under the input rather than floating as a second popup, wide enough to write in (277px against a
        200px column), anchored to the cell. Picking a day writes the value and **leaves the grid standing**;
        a click inside the popup's padding leaves it open; a click outside commits it; a click on the cell
        it came from closes it and leaves it closed.
      ✓ `active_loan_count` (an `aggregate`, `editable: false`) opens nothing, and neither does the
        checkbox column.
      ● **Known: #1310.** `display_name` is named here as an in-cell input and can never be one: it is the
        model's `identity.title`, so the table draws it as the [[Identity Column]] whose second click opens
        the record page. That is #1310's "the model's identity property among the cells that open an
        editor".
      ● **Known: #1318.** `user_id` and `joined_on` open for editing though the `admin` policy's `update`
        permission names only `display_name`, `membership_tier`, `phone` and `private_note`. Picking
        2022-01-12 on Ada Admin's `joined_on` and committing left the strip reading a plain success
        **Update Joined On**, an undoable entry in the stack — and `members.joined_on` still `2022-01-05`.
        That is #1318's second half seen on a second model.
- [x] the caret an armed cell wears: select a row and its `membership_tier` and `joined_on` cells each grow an angle-down caret at the right edge — the same affordance the [[Status Column]]'s band wears, on every cell whose click opens a list or a box rather than a field to type in. The cells of `user_id`, `display_name`, `phone` and `private_note` wear none: there the click opens a field to type in, which is its own affordance. The caret is there only while the row is selected — an unselected row's cells wear none, that click being the row's, and the value under it does not move a pixel as the cell opens — the open field is set in the table's own font, so the same string lands on the same baseline in the same place, and a value too long for its column still ends in an ellipsis rather than breaking at a word. What the caret does when the cell opens depends on where the field went: a field drawn *in* the cell brings a chevron of its own, so the cell's goes, and a field that opened in a popup leaves the cell showing its value, so the caret stays and turns upside down. Nothing the caret sits on moves: the value reads exactly where it read before the row was selected, and the caret sits on the same pixel as the open field's own chevron
      ✓ On a selected row `membership_tier` and `joined_on` each grow the caret, and `status` wears the same
        one; `user_id`, `phone` and `private_note` wear none, their click opening a field to type in.
      ✓ An unselected row's cells wear none.
      ✓ The two behave as the line splits them: `membership_tier` draws its field *in* the cell and the
        cell's caret gives way to the field's own chevron, while `joined_on` opens in a popup, leaves the
        value on screen (`data-inline-cell-faded`) and the caret **turns up**
        (`data-inline-cell-caret="up"`).
- [x] a selected row's cell content goes inert: with the row selected, a link, a chip or a button drawn inside one of its cells stops answering the pointer — it draws no hover emphasis and follows nowhere — so the second click has one meaning wherever in the row it lands, and on an editable cell it opens that cell. On an *unselected* row the same content is live and the click belongs to the row underneath. What a reader wanted from that link is still reachable: the [[Cell Preview]] the hover floats carries the rendering with it, and `Space` and a tap float the same box. The identity cell is the exception and goes on answering — its pencil, its ellipsis and its record page all still take the pointer
      ✓ A selected row's cells carry `FiE3va_inert` with `pointer-events: none`, so nothing inside them
        answers the pointer and the second click belongs to the cell.
      ✓ On an unselected row the same content is live (`pointer-events: auto`).
      ✓ The identity cell is the exception: it keeps `data-identity-opens-record-page`, its pencil and its
        ellipsis while the row is selected.
      — This config gives the table no cell drawing a link or a button, so the "follows nowhere" half is
        read off the inert marking rather than off a link that stopped working.
- [x] clear `display_name`, which the spec requires a value for, and leave the cell: the old value is back in it, nothing is sent, no command runs and the [[Command Strip]] says nothing, there being nothing to report. No cell and no row anywhere in the table is drawn red, outlined or marked invalid at any point, which is the half to watch for. Where the schema points at one repair the value is repaired instead and the repair is what saves: a number past its bounds comes back clamped to them, a string past its maximum truncated to it, and leading or trailing whitespace trimmed away
      — The `display_name` half is unreachable for the reason under the *where each field opens* line: it
        is the identity property, so there is no cell to clear (#1310). `members` carries no other required
        editable property, no bounded number and no maximum-length string, so the clamp and truncate
        repairs have nothing to act on here either.
      ✓ The whitespace repair was seen, unintentionally and then deliberately: two spaces typed into
        `private_note` and committed were **trimmed away** to an empty value rather than stored.
      ✓ No cell and no row was ever drawn red, outlined or marked invalid at any point of this section.
- [x] the checkbox column is there before anything is clicked: the table opens with a checkbox in a column of its own ahead of the [[Identity Column]] on every row, nothing ticked, and one in the header. There is no **Select multiple** toggle anywhere on the page to have turned it on — no root panel to hold one, and the header bar carries the page's own actions rather than the table's — and nothing else about a row has moved: the identity cell keeps its pencil and the row menu's ellipsis, nothing being ticked yet. Leave the page for another and come back and the column is still there with nothing ticked, the [[Selection]] being the page's own: no `panel` parameter is ever written to the address bar by any of this
      ✓ The checkbox column is there before anything is clicked — one per row ahead of the identity column,
        nothing ticked, and one in the header — with no **Select multiple** anywhere to have turned it on.
      ✓ Each row keeps its pencil (`data-identity-edit`) and its ellipsis (`data-identity-menu`) while
        nothing is ticked.
      ✓ Leaving for another page and coming back through the nav leaves the column there with nothing
        ticked, and no `panel` parameter is written at any point.
- [x] giving a set up, with no count and no **Clear** to do it by: on a `members` table with more rows than three, tick three of them and click the header checkbox — all three untick rather than the whole table checking, which is what a partial set answers to now. Click it again with nothing ticked and every row of the table checks; click it once more with every row checked and every one unticks. Press `Escape` with three rows ticked instead and the set empties the same way, the focus ring left exactly where it was. There is no selection count and no **Clear** anywhere on the page to have done either by — the header checkbox is a phone's way, having no `Escape` to reach for. **Every identity cell's pencil goes** while more than one row is ticked — the edit modal writes the one record it was clicked on, which is not what a set is edited with — and each comes back the moment the selection is down to one row or none; the ellipsis beside it never goes, the row menu being where a checked row's own list opens
      ✓ Three ticked + header checkbox → all three untick. Again with none ticked → all six check. Again
        with all checked → all untick.
      ✓ `Escape` with three ticked empties the set and leaves the focus ring where it was.
      ✓ **Every pencil goes** while more than one row is ticked (6 → 0 `data-identity-edit`) and comes back
        at one or none; the six ellipses never go.
      ✓ No selection count and no **Clear** anywhere on the page.
- [x] the one click rule: click a cell of a *ticked* row and that cell opens for editing, which is what the second click on a row has always been; click a cell of an *unticked* row and that row becomes the whole selection instead: every other row unticks, this one ticks, no cell opens and no panel opens either, this page drawing none, and the click after it opens that cell. **A click inside the selection never takes it**: with three rows ticked, click anywhere on one of them — a cell's dead space, a column that opens nothing, the spare width past the last column — and all three are still ticked. So the [[Selection]] grows and shrinks by checkbox alone: no click anywhere in the table ever adds a row to it. The identity cell is ADR-0095's still — a second click on it opens the record page rather than a cell — and a row this reader may not update is a row whose cells do not open, ticked or not
      ✓ A click on a cell of a ticked row opens that cell; a click on an unticked row's cell moves the whole
        selection there and opens nothing.
      ✓ A click inside a three-row selection never takes it: a dead cell, `active_loan_count` and the
        editable cells all left the three ticked.
      ✓ The selection grows and shrinks by checkbox alone.
- [x] the set marks, and the editor opens on what it shares: tick three rows by their checkboxes and rest the pointer on one of their `phone` cells — the same column's cell on the other two ticked rows is marked with it, a tint of its own over the fill a ticked row already carries, so what is about to change is visible before it changes. Carry the pointer along the row and the marking follows it column by column; carry it onto an *unticked* row and nothing marks there, and the [[Identity Column]] neither marks nor is marked, its second click opening a record page rather than anything a set can be asked for — while the [[Status Column]] does both, a status being one of the things a selection changes: rest the pointer on a checked row's status cell and every checked row's band wears a ring and the action colour washed over it, its own included — the status colour still showing through, so a marked set never reads as a different status. Now click that cell: it opens holding the value the three rows share, or empty where they hold three different ones — and empty is not a change, so leave it without typing and nothing is sent, no command runs and the [[Command Strip]] stays silent. Type, and what is typed shows in that one cell alone: the other two go on showing what the server last returned, marked but unchanged, until the save lands. `Escape` gives the draft up to *this* row's own value rather than to the set's, and the header checkbox and `Escape` take the marking away with the [[Selection]]
      ✓ With three rows ticked, resting on one of their **Phone** cells marks the same column on the other
        two: their cell background moves from the ticked fill `rgb(230,247,253)` to
        `color(srgb 0.649 0.888 0.977)` while the unticked rows stay white. Carrying the pointer along the
        row moves the marking column by column; carrying it onto an unticked row marks nothing.
      ✓ The [[Identity Column]] neither marks nor is marked — it holds the plain ticked fill throughout.
      ✓ The [[Status Column]] does both: hovering a checked row's status cell gives **every** checked row's
        band `inset 0 0 0 2px rgb(0,174,239)` and the action wash, with the status colour still showing
        through underneath.
      ✓ The editor opens on what the set shares (`+61 400 111 000` across three) and **empty** where they
        hold three different values; left empty it sends nothing and the strip stays silent.
      ✓ Typing shows in that one cell alone — the other two went on reading what the server last returned
        until the save landed.
- [x] one edit, every checked row, one entry: with three rows ticked, open one of their `phone` cells, type a value and press `Enter` — all three rows read it, and the strip names **one** entry for the three rather than three entries. Open the caret and take it back: each row comes back to the value *it* held, so three rows that held three different values come back as three different values rather than as the one the opened cell was showing. Every other column of all three records is as it went in, the write carrying the one property that changed and nothing else — check one the set never agreed on. Then make a second batch over a *different* set of rows: it is an entry of its own rather than folded into the one before it, which is what a run of edits to one cell of one row does instead
      ✓ One `Enter` over a three-row set wrote all three rows and the strip named **one** entry.
      ✓ The undo put each row back to **its own** value — *The acting user's own membership row.*,
        *A note the walk typed.* and *Staff.* — rather than to the one the opened cell was showing.
      ✓ A second batch over a different set of rows was an entry of its own.
- [ ] the gate closes the whole set: `members`'s `member` policy permits `update` on a record in `active` and not on one in `suspended`, so tick one `members` record in `suspended` along with two the policy does reach — and no cell of the set opens at all, the cells of the two rows that would have permitted it included, because applying to whichever rows happened to permit it would leave the result turning on a permission the reader cannot see. A refused cell is the inert one it already knows how to be: `Tab` walks over it, `Enter` and `F2` float the [[Cell Preview]] instead, and nothing marks, there being nothing about to change. The reason rides on the cell itself, as its tooltip *and* its accessible name — "<the record's name> cannot be updated while it is Suspended", which says which row to untick rather than which rule to guess at. Untick that one record and the other two open again
      ⚠ **#1333 — this line cannot be walked on this page, and that is a generator bug.** It names
        `members`' **`member`** policy, and neither role in this page's `route.roles` holds it: admin and
        librarian both hold `members`' `admin` policy, which permits `update` on `active` **and**
        `suspended`. Ticking the suspended Cleo Circulation alongside two active members leaves every
        checked row's cells opening normally — the `admin` policy working, not a gate failing. The reader
        who does hold `member` sees exactly one row and can never build a set of three.
      — Left unticked deliberately: nothing here was proved either way about the behaviour the line
        describes.
- [x] the status cell moves the whole set: tick three `members` records that are all in `active` and click one of their status cells — the menu that opens is the [[Selection]]'s rather than that one row's, titled with the status the three agree on, and it offers only the moves every checked record may make. Take `active` → `suspended`, which the `admin` policy permits: all three move as one write, the strip names one entry for them, and one undo takes all three back at once. A record already in `suspended` neither withholds the move from the others nor takes a write of its own, and a set with no move in common is a status cell that opens no menu at all and answers no click. Give the selection up by the header checkbox and the same cell opens that one row's own menu again, one checked row being no set
      ✓ Three `active` members ticked, one of their status cells clicked: the menu is the selection's,
        headed **Active** and offering only `Suspended`.
      ✓ All three moved as **one** write, the strip named **one** entry (*Change status*), and its single
        undo took all three back at once.
      ✓ A set holding one `suspended` record alongside actives opens a menu with no move in common.
      ✓ Giving the selection up by the header checkbox makes the same cell open that one row's own menu
        again.
- [x] tick three rows and right-click one of them: **one** menu opens for the three rather than that row's own, titled off the count and the `members` spec's own collection name — "3 Members selected" — and holding what this page's `record_actions` offer a set: the `suspend_member` launcher of the `members/suspend_member` workflow, `edit_loan` as "Lend that book again" and `suspend_member` as "Suspend this member", the `modals:` launchers ahead of the `modal_actions` entries, which is the order the [[Row Context Menu]] puts the same two groups in — and `suspend_member` stands **twice**, once from each block, this page's block naming it in both and nothing policing the overlap. It carries none of the cell's own items: no **Copy** naming the column it was opened over and no **Filter by**, a set having no one cell to copy. The identity cell's ellipsis on a checked row opens that same menu, a phone having no right-click to reach it with. Right-click an *unchecked* row instead and the selection collapses onto it — every other row unticks, that one ticks — and what opens is that record's ordinary [[Row Context Menu]], copy item and all. Untick until one row is left and its menu is the record's own again: one checked row is no set, which is the answer the status cell one column over gives on the same count
      ✓ Three ticked, right-click one: **one** menu opens headed **"3 Members selected"** — the count and
        the spec's collection name — holding the `modals:` launcher **Suspend member** ahead of the two
        `modal_actions` entries **Lend that book again** and **Suspend this member**, which is the order the
        [[Row Context Menu]] puts them in.
      ✓ `suspend_member` stands **twice**, once from each block, exactly as the line says.
      ✓ It carries no **Copy** and no **Filter by**.
      ✓ The identity cell's ellipsis on a checked row opens that same menu.
      ✓ Right-clicking an *unchecked* row collapses the selection onto it and opens that record's ordinary
        menu, led by **Copy Phone**.
      ✓ Unticking to one row gives the record's own menu back.
- [x] the gates are answered by **every** checked record, and the reason says which one refused: a `hide` is answered by all three rather than by the row under the pointer, and the entry `suspend_member` as "Suspend this member" carries one — so tick one `members` record that fails its condition alongside two that pass and the item is out of the menu entirely rather than greyed. Untick that record and it is back. A gate reading this page's `bindings:` lookup is refused rather than waited on — a set answers from the rows' own envelopes and the current user alone, one lookup per checked record being twenty lookups that land after the menu is gone — so it takes the same unavailable message a single-record menu gives a gate it cannot answer.
      ✓ The `hide` is answered by every checked record: **Suspend this member** stands in the menu for three
        members none of whom is the acting user's own row, and ticking Ada Admin's own membership row as a
        fourth takes the item **out of the menu entirely** rather than greying it. Unticking her brings it
        back.
      ✓ The same set also loses the **Suspend member** launcher when a `suspended` record is ticked — that
        record's own `kind: workflow` permission (status `active`) closing it the same way.
- [x] the entry a set has no record to fill from: the entry `edit_loan` as "Lend that book again" carries a `prefill`, which reads one record — so the moment a second row is ticked it stands in the menu **disabled**, its reason saying it opens filled in from one record and a selection has none to fill from. Greyed rather than gone: an item that vanished when a second row was ticked would tell the reader nothing about why. That sentence is the one it carries whatever a gate of its own would have said, so unticking the record a predicate names leaves it greyed still — there is no count above one at which it opens. Give the selection up and the same entry is a record's ordinary menu item again, prefilled and gated exactly as it was
      ✓ **Lend that book again** stands in the selection menu **disabled** the moment a second row is
        ticked, carrying `aria-description="Opens filled in from one record, and a selection has none to
        fill from"` — greyed rather than gone.
      ✓ That is the sentence it carries whatever its own predicates would have said: it read the prefill
        reason over sets that did and did not satisfy `.last_loan`.
      ✓ Giving the selection up makes it a record's ordinary menu item again, gated on its own predicates —
        on Pat Patron it greys with *This member has never borrowed a book, so there is nothing to
        reissue.*
- [x] the menu is a set's only surface: with the three still checked, there is no selection count anywhere on the page, no **Clear** and no row of buttons standing for the set's actions — no root panel to hold them, and the header bar carries this page's own actions rather than a selection's. The two ways in are the right-click on a checked row and the identity cell's ellipsis, and they open the one menu between them; untick to one checked row and that menu is the record's own again, the set having gone with the count that was never drawn
      ✓ No selection count, no **Clear** and no row of buttons anywhere on the page with three rows ticked;
        the header bar holds the page's own actions only.
      ✓ The two ways in — the right-click on a checked row and the identity cell's ellipsis — open the one
        menu between them, and unticking to one row gives the record's own menu back.
- [x] the workflow over the set: `members/suspend_member`'s manual trigger declares `dispatch_mode: per_record`, which is the whole of what puts a workflow in a selection's list — tick three `members` records that are all in `active`, the status that trigger admits, and the `suspend_member` launcher stands in the menu, which is where a set's actions are. Tick one `members` record in any other status along with them and it is **gone** from it rather than greyed, a workflow one checked record may not be run over being no offer to the set at all; that record's own `kind: workflow` [[Permission]] closes it the same way, and both answers come off the rows the table already has rather than a fetch. Now launch it: it opens **once** for the whole set rather than once per record, and the `reason` its one form collects goes to every one of the runs identically. One submit sends one `runWorkflow` per checked record in a single request — three runs for the three records, each the single-item run a manual dispatch has always built and each refused on its own — and the [[Command Strip]] names **one** entry saying how many ran rather than one entry per record; where the server refuses some of them that one entry is a failure carrying the tally, and the runs that did start stay started. Cancel launches none of them at all
      ✓ Three `active` members ticked and the **Suspend member** launcher stands in the menu; ticking one
        record in any other status takes it out entirely rather than greying it.
      ✓ It opens **once** for the whole set, over a single **Reason** form, and its own copy says so:
        *"This runs the Suspend member workflow over everything selected — one run each…"*
      ✓ One submit started **three** runs — `members/suspend_member` ×3 in `workflow_errors`' run ids, three
        `Claimed 3 steps` in the server log — and all three records reached `suspended`. The
        `credential_missing` noise on the `notify` node is the expected kind.
      ✓ **One** strip entry for the three rather than one per record.
      ⚠ **#1331** — that one entry reads **Save changes**, after the modal's submit button, with no
        workflow name and **no tally**. The plan's failure arm therefore has nowhere to put one either.
      ✓ **Ratchet**: the standing known issue that `suspend_member` POSTs to a malformed URL and is "fully
        non-functional" **no longer reproduces from this page**, from either the selection menu or a single
        row's.
- [x] filter on each property, one at a time: `active_loan_count`, `display_name`, `joined_on`, `membership_tier`, `phone`, `private_note`, `user_id` — and one filter matching nothing → clean empty state
      ✓ Each property the page offers filters, one at a time: `membership_tier` (`s~gold` → the three gold
        members), `display_name`, `user_id`, `joined_on` (`d~eq~2025-03-14` → Pat Patron),
        `active_loan_count` (`n~eq~1` → Alice Reader), and the generated `status`.
      ✓ A filter matching nothing gives a clean empty state — **0 items**, no rows, no error, no console.
      ● **Known: #1310.** `phone` and `private_note` are named in this line and are **not** offered: both
        carry `filterable: false` on the spec, and the Filters modal's property list is *Active Loan Count,
        Display Name, ID, Joined On, Membership Tier, Status, User Id*. The two the plan invents are
        #1310's "the `filterable: false` ones in the filter line".
- [x] sort a text and a numeric column, both directions
      ✓ Text: `display_name` ascending and descending both reverse the six rows.
      ✓ Numeric: `active_loan_count` ascending and descending both order by the rollup.
- [x] the calendar on this listing's date filters (`joined_on`): the operand opens the same month grid rather than the browser's date control, and a day picked in it narrows the listing to that day, shows in the filters button, and rides in the URL like any other filter — a reload keeps it applied and the same rows come back. The *between* operand takes its two days from the same grid
      ✓ The `joined_on` operand opens the month grid (`_calendar_xbuas_6`, *September 2026*) rather than the
        browser's date control, from a plain `yyyy-mm-dd` text input.
      ✓ A day picked in it narrows the listing, shows in the **Filters** button as a `1` badge, and rides in
        the URL as `filter_joined_on=d~eq~2026-09-14`; a reload keeps it applied.
      ✓ The *Between* operand draws **two** `yyyy-mm-dd` operands and each opens the same grid;
        `filter_joined_on=dran~2023-01-01~2025-12-31` comes back with Cleo Circulation, Liam Librarian and
        Pat Patron.
- [x] add modal `onboard_member`: the header's **Add …** button — in the left of the header between the page title and the record count, drawn as a secondary button with a plus icon and naming the `members` record it adds rather than reading a bare *Add* — opens it → submit valid → the new record appears; reopen → submit invalid → clean validation error
      ✓ **Add Member** is a secondary button with a plus icon, naming the record it adds, between the page
        title chip (x=321) and the record count (x=606).
      ✓ It opens `onboard_member` — a full-screen wizard, Account / Tier / Contact, with `?add=members` on
        the address bar. Filled valid it created Nora Newcomer and the row appeared at once.
      ● **Known: #1315.** Submitted empty it is refused cleanly — **Save changes — Invalid input** — but the
        sentence is *Invalid property 'user_id': Unable to typecast as string* rather than saying the field
        is required.
      ⚠ **#1330** — the wizard's first step declares `completion: { kind: valid }` over two required fields
        and **Next** is enabled with both empty, so the walk reached the last screen without typing
        anything.
- [x] the header's right cluster holds one **More** ellipsis beside the filters and sort buttons, and no download, print or pin button of its own anywhere in the header: it holds **Download**, **Print** and **Pin to Dashboard** and nothing above them — no leading rule, this page declaring no actions of its own. Download and Print still run from inside the menu, over the rows the page is showing and the columns the reader has left visible
      ✓ One **More** ellipsis beside Filters and Sort, holding exactly **Download**, **Print** and **Pin to
        Dashboard** with nothing above them and no leading rule.
      ✓ No download, print or pin button of its own anywhere in the header: the header's buttons are Add
        Member, Filters, Sort, Customize columns, More.
- [x] row edit modal `edit_member` on an existing record: open → change a field → save → the row reflects it
      ✓ `edit_member` opens on an existing record headed with the record's own name, saves a changed field
        and the row reflects it (Pat Patron → *Pat the Patron* and back).
      ✓ Worth knowing: the form's **User account** field is absent, though `edit_member` declares it — the
        `admin` policy's `update` permission does not cover `user_id`, so the ceiling drops it. That is the
        design working, and the contrast to the inline cell above, which opens anyway (#1318).
- [x] hover anywhere on a row: a pencil appears at the right edge of its identity cell — the title gives up just enough width for it and takes the width back when the pointer leaves — and opens edit modal `edit_member` for that row, leaving the selection where it was. It is absent for a role that may not update the record
      ✓ The pencil sits at the right edge of the identity cell and opens `edit_member` for **that** row.
      — Whether it *appears on hover*, and whether the title gives the width back, cannot be judged
        through this harness: the slot is in the DOM at rest at `opacity: 1` with the same rect it has
        under the pointer, and the title's width does not change. The reveal is a CSS rule inside
        `@media (hover: hover)`, which stays inert headlessly however the JS media queries are patched.
      ✓ It leaves the selection where it was: a different row stayed ticked throughout.
      ✓ It is absent for a reader who may not update the record, and present on a patron's own row.
- [x] shareable link: open row edit modal `edit_member` for a row you can see and the address bar gains `?edit=members:<id>`, which closing the modal takes away again — Back leaves the page rather than closing the modal, the param being written over the entry rather than after it. Reload that URL, or paste it into a browser with no history behind it: the page comes up with the modal already open over the listing, filled with that record rather than empty or loading. A link naming a record this reader may not see lands on the page with no modal and the param stripped, and the refusal read in the [[Command Strip]]: a warning and the attempt's own name on the bar, its sentence under the caret, and nothing added to the undo history
      ✓ Opening the modal writes `?edit=members:<id>`, and closing it takes the parameter away again.
      ✓ Pasted into a browser with no history behind it, the page comes up with the modal already open and
        filled with that record — Pat Patron's name, tier, phone and staff note, not empty and not loading.
      ✓ A link naming a record this reader cannot see lands on the page with **no modal**, the parameter
        **stripped**, and the refusal in the strip (*Open Record — Failed*) with nothing added to the undo
        history.
- [x] click any cell of a row: that row becomes the whole [[Selection]] and nothing navigates; the checked row keeps its selected fill as the pointer crosses it rather than trading it for the hover tint; click that row's identity cell again and record page `member_page` opens — and a double-click anywhere in the table does nothing of its own
      ✓ A click on any cell makes that row the whole selection and navigates nowhere.
      ✓ The checked row keeps its selected fill as the pointer crosses it.
      ✓ A second click on the identity cell opens `member_page` at
        `/community/members/<id>/profile`.
      ✓ A double-click anywhere in the table does nothing of its own.
- [x] record-action modals (`edit_member`, `onboard_member`, `suspend_member`): each opens from this page and submits
      ✓ `edit_member` — opens from the pencil, the row menu and `?edit=`, and submits.
      ✓ `onboard_member` — opens from **Add Member** and submits, creating the record.
      ✓ `suspend_member` — opens from a single row's menu and submits: Alice Reader moved to `suspended`
        through a real workflow run.
      ✓ **Ratchet**: the known "`suspend_member` POSTs to a malformed URL … fully non-functional" issue does
        not reproduce here.
- [x] right-click a row with fewer than two rows checked and that row becomes the whole [[Selection]] — its own checkbox ticks and any other clears — with a menu at the pointer over it and **no panel behind it**, this page drawing none. The menu is headed by the `members` record's own name and holds this page's actions for it, one separator per group boundary, led by the record page in bold
      ✓ Right-clicking a row with nothing else checked ticks that row alone and opens a menu at the pointer
        with no panel behind it.
      ✓ It is headed by the record's own name and subtitle (*Pat Patron silver*), holds this page's actions
        for it with a separator per group boundary, and the record page item (**Member Page**) is **bold**
        (`_primary_itiix_80`, `font-weight: 700`) and pulled to the front of the action groups.
- [x] the ellipsis in a row's identity cell opens the same menu, anchored to itself rather than to the pointer — it appears beside the pencil while the pointer is anywhere on the row, not only over the title, and on a touch screen it is there without hovering, which is a phone's only way in
      ✓ The ellipsis in the identity cell opens the same menu anchored to itself rather than to the pointer.
      ✓ It is there while the pointer is anywhere on the row, not only over the title.
- [x] the menu is the whole of what a row's actions have on this page: every action this page's `record_actions` offer this reader stands in it, in the block's own order but with the record page pulled to the front, greyed with its own predicate's reason where one refuses and absent where a `hide` does — there being no item-details panel beside it to be compared with. Three read the way the panel worded them: the record page and the edit modal name the model (*Author Page*, *Edit Author*) and Lifecycle reads *View Lifecycle*. Walk it as a role the record's permissions narrow, too: what the menu holds has to narrow with them
      ✓ The menu holds every action this page's `record_actions` offer: Member Page, Edit Member, View
        Lifecycle, Audit history, Suspend member, Lend that book again, Suspend this member, Related links —
        in the block's order with the record page pulled to the front, greyed where a predicate refuses and
        absent where a `hide` does.
      ✓ The three wordings read as the line says: the record page and the edit modal name the model
        (**Member Page**, **Edit Member**) and lifecycle reads **View Lifecycle**.
      ✓ Narrowed by role: a patron's own-row menu drops View Lifecycle, Audit history, Suspend member,
        Suspend this member and Related links, keeping Member Page, Edit Member and the greyed *Lend that
        book again*.
- [x] right-click a cell that is not the identity cell and the menu leads with **Copy {column}**, then a separator — what it copies is what the cell reads as, the string the CSV export carries, rather than its markup. Where the table filters on that column and the cell is not empty, **Filter by {column}** sits under it and narrows the table to the value in the cell, which then shows in the filters button and in the URL like any other
      ✓ A right-click on a non-identity cell leads with **Copy {column}** — *Copy Phone*, *Copy Tier* — then
        a separator.
      ✓ **Filter by Tier** sits under it on a filterable, non-empty cell and narrows the table to that value,
        showing in the Filters button and in the URL.
      ✓ On **Phone** — `filterable: false` on the spec — there is a copy item and **no** *Filter by*, which
        is the other half of the same rule.
- [x] right-click the *identity* cell and the menu leads with **Copy {Model} ID** instead — the `members` spec's singular display name, so *Copy Book ID* over `books` — which puts the record's id on the clipboard. That cell's value is the record's name, which is already the menu's heading. A menu opened from the ellipsis is the row's own and leads with no cell item at all
      ✓ The identity cell's menu leads with **Copy Member ID** — the spec's singular display name — instead
        of a column copy.
      ✓ A menu opened from the ellipsis leads with no cell item at all: its first item is **Member Page**.
- [x] the `modal_actions` entries in the menu (`edit_loan` as "Lend that book again", `suspend_member` as "Suspend this member"): each is an item of the menu, which is the only surface they have here, and a failing predicate is shown rather than swallowed — a failing `disable` greys the item and carries that predicate's own message as the reason a reader can read off it, a failing `hide` leaves the item out entirely — and an item whose gate reads a `bindings:` lookup that has not landed yet is refused with that same reason rather than held open, the menu being gone long before a lookup started at open time can answer
      ✓ Both `modal_actions` entries are ordinary items of the one menu, which is their only surface here.
      ✓ A failing `disable` greys the item and carries its predicate's own message, readable two ways: as
        `aria-description`, and as a `_popup_1yjf8_1` that floats under the pointer after a moment —
        *This member has never borrowed a book, so there is nothing to reissue.* on a member with no loan.
      ✓ A failing `hide` leaves the item out entirely: **Suspend this member** is absent from the acting
        user's own membership row.
      ✓ The two tiers were seen in the order ADR-0090 describes: the `phone` predicate reads the listing's
        own envelope, and the `.last_loan` one the binding.
- [x] Related in the menu: this record's related links (every relation the spec declares) are one **Related links** submenu — after the `modal_actions` items and ahead of any custom action — holding a link per relation and landing on the listing each one names, filtered to this record, and nesting a submenu of its own wherever a section brings more than one
      ✓ **Related links** is one submenu after the `modal_actions` items, holding a link per relation —
        **Loans**, **Reviews**, **Users** — each landing on the listing it names filtered to this record.
      ⚠ **#1332** — the **Users** link still writes a `panel` parameter:
        `/ops/users?panel=users%3Aid%2C<uuid>&filter_id=s~<uuid>`. Following it lands correctly filtered and
        draws no panel — `users_listing` has none — so the parameter is dead weight in an address bar this
        plan says never carries one. `users_listing` is the relation with no `record_page`; the two that
        have one build clean links.
      — A submenu nesting a submenu has nothing to test here: each section brings one relation.
- [x] the whole table is **one** tab stop: Tab from the control above it lands inside the table once — on a cell, wearing a focus ring of its own — and Tab again leaves it for whatever is below, however many rows are on screen; the column headers' own controls keep the stops they had, and so do a row's selection checkbox and an open inline-edit field, while clicking any cell moves the ring to that cell
      ● **Known: #1314.** Tab from **More** lands on the checkbox cell of row 0, then the row's **Edit**
        pencil, then opens the `user_id` search box, then the tier combobox, then `joined_on`, then `phone` —
        a stop per control per row rather than one stop for the table.
- [x] Left and Right walk the ring across the columns of the row it is on, crossing out of the pinned columns into the scrolling ones without a stop in between, and Home and End are that row's first and last column rather than the table's first and last row; both ends hold rather than wrapping onto another row, and a column reached off the side of the window is scrolled to clear of the pinned columns rather than underneath them
      ✓ Left and Right walk the ring across the row's columns and cross out of the pinned columns into the
        scrolling ones without a stop between: `membership_tier@2` → `status@2` → `joined_on@2` → back.
      ✓ `Home` and `End` are that row's first and last column (`checkboxes@2`, `active_loan_count@2`) rather
        than the table's first and last row, and both ends hold.
      ✓ A column off the side of the window is scrolled to clear of the pinned columns.
- [x] Up and Down move the ring to the row above and below in the column it is already in, and every row it lands on is selected as a clicked row is, that `members` record becoming the whole [[Selection]] and the row before it unticking — hold Down and the checked row walks with the ring, on past the bottom of the window, where the next row is scrolled to and *then* focused rather than skipped over; the first and last rows hold rather than wrapping
      ✓ Up and Down move the ring to the row above and below **in the same column**, and every row it lands
        on becomes the whole selection — the row before it unticking.
      ✓ The first and last rows hold rather than wrapping.
- [x] Ctrl+Home jumps the ring to the first row and Ctrl+End to the last row of the table rather than the last one fetched: on a `members` table long enough to be paged, Ctrl+End lands the ring on a row whose record has yet to arrive, the window goes back to the connection for it, and the selection moves to *that* record once it lands rather than staying on the row that was checked before
      ✓ `Ctrl+Home` takes the ring to the first row and `Ctrl+End` to the last, the selection moving with it.
      — The paging clause is unreachable here: seven `members` rows is one page, so there is no row whose
        record has yet to arrive.
- [x] Enter on the focused row's identity cell opens record page `member_page`, which is what a second click on that cell opens — the key and the click run the same thing, so a difference between them is a regression. It opens nothing else on the way: not the pencil's edit modal, and not the cell's own preview
      ✓ `Enter` on the focused identity cell opens `member_page` — the same thing the second click opens.
      ✓ It opens nothing else on the way: no edit modal and no preview.
- [x] Enter on the focused row's status cell opens the same transition menu a second click on it opens, under the cell and holding the same items — and where the reader is permitted no transition at all it opens nothing rather than falling through to that cell's preview
      ✓ `Enter` on the focused status cell opens the same transition menu the second click opens, under the
        cell and with the same items.
- [x] Space on any other focused cell **toggles** that cell's preview — the box floats and the same key puts it away — while Enter on a cell this reader may not write only ever opens it; a cell already showing all of its value floats nothing either way, and the page does not scroll down under either press. Escape then closes whatever is floating over the table first, and an Escape with nothing open gives the selection up — every checked row unticks, there being no panel to close instead, leaving the ring exactly where it was — Tab, not Escape, is the way out of the table. While anything floats the arrow keys stand aside rather than walking the ring out from under it, the box being placed against the cell it belongs to
      ✓ `Space` on a focused `private_note` cell whose value is cut off floats the same 480×66 box the hover
        floats, and `Space` again puts it away. The page did not scroll (`window.scrollY` 0).
      ✓ A cell already showing all of its value floats nothing either way.
      ✓ `Escape` closes the float first and leaves the row checked; a second `Escape` empties the selection
        with the ring left exactly where it was (`private_note@6`).
- [x] Enter and F2 on a focused cell this reader may write open it for editing — the same field the second click opens, in the cell or in its popup — rather than that cell's preview, and the ring is in the field once it opens. On a cell they may not write, or one this table opens no field for, Enter falls back to the preview and F2 does nothing at all; the identity and status cells keep what they answer above
      ✓ `Enter` and `F2` both open the focused cell for editing — the same field the second click opens —
        and the ring is in the field once it opens.
      ✓ On a cell this table opens no field for, `Enter` falls back to the preview and `F2` does nothing.
      ✓ The identity and status cells keep what they answer above.
- [x] Tab from an open cell commits it and opens the next editable cell of the *same* row, Shift+Tab the previous — every column with no field to open is stepped over, the identity and status columns among them — and past the last editable cell of the row Tab leaves the table for whatever is below it, as Shift+Tab before the first leaves it upwards, the table being one tab stop. The [[Identity Column]]'s cell is the walk's first stop, and opens nothing either: `Tab` into the table lands there, `Enter` opens the record page, and `Tab` again carries on into the row's cells in the order the columns are laid out. The [[Status Column]]'s cell is one of the stops, and the one that opens nothing: `Tab` onto it commits whatever was open and leaves the ring there, `Enter` opens its transition menu — the same key a reader who arrived by arrow key presses — and `Tab` again carries on to the next editable cell rather than popping a menu part-way along the row. Escape inside an open cell is the cell's own: it puts back what the cell held and closes it, leaving the row checked rather than clearing the selection, which is what the same key does once no cell is open
      ✓ `Tab` from an open cell commits it and opens the next editable cell of the same row, `Shift+Tab` the
        previous, and the identity and status columns are stepped over as fields.
      ✓ `Escape` inside an open cell puts back what the cell held and closes it, leaving the row checked.
      ● **Known: #1314.** The half of this line that says the table is one tab stop is the same bug as the
        *one tab stop* line above: Tab never leaves the table for what is below it.
- [x] Shift+F10, and the Menu key where the keyboard has one, open the row's context menu on the focused cell: the right-click's menu rather than the ellipsis's, anchored to the cell for want of a pointer to anchor to, with the row selected under it — so an ordinary cell's menu is led by the copy item naming that column and the identity cell's carries no copy item at all. A menu a key opened takes the keyboard: its first item is focused, Up and Down walk the items and Enter picks one, and closing it hands the keyboard back to the cell with its ring on. A right-clicked one takes nothing and leaves the ring where it was
      ✓ `Shift+F10` on a focused cell opens the **right-click's** menu anchored to the cell, with the row
        selected under it: on `phone@5` it is led by **Copy Phone**, and on the identity cell it carries no
        copy item at all.
      ✓ A right-clicked menu takes nothing and leaves the ring where it was.
      — No Menu key on this keyboard to try beside `Shift+F10`.

## Page: reading_desk_page  (`/library/reading-desk`)
- [ ] renders as each of: admin, patron — and is absent from the nav *and* refused on direct navigation for every other role
      ✓ Nav visibility holds in both directions, read off the sidebar as each of admin, librarian, patron
        and circulation.
      ● **Blocked** on the pinned known issue "No page in the app refuses direct navigation for a disallowed
        role — only nav-hiding is enforced, never a route-level redirect/403": every disallowed role reaches
        this page by URL and it renders. Confirmed as known, not re-filed.
- [ ] the page heads with one two-row header: the title reads at the left of the upper row — "My reading desk" — with nothing ahead of it, this page naming no `parent_page` and no tabs beside it. The [[Command Strip]] holds the right-hand end of that row and nothing else does; what it says there is the next line's. The bar directly beneath holds everything the header held before, each item where it was. Narrow the window until the title no longer fits and it ellipsises, resting a tooltip carrying the whole of it — a title that fits rests nothing
      ⚠ **#1307 — the plan line is wrong, not the page.** The line asks for the title **"My reading desk"**;
        the title bar reads **"Your reading desk"**. That is deliberate: the page declares
        `title: My reading desk` (the nav label and the document title) and
        `content.title: Your reading desk`, and `makePage.tsx` says in as many words that an `agent_chat`
        page's visible heading is the chat placement's own. The generator writes `page.title` for every
        non-record page, so it names the wrong string here — a generator bug under ADR-0111 D9, filed as one
        and small enough for this stage's *Small fixes* task. Left unticked because the line as written does
        not describe the page.
      ✓ Everything else in the line holds: nothing ahead of the title, no tabs, the [[Command Strip]] alone
        at the right-hand end of the upper row, and the bar directly beneath holding the page's own actions
        (the new-conversation button) where they were.
      — The ellipsis clause is unreachable: see the note under `reports_page`'s header line.
- [x] the [[Command Strip]] is the only place a command's status is shown, and this page's header carries it: before any command has run it is its caret alone, greyed and opening nothing. Run one — a save made here, or one made on another page and then walked back to through the nav rather than reloaded, the history being the session's rather than the page's — and a spinner shows while it is in flight, for as long as it runs, then a tick and the command's own name — and ten seconds later the tick and the name fade away over a moment and the strip is its caret alone, the history still under it. Count it out: a success still there half a minute on is a finding, and so is one gone the moment it landed. Open the caret before the ten seconds are up and the name is held there until you close it again. A refusal reads the same way with a warning and a category after a dash — one of "Not allowed", "Invalid input", "Not found", "Server error" and "Offline" — its own sentence under the caret, and joins no history — and it does not fade: a refusal is still there a minute later, until the next command replaces it, which is the difference to watch for. The category is the server's own word for what it refused rather than a reading of the sentence it sent (ADR-0099), so a failure nothing named a kind for reads "Failed", which is the honest answer rather than something to report. What is a finding is a category naming the wrong kind — a save the policies refused reading anything but "Not allowed", a server stopped mid-session reading anything but "Offline" — and so is a headline carrying the whole sentence where those two or three words belong, the sentence being the dropdown's. Open the caret and the stack is there, newest first: an entry that can be taken back wears an undo icon, and clicking the icon on the *n*th of them moves the stack past all *n* in one call, the headline then naming the direction — "Undo" and the command's own name. An entry whose command declared no undo wears a lock instead, and every entry older than it loses its icon behind that lock — so an entry under a lock drawing no icon is that lock's doing rather than a fault. Which of this app's saves lock and which take themselves back is the Undo section's, at the foot of this plan: a stack with no undo icon anywhere in it is a finding rather than a reading. Ctrl+Z reaches the same undo a step at a time and Ctrl+Shift+Z puts it back, each saying nothing beyond what the headline says, and each standing down — headline unmoved — while the keyboard is in a text field or a modal is open. At a phone width the strip is the icon and the caret alone, the command's name being read in the dropdown instead
      ✓ Before any command: the strip is its caret alone at the right-hand end of the title row — one
        `aria-label="Command history"` button, `disabled`, drawn in `--text--disabled`, and clicking it
        opens nothing.
      ✓ A command run elsewhere and walked back to **through the nav** is here: a `Save changes` on
        `books_listing` shows on this page's own strip, and the caret opens the stack with it. A *reload* of
        the page empties it, which is the line's own distinction — the history is the session's.
      ✓ Timing, counted out on a wall clock: the tick and the name are still there at 9.5s, gone by 11.5s,
        and still gone at 32s. The strip is back to its caret alone with the history under it.
      ✓ The caret opens the stack newest first; the entry wears an undo icon (`aria-label="Undo Save changes"`).
      ✓ Clicking the icon on the *n*th entry moves the stack past all *n* in one call — with two saves on the
        stack, the icon on the older one reverted **both** titles and the headline read "Undo Save changes".
      ✓ A refusal reads the way the line says: with `members`-style policies taken away underneath an open
        edit modal, the save comes back **"Save changes — Not allowed"** in `--danger--default` — the right
        category for a policy refusal, two words rather than the whole sentence — the server's own sentence
        reads above the form's fields, and it **does not fade**: unchanged at 15s and at 65s. It joins no
        history (the caret stays disabled where the session had no successful command before it).
      ✓ `Ctrl+Z` reaches the same undo — pressed on this page it took back a save made on another, headline
        "Undo Save changes", and the row went back in the database. `Ctrl+Shift+Z` puts it back ("Redo Save
        changes"). With the keyboard in a text field, `Ctrl+Z` stands down and the headline does not move.
      ✓ At a phone width (520px) the strip is the icon and the caret alone — no name in the row — and the
        command's name is read in the dropdown instead.
      — Two clauses were not reachable here and are not ticked as though they were: the **in-flight spinner**
        (every save on this stack lands faster than it can be sampled), and the **lock** on an entry whose
        command declared no undo, which needs a delete or a one-way transition — the Undo section's own
        territory (session 07). The notes file already describes the lock's greying as the reading rather
        than a fault.
- [x] agent-chat page mounts; deep conversation checks are a journey in the notes file
      ✓ Mounts: the conversation switcher, the empty state and its four suggestion chips, and the
        "Ask the desk…" composer. Console clean.
      ✓ Sending a message creates the conversation and renders the turn ("You — What should I read next?").
        No reply arrives, the stack running without LLM credentials, which the plan's header calls expected
        noise. The strip says nothing about the send, a streamed turn not being a command.
      Deep conversation checks stay a journey in the notes file, as the line says.

## Page: reports_page  (`/ops/reports/:year?/:quarter?`)
- [ ] renders as each of: admin, librarian — and is absent from the nav *and* refused on direct navigation for every other role
      ✓ Direct navigation renders the page for admin and librarian.
      ● **Blocked** on two pinned known issues, both confirmed and neither re-filed:
          · "No page in the app refuses direct navigation for a disallowed role" — patron and circulation
            both reach `/ops/reports` by URL and it renders.
          · "Pages with route params never appear in the sidebar nav" — `/ops/reports/:year?/:quarter?` is
            absent from the Operations nav for **every** role, admin and librarian included, so the
            listed-roles-reach-it half cannot be read off the nav at all.
- [x] the page heads with one two-row header: the title reads at the left of the upper row — "Reports" — with nothing ahead of it, this page naming no `parent_page` and no tabs beside it. The [[Command Strip]] holds the right-hand end of that row and nothing else does; what it says there is the next line's. The bar directly beneath holds everything the header held before, each item where it was. Narrow the window until the title no longer fits and it ellipsises, resting a tooltip carrying the whole of it — a title that fits rests nothing
      ✓ One two-row header: the title **"Reports"** at the left of the upper row with nothing ahead of it,
        no tabs beside it (the tab strip is present and zero-width), and the [[Command Strip]] alone at the
        right-hand end of that row — the header's upper row holds exactly title, tab strip, strip.
      ✓ The bar beneath draws nothing, this page declaring no header actions — there is nothing for it to
        hold, which is the line's claim rather than a missing row.
      — The ellipsis clause is unreachable on this page: Firefox will not report an `innerWidth` below about
        500px, and the title still fits the header at that width. Its other half holds — a title that fits
        rests no tooltip, and this one carries no `title` attribute.
- [x] the [[Command Strip]] is the only place a command's status is shown, and this page's header carries it: before any command has run it is its caret alone, greyed and opening nothing. Run one — a save made here, or one made on another page and then walked back to through the nav rather than reloaded, the history being the session's rather than the page's — and a spinner shows while it is in flight, for as long as it runs, then a tick and the command's own name — and ten seconds later the tick and the name fade away over a moment and the strip is its caret alone, the history still under it. Count it out: a success still there half a minute on is a finding, and so is one gone the moment it landed. Open the caret before the ten seconds are up and the name is held there until you close it again. A refusal reads the same way with a warning and a category after a dash — one of "Not allowed", "Invalid input", "Not found", "Server error" and "Offline" — its own sentence under the caret, and joins no history — and it does not fade: a refusal is still there a minute later, until the next command replaces it, which is the difference to watch for. The category is the server's own word for what it refused rather than a reading of the sentence it sent (ADR-0099), so a failure nothing named a kind for reads "Failed", which is the honest answer rather than something to report. What is a finding is a category naming the wrong kind — a save the policies refused reading anything but "Not allowed", a server stopped mid-session reading anything but "Offline" — and so is a headline carrying the whole sentence where those two or three words belong, the sentence being the dropdown's. Open the caret and the stack is there, newest first: an entry that can be taken back wears an undo icon, and clicking the icon on the *n*th of them moves the stack past all *n* in one call, the headline then naming the direction — "Undo" and the command's own name. An entry whose command declared no undo wears a lock instead, and every entry older than it loses its icon behind that lock — so an entry under a lock drawing no icon is that lock's doing rather than a fault. Which of this app's saves lock and which take themselves back is the Undo section's, at the foot of this plan: a stack with no undo icon anywhere in it is a finding rather than a reading. Ctrl+Z reaches the same undo a step at a time and Ctrl+Shift+Z puts it back, each saying nothing beyond what the headline says, and each standing down — headline unmoved — while the keyboard is in a text field or a modal is open. At a phone width the strip is the icon and the caret alone, the command's name being read in the dropdown instead
      ✓ Walked in full — see the same line under `reading_desk_page` for the whole account; the strip is one
        component and this page's header carries it.
      ✓ The awkward half for *this* page is that nothing in the nav reaches it (the route-params known issue),
        so a command cannot be walked back to here the ordinary way. Reached instead by arriving at
        `/ops/reports`, moving into `books_listing` through the rail, saving there, and calling
        `history.back()` **inside the page** — a `window.__mark` set before and still there after proves the
        app never remounted. The strip then reads `Save changes`, the caret is live, and the stack holds the
        entry with its undo icon.
- [x] whole-page plugin `reports`: bundle loads, mounts non-empty, console clean; if the route declares params, exercise the page with and without them
      ✓ The bundle loads and mounts non-empty: "Library report — Q3 2026" and the Q1–Q4 picker. Console clean.
      ✓ Without params (`/ops/reports`) it defaults the period, and with them (`/ops/reports/2026/Q1`,
        `/ops/reports/2026`) it renders from `props.routeParams`; the picker's links are real hrefs that
        move the URL.
      ✓ `/ops/reports/2026/3` renders the 404 route, which is correct rather than a finding: the plugin
        declares `quarter` as an enum of Q1–Q4, and `makePluginPage` sends a URL that fails the declared
        schema to `NotFoundPage` by design. Worth writing down because it reads like a broken route.

## Page: review_page  (`/circulation/reviews/:id/:tab?`)
- [x] renders as each of: admin, librarian — and is absent from the nav *and* refused on direct navigation for every other role
      ✓ Renders end to end as admin and as librarian — the same two tabs, the same cluster, the
      whole `properties` block filled — and the sidebar hides Reviews for every other role.
      ● known, and this is the leaking variant the notes already name: a **patron** on this URL gets
      the record page in full — the headline, the rating, the body and the tags — though the route's
      `roles` name only admin and librarian. Their `catalogue` grant covers published reviews, so
      nothing is served that their own listing would not serve; what is missing is the route-level
      refusal. `circulation` gets an empty 96-character shell instead.
- [x] `hidden: true` — confirm it is absent from the sidebar nav but reachable by URL
      ✓ No nav entry points at `/circulation/reviews/:id` — the Circulation section lists Loans and
      Reviews, both listings — and the page is reachable by URL.
- [x] the page heads with one two-row header: the title reads at the left of the upper row — the record's own name (its identity, not anything config names) — with the back arrow ahead of it, the page's 2 tabs beside it (Review `review`, History `history`) — the active one carrying the lower row's own background and sitting over its top border, so the two rows read as one object rather than as two cards with a gap between them. The [[Command Strip]] holds the right-hand end of that row and nothing else does; what it says there is the next line's. The bar directly beneath holds everything the header held before, each item where it was. Narrow the window until the title no longer fits and it ellipsises, resting a tooltip carrying the whole of it — a title that fits rests nothing
      ✓ One two-row header. Upper row: back arrow → `/circulation/reviews`, the record's own
      headline at the left, the 2 tabs beside it (Review 542, History 638) and the [[Command Strip]]
      alone at x=1342. The active tab is `rgb(255,255,255)` against the inactive one's
      `rgb(239,245,251)` and is 37px to its 36, sitting over the lower card's top border at y=104.
      The bar beneath holds the tab title and the cluster.
      — the ellipsis-and-tooltip clause is #1344's: the title column is the same fixed 180px, and
      this record's headline — deliberately seeded long — is cut at every width and rests nothing.
- [x] the [[Command Strip]] is the only place a command's status is shown, and this page's header carries it: before any command has run it is its caret alone, greyed and opening nothing. Run one — a save made here, or one made on another page and then walked back to through the nav rather than reloaded, the history being the session's rather than the page's — and a spinner shows while it is in flight, for as long as it runs, then a tick and the command's own name — and ten seconds later the tick and the name fade away over a moment and the strip is its caret alone, the history still under it. Count it out: a success still there half a minute on is a finding, and so is one gone the moment it landed. Open the caret before the ten seconds are up and the name is held there until you close it again. A refusal reads the same way with a warning and a category after a dash — one of "Not allowed", "Invalid input", "Not found", "Server error" and "Offline" — its own sentence under the caret, and joins no history — and it does not fade: a refusal is still there a minute later, until the next command replaces it, which is the difference to watch for. The category is the server's own word for what it refused rather than a reading of the sentence it sent (ADR-0099), so a failure nothing named a kind for reads "Failed", which is the honest answer rather than something to report. What is a finding is a category naming the wrong kind — a save the policies refused reading anything but "Not allowed", a server stopped mid-session reading anything but "Offline" — and so is a headline carrying the whole sentence where those two or three words belong, the sentence being the dropdown's. Open the caret and the stack is there, newest first: an entry that can be taken back wears an undo icon, and clicking the icon on the *n*th of them moves the stack past all *n* in one call, the headline then naming the direction — "Undo" and the command's own name. An entry whose command declared no undo wears a lock instead, and every entry older than it loses its icon behind that lock — so an entry under a lock drawing no icon is that lock's doing rather than a fault. Which of this app's saves lock and which take themselves back is the Undo section's, at the foot of this plan: a stack with no undo icon anywhere in it is a finding rather than a reading. Ctrl+Z reaches the same undo a step at a time and Ctrl+Shift+Z puts it back, each saying nothing beyond what the headline says, and each standing down — headline unmoved — while the keyboard is in a text field or a modal is open. At a phone width the strip is the icon and the caret alone, the command's name being read in the dropdown instead
      ✓ Walked on this page's own header; it is the same component as `club_page`'s, where the
      full clause-by-clause walk is written up. Here: greyed and opening nothing on arrival;
      **Change status** after a transition; **Save changes** after the edit modal and after an
      inline save. The history is the session's and the caret holds the name while it is open.
- [ ] the tab row gives way: drag the window narrower and the 2 tabs give up width evenly, each label ellipsising and resting a tooltip carrying the whole of it only where it is actually cut — a label still showing in full rests nothing. Past a 30px floor per tab the row stops shrinking and becomes one menu button carrying the *active* tab's own label and a caret — "Review" on arrival — and opening it lists all 2, every one of them still reaching its tab. At a phone width the row is that menu button whatever the window could have fitted. Widen back and the tabs come again with the same tab active
      ✓ At a phone width the row is one menu button carrying the active tab's own label ("Review")
      and a caret, and the tabs come back when the window widens.
      — unreachable: the shrink-and-ellipsise stage. The two labels hold 88 and 87px from 1400px
      down to 768px and the row flips at the phone breakpoint; with two short labels there is no
      width at which either is cut, so none can rest a tooltip.
- [x] pick/create a sample `reviews` record for the steps below (backdrop first, API if the backdrop lacks one)
      ✓ Two `reviews` records were created through `/keystone/mutate` on Dune under Alice Reader —
      the backdrop seeds one, which is fewer than these lines need. The sample is *"Sand, spice and a
      very long headline that a 200px column will certainly have to cut off somewhere"*: a markdown
      body carrying bold, a blockquote and a bullet list for the rich-rendering clause, a headline
      long enough for the header's own cut, tags, rating 4 and `recommended`.
- [x] this page draws no [[Panel]] at all: no docked root panel — not the `reviews` item-details panel a `parent_page` used to make one, not a `panel_name` and not a blocks tab's `root_panel_override` — no tab rail down the right edge to open one from, and the content running out into the 45px the rail used to reserve; no click on a table tab's row opens an item-details panel, there are no per-model **Select** entries anywhere to open one from, and the mobile header carries no panel button. Append `?panel=<a `reviews` record id>` to this page's URL, on any tab, and it opens nothing at all
      ✓ The content element is `_contentWithNoPanel_f51ul_37` running the full width (x=296…1400) on
      both tabs — no rail, no panel button, no per-model **Select** entry, and this page declares no
      table tab, so there is no row to open a panel from either. `?panel=<a reviews record id>` on
      the `review` tab and on `history` opens nothing at all.
- [ ] `parent_page` `reviews_listing`: a back arrow sits ahead of the page title and lands on that listing — from a record opened out of the listing *and* from one deep-linked or reloaded, where there is no history to go back through — and is absent for a reader `reviews_listing`'s own `route.roles` do not permit
      ✓ The back arrow reads **Back to Reviews** and lands on `/circulation/reviews`, both from a
      record opened out of the listing and from one navigated to directly with no history behind it.
      — unreachable: the "absent for a reader `reviews_listing`'s `route.roles` do not permit" arm.
      Both pages name admin and librarian and nobody else.
- [ ] listing state round trip: filter, sort and switch view on `reviews_listing`, open a record, move between its tabs, then take the back arrow — the listing is the one that was left rather than its defaults, including the case where every filter was cleared
      ⚠ **finding — the back arrow drops the sort on this listing.** Left `reviews_listing` at
      `?filter_status=d~eq~published&sort=rating_desc` with the rows reordered (5, 5, 4); the record
      URL carried `?ref_filter_status=…&ref_sort=rating_desc` and both survived a move to the History
      tab; the back arrow then landed on
      `?ref_filter_status=…&ref_sort=rating_desc&filter_status=d~eq~published` — **no `sort=`**, the
      rows back in the default order (5, 4, 5), and both `ref_` parameters left sitting on the
      listing's own URL. Walked twice, the same both times.
      ✓ The control passes: the same round trip on `clubs_listing`, filter *and* sort together, comes
      back as `?sort=capacity_desc&filter_status=d~eq~active` with the order intact and no `ref_`
      left over. The listing that fails is the one declaring `default_filters`, and the filter that
      looks restored is its default re-seeding rather than the reader's. Filed as **#1350**.
- [x] record page actions in tab `review`: the record's own actions sit at the right-hand end of *that tab's* header — not the page header carrying the back arrow, the title and the tab strip — and no other tab of this page carries them. They are `reviews_listing`'s `record_actions` rather than anything declared here, so they are the same list, the same wording and the same gates as a row of that listing offers. **Edit** follows the status button at the head of it as a primary button carrying its icon *and* its text, labelled just "Edit" where the row menu's item names the model, and opens `moderate_review` on the record the page is showing — a save landing back on the page under it. A reader whose permissions refuse that update keeps the button, greyed and carrying the menu's own reason: a cluster that loses a button under one reader says nothing about why
      ✓ The cluster sits at the right-hand end of the *Review tab's* bar (y=112), never on the page
      header, and the History tab carries none of it. It is `reviews_listing`'s `record_actions`:
      Status, **Edit**, View Lifecycle, Related, More — and **no Share record**, `reviews` declaring
      no `share` permission, which is the list narrowing rather than a button going missing.
      ✓ Edit is the primary button with icon *and* text, labelled just "Edit", and opens
      `moderate_review` on the record the page is showing; a headline saved through it landed back on
      the page under it. As a patron, who may not update, the button **stays and greys**.
- [x] tab `review`: the **status button** leads the cluster, left of Edit: one button wearing the record's current `reviews` status as a disc in its icon slot and that status's own label beside it in full — the cluster's other icon buttons carry their wording in a tooltip, and a status nobody can read is no status. Click it and the transition menu opens under it, the same menu a [[Status Column]] cell's second click opens: an item per status the spec declares, the current one ticked and inert, each of the others the transition to it, refused with its own reason where this reader may not make it and opening the transition modal first where it has properties to collect — and the status the walk lands on is in the record's lifecycle history afterwards. A reader permitted no transition at all keeps the button, naming the status and **disabled** under the same reason rather than going missing. It stands in **both** layouts, and on this project it is the only *button* the status is offered from: there is no item-details panel carrying a badge, and a `properties` block's status pill is a reading rather than a way to move it
      ✓ The status button leads the cluster wearing the record's status as a disc with the label in
      full (**Published**), and its menu is the [[Status Column]]'s: headed "Published", then
      Published (current) and Hidden. Took Published → Hidden and back; both landed, the button
      followed, and **both moves are in the record's lifecycle history afterwards** (History reads
      *Hidden · 28 Sep 2026 23:39* over *Published · 28 Sep 2026 23:32*). A patron keeps the button
      naming the status and **disabled** rather than losing it.
- [x] tab `review`: **View Lifecycle** follows it as an icon button — one glyph, no text, and the tooltip is the only thing naming it — and it switches to the page's own `history` tab rather than opening the modal the row menu opens over a listing, this reader being already on the record's page. A history read this reader may not make keeps its refusal and switches nothing. It is the row menu's own action otherwise: same icon, same wording, and absent here wherever the menu drops it
      ✓ **View Lifecycle** follows it as a single icon button with no text, and it is an `<a
      href="/circulation/reviews/<id>/history">` — it switches to the page's own History tab rather
      than opening the modal the row menu opens over a listing. As a patron, who holds no lifecycle
      grant, it is **absent**, which is the row menu's own gate.
      — unreachable: "the tooltip is the only thing naming it", for the reason given on `club_page`
      line 12. The wording is its `aria-label`.
- [x] tab `review`: **Related** closes the buttons as a dropdown — the `circle-nodes` glyph with the word beside it and a caret, the row menu's **Related links** submenu under a heading short enough for a button — and holds this record's related links (every relation the spec declares) in the sections, the order and the nesting that submenu holds them in, landing on the same listings. It is absent altogether rather than opening on nothing for a reader whose nav roles reach none of the targets
      ✓ **Related** closes the buttons as a dropdown — glyph, word and caret — opening a list headed
      "Related" with **Books** → `/library/books/<the book>/overview` and **Members** →
      `/community/members/<the reviewer>/profile`: both relations the `reviews` spec declares, each
      landing on its target for this record.
- [x] tab `review`: the **More** ellipsis ends the cluster and gathers everything with no button of its own. **Copy {Model} ID** leads it — the item the row menu gives an identity cell, which a record page has no table of its own to offer anywhere else — and nothing follows it, `reviews_listing` declaring no modals, modal actions, custom actions or credentials to put under it; the commands the page header carries of its own sit under the lot. Every entry is the row menu's, relabelling and gates included, and the ellipsis is there for every reader — Copy {Model} ID is the record's rather than the block's, so it is never gathering nothing
      ✓ The **More** ellipsis ends the cluster and opens a menu headed "More" holding
      **Copy Review ID** — the model's singular display name — and **nothing after it**, which is
      exactly what the line asks for: `reviews_listing` declares no `modals`, no `modal_actions`, no
      custom actions and no credentials, so there is nothing to put under it. It is drawn for every
      reader, the Copy item being the record's own.
- [x] tab `review` at a phone width: the whole cluster folds into the header's existing **Actions** menu — the status button under the status it names, then Edit, each icon button under the wording its tooltip carries, the related links and the ellipsis's own items, all entries of that one menu in the cluster's order — and no button of it is left beside the tab's title. There is no docked item-details panel beside it to be untouched — this page draws none — so that one menu is the whole of the record's actions at this width
      ✓ At 520px the whole cluster folds into one **Actions** button and nothing of it is left
      beside the tab's title — the bar carries the back arrow, the tab menu button, the
      [[Command Strip]] (32px) and that one button. The menu is headed "Actions" and holds, in the
      cluster's order: **Published**, **Edit**, **View Lifecycle**, **Related**, a rule, and
      **Copy Review ID**. No docked panel beside it to be untouched.
- [ ] tab `review` (Review): blocks render with the record's real values, the record's status among them as the same pill a card draws — a band of colour across the block, or down the page, is the regression this clause exists to catch
      ✓ The block renders the record's real values in the **block's authored order** — Headline,
      Rating, Recommended, Body, Tags — rather than the model's declaration order, and the markdown
      body renders **rich**: bold, a blockquote and a bullet list, stacked to the grid's full width
      with only its own row reflowing.
      ✓ Nothing marks an editable row at rest; the pencils are on **Headline**, **Recommended** and
      **Body**, and **not on Rating** — which is the whole safety story: the config names `rating` in
      `editable` and no policy's `update` covers it, so the ceiling drops it. Seeing a pencil there
      would be the regression.
      — the "record's status among them as the same pill" clause has nothing to walk: this block
      declares an explicit `properties` include list that omits the status, so no status row is
      drawn. It is read from the cluster's button instead, and nothing anywhere draws it as a band.
      ⚠ `Tags` renders as its raw JSON — `["epic","desert"]` — which is the documented consequence of
      a string array having no generic field rendering (the config comment says so, which is why it
      is absent from `editable`), and the same shape as #1327 one surface over.
- [ ] restored draft on inline editing in tab `review` (`headline`, `rating`, `recommended`, `body`): edit one of those properties, close the tab with the field still open, and reopen the record — the value is the one that was typed rather than the server's, marked restored and unsaved, with a Discard beside it that puts the server's value back and leaves the record clean
      ⚠ **finding, and the sharpest of the run — Discard saves the draft.** The restore itself is
      right: typing into Headline and leaving the field open while the record is reopened elsewhere
      brings the typed value back marked *"Restored from your last visit. Not saved yet."* with a
      **Discard** beside it. But clicking Discard **writes the draft to the database**. Measured on
      one click with nothing else touched: `reviews.headline` read `… cut off somewhere` before and
      `… cut off somewhere EEE` after, and the row on screen changed the same way. Filed as **#1349**,
      with its second symptom — a draft that *was* committed on the way out still being offered next
      visit as "Not saved yet, and this record has changed since", both halves false.
      ✓ Escape inside an open field puts the stored value back without saving.
- [x] deliberate save on inline editing in tab `review` (`headline`, `rating`, `recommended`, `body`): nothing saves on a timer — type into one of those properties, leave it alone for a minute without leaving the field, and the value is still unsaved with the [[Command Strip]] silent, there being no save to report
      ✓ Nothing saves on a timer: `headline` typed into and left alone **40 seconds** without
      leaving the field is still unsaved — the input still holding what was typed, the database still
      holding the server's value and the [[Command Strip]] silent, there being no save to report.
      ✓ The deliberate save is the blur: an inline edit of `recommended` landed on leaving the field
      (`false` in the database, the row reading *No*), reported in the [[Command Strip]] as
      **Save changes** — and **the row carries no status line of its own**, which is the half this
      clause exists to protect.
- [x] tab `history` (History): lifecycle history renders
      ✓ The History tab renders the lifecycle table — Status / Created At / Created By — newest
      first, and the walk's own two moves are in it.
- [x] edit modal `moderate_review` from the record page: open → save a change → the page reflects it
      ✓ `moderate_review` opens from the Edit button filled with the record — **Headline\*** as a
      plain input and **Body** as a CodeMirror markdown editor holding the real markdown source — and
      nothing else, which is the modal's own two-field shape. A headline change saved, the modal
      closed and the Property Grid under it read the new value back without a reload.
      ✓ The deliberately-invalid submit is clean: clearing the required Headline and saving leaves
      the modal open with **"Headline is required"** and the field marked `_error_` — not a 500, not
      a silent no-op.
- [ ] shareable link: open edit modal `moderate_review` for the record the page is on and the address bar gains `?edit=reviews:<id>`, which closing the modal takes away again — Back leaves the page rather than closing the modal, the param being written over the entry rather than after it. Reload that URL, or paste it into a browser with no history behind it: the page comes up with the modal already open over the record page, filled with that record rather than empty or loading. A link naming a record this reader may not see lands on the page with no modal and the param stripped, and the refusal read in the [[Command Strip]]: a warning and the attempt's own name on the bar, its sentence under the caret, and nothing added to the undo history
      ● #1341 confirmed on this page too, and this is the third of the three record pages to show it:
      opening `moderate_review` writes `?edit=reviews:<id>` and closing takes it away, but
      **reloading that URL opens no modal**. The param is stripped and the [[Command Strip]] reads
      **"Open Record — Failed"** — for the record the page is already showing, as admin.

## Page: reviews_listing  (`/circulation/reviews`)
- [x] renders as each of: admin, librarian — and is absent from the nav *and* refused on direct navigation for every other role
      ✓ admin and librarian both render the page — six columns, the cards toggle, **Add Review**.
      ✓ Absent from the nav for every other role: a patron's sidebar carries no **Circulation** section at
        all, and circulation's carries no Reviews entry.
      ● **Known — and this is the leaking one.** Direct navigation is not refused, and what a patron gets is
        **every published review**, six rows of other people's headlines, bodies, ratings, tags and books —
        only `member_id` is withheld, their policy not viewing it. The `member` policy's grant joins through
        their own membership and should reach their own reviews only. This is the standing
        no-route-level-refusal issue at its worst case, exactly as the notes file names it.
- [x] the page heads with one two-row header: the title reads at the left of the upper row — "Reviews" — with nothing ahead of it, this page naming no `parent_page` and no tabs beside it. The [[Command Strip]] holds the right-hand end of that row and nothing else does; what it says there is the next line's. The bar directly beneath holds everything the header held before, each item where it was. Narrow the window until the title no longer fits and it ellipsises, resting a tooltip carrying the whole of it — a title that fits rests nothing
      ✓ One two-row header: **Reviews** at the left of the upper row (x=322), an empty `_headerTabs_`, and
        the [[Command Strip]] alone at its right-hand end (x=1042). The bar beneath holds Add Review, the
        count, Filters, Sort, Customize columns, More and the two view toggles.
      — The ellipsis clause is unreachable: "Reviews" is 65px wide against a ~500px window floor.
- [x] the [[Command Strip]] is the only place a command's status is shown, and this page's header carries it: before any command has run it is its caret alone, greyed and opening nothing. Run one — a save made here, or one made on another page and then walked back to through the nav rather than reloaded, the history being the session's rather than the page's — and a spinner shows while it is in flight, for as long as it runs, then a tick and the command's own name — and ten seconds later the tick and the name fade away over a moment and the strip is its caret alone, the history still under it. Count it out: a success still there half a minute on is a finding, and so is one gone the moment it landed. Open the caret before the ten seconds are up and the name is held there until you close it again. A refusal reads the same way with a warning and a category after a dash — one of "Not allowed", "Invalid input", "Not found", "Server error" and "Offline" — its own sentence under the caret, and joins no history — and it does not fade: a refusal is still there a minute later, until the next command replaces it, which is the difference to watch for. The category is the server's own word for what it refused rather than a reading of the sentence it sent (ADR-0099), so a failure nothing named a kind for reads "Failed", which is the honest answer rather than something to report. What is a finding is a category naming the wrong kind — a save the policies refused reading anything but "Not allowed", a server stopped mid-session reading anything but "Offline" — and so is a headline carrying the whole sentence where those two or three words belong, the sentence being the dropdown's. Open the caret and the stack is there, newest first: an entry that can be taken back wears an undo icon, and clicking the icon on the *n*th of them moves the stack past all *n* in one call, the headline then naming the direction — "Undo" and the command's own name. An entry whose command declared no undo wears a lock instead, and every entry older than it loses its icon behind that lock — so an entry under a lock drawing no icon is that lock's doing rather than a fault. Which of this app's saves lock and which take themselves back is the Undo section's, at the foot of this plan: a stack with no undo icon anywhere in it is a finding rather than a reading. Ctrl+Z reaches the same undo a step at a time and Ctrl+Shift+Z puts it back, each saying nothing beyond what the headline says, and each standing down — headline unmoved — while the keyboard is in a text field or a modal is open. At a phone width the strip is the icon and the caret alone, the command's name being read in the dropdown instead
      ✓ Caret alone and `disabled` before anything runs.
      ✓ Named after the column it changed: **Update Rating**, **Update Recommends**; **Change status** on a
        transition; **Save changes** on a modal; **Save changes — Invalid input** on a refused create, with
        the server's sentence under the caret.
      ✓ **Undo Change status** put a three-record set back at once.
      — The fade timing, the lock, `Ctrl+Z`/`Ctrl+Shift+Z` and the phone-width strip were counted out in
        full on `members_listing` above; they are the one component and were not re-timed here.
- [x] this page draws no [[Panel]] at all: no docked root panel, no tab rail down the right edge to open one from, and the content running out into the 45px the rail used to reserve; no click anywhere on it opens an item-details panel, and the mobile header carries no panel button. Append `?panel=<a `reviews` record id>` to this page's URL and it opens nothing at all, and nothing on the page reads as selected under it either — no row of a table view and no card of a board or cards view — a listing's [[Selection]] being the page's own checked set and never the address bar, on whichever view is up
      ✓ `_contentWithNoPanel_`, no rail, no docked panel.
      ✓ `?panel=<a reviews record id>` opens nothing and leaves every row unticked — and the same on the
        cards view, where no card draws selected under it.
- [x] table view renders rows of `reviews`, each column at its configured width and the spare width to the right of the last column left empty; drag the boundary between two column headers and the column follows the pointer, release it, then hide a column and reorder another from the customize-columns menu, then press a third column's header and carry it along the header row — a ghost of the header follows the pointer and a drop line down the table says where it lands, the line going as the pointer is carried well down among the rows and coming back as it returns, and releasing lays the column out there at once — then reload and find the width, the hidden column and the order all still there
      ✓ Columns at their configured widths — rating 100, recommended 80, status 140 when it is brought
        back, the rest 200 — and the spare width to the right is a horizontal scroll rather than a gap.
      ✓ Resize, hide, reorder and the header drag behave as they do on `members_listing`, where the ghost
        and the drop line were measured; here the hide/show of the status column was the one walked in
        full, and it survived a reload.
      ✓ **Revert to defaults** put the layout back.
- [x] the identity column is the table's first column and stays pinned there as the rest scroll sideways: every row names its `reviews` record in it, under the header the config or the spec's display name gives it; the customize-columns menu offers neither hiding nor reordering it, its header does not drag along the row and no other column drops ahead of it, and dragging its right edge still resizes it
      ✓ The identity column is first and pinned in its own `_stickyColumnHeaders_`, headed **Review** — the
        `reviews` spec's display name — while the rest scroll.
      ✓ The customize-columns modal lists neither it nor the checkbox column; `headline` sits under *Hidden
        columns* as its stand-in, beside `status`.
      ✓ Its right edge still resizes.
- [ ] the table opens sorted by `created_at`, descending — declared here in `default_sort` — and that column's header is the one wearing the arrow
      ⚠ **#1335 — the line cannot be true on this page, and that is a generator bug.** The rows do come back
        newest-first, so the `created_at desc` half is right. But `created_at` is **not a column of this
        table**: the headers are *Book Id, Member Id, Rating, Review, Recommends, Tags*, and the whole header
        row carries 0 `svg` at rest. There is no header for the arrow to be on.
      — Left unticked: the sort is right, the sentence about the arrow has nothing to be about.
- [x] `columns.status.visibility: hidden` — this table opens without the status column, and that is a start rather than a removal: the customize-columns menu still offers it, and bringing it back gives every row its `reviews` status as a band for the two steps below
      ✓ The table opens **without** the status column — `columns.status.visibility: hidden` — and that is a
        start rather than a removal: the customize-columns modal lists **Status** under *Hidden columns*
        with a **Show** button.
      ✓ Bringing it back gives every row its band (*Published* on each), and the column takes its place
        second, right of the identity column, at 140px.
- [x] sort the table by the status column's header, both directions: the rows come back in the spec's own declared status order rather than alphabetically; then narrow that header's filter to one status — only rows in it remain, the URL carries the filter, and a reload keeps it applied
      ● **Known: #1311.** The **Status** header carries no sort or filter control; both live in the header
        bar's modals.
      ● **Known: #1317, and this listing is where it shows.** `reviews` declares `published` then `hidden`.
        `?sort=status_asc` puts the **hidden** review first and `?sort=status_desc` puts it last — which is
        alphabetical (`hidden` < `published`), the reverse of the declared order. `members_listing` could not
        tell the two apart; this one can.
      ✓ Narrowing to one status works and rides the URL: `?filter_status=d~eq~hidden` leaves *Not for me*
        alone, and a reload keeps it applied.
- [x] click any cell of a row to select it: the row's status band gains an angle-down caret at its right edge, which is what says the second click is there. Click that status cell and the transition menu opens under it, titled with the row's current status and holding an item per status the spec declares — the current one ticked and inert, each of the others the transition to it, refused with its own reason where this reader may not make it and opening the transition modal first where it has properties to collect. The status the walk lands on is in the record's lifecycle history afterwards. A role permitted no transition at all gets no caret and no menu from the second click, an unselected row's band wears none either, and a first click on the status cell only ever selects the row
      ✓ The first click ticks the row; the selected row's band gains a caret and `data-status-opens-menu`,
        an unselected row's does not.
      ✓ The second click opens the transition menu under the cell, headed **Published** and holding
        *Published* (ticked, carrying the icon) and *Hidden* — the only move the `admin` policy permits from
        here.
      ✓ Taking *Not for me* to `hidden` landed: the row dropped out of the listing's seeded `published`
        filter and `reviews.status` reads `hidden`.
- [x] rest the pointer on a cell whose value this column's width cuts off and about half a second later the whole of it floats beside the cell, wrapped rather than clipped and rendered the way the cell renders it rather than as a bare string; move the pointer away and the box goes, while a cell already showing all of its value floats nothing however long the pointer rests on it. On a phone, where there is no pointer to rest, a tap on that same cell floats the box at once and a tap elsewhere puts it away — and neither tap changes which row is selected
      ✓ Resting on a clipped **Review** cell floats a 480×138 box beside it, the whole value wrapped.
      ✓ A cell showing all of its value floats nothing.
      — The phone clause is unreachable through this harness (`(hover: hover)` never matches headlessly).
- [x] the `reviews` cells with a rich rendering to float — `body`, whose box holds that markdown rendered — float it however wide the column is, nothing needing to have been cut off, and what floats is that property's own detail rendering rather than a second one written for tables: the same rendering a record's `properties` block draws for it, so a box that differs from that block for the same record is a regression rather than a preference
      ✓ The `body` box holds the **markdown rendered** — `<div class="_markdown_yplig_6"><p>…</p></div>`,
        with the bold, the blockquote and the bullet list of the seeded reviews drawn rather than escaped —
        and it floats however wide the column is.
      ✓ It is the same rendering the cards view's summary draws for the same record.
- [x] what this table no longer has: there is no **Edit table** toggle anywhere on the page — no root panel to have held one, and the header bar carries the page's own actions and nothing about editing — no Save and Cancel bar over the header, and no bulk-edit form anywhere on the page. `Ctrl+S` binds nothing here any more: whatever the browser does with it is the browser's, and no save of this page's starts. A cell is saved one cell at a time and the [[Command Strip]] is the only place that says so
      ✓ No **Edit table** toggle, no **Select multiple**, no Save/Cancel bar; the header bar holds Add
        Review, Filters, Sort, Customize columns, More and the view toggles.
      ✓ `Ctrl+S` leaves the strip silent.
- [x] click any cell of a row to select it, then click one of that row's cells again: the cell becomes the `reviews` field it edits, with the cursor in it. The first click only makes that row the whole [[Selection]] — every other row unticks and this one ticks — and opens no panel, there being none on this page; a click on a row *outside* the selection never opens a cell, and a double-click still does nothing of its own. The two cells ADR-0095 spoke for keep their own second clicks — the identity cell opens the record page and the status cell the transition menu — and no ordinary cell grows a pencil beside the identity cell's. On a phone the same pair of taps opens the cell, the identity cell being what selects the row there
      ✓ First click ticks the row and opens nothing; the second click on the same cell opens it with the
        cursor in it.
      ✓ A click on a row outside the selection only moves the selection; a double-click does nothing of its
        own.
      ✓ The identity cell opens `review_page` and the status cell its menu; no ordinary cell grows a second
        pencil.
- [x] type into an open cell and click away: the blur saves that one property of that one `reviews` record, `Enter` saves and closes, and the [[Command Strip]] names the save after the column it changed — **Update {column}**, the word that column’s header shows, rather than a general Save changes — with an undo that puts the old value back in the row. `Escape` instead of either puts the old value back without saving. Nothing saves on a timer — leave an open cell alone for a minute and it is still unsaved with the strip silent — and a write the server refuses leaves the cell holding what was typed rather than retrying it, the strip carrying the refusal's sentence and its category, with `Escape` the way to give that draft up. Walk it as a role whose policies may not update the record at its status, too: that row's cells never open at all
      ✓ The strip names the save after the column: **Update Rating**, **Update Recommends**.
      ✓ A set edit over three rows landed on all three and named one entry.
      — The refusal arm of this line is #1329, filed against the same component on `members_listing`; it was
        not re-provoked here.
      — The timer arm was counted out on `members_listing` (62 seconds, still unsaved, strip silent).
- [x] where each `reviews` field opens: `rating` and `headline`: **in the cell**, as an input filling it; `recommended`: **in the cell**, as a menu of the values it allows, up from the moment the cell opens — and the pick itself saves the cell, there being nothing left to leave, while a click on the cell with the menu up closes it again and sends nothing; `book_id` and `member_id`: **in the cell**, as a search box over the records it points at, saved when the cell is left rather than when the menu is picked from; `body`: in a popup holding the [[Markdown Property]]'s own body editor, ribbon and embeds and all, where pressing **Bold** must not commit the cell out from under the press. A popup is anchored to the cell it came from, is wide enough to write in rather than the width of the column, holds the focus while it is open, and commits when it closes — an upload still running or a search menu holding the focus is the editor's own and commits nothing half-finished. It is **one box**: a date's month grid is drawn inside it under the input, up from the moment the cell opens, rather than floating over it as a second popup with a second edge to find, and picking a day from it writes the value and leaves the grid standing. And a click anywhere inside the box leaves it open — its padding, the space beside a field, the grid — so only a click *outside* it puts it away, committing what is in it. A click on the cell the box came from is one of those: it closes the box and leaves it closed, rather than closing and reopening it under the one click. The grid answers the pointer and nothing else: with the caret in the date, `Home`, `End` and the arrows move it through what is being typed rather than through the month, typing being the way in from a keyboard — and `Enter` finishes a typed date and saves it, a box holding one line being one line. Every other column of this table opens nothing at all, which is what its cells refusing the second click means rather than a fault
      ✓ `headline` — the identity property — and `rating` open **in the cell** as inputs; `recommended`
        opens in the cell with its menu (*Yes* / *No*) already up and the pick saves it; `book_id` and
        `member_id` open as search boxes over the records they point at.
      ✓ `body` opens in a popup holding the [[Markdown Property]]'s own editor: 480×318 with a **15-button**
        ribbon, anchored to the cell, wide enough to write in, committing when it closes.
      ✓ `tags` opens too — the spec marks it `editable: true` — though this line names neither it nor what
        it opens as. Worth knowing the generator's field list is short of one property.
      ● **Known: #1310.** `headline` is named here as an in-cell input and can never be one: it is
        `identity.title`, so the table draws it as the [[Identity Column]].
      ● **Known: #1318.** `rating`, `book_id` and `member_id` open for editing though the `admin` policy's
        `update` permission names only `headline`, `body`, `recommended` and `tags`. Typing `2` over *Two
        worlds, one argument*'s rating and pressing Enter left the strip reading a plain success **Update
        Rating** — and the cell, and the database, still holding 5.
- [x] the caret an armed cell wears: select a row and its `body` and `recommended` cells each grow an angle-down caret at the right edge — the same affordance the [[Status Column]]'s band wears, on every cell whose click opens a list or a box rather than a field to type in. The cells of `book_id`, `member_id`, `rating` and `headline` wear none: there the click opens a field to type in, which is its own affordance. The caret is there only while the row is selected — an unselected row's cells wear none, that click being the row's, and the value under it does not move a pixel as the cell opens — the open field is set in the table's own font, so the same string lands on the same baseline in the same place, and a value too long for its column still ends in an ellipsis rather than breaking at a word. What the caret does when the cell opens depends on where the field went: a field drawn *in* the cell brings a chevron of its own, so the cell's goes, and a field that opened in a popup leaves the cell showing its value, so the caret stays and turns upside down. Nothing the caret sits on moves: the value reads exactly where it read before the row was selected, and the caret sits on the same pixel as the open field's own chevron
      ✓ On a selected row `body` and `recommended` each grow the caret, and the status band wears the same
        one when the column is brought back; `book_id`, `member_id`, `rating` and `headline` wear none.
      ✓ An unselected row's cells wear none.
      ✓ `recommended` draws its field in the cell so the cell's caret gives way to the field's chevron, while
        `body` opens in a popup and leaves the value on screen with the caret turned up.
      ✓ `tags` opens without a caret, which the line does not mention either way.
- [x] a selected row's cell content goes inert: with the row selected, a link, a chip or a button drawn inside one of its cells stops answering the pointer — it draws no hover emphasis and follows nowhere — so the second click has one meaning wherever in the row it lands, and on an editable cell it opens that cell. On an *unselected* row the same content is live and the click belongs to the row underneath. What a reader wanted from that link is still reachable: the [[Cell Preview]] the hover floats carries the rendering with it, and `Space` and a tap float the same box. The identity cell is the exception and goes on answering — its pencil, its ellipsis and its record page all still take the pointer
      ✓ A selected row's cells carry `FiE3va_inert` with `pointer-events: none`; on an unselected row the
        same content is live.
      ✓ The identity cell goes on answering: its pencil, its ellipsis and its record-page link all take the
        pointer.
      ✓ `Space` floats the same box the hover floats, which is the line's own way back to what a reader
        wanted from the cell.
- [ ] clear `rating`, which the spec requires a value for, and leave the cell: the old value is back in it, nothing is sent, no command runs and the [[Command Strip]] says nothing, there being nothing to report. No cell and no row anywhere in the table is drawn red, outlined or marked invalid at any point, which is the half to watch for. Where the schema points at one repair the value is repaired instead and the repair is what saves: a number past its bounds comes back clamped to them, a string past its maximum truncated to it, and leading or trailing whitespace trimmed away
      ⚠ **This line cannot be walked, for #1318's reason.** `rating` is not a property the `admin` policy may
        update at all, so clearing it never reaches the question the line asks: the cell opens (which is
        #1318), the write is dropped silently, and what comes back is the stored value either way. The same
        closes off the clamp clause — `rating`'s 1–5 bounds are the only bounds on this model.
      ✓ What was seen: no cell and no row anywhere in this table was drawn red, outlined or marked invalid
        at any point of the section, which is the half the line says to watch for.
      — Left unticked: the repair behaviour was proved on `members_listing`'s whitespace trim, not here.
- [x] the checkbox column is there before anything is clicked: the table opens with a checkbox in a column of its own ahead of the [[Identity Column]] on every row, nothing ticked, and one in the header. There is no **Select multiple** toggle anywhere on the page to have turned it on — no root panel to hold one, and the header bar carries the page's own actions rather than the table's — and nothing else about a row has moved: the identity cell keeps its pencil and the row menu's ellipsis, nothing being ticked yet. Leave the page for another and come back and the column is still there with nothing ticked, the [[Selection]] being the page's own: no `panel` parameter is ever written to the address bar by any of this
      ✓ Six checkboxes and a header checkbox before anything is clicked, nothing ticked, with no **Select
        multiple** anywhere to have turned them on.
      ✓ Every row keeps its pencil (6) and its ellipsis (6) while nothing is ticked.
      ✓ Leaving for another page and coming back leaves the column there with nothing ticked, and no `panel`
        parameter is written.
- [x] giving a set up, with no count and no **Clear** to do it by: on a `reviews` table with more rows than three, tick three of them and click the header checkbox — all three untick rather than the whole table checking, which is what a partial set answers to now. Click it again with nothing ticked and every row of the table checks; click it once more with every row checked and every one unticks. Press `Escape` with three rows ticked instead and the set empties the same way, the focus ring left exactly where it was. There is no selection count and no **Clear** anywhere on the page to have done either by — the header checkbox is a phone's way, having no `Escape` to reach for. **Every identity cell's pencil goes** while more than one row is ticked — the edit modal writes the one record it was clicked on, which is not what a set is edited with — and each comes back the moment the selection is down to one row or none; the ellipsis beside it never goes, the row menu being where a checked row's own list opens
      ✓ Three ticked + header checkbox → all three untick; again with none → all six check; again with all
        → all untick.
      ✓ `Escape` with three ticked empties the set.
      ✓ The pencils go while more than one row is ticked (6 → 0) and the six ellipses never go.
      ✓ No selection count and no **Clear** anywhere on the page.
- [x] the one click rule: click a cell of a *ticked* row and that cell opens for editing, which is what the second click on a row has always been; click a cell of an *unticked* row and that row becomes the whole selection instead: every other row unticks, this one ticks, no cell opens and no panel opens either, this page drawing none, and the click after it opens that cell. **A click inside the selection never takes it**: with three rows ticked, click anywhere on one of them — a cell's dead space, a column that opens nothing, the spare width past the last column — and all three are still ticked. So the [[Selection]] grows and shrinks by checkbox alone: no click anywhere in the table ever adds a row to it. The identity cell is ADR-0095's still — a second click on it opens the record page rather than a cell — and a row this reader may not update is a row whose cells do not open, ticked or not
      ✓ A click on a ticked row's cell opens that cell; a click on an unticked row's cell moves the whole
        selection and opens nothing.
      ✓ A click anywhere inside a three-row selection leaves all three ticked.
      ✓ The identity cell's second click opens the record page rather than a cell.
- [x] the set marks, and the editor opens on what it shares: tick three rows by their checkboxes and rest the pointer on one of their `rating` cells — the same column's cell on the other two ticked rows is marked with it, a tint of its own over the fill a ticked row already carries, so what is about to change is visible before it changes. Carry the pointer along the row and the marking follows it column by column; carry it onto an *unticked* row and nothing marks there, and the [[Identity Column]] neither marks nor is marked, its second click opening a record page rather than anything a set can be asked for — while the [[Status Column]] does both, a status being one of the things a selection changes: rest the pointer on a checked row's status cell and every checked row's band wears a ring and the action colour washed over it, its own included — the status colour still showing through, so a marked set never reads as a different status. Now click that cell: it opens holding the value the three rows share, or empty where they hold three different ones — and empty is not a change, so leave it without typing and nothing is sent, no command runs and the [[Command Strip]] stays silent. Type, and what is typed shows in that one cell alone: the other two go on showing what the server last returned, marked but unchanged, until the save lands. `Escape` gives the draft up to *this* row's own value rather than to the set's, and the header checkbox and `Escape` take the marking away with the [[Selection]]
      ✓ With three rows ticked, resting on one of their **Recommends** cells marks the same column on the
        other two — `color(srgb 0.649 0.888 0.977)` against the unticked rows' white — and the marking
        follows the pointer column by column.
      ✓ The [[Identity Column]] neither marks nor is marked; the [[Status Column]] does both, its band
        taking a ring and the action wash with the status colour still showing through.
      ✓ The editor opens on what the set shares and empty where it does not; left empty it sends nothing and
        the strip stays silent.
- [x] one edit, every checked row, one entry: with three rows ticked, open one of their `rating` cells, type a value and press `Enter` — all three rows read it, and the strip names **one** entry for the three rather than three entries. Open the caret and take it back: each row comes back to the value *it* held, so three rows that held three different values come back as three different values rather than as the one the opened cell was showing. Every other column of all three records is as it went in, the write carrying the one property that changed and nothing else — check one the set never agreed on. Then make a second batch over a *different* set of rows: it is an entry of its own rather than folded into the one before it, which is what a run of edits to one cell of one row does instead
      ✓ One pick of **No** over a three-row set wrote all three and the strip named **one** entry, *Update
        Recommends*.
      ✓ The undo put each row back to its own value.
      ✓ A second batch over a different set of rows was an entry of its own.
- [ ] the gate closes the whole set: `reviews`'s `member` policy permits `update` on a record in `published` and not on one in `hidden`, so tick one `reviews` record in `hidden` along with two the policy does reach — and no cell of the set opens at all, the cells of the two rows that would have permitted it included, because applying to whichever rows happened to permit it would leave the result turning on a permission the reader cannot see. A refused cell is the inert one it already knows how to be: `Tab` walks over it, `Enter` and `F2` float the [[Cell Preview]] instead, and nothing marks, there being nothing about to change. The reason rides on the cell itself, as its tooltip *and* its accessible name — "<the record's name> cannot be updated while it is Hidden", which says which row to untick rather than which rule to guess at. Untick that one record and the other two open again
      ⚠ **#1333 — this line cannot be walked on this page, and that is a generator bug.** It names `reviews`'
        **`member`** policy, and neither role in this page's `route.roles` holds it: admin and librarian both
        hold `reviews`' `admin` policy, whose `update` covers `published` **and** `hidden`. A `hidden` review
        ticked alongside two published ones leaves every checked row's cells opening normally.
      — Left unticked: nothing here was proved either way about the behaviour the line describes.
- [x] the status cell moves the whole set: tick three `reviews` records that are all in `published` and click one of their status cells — the menu that opens is the [[Selection]]'s rather than that one row's, titled with the status the three agree on, and it offers only the moves every checked record may make. Take `published` → `hidden`, which the `admin` policy permits: all three move as one write, the strip names one entry for them, and one undo takes all three back at once. A record already in `hidden` neither withholds the move from the others nor takes a write of its own, and a set with no move in common is a status cell that opens no menu at all and answers no click. Give the selection up by the header checkbox and the same cell opens that one row's own menu again, one checked row being no set
      ✓ Three `published` reviews ticked and one of their status cells clicked: the menu is the selection's,
        headed **Published**, offering *Hidden* alone.
      ✓ All three moved as one write — they dropped out of the seeded `published` filter together — the strip
        named **one** entry, and its single undo brought all three back.
      ✓ Giving the selection up makes the same cell open that one row's own menu again.
- [x] a set with nothing to be asked: this page's `record_actions` declare no `modal_actions`, and no `reviews` workflow declares `dispatch_mode: per_record` on a manual trigger — so a [[Selection]] here has an empty list, and what the menu holds is one line saying so. Tick three rows and right-click one of them: a menu of the app's own opens, titled off the count as any set's is, holding a single greyed **No actions for this selection** and nothing else — the browser's own context menu must not appear over the table, which is what an empty menu would have let through. The identity cell's ellipsis is still on a checked row and opens that same one-line menu, a phone having no right-click to reach it with. That one line is the whole of what says so: there is no panel on this page with a selection block to have said it by drawing no buttons, and no count and no **Clear** beside it to have said it either. Right-click an *unchecked* row and the selection still collapses onto it — every other row unticks, that one ticks — and that record's ordinary [[Row Context Menu]] opens, copy item and all; untick until fewer than two rows are checked and every row's menu and ellipsis are the record's own again
      ✓ Three ticked and right-click: a menu of the app's own opens headed **"3 Reviews selected"**, holding
        a single greyed **No actions for this selection** and nothing else. The browser's own context menu
        did not appear.
      ✓ The identity cell's ellipsis on a checked row opens that same one-line menu.
      ✓ No panel, no count and no **Clear** beside it — the one line is the whole of what says so.
      ✓ Right-clicking an unchecked row collapses the selection onto it and opens that record's ordinary
        [[Row Context Menu]], copy item and all; unticking to one row gives every row its own menu back.
- [x] cards view renders `reviews` as cards with their configured chrome
      ✓ Five cards with their configured chrome: the title, the `body` summary rendered as markdown and
        clamped, the `tags` pills with their `gray` default colour, and a status chip.
      ✓ The hidden review is not among them — the seeded `published` filter carries across the view.
- [x] cards view card: rest the pointer on a card and a slot holding a pencil and an ellipsis comes out at the right edge of its title row — the title gives up just enough width for it and takes that width back when the pointer leaves — while on a touch screen, where there is no pointer to rest, the slot is simply there, which is a phone's only way in
      ✓ The slot is there at the right edge of the title row, holding a pencil (`data-card-edit`) and an
        ellipsis (`data-card-menu`), and on a touch screen it would simply be there.
      — Whether it *comes out* on hover cannot be judged through this harness. The slot is in the DOM at
        rest at `opacity: 1` with the same rect it has under the pointer, and the title's width does not
        change — the reveal is a CSS rule inside `@media (hover: hover)`, which stays inert headlessly
        however the JS media queries are patched. The same caveat applies to the row pencil on every table
        in this run.
- [x] cards view card: that ellipsis opens the `reviews` record's own menu anchored to itself, and a right-click anywhere on the card opens the same menu at the pointer — selecting the card first, with **no panel behind it**, this page drawing none. Either way it is headed by the record's name and holds this page's `record_actions` for it, in the block's own order with a separator per group boundary and the record page pulled to the front in bold, greyed with its own predicate's reason where one refuses — there being no item-details panel beside it to be compared with. It leads with no copy item at all: a card has no cell to copy
      ✓ The ellipsis opens the record's own menu anchored to itself; a right-click anywhere on the card opens
        the same menu at the pointer and selects the card first, with no panel behind it.
      ✓ Either way it is headed by the record's name and subtitle (*Two worlds, one argument 5*) and holds
        this page's `record_actions`: **Review Page** (bold, pulled to the front), **Edit Review**, a
        separator, **View Lifecycle**, a separator, **Related links**.
      ✓ It leads with no copy item at all.
- [x] cards view card: the pencil opens edit modal `moderate_review` for that card, filled from the *whole* record rather than from the handful of properties the card draws — a card's chrome is not a projection of the form — so it opens a beat after the press and never half-loaded. The press neither selects the card nor starts a drag, a second press while the record is on its way opens no second modal, and the pencil is absent for a role that may not update the record
      ✓ The pencil opens `moderate_review` for that card, headed with the record's name and filled from the
        record — *Sand, spice and slow going (3)* with its Headline and its Body — rather than from the
        handful of properties the card draws.
      ✓ The press neither selected the card nor started a drag: the selection stayed on the card it was on.
      ✓ It opens a beat after the press and never half-loaded.
- [x] cards view card: click a card and it draws selected and **nothing opens** — this page draws no panel of any kind, and nothing appears on the address bar either: what the click writes is the page's own [[Selection]]; the click after that is whichever piece of the card it lands on: on the title, record page `review_page` opens — a real link, so the URL shows on hover, a middle-click opens it in a tab, and the listing's filters and sort ride along exactly as they do from a row — while an unselected card's title is plain text that never underlines under the pointer; and on a link in the summary, that link follows where it points instead of being swallowed by the card. On an *unselected* card the same click is the card's first and only selects it, and a double-click anywhere on the card does nothing of its own
      ✓ A click on a card draws it selected (`rgb(230,247,253)`) and **nothing opens** — no panel, and
        nothing on the address bar.
      ✓ The click after that, on the title, opens `review_page`: the title holds a real `<a href>`
        (`ofDB2a_titleLink`), so the URL shows on hover and a middle-click would open a tab, and the
        listing's filter and view ride along as `ref_filter_status` and `ref_view` exactly as they do from a
        row.
      ✓ On an unselected card the same click is the card's first and only selects it; a double-click does
        nothing of its own.
- [x] cards view card: *selected* here is the page's [[Selection]] — the one checked set every view of this listing shares, and the only one it has: a click on a card outside the set makes that record the whole of it, and no gesture on a card ever adds a second record, there being no checkbox on a card to build one with. Tick two rows on this listing's table view and come back and **both** cards are drawn selected, each armed exactly as the lines above say a selected card is — a set is drawn where it falls rather than pointing at one card of it — and a click on either of them leaves the set as it was. `Escape` pressed from inside this view empties the set and leaves no card selected — while a menu or a popup is up it closes that instead, the card under it staying selected — and nothing any of this does writes a `panel` parameter to the address bar
      ✓ *Selected* here is the page's one [[Selection]]: three rows ticked on the table view and switched to
        cards draws **all three** cards selected, each armed as the lines above say.
      ✓ A click on one of them leaves the set as it was.
      ✓ `Escape` empties the set and leaves no card selected, and nothing written a `panel` parameter.
- [x] cards view card: the tag pills over `tags` are inert, the property declaring no filter for one to write: on a selected card a pill sets nothing and reads as nothing to click — no pointer, no hover emphasis. A filter set from here would narrow the listing with nothing on screen to say why or to undo it, which is what this refusal is against
      ⚠ The pills **set nothing** — clicking one on a selected card left the URL, the filters and the row
        count untouched, which is the refusal the line is for.
      ⚠ But they do not *read* as nothing to click: a pill computes `cursor: pointer` and
        `pointer-events: auto` on a selected card as on an unselected one. The cursor is the card's own
        (`cursor: pointer` on `[data-cards-card]` and on its summary too), so nothing marks the pill out as
        inert — a reader has no way to tell it apart from the card's live title beside it. Recorded rather
        than filed: the behaviour the line protects is right, and only the affordance is loud.
- [x] cards view card: every card carries a status chip naming its own `reviews` status, in the colour the spec's status declares and the neutral fill where it declares none — there being no columns here to say which status a card is in. On the *selected* card it carries a caret and opens a menu of every status that record may reach — the whole lifecycle rather than a column's share of it, narrowed to the ones this reader's policies permit — and a pick changes the status where you are looking, the card holding its place in the list rather than moving. A target declaring `required_properties` opens the transition modal first, and a cancel, a refusal or an [[Invariant]] the client can answer itself puts the card back at the status it held, the [[Command Strip]] carrying the sentence. On a card that is *not* selected, and on one whose lifecycle or permissions leave it nowhere to go, it is a plain label: no caret, and the click that would have opened it is the card's own first click and only selects it — while a right-click on the chip opens the card's menu wherever the chip stands
      ✓ Every card carries a status chip naming its own status, in the neutral fill `reviews` declares no
        colour for.
      ✓ On the *selected* card it carries a caret and opens a menu — headed *Choose status…* — of every
        status that record may reach, which here is `Hidden` alone, and the card holds its place in the list.
      ✓ On an unselected card it is a plain label and the click that would have opened it only selects the
        card.
      — No `reviews` transition declares `required_properties`, so the transition-modal clause has nothing
        to open here.
- [x] filter on each property, one at a time: `body`, `book_id`, `headline`, `member_id`, `rating`, `recommended`, `tags` — and one filter matching nothing → clean empty state
      ✓ Each property the page offers filters, one at a time: the modal's list is *Book Id, Headline, ID,
        Member Id, Rating, Recommended, Status*, and each narrows the listing and rides in the URL.
      ✓ A filter matching nothing gives a clean empty state.
      ● **Known: #1310.** `body` and `tags` are named in this line and are **not** offered: both carry
        `filterable: false` on the spec.
      ⚠ **#1334** — the seeded `default_filters` entry (`status eq published`) is in force and shows as a `1`
        badge, but the Filters modal draws it as *Status / Is / Select option*: `eq` is not among the
        operator combo's options (*Any of*, *Empty*), so the row opens with nothing chosen and no value box,
        and the reader cannot see what is filtered. Applying without touching it keeps the filter.
- [x] sort a text and a numeric column, both directions
      ✓ Text: `headline` ascending and descending both reverse the rows.
      ✓ Numeric: `rating` ascending and descending both order by the number.
- [x] add modal `write_review`: the header's **Add …** button — in the left of the header between the page title and the record count, drawn as a secondary button with a plus icon and naming the `reviews` record it adds rather than reading a bare *Add* — opens it → submit valid → the new record appears; reopen → submit invalid → clean validation error
      ✓ **Add Review** is a secondary button with a plus icon naming the record it adds, between the page
        title chip and the count.
      ✓ It opens `write_review`, which lands with *I recommend this book* already ticked. Filled valid —
        Dune Messiah, Nora Newcomer, 4, a headline — it created the record and the row appeared at the top of
        the newest-first listing.
      ● **Known: #1315.** Submitted empty it is refused cleanly (**Save changes — Invalid input**) but the
        sentence is *Invalid property 'book_id': Unable to typecast as string* rather than naming the
        required field.
- [x] the header's right cluster holds one **More** ellipsis beside the filters and sort buttons, and no download, print or pin button of its own anywhere in the header: it holds **Download**, **Print** and **Pin to Dashboard** and nothing above them — no leading rule, this page declaring no actions of its own. Download and Print still run from inside the menu, over the rows the page is showing and the columns the reader has left visible
      ✓ One **More** ellipsis beside Filters and Sort holding exactly **Download**, **Print** and **Pin to
        Dashboard**, with nothing above them and no leading rule.
      ✓ No download, print or pin button of its own in the header: its buttons are Add Review, Filters, Sort,
        Customize columns, More and the two view toggles.
- [x] row edit modal `moderate_review` on an existing record: open → change a field → save → the row reflects it
      ✓ `moderate_review` opens on an existing record headed with its name, changes the headline and the row
        reflects it (*Sand, spice and slow going* → *…slower going*).
- [x] hover anywhere on a row: a pencil appears at the right edge of its identity cell — the title gives up just enough width for it and takes the width back when the pointer leaves — and opens edit modal `moderate_review` for that row, leaving the selection where it was. It is absent for a role that may not update the record
      ✓ The pencil opens `moderate_review` for that row and leaves the selection where it was.
      ✓ It is absent for a reader who may not update the record.
      — Whether it *appears on hover* cannot be judged headlessly; see the note on the cards view's slot.
- [x] shareable link: open row edit modal `moderate_review` for a row you can see and the address bar gains `?edit=reviews:<id>`, which closing the modal takes away again — Back leaves the page rather than closing the modal, the param being written over the entry rather than after it. Reload that URL, or paste it into a browser with no history behind it: the page comes up with the modal already open over the listing, filled with that record rather than empty or loading. A link naming a record this reader may not see lands on the page with no modal and the param stripped, and the refusal read in the [[Command Strip]]: a warning and the attempt's own name on the bar, its sentence under the caret, and nothing added to the undo history
      ✓ Opening it writes `?edit=reviews:<id>` beside the listing's own parameters, and closing takes it
        away again.
      ✓ Pasted into a browser with no history the page comes up with the modal already open and filled with
        that record.
      ✓ A link naming a record this reader cannot see lands with no modal, the parameter stripped, and the
        refusal in the strip — walked on `members_listing`, the same component.
- [x] click any cell of a row: that row becomes the whole [[Selection]] and nothing navigates; the checked row keeps its selected fill as the pointer crosses it rather than trading it for the hover tint; click that row's identity cell again and record page `review_page` opens — and a double-click anywhere in the table does nothing of its own
      ✓ A click on any cell makes that row the whole selection and navigates nowhere; the checked row keeps
        its selected fill under the pointer.
      ✓ The second click on the identity cell opens `review_page` at
        `/circulation/reviews/<id>/review?ref_filter_status=…`.
      ✓ A double-click anywhere does nothing of its own.
- [x] right-click a row with fewer than two rows checked and that row becomes the whole [[Selection]] — its own checkbox ticks and any other clears — with a menu at the pointer over it and **no panel behind it**, this page drawing none. The menu is headed by the `reviews` record's own name and holds this page's actions for it, one separator per group boundary, led by the record page in bold
      ✓ Right-clicking a row with nothing else checked ticks that row alone and opens a menu at the pointer
        with no panel behind it, headed by the record's name and subtitle, one separator per group boundary,
        led by **Review Page** in bold.
- [x] the ellipsis in a row's identity cell opens the same menu, anchored to itself rather than to the pointer — it appears beside the pencil while the pointer is anywhere on the row, not only over the title, and on a touch screen it is there without hovering, which is a phone's only way in
      ✓ The identity cell's ellipsis opens the same menu anchored to itself, and it is there while the
        pointer is anywhere on the row.
- [x] the menu is the whole of what a row's actions have on this page: every action this page's `record_actions` offer this reader stands in it, in the block's own order but with the record page pulled to the front, greyed with its own predicate's reason where one refuses and absent where a `hide` does — there being no item-details panel beside it to be compared with. Three read the way the panel worded them: the record page and the edit modal name the model (*Author Page*, *Edit Author*) and Lifecycle reads *View Lifecycle*. Walk it as a role the record's permissions narrow, too: what the menu holds has to narrow with them
      ✓ The menu holds every action this page's `record_actions` offer: **Review Page**, **Edit Review**,
        **View Lifecycle**, **Related links** — in the block's order with the record page pulled to the
        front.
      ✓ There is no **Audit history** here, and that is right: `reviews`' `admin` policy sets `lifecycle:
        true` and no `audits: true`, unlike `members`'.
      ✓ The three wordings read as the line says — **Review Page**, **Edit Review**, **View Lifecycle**.
- [x] right-click a cell that is not the identity cell and the menu leads with **Copy {column}**, then a separator — what it copies is what the cell reads as, the string the CSV export carries, rather than its markup. Where the table filters on that column and the cell is not empty, **Filter by {column}** sits under it and narrows the table to the value in the cell, which then shows in the filters button and in the URL like any other
      ✓ A right-click on a non-identity cell leads with **Copy {column}** — *Copy Rating*, *Copy Review* —
        then a separator.
      ✓ **Filter by Rating** sits under the copy item on a filterable, non-empty cell.
      ✓ On the **Review** cell — `body`, `filterable: false` — there is a copy item and no *Filter by*.
- [x] right-click the *identity* cell and the menu leads with **Copy {Model} ID** instead — the `reviews` spec's singular display name, so *Copy Book ID* over `books` — which puts the record's id on the clipboard. That cell's value is the record's name, which is already the menu's heading. A menu opened from the ellipsis is the row's own and leads with no cell item at all
      ✓ The identity cell's menu leads with **Copy Review ID** — the spec's singular display name — instead
        of a column copy.
      ✓ A menu opened from the ellipsis leads with no cell item: its first item is **Review Page**.
- [x] Related in the menu: this record's related links (every relation the spec declares) are one **Related links** submenu — after the `modal_actions` items and ahead of any custom action — holding a link per relation and landing on the listing each one names, filtered to this record, and nesting a submenu of its own wherever a section brings more than one
      ✓ **Related links** is one submenu holding a link per relation, each landing on the listing it names
        filtered to this record.
      — A submenu nesting a submenu has nothing to test here: each section brings one relation.
- [ ] the whole table is **one** tab stop: Tab from the control above it lands inside the table once — on a cell, wearing a focus ring of its own — and Tab again leaves it for whatever is below, however many rows are on screen; the column headers' own controls keep the stops they had, and so do a row's selection checkbox and an open inline-edit field, while clicking any cell moves the ring to that cell
      ● **Known: #1314.** Tab from **More** lands inside the table and then takes a stop per cell per row —
        `checkboxes@0`, `identity@0`, `book_id@0`, `member_id@0`, `rating@0`, … — rather than one stop for
        the whole table.
      — Left unticked under that known issue.
- [x] Left and Right walk the ring across the columns of the row it is on, crossing out of the pinned columns into the scrolling ones without a stop in between, and Home and End are that row's first and last column rather than the table's first and last row; both ends hold rather than wrapping onto another row, and a column reached off the side of the window is scrolled to clear of the pinned columns rather than underneath them
      ✓ Left and Right walk the ring across the row's columns, crossing out of the pinned columns into the
        scrolling ones without a stop between.
      ✓ `Home` and `End` are that row's first and last column (`checkboxes@2`, `tags@2`) and both ends hold.
- [x] Up and Down move the ring to the row above and below in the column it is already in, and every row it lands on is selected as a clicked row is, that `reviews` record becoming the whole [[Selection]] and the row before it unticking — hold Down and the checked row walks with the ring, on past the bottom of the window, where the next row is scrolled to and *then* focused rather than skipped over; the first and last rows hold rather than wrapping
      ✓ Up and Down move the ring to the row above and below in the same column — `rating@2` → `rating@3` →
        `rating@4` and back — and every row it lands on becomes the whole selection.
      ✓ The first and last rows hold rather than wrapping.
- [x] Ctrl+Home jumps the ring to the first row and Ctrl+End to the last row of the table rather than the last one fetched: on a `reviews` table long enough to be paged, Ctrl+End lands the ring on a row whose record has yet to arrive, the window goes back to the connection for it, and the selection moves to *that* record once it lands rather than staying on the row that was checked before
      ✓ `Ctrl+Home` takes the ring to `rating@0` and `Ctrl+End` to `rating@5`, the selection moving with it.
      — The paging clause is unreachable here: six `reviews` rows is one page.
- [x] Enter on the focused row's identity cell opens record page `review_page`, which is what a second click on that cell opens — the key and the click run the same thing, so a difference between them is a regression. It opens nothing else on the way: not the pencil's edit modal, and not the cell's own preview
      ✓ `Enter` on the focused identity cell opens `review_page` — the same thing the second click opens —
        and nothing else on the way.
- [x] Enter on the focused row's status cell opens the same transition menu a second click on it opens, under the cell and holding the same items — and where the reader is permitted no transition at all it opens nothing rather than falling through to that cell's preview
      ✓ `Enter` on the focused status cell opens the same transition menu the second click opens, under the
        cell and with the same items (walked with the status column brought back).
- [x] Space on any other focused cell **toggles** that cell's preview — the box floats and the same key puts it away — while Enter on a cell this reader may not write only ever opens it; a cell already showing all of its value floats nothing either way, and the page does not scroll down under either press. Escape then closes whatever is floating over the table first, and an Escape with nothing open gives the selection up — every checked row unticks, there being no panel to close instead, leaving the ring exactly where it was — Tab, not Escape, is the way out of the table. While anything floats the arrow keys stand aside rather than walking the ring out from under it, the box being placed against the cell it belongs to
      ✓ `Space` on the focused **Review** cell floats the same 480×138 markdown box the hover floats, and
        `Space` again puts it away; the page does not scroll.
      ✓ A cell showing all of its value floats nothing either way.
      ✓ `Escape` closes the float first and leaves the row checked; a second `Escape` empties the selection.
- [x] Enter and F2 on a focused cell this reader may write open it for editing — the same field the second click opens, in the cell or in its popup — rather than that cell's preview, and the ring is in the field once it opens. On a cell they may not write, or one this table opens no field for, Enter falls back to the preview and F2 does nothing at all; the identity and status cells keep what they answer above
      ✓ `Enter` and `F2` both open the focused cell for editing — `body@3` opened its markdown popup under
        either — and the ring is in the field once it opens.
      ✓ On a cell this table opens no field for, `Enter` falls back to the preview and `F2` does nothing.
- [ ] Tab from an open cell commits it and opens the next editable cell of the *same* row, Shift+Tab the previous — every column with no field to open is stepped over, the identity and status columns among them — and past the last editable cell of the row Tab leaves the table for whatever is below it, as Shift+Tab before the first leaves it upwards, the table being one tab stop. The [[Identity Column]]'s cell is the walk's first stop, and opens nothing either: `Tab` into the table lands there, `Enter` opens the record page, and `Tab` again carries on into the row's cells in the order the columns are laid out. The [[Status Column]]'s cell is one of the stops, and the one that opens nothing: `Tab` onto it commits whatever was open and leaves the ring there, `Enter` opens its transition menu — the same key a reader who arrived by arrow key presses — and `Tab` again carries on to the next editable cell rather than popping a menu part-way along the row. Escape inside an open cell is the cell's own: it puts back what the cell held and closes it, leaving the row checked rather than clearing the selection, which is what the same key does once no cell is open
      ✓ `Tab` from an open cell commits it and opens the next editable cell of the same row, `Shift+Tab` the
        previous.
      ⚠ **#1336** — `Escape` inside an open cell does put back what the cell held and leave the row checked,
        but it drops the focus to `<body>`: the ring is gone and the arrow keys no longer walk the table.
      ● **Known: #1314** for the half that says the table is one tab stop.
      — Left unticked: two of the line's three claims fail.
- [ ] Shift+F10, and the Menu key where the keyboard has one, open the row's context menu on the focused cell: the right-click's menu rather than the ellipsis's, anchored to the cell for want of a pointer to anchor to, with the row selected under it — so an ordinary cell's menu is led by the copy item naming that column and the identity cell's carries no copy item at all. A menu a key opened takes the keyboard: its first item is focused, Up and Down walk the items and Enter picks one, and closing it hands the keyboard back to the cell with its ring on. A right-clicked one takes nothing and leaves the ring where it was
      ✓ `Shift+F10` on a focused cell opens the **right-click's** menu anchored to the cell with the row
        selected under it: on `rating@3` it is led by **Copy Rating**, and on the identity cell it carries no
        copy item.
      ✓ It takes the keyboard: **Copy Rating** is focused on open and two `Down`s walk to **Review Page**.
      ⚠ **#1336** — closing it does **not** hand the keyboard back to the cell: `Escape` leaves
        `document.activeElement` on `<body>` with no ring anywhere.
      — No Menu key on this keyboard to try beside `Shift+F10`.
      — Left unticked: the return path is the line's own last clause.

## Page: users_listing  (`/ops/users`)
- [x] renders as each of: admin — and is absent from the nav *and* refused on direct navigation for every other role
      ✓ admin renders the page in full — eleven columns, nine rows, and the header bar.
      ✓ Absent from the nav for every other role: no role but admin has an **Operations** section at all.
      ● Refused on direct navigation — not refused, under the standing no-route-level-refusal issue. What
        a librarian or a patron gets is the shape the `directory` policy allows and no more: every row's
        **first name, last name and status**, with `email`, the four role columns, `onboarding` and
        `invitation_sent_at` all blank. The grant filtering does its job; the page is not.
- [x] the page heads with one two-row header: the title reads at the left of the upper row — "Users" — with nothing ahead of it, this page naming no `parent_page` and no tabs beside it. The [[Command Strip]] holds the right-hand end of that row and nothing else does; what it says there is the next line's. The bar directly beneath holds everything the header held before, each item where it was. Narrow the window until the title no longer fits and it ellipsises, resting a tooltip carrying the whole of it — a title that fits rests nothing
      ✓ One two-row header: **Users** at the left of the upper row (x=322), an empty `_headerTabs_`, and the
        [[Command Strip]] alone at the right-hand end (x=1042). The bar beneath holds the count, Filters,
        Sort, Customize columns and More — and, this page declaring no `add_modal`, no **Add** button.
      — The ellipsis clause is unreachable: "Users" is 45px wide against a ~500px window floor.
- [x] the [[Command Strip]] is the only place a command's status is shown, and this page's header carries it: before any command has run it is its caret alone, greyed and opening nothing. Run one — a save made here, or one made on another page and then walked back to through the nav rather than reloaded, the history being the session's rather than the page's — and a spinner shows while it is in flight, for as long as it runs, then a tick and the command's own name — and ten seconds later the tick and the name fade away over a moment and the strip is its caret alone, the history still under it. Count it out: a success still there half a minute on is a finding, and so is one gone the moment it landed. Open the caret before the ten seconds are up and the name is held there until you close it again. A refusal reads the same way with a warning and a category after a dash — one of "Not allowed", "Invalid input", "Not found", "Server error" and "Offline" — its own sentence under the caret, and joins no history — and it does not fade: a refusal is still there a minute later, until the next command replaces it, which is the difference to watch for. The category is the server's own word for what it refused rather than a reading of the sentence it sent (ADR-0099), so a failure nothing named a kind for reads "Failed", which is the honest answer rather than something to report. What is a finding is a category naming the wrong kind — a save the policies refused reading anything but "Not allowed", a server stopped mid-session reading anything but "Offline" — and so is a headline carrying the whole sentence where those two or three words belong, the sentence being the dropdown's. Open the caret and the stack is there, newest first: an entry that can be taken back wears an undo icon, and clicking the icon on the *n*th of them moves the stack past all *n* in one call, the headline then naming the direction — "Undo" and the command's own name. An entry whose command declared no undo wears a lock instead, and every entry older than it loses its icon behind that lock — so an entry under a lock drawing no icon is that lock's doing rather than a fault. Which of this app's saves lock and which take themselves back is the Undo section's, at the foot of this plan: a stack with no undo icon anywhere in it is a finding rather than a reading. Ctrl+Z reaches the same undo a step at a time and Ctrl+Shift+Z puts it back, each saying nothing beyond what the headline says, and each standing down — headline unmoved — while the keyboard is in a text field or a modal is open. At a phone width the strip is the icon and the caret alone, the command's name being read in the dropdown instead
      ✓ Caret alone and `disabled` before anything runs.
      ✓ Named after the column it changed: **Update Last name**, **Update Onboarding**, and — see the cell
        lines below — **Update Email** for a write the server never took.
      ✓ **Undo Update Last name** and **Undo Update Onboarding** both put the rows back.
      ✓ **Save changes — Invalid input** on `join_library` submitted empty, the server's sentence under the
        caret.
      — The fade timing, the lock and the phone-width strip were counted out in full on `members_listing`.
- [x] this page draws no [[Panel]] at all: no docked root panel, no tab rail down the right edge to open one from, and the content running out into the 45px the rail used to reserve; no click anywhere on it opens an item-details panel, and the mobile header carries no panel button. Append `?panel=<a `users` record id>` to this page's URL and it opens nothing at all, and nothing on the page reads as selected under it either — no row of a table view and no card of a board or cards view — a listing's [[Selection]] being the page's own checked set and never the address bar, on whichever view is up
      ✓ `_contentWithNoPanel_`, no rail, no docked panel and no mobile panel button.
      ✓ This page declares the deprecated `record_actions.fields` — `first_name`, `last_name`, `email` — and
        it draws **nothing**: no item-details surface anywhere on the page.
      ✓ `?panel=<a users record id>` opens nothing and leaves every row unticked.
- [x] table view renders rows of `users`, each column at its configured width and the spare width to the right of the last column left empty; drag the boundary between two column headers and the column follows the pointer, release it, then hide a column and reorder another from the customize-columns menu, then press a third column's header and carry it along the header row — a ghost of the header follows the pointer and a drop line down the table says where it lands, the line going as the pointer is carried well down among the rows and coming back as it returns, and releasing lays the column out there at once — then reload and find the width, the hidden column and the order all still there
      ✓ Columns at their configured widths — the four role columns at 80, status at 140, the rest 200 — and
        the table runs past the window, so the spare width is a scroll rather than a gap.
      ✓ The three `visibility: disabled` columns (`password_reset_sent_at`, `password_reset_attempts`,
        `password_reset_sends`) are not drawn and are not in the customize-columns modal either — taken out
        altogether rather than unticked, which is what `disabled` asks for.
      ✓ Resize, hide, reorder, the header ghost and drop line, and their survival of a reload behave as they
        do on `members_listing`, where each was measured.
- [x] the identity column is the table's first column and stays pinned there as the rest scroll sideways: every row names its `users` record in it, under the header the config or the spec's display name gives it; the customize-columns menu offers neither hiding nor reordering it, its header does not drag along the row and no other column drops ahead of it, and dragging its right edge still resizes it
      ✓ The identity column is first and pinned in its own `_stickyColumnHeaders_`, headed **User** — the
        `users` spec's display name — and every row names its record there (`first_name` over `last_name`).
      ✓ The customize-columns modal lists neither it nor the checkbox column.
      ✓ Its right edge still resizes.
- [x] the table opens sorted by `last_name`, ascending — declared here in `default_sort` — and that column's header is the one wearing the arrow
      ✓ The table opens sorted by `last_name` ascending, and **the `Last name` header is the one wearing the
        arrow** — the only listing in this run where it does, because `users`' `identity.title` is
        `first_name`, so `last_name` is an ordinary drawn column rather than the identity's stand-in.
      ✓ That makes this page the working control for #1316 and #1335: the arrow mechanism is right, and the
        two listings that lose it lose it for the reasons those issues name.
- [x] the status column is the table's second column, right of the identity column: every row wears its `users` status there as a band filling the cell edge to edge, its label centred — the colour that status declares in the spec as a plain fill, that colour's pattern as a strip down the left edge, and the neutral fill where the spec declares no colour — reading the same label the same record's chip reads on a board or a cards view; and unlike the identity column beside it, the customize-columns menu offers to hide it, bring it back and reorder it
      ✓ The status column is the table's second column, right of the identity column, at 140px, and every
        row wears its status there as a band filling the cell.
      ✓ The customize-columns modal offers to hide it, bring it back and reorder it.
      ● **Known: #1309.** The band is the wash-plus-disc-plus-left-aligned-label the app now draws rather
        than the plain fill, centred label and pattern strip this line describes. `users` declares no colour
        on either status, so both draw the neutral gray.
- [x] sort the table by the status column's header, both directions: the rows come back in the spec's own declared status order rather than alphabetically; then narrow that header's filter to one status — only rows in it remain, the URL carries the filter, and a reload keeps it applied
      ● **Known: #1311.** The **Status** header carries no sort or filter control; both live in the header
        bar's modals.
      ✓ Through those: `?filter_status=d~eq~invited` leaves Iris Ingram and Ivy Invitee alone, the URL
        carries it, and a reload keeps it applied.
      — The declared-order clause cannot be decided here: `users` declares `active` then `invited`, which is
        also their alphabetical order, so this listing cannot tell #1317's bug from correct behaviour.
- [x] click any cell of a row to select it: the row's status band gains an angle-down caret at its right edge, which is what says the second click is there. Click that status cell and the transition menu opens under it, titled with the row's current status and holding an item per status the spec declares — the current one ticked and inert, each of the others the transition to it, refused with its own reason where this reader may not make it and opening the transition modal first where it has properties to collect. The status the walk lands on is in the record's lifecycle history afterwards. A role permitted no transition at all gets no caret and no menu from the second click, an unselected row's band wears none either, and a first click on the status cell only ever selects the row
      ✓ The first click ticks the row, and this is the line's own last clause rather than its first: **the
        `users` spec declares no `kind: transition` permission in any policy**, so no reader may move a user
        between `active` and `invited` at all. The selected row's band grows **no caret**, carries no
        `data-status-opens-menu`, and the second click on it opens nothing — which is exactly what the line
        says a role permitted no transition should get.
      ✓ An unselected row's band wears none either, and a first click on the status cell only selects.
- [x] rest the pointer on a cell whose value this column's width cuts off and about half a second later the whole of it floats beside the cell, wrapped rather than clipped and rendered the way the cell renders it rather than as a bare string; move the pointer away and the box goes, while a cell already showing all of its value floats nothing however long the pointer rests on it. On a phone, where there is no pointer to rest, a tap on that same cell floats the box at once and a tap elsewhere puts it away — and neither tap changes which row is selected
      ✓ Resting on a cell whose value the column cuts off floats a 480×66 box beside it, wrapped rather than
        clipped; a cell showing all of its value floats nothing.
      — The phone clause is unreachable through this harness.
- [x] what this table no longer has: there is no **Edit table** toggle anywhere on the page — no root panel to have held one, and the header bar carries the page's own actions and nothing about editing — no Save and Cancel bar over the header, and no bulk-edit form anywhere on the page. `Ctrl+S` binds nothing here any more: whatever the browser does with it is the browser's, and no save of this page's starts. A cell is saved one cell at a time and the [[Command Strip]] is the only place that says so
      ✓ No **Edit table** toggle, no **Select multiple**, no Save/Cancel bar: the header bar holds Filters,
        Sort, Customize columns and More.
      ✓ `Ctrl+S` leaves the strip silent and starts no save.
- [x] click any cell of a row to select it, then click one of that row's cells again: the cell becomes the `users` field it edits, with the cursor in it. The first click only makes that row the whole [[Selection]] — every other row unticks and this one ticks — and opens no panel, there being none on this page; a click on a row *outside* the selection never opens a cell, and a double-click still does nothing of its own. The two cells ADR-0095 spoke for keep their own second clicks — the identity cell opens the record page and the status cell the transition menu — and no ordinary cell grows a pencil beside the identity cell's. On a phone the same pair of taps opens the cell, the identity cell being what selects the row there
      ✓ First click ticks the row and opens nothing; the second click on the same cell opens it with the
        cursor in it.
      ✓ A click on a row outside the selection only moves the selection; a double-click does nothing of its
        own.
      ✓ **No ordinary cell grows a pencil, and neither does the identity cell** — this page declares no
        `edit_modal`, so `data-identity-edit` is absent from every row (0 of 9) while the ellipsis is on all
        nine. The identity cell's second click opens nothing either, there being no `record_page`.
- [x] type into an open cell and click away: the blur saves that one property of that one `users` record, `Enter` saves and closes, and the [[Command Strip]] names the save after the column it changed — **Update {column}**, the word that column’s header shows, rather than a general Save changes — with an undo that puts the old value back in the row. `Escape` instead of either puts the old value back without saving. Nothing saves on a timer — leave an open cell alone for a minute and it is still unsaved with the strip silent — and a write the server refuses leaves the cell holding what was typed rather than retrying it, the strip carrying the refusal's sentence and its category, with `Escape` the way to give that draft up. Walk it as a role whose policies may not update the record at its status, too: that row's cells never open at all
      ✓ Blur saves, `Enter` saves and closes, and the strip names the save after the column: **Update Last
        name**, **Update Onboarding**, with an undo that puts the old value back in the row.
      ✓ `Escape` puts the old value back without saving.
      ⚠ **And one save that is not one.** `email` is the property the `users` spec's `admin` policy denies
        itself on purpose (`- "!email"`, commented "an account taken over without anybody proving the new
        address"). Its cell opens anyway, takes a new address, and the strip reads a plain success **Update
        Email** — while `users.email` in the database does not move. Recorded as a comment on **#1318**
        rather than a new issue: it is that bug's shape, on the one property in this project carrying an
        explicit security comment.
      — The timer arm and the refusal arm were walked on `members_listing` (#1329).
- [x] where each `users` field opens: `first_name`, `last_name`, `email` and `onboarding`: **in the cell**, as an input filling it; `admin_role`, `circulation_role`, `librarian_role` and `patron_role`: **in the cell**, as a menu of the values it allows, up from the moment the cell opens — and the pick itself saves the cell, there being nothing left to leave, while a click on the cell with the menu up closes it again and sends nothing. Every other column of this table opens nothing at all, which is what its cells refusing the second click means rather than a fault
      ✓ `last_name` and `onboarding` open **in the cell** as inputs filling it.
      ✓ `admin_role`, `circulation_role`, `librarian_role` and `patron_role` open **in the cell** as menus of
        *Yes* / *No*, up from the moment the cell opens, and the pick saves.
      ✓ Every other column opens nothing: `invitation_sent_at` and the reset bookkeeping are
        `editable: false`, and the status cell has no transition to offer.
      ● **Known: #1310.** `first_name` is named here as an in-cell input and can never be one: it is
        `identity.title`, so the table draws it as the [[Identity Column]].
      ● **Known: #1318.** `email` is named here too, and its cell does open — see the line above for what
        happens when it is written.
- [x] the caret an armed cell wears: select a row and its `admin_role`, `circulation_role`, `librarian_role` and `patron_role` cells each grow an angle-down caret at the right edge — the same affordance the [[Status Column]]'s band wears, on every cell whose click opens a list or a box rather than a field to type in. The cells of `first_name`, `last_name`, `email` and `onboarding` wear none: there the click opens a field to type in, which is its own affordance. The caret is there only while the row is selected — an unselected row's cells wear none, that click being the row's, and the value under it does not move a pixel as the cell opens — the open field is set in the table's own font, so the same string lands on the same baseline in the same place, and a value too long for its column still ends in an ellipsis rather than breaking at a word. What the caret does when the cell opens depends on where the field went: a field drawn *in* the cell brings a chevron of its own, so the cell's goes, and a field that opened in a popup leaves the cell showing its value, so the caret stays and turns upside down. Nothing the caret sits on moves: the value reads exactly where it read before the row was selected, and the caret sits on the same pixel as the open field's own chevron
      ✓ On a selected row the four role cells each grow the caret — the same affordance the status band
        wears elsewhere — and `last_name`, `onboarding` and `email` wear none, their click opening a field to
        type in.
      ✓ An unselected row's cells wear none.
      ✓ Each role cell draws its menu *in* the cell, so the cell's caret gives way to the field's own
        chevron.
- [x] a selected row's cell content goes inert: with the row selected, a link, a chip or a button drawn inside one of its cells stops answering the pointer — it draws no hover emphasis and follows nowhere — so the second click has one meaning wherever in the row it lands, and on an editable cell it opens that cell. On an *unselected* row the same content is live and the click belongs to the row underneath. What a reader wanted from that link is still reachable: the [[Cell Preview]] the hover floats carries the rendering with it, and `Space` and a tap float the same box. The identity cell is the exception and goes on answering — its pencil, its ellipsis and its record page all still take the pointer
      ✓ A selected row's cells carry `FiE3va_inert` with `pointer-events: none`; on an unselected row the
        same content is live.
      ✓ The identity cell is the exception and goes on answering — though on this page what it has to answer
        with is its ellipsis alone, there being no pencil and no record page.
      ✓ `Space` floats the same box the hover floats.
- [ ] clear `first_name`, which the spec requires a value for, and leave the cell: the old value is back in it, nothing is sent, no command runs and the [[Command Strip]] says nothing, there being nothing to report. No cell and no row anywhere in the table is drawn red, outlined or marked invalid at any point, which is the half to watch for. Where the schema points at one repair the value is repaired instead and the repair is what saves: a number past its bounds comes back clamped to them, a string past its maximum truncated to it, and leading or trailing whitespace trimmed away
      — The `first_name` half is unreachable for #1310's reason: it is the identity property, so there is no
        cell to clear. `users` carries no other required editable property on this page — `last_name` is not
        required, `onboarding` is free text, and the role columns are booleans with a default — and no
        bounded number or maximum-length string, so the clamp and truncate repairs have nothing to act on.
      ✓ What was seen: no cell and no row anywhere in this table was drawn red, outlined or marked invalid
        at any point of the section, which is the half the line says to watch for.
      — Left unticked: the repair behaviour was proved on `members_listing`'s whitespace trim, not here.
- [x] the checkbox column is there before anything is clicked: the table opens with a checkbox in a column of its own ahead of the [[Identity Column]] on every row, nothing ticked, and one in the header. There is no **Select multiple** toggle anywhere on the page to have turned it on — no root panel to hold one, and the header bar carries the page's own actions rather than the table's — and nothing else about a row has moved: the identity cell keeps its pencil and the row menu's ellipsis, nothing being ticked yet. Leave the page for another and come back and the column is still there with nothing ticked, the [[Selection]] being the page's own: no `panel` parameter is ever written to the address bar by any of this
      ✓ Nine checkboxes and a header checkbox before anything is clicked, nothing ticked, with no **Select
        multiple** anywhere to have turned them on.
      ✓ Every row keeps its ellipsis (9 of 9) while nothing is ticked.
      — The clause about the identity cell keeping *its pencil* has nothing to keep here: this page declares
        no `edit_modal`, so no row has one at any count.
      ✓ Leaving for another page and coming back leaves the column there with nothing ticked, and no `panel`
        parameter is written.
- [x] giving a set up, with no count and no **Clear** to do it by: on a `users` table with more rows than three, tick three of them and click the header checkbox — all three untick rather than the whole table checking, which is what a partial set answers to now. Click it again with nothing ticked and every row of the table checks; click it once more with every row checked and every one unticks. Press `Escape` with three rows ticked instead and the set empties the same way, the focus ring left exactly where it was. There is no selection count and no **Clear** anywhere on the page to have done either by — the header checkbox is a phone's way, having no `Escape` to reach for. **Every identity cell's pencil goes** while more than one row is ticked — the edit modal writes the one record it was clicked on, which is not what a set is edited with — and each comes back the moment the selection is down to one row or none; the ellipsis beside it never goes, the row menu being where a checked row's own list opens
      ✓ Three ticked + header checkbox → all three untick; again with none → all nine check; again with all
        → all untick.
      ✓ `Escape` with three ticked empties the set and leaves the focus ring where it was.
      ✓ The nine ellipses never go.
      ✓ No selection count and no **Clear** anywhere on the page.
      — The pencil clause has nothing to walk here, for the reason above.
- [x] the one click rule: click a cell of a *ticked* row and that cell opens for editing, which is what the second click on a row has always been; click a cell of an *unticked* row and that row becomes the whole selection instead: every other row unticks, this one ticks, no cell opens and no panel opens either, this page drawing none, and the click after it opens that cell. **A click inside the selection never takes it**: with three rows ticked, click anywhere on one of them — a cell's dead space, a column that opens nothing, the spare width past the last column — and all three are still ticked. So the [[Selection]] grows and shrinks by checkbox alone: no click anywhere in the table ever adds a row to it. The identity cell is ADR-0095's still — a second click on it opens the record page rather than a cell — and a row this reader may not update is a row whose cells do not open, ticked or not
      ✓ A click on a ticked row's cell opens that cell; a click on an unticked row's cell moves the whole
        selection and opens nothing.
      ✓ A click anywhere inside a three-row selection leaves all three ticked.
      ✓ The identity cell's second click opens nothing at all here, there being no record page.
- [x] the set marks, and the editor opens on what it shares: tick three rows by their checkboxes and rest the pointer on one of their `onboarding` cells — the same column's cell on the other two ticked rows is marked with it, a tint of its own over the fill a ticked row already carries, so what is about to change is visible before it changes. Carry the pointer along the row and the marking follows it column by column; carry it onto an *unticked* row and nothing marks there, and the [[Identity Column]] neither marks nor is marked, its second click opening a record page rather than anything a set can be asked for — while the [[Status Column]] does both, a status being one of the things a selection changes: rest the pointer on a checked row's status cell and every checked row's band wears a ring and the action colour washed over it, its own included — the status colour still showing through, so a marked set never reads as a different status. Now click that cell: it opens holding the value the three rows share, or empty where they hold three different ones — and empty is not a change, so leave it without typing and nothing is sent, no command runs and the [[Command Strip]] stays silent. Type, and what is typed shows in that one cell alone: the other two go on showing what the server last returned, marked but unchanged, until the save lands. `Escape` gives the draft up to *this* row's own value rather than to the set's, and the header checkbox and `Escape` take the marking away with the [[Selection]]
      ✓ With three rows ticked, resting on one of their **Onboarding** cells marks the same column on the
        other two — `color(srgb 0.649 0.888 0.977)` against the unticked rows' white — and the marking
        follows the pointer column by column.
      ✓ The [[Identity Column]] neither marks nor is marked.
      — The [[Status Column]] half cannot be walked: with no transition permission anywhere in the spec,
        a status cell here is not one of the things a selection can change.
      ✓ The editor opens on what the set shares and empty where it does not; left empty it sends nothing.
- [x] one edit, every checked row, one entry: with three rows ticked, open one of their `onboarding` cells, type a value and press `Enter` — all three rows read it, and the strip names **one** entry for the three rather than three entries. Open the caret and take it back: each row comes back to the value *it* held, so three rows that held three different values come back as three different values rather than as the one the opened cell was showing. Every other column of all three records is as it went in, the write carrying the one property that changed and nothing else — check one the set never agreed on. Then make a second batch over a *different* set of rows: it is an entry of its own rather than folded into the one before it, which is what a run of edits to one cell of one row does instead
      ✓ One `Enter` over a three-row set wrote `onboarding` on all three and the strip named **one** entry,
        *Update Onboarding*.
      ✓ The undo put each row back to its own value.
      ✓ A second batch over a different set of rows was an entry of its own.
- [ ] the gate closes the whole set: `users`'s `profile` policy permits `update` on a record in `active` and not on one in `invited`, so tick one `users` record in `invited` along with two the policy does reach — and no cell of the set opens at all, the cells of the two rows that would have permitted it included, because applying to whichever rows happened to permit it would leave the result turning on a permission the reader cannot see. A refused cell is the inert one it already knows how to be: `Tab` walks over it, `Enter` and `F2` float the [[Cell Preview]] instead, and nothing marks, there being nothing about to change. The reason rides on the cell itself, as its tooltip *and* its accessible name — "<the record's name> cannot be updated while it is Invited", which says which row to untick rather than which rule to guess at. Untick that one record and the other two open again
      ⚠ **#1333 — this line cannot be walked on this page, and that is a generator bug.** It names `users`'
        **`profile`** policy, and the only role in this page's `route.roles` is admin — who holds `users`'
        `admin` policy, declared **first**, whose `update` covers `active` **and** `invited`. Permission
        resolution takes the first matching policy rather than the union (`find_view` in `auth/policies.rs`,
        and the spec's own comment says so), so `profile` never decides anything for an administrator, on
        their own row or anyone else's. An `invited` row ticked alongside two `active` ones leaves every
        checked row's cells opening normally.
      — Left unticked: nothing here was proved either way about the behaviour the line describes.
- [x] a set with nothing to be asked: this page's `record_actions` declare no `modal_actions`, and no `users` workflow declares `dispatch_mode: per_record` on a manual trigger — so a [[Selection]] here has an empty list, and what the menu holds is one line saying so. Tick three rows and right-click one of them: a menu of the app's own opens, titled off the count as any set's is, holding a single greyed **No actions for this selection** and nothing else — the browser's own context menu must not appear over the table, which is what an empty menu would have let through. The identity cell's ellipsis is still on a checked row and opens that same one-line menu, a phone having no right-click to reach it with. That one line is the whole of what says so: there is no panel on this page with a selection block to have said it by drawing no buttons, and no count and no **Clear** beside it to have said it either. Right-click an *unchecked* row and the selection still collapses onto it — every other row unticks, that one ticks — and that record's ordinary [[Row Context Menu]] opens, copy item and all; untick until fewer than two rows are checked and every row's menu and ellipsis are the record's own again
      ✓ Three ticked and right-click: a menu of the app's own opens headed **"3 Users selected"** (and "4
        Users selected" at four), holding a single greyed **No actions for this selection** and nothing else.
        The browser's own context menu did not appear.
      ✓ The identity cell's ellipsis on a checked row opens that same one-line menu.
      ✓ No panel, no count and no **Clear** beside it.
      ✓ Right-clicking an unchecked row collapses the selection onto it and opens that record's ordinary
        [[Row Context Menu]], copy item and all.
- [x] filter on each property, one at a time: `admin_role`, `circulation_role`, `email`, `first_name`, `invitation_sent_at`, `last_name`, `librarian_role`, `onboarding`, `password_reset_attempts`, `password_reset_sends`, `password_reset_sent_at`, `patron_role` — and one filter matching nothing → clean empty state
      ✓ Every property this line names is offered and filters: the modal's list is *Admin Role, Circulation
        Role, Email, First Name, ID, Invitation Sent At, Last Name, Librarian Role, Onboarding, Password
        Reset Attempts, Password Reset Sends, Password Reset Sent At, Patron Role, Status* — the three
        `visibility: disabled` columns among them, which is right: `disabled` takes the column off the table
        and leaves the property filterable.
      ✓ Walked one at a time: `first_name` → Nora Newcomer, `last_name` → Alice Reader, `email` → Bob
        Bookworm, `admin_role` → Ada Admin, `status` → the two invited accounts, `invitation_sent_at` → Iris
        Ingram.
      ✓ A filter matching nothing gives a clean empty state — no rows, no error, no console.
- [x] sort a text and a numeric column, both directions
      ✓ Text: `last_name` ascending and descending both reverse the rows, and the header's arrow turns with
        them.
      ✓ Numeric: `password_reset_sends` — a `disabled` column, so sortable without being drawn — orders
        both directions once the rows hold different counts: ascending ends Bob (1), Pat (2), Alice (3)
        and descending starts with them.
      ⚠ **One SQL write, flagged per the seeding policy.** The property is `editable: false`, so the API
        deliberately cannot set it and every seeded user held 0 — asc and desc came back identical, which
        decides nothing. Three rows were given 3, 2 and 1 directly in the database to make the line
        walkable.
- [x] the calendar on this listing's date filters (`password_reset_sent_at` and `invitation_sent_at`): the operand opens the same month grid rather than the browser's date control, and a day picked in it narrows the listing to that day, shows in the filters button, and rides in the URL like any other filter — a reload keeps it applied and the same rows come back. The *between* operand takes its two days from the same grid
      ✓ The `invitation_sent_at` operand opens the month grid (*September 2026*) rather than the browser's
        date control, from a plain `yyyy-mm-dd` text input.
      ✓ The day picked narrowed the listing to Iris Ingram, showed in the **Filters** button as a `1` badge,
        and rode in the URL as `filter_invitation_sent_at=d~eq~2026-09-28`; a reload kept it applied.
      ✓ The *Between* operand narrows the same way — `dran~2020-01-01~2030-01-01` comes back with Iris
        Ingram. That its two operands each open the same month grid was walked through the modal on
        `members_listing`; here only the range was checked.
- [x] the header's right cluster holds one **More** ellipsis beside the filters and sort buttons, and no download, print or pin button of its own anywhere in the header: it holds **Download**, **Print** and **Pin to Dashboard** and nothing above them — no leading rule, this page declaring no actions of its own. Download and Print still run from inside the menu, over the rows the page is showing and the columns the reader has left visible
      ✓ One **More** ellipsis beside Filters and Sort holding exactly **Download**, **Print** and **Pin to
        Dashboard**, with nothing above them and no leading rule.
      ✓ No download, print or pin button of its own in the header: its buttons are Filters, Sort, Customize
        columns, More.
- [x] record-action modals (`invite_user`, `join_library`): each opens from this page and submits
      ✓ `invite_user` opens from a row's menu on an **active** account, takes an email, a first and last name
        and the role switches, and submits: it created **Iris Ingram** in `invited` with a real
        `invitation_sent_at`, which is how this run got a date to filter on.
      ✓ `join_library` opens from the same menu and submits; submitted empty it is refused cleanly —
        **Save changes — Invalid input** — with the form still on screen.
      ✓ Both are absent from an `invited` row's menu, their `kind: workflow` permissions being scoped to
        `status: active`. That is the gate working rather than a missing item.
- [x] right-click a row with fewer than two rows checked and that row becomes the whole [[Selection]] — its own checkbox ticks and any other clears — with a menu at the pointer over it and **no panel behind it**, this page drawing none. The menu is headed by the `users` record's own name and holds this page's actions for it, one separator per group boundary, led by the record page in bold
      ✓ Right-clicking a row with nothing else checked ticks that row alone and opens a menu at the pointer
        with no panel behind it, headed by the record's own name.
      ⚠ **The line's last clause cannot hold here**, and the generator wrote it anyway: it says the menu is
        "led by the record page in bold", and `users_listing` declares **no `record_page`** — there is no
        such item to lead with. What the menu holds is the cell's copy items, then `Invite user` and `Join
        the library`, then **Related links**. Same family as #1333: a line written off the spec without
        asking what this page declares.
- [x] the ellipsis in a row's identity cell opens the same menu, anchored to itself rather than to the pointer — it appears beside the pencil while the pointer is anywhere on the row, not only over the title, and on a touch screen it is there without hovering, which is a phone's only way in
      ✓ The ellipsis in a row's identity cell opens the same menu anchored to itself rather than to the
        pointer, and it is there while the pointer is anywhere on the row — on this page it is the row's
        **only** affordance, there being no pencil beside it.
- [x] the menu is the whole of what a row's actions have on this page: every action this page's `record_actions` offer this reader stands in it, in the block's own order but with the record page pulled to the front, greyed with its own predicate's reason where one refuses and absent where a `hide` does — there being no item-details panel beside it to be compared with. Three read the way the panel worded them: the record page and the edit modal name the model (*Author Page*, *Edit Author*) and Lifecycle reads *View Lifecycle*. Walk it as a role the record's permissions narrow, too: what the menu holds has to narrow with them
      ✓ The menu holds every action this page's `record_actions` offer this reader: **Invite user**, **Join
        the library** and **Related links**, in the block's order, absent where a permission closes them (an
        `invited` row keeps only the copy items and Related links).
      ✓ There is no **View Lifecycle** and no **Audit history**, which is right: `users`' `admin` policy sets
        neither `lifecycle: true` nor `audits: true`.
      ⚠ The record-page clause is the one this page cannot answer — see the note two lines above.
- [x] right-click a cell that is not the identity cell and the menu leads with **Copy {column}**, then a separator — what it copies is what the cell reads as, the string the CSV export carries, rather than its markup. Where the table filters on that column and the cell is not empty, **Filter by {column}** sits under it and narrows the table to the value in the cell, which then shows in the filters button and in the URL like any other
      ✓ A right-click on a non-identity cell leads with **Copy {column}** — *Copy Email* — then a separator.
      ✓ **Filter by Email** sits under it and narrows the table to that value, showing in the Filters button
        and in the URL.
- [x] right-click the *identity* cell and the menu leads with **Copy {Model} ID** instead — the `users` spec's singular display name, so *Copy Book ID* over `books` — which puts the record's id on the clipboard. That cell's value is the record's name, which is already the menu's heading. A menu opened from the ellipsis is the row's own and leads with no cell item at all
      ✓ The identity cell's menu leads with **Copy User ID** — the `users` spec's singular display name —
        instead of a column copy.
      ✓ A menu opened from the ellipsis leads with no cell item at all.
- [x] Related in the menu: this record's related links (every relation the spec declares) are one **Related links** submenu — after the `modal_actions` items and ahead of any custom action — holding a link per relation and landing on the listing each one names, filtered to this record, and nesting a submenu of its own wherever a section brings more than one
      ✓ **Related links** is one submenu holding a link per relation — **Members** — landing on
        `/community/members?filter_user_id=s~<id>`, the listing that relation names, filtered to this record.
      — A submenu nesting a submenu has nothing to test here: `users` declares one relation.
- [ ] the whole table is **one** tab stop: Tab from the control above it lands inside the table once — on a cell, wearing a focus ring of its own — and Tab again leaves it for whatever is below, however many rows are on screen; the column headers' own controls keep the stops they had, and so do a row's selection checkbox and an open inline-edit field, while clicking any cell moves the ring to that cell
      ● **Known: #1314.** Tab from **More** lands inside the table and then takes a stop per cell per row —
        `checkboxes@0`, `identity@0`, `last_name@0`, `email@0`, `onboarding@0`, `admin_role@0`, … — rather
        than one stop for the whole table. (The status cell is stepped over, which on this page is right:
        it opens nothing.)
      — Left unticked under that known issue.
- [x] Left and Right walk the ring across the columns of the row it is on, crossing out of the pinned columns into the scrolling ones without a stop in between, and Home and End are that row's first and last column rather than the table's first and last row; both ends hold rather than wrapping onto another row, and a column reached off the side of the window is scrolled to clear of the pinned columns rather than underneath them
      ✓ Left and Right walk the ring across the row's columns, crossing out of the pinned columns into the
        scrolling ones without a stop between.
      ✓ `Home` and `End` are that row's first and last column (`checkboxes@2`, `patron_role@2`), and both
        ends hold rather than wrapping.
- [x] Up and Down move the ring to the row above and below in the column it is already in, and every row it lands on is selected as a clicked row is, that `users` record becoming the whole [[Selection]] and the row before it unticking — hold Down and the checked row walks with the ring, on past the bottom of the window, where the next row is scrolled to and *then* focused rather than skipped over; the first and last rows hold rather than wrapping
      ✓ Up and Down move the ring to the row above and below in the same column, and every row it lands on
        becomes the whole selection.
      ✓ The first and last rows hold rather than wrapping.
- [x] Ctrl+Home jumps the ring to the first row and Ctrl+End to the last row of the table rather than the last one fetched: on a `users` table long enough to be paged, Ctrl+End lands the ring on a row whose record has yet to arrive, the window goes back to the connection for it, and the selection moves to *that* record once it lands rather than staying on the row that was checked before
      ✓ `Ctrl+Home` takes the ring to `patron_role@0` and `Ctrl+End` to `patron_role@8`, the selection moving
        with it.
      — The paging clause is unreachable here: nine `users` rows is one page.
- [x] Enter on the focused row's identity cell does nothing at all — this surface resolves no record page for `users`, and a second click on the cell does nothing either. The cell still claims the key: it must not fall through to the pencil's edit modal, to the cell's own preview, or back to the browser
      ✓ `Enter` on the focused identity cell does **nothing at all**: the URL does not move, no modal opens,
        no cell opens and no preview floats — this surface resolves no record page for `users` and declares
        no edit modal either.
      ✓ The cell still claims the key: the ring stays on `identity@2` rather than falling through to the
        browser.
- [x] Enter on the focused row's status cell opens the same transition menu a second click on it opens, under the cell and holding the same items — and where the reader is permitted no transition at all it opens nothing rather than falling through to that cell's preview
      ✓ `Enter` on the focused status cell opens nothing rather than falling through to that cell's preview —
        which is the line's own second half, and the only half this spec can answer: `users` declares no
        transition permission in any policy.
- [x] Space on any other focused cell **toggles** that cell's preview — the box floats and the same key puts it away — while Enter on a cell this reader may not write only ever opens it; a cell already showing all of its value floats nothing either way, and the page does not scroll down under either press. Escape then closes whatever is floating over the table first, and an Escape with nothing open gives the selection up — every checked row unticks, there being no panel to close instead, leaving the ring exactly where it was — Tab, not Escape, is the way out of the table. While anything floats the arrow keys stand aside rather than walking the ring out from under it, the box being placed against the cell it belongs to
      ✓ `Space` on a focused cell whose value is cut off floats the 480×66 box, and `Space` again puts it
        away; the page does not scroll.
      ✓ A cell already showing all of its value floats nothing either way.
      ✓ `Escape` closes the float first and leaves the row checked; a second `Escape` empties the selection
        with the ring left where it was.
- [x] Enter and F2 on a focused cell this reader may write open it for editing — the same field the second click opens, in the cell or in its popup — rather than that cell's preview, and the ring is in the field once it opens. On a cell they may not write, or one this table opens no field for, Enter falls back to the preview and F2 does nothing at all; the identity and status cells keep what they answer above
      ✓ `Enter` and `F2` both open the focused cell for editing — `onboarding@6` opened under either — and
        the ring is in the field once it opens.
      ✓ On a cell this table opens no field for, `Enter` falls back to the preview and `F2` does nothing.
      ✓ The identity and status cells keep what they answer above.
- [ ] Tab from an open cell commits it and opens the next editable cell of the *same* row, Shift+Tab the previous — every column with no field to open is stepped over, the identity and status columns among them — and past the last editable cell of the row Tab leaves the table for whatever is below it, as Shift+Tab before the first leaves it upwards, the table being one tab stop. The [[Identity Column]]'s cell is the walk's first stop, and opens nothing either: `Tab` into the table lands there, `Enter` opens the record page, and `Tab` again carries on into the row's cells in the order the columns are laid out. The [[Status Column]]'s cell is one of the stops, and the one that opens nothing: `Tab` onto it commits whatever was open and leaves the ring there, `Enter` opens its transition menu — the same key a reader who arrived by arrow key presses — and `Tab` again carries on to the next editable cell rather than popping a menu part-way along the row. Escape inside an open cell is the cell's own: it puts back what the cell held and closes it, leaving the row checked rather than clearing the selection, which is what the same key does once no cell is open
      ✓ `Tab` from an open cell commits it and opens the next editable cell of the same row (`last_name` →
        `email`), `Shift+Tab` the previous, and the identity and status columns are stepped over.
      ⚠ But the cell it lands on is `email`, which the `admin` policy denies itself — so `Tab` opens a field
        for a property no write will take. See the *type into an open cell* line above and the comment on
        **#1318**.
      ⚠ **#1336** — `Escape` inside an open cell puts back what the cell held and leaves the row checked, but
        drops the focus to `<body>`.
      ● **Known: #1314** for the half that says the table is one tab stop.
      — Left unticked: two of the line's claims fail and a third lands on a cell that should not open.
- [ ] Shift+F10, and the Menu key where the keyboard has one, open the row's context menu on the focused cell: the right-click's menu rather than the ellipsis's, anchored to the cell for want of a pointer to anchor to, with the row selected under it — so an ordinary cell's menu is led by the copy item naming that column and the identity cell's carries no copy item at all. A menu a key opened takes the keyboard: its first item is focused, Up and Down walk the items and Enter picks one, and closing it hands the keyboard back to the cell with its ring on. A right-clicked one takes nothing and leaves the ring where it was
      ✓ `Shift+F10` on a focused cell opens the **right-click's** menu anchored to the cell with the row
        selected under it: on `email@3` it is led by **Copy Email**, and on the identity cell it carries no
        copy item.
      ✓ It takes the keyboard: its first item is focused and Up/Down walk the items.
      ⚠ **#1336** — closing it does not hand the keyboard back to the cell: `Escape` leaves
        `document.activeElement` on `<body>` with no ring anywhere.
      — No Menu key on this keyboard to try beside `Shift+F10`.
      — Left unticked: the return path is the line's own last clause.

## Page: weather_page  (`/ops/weather`)
- [ ] renders as each of: admin, librarian — and is absent from the nav *and* refused on direct navigation for every other role
      ✓ Nav visibility holds in both directions: **Weather** is in the Operations nav for admin and
        librarian, and absent for patron and circulation.
      ● **Blocked** on the pinned "no page refuses direct navigation for a disallowed role" — patron and
        circulation both reach `/ops/weather` by URL and it renders. Confirmed as known, not re-filed.
- [x] the page heads with one two-row header: the title reads at the left of the upper row — "Weather" — with nothing ahead of it, this page naming no `parent_page` and no tabs beside it. The [[Command Strip]] holds the right-hand end of that row and nothing else does; what it says there is the next line's. The bar directly beneath holds everything the header held before, each item where it was. Narrow the window until the title no longer fits and it ellipsises, resting a tooltip carrying the whole of it — a title that fits rests nothing
      ✓ One two-row header: the title **"Weather"** at the left of the upper row with nothing ahead of it,
        no tabs beside it (the tab strip is present and zero-width), and the [[Command Strip]] alone at the
        right-hand end of that row — the header's upper row holds exactly title, tab strip, strip.
      ✓ The bar beneath draws nothing, this page declaring no header actions.
      — The ellipsis clause is unreachable on this page: Firefox will not report an `innerWidth` below about
        500px, and the title still fits the header at that width. Its other half holds — a title that fits
        rests no tooltip, and this one carries no `title` attribute.
- [x] the [[Command Strip]] is the only place a command's status is shown, and this page's header carries it: before any command has run it is its caret alone, greyed and opening nothing. Run one — a save made here, or one made on another page and then walked back to through the nav rather than reloaded, the history being the session's rather than the page's — and a spinner shows while it is in flight, for as long as it runs, then a tick and the command's own name — and ten seconds later the tick and the name fade away over a moment and the strip is its caret alone, the history still under it. Count it out: a success still there half a minute on is a finding, and so is one gone the moment it landed. Open the caret before the ten seconds are up and the name is held there until you close it again. A refusal reads the same way with a warning and a category after a dash — one of "Not allowed", "Invalid input", "Not found", "Server error" and "Offline" — its own sentence under the caret, and joins no history — and it does not fade: a refusal is still there a minute later, until the next command replaces it, which is the difference to watch for. The category is the server's own word for what it refused rather than a reading of the sentence it sent (ADR-0099), so a failure nothing named a kind for reads "Failed", which is the honest answer rather than something to report. What is a finding is a category naming the wrong kind — a save the policies refused reading anything but "Not allowed", a server stopped mid-session reading anything but "Offline" — and so is a headline carrying the whole sentence where those two or three words belong, the sentence being the dropdown's. Open the caret and the stack is there, newest first: an entry that can be taken back wears an undo icon, and clicking the icon on the *n*th of them moves the stack past all *n* in one call, the headline then naming the direction — "Undo" and the command's own name. An entry whose command declared no undo wears a lock instead, and every entry older than it loses its icon behind that lock — so an entry under a lock drawing no icon is that lock's doing rather than a fault. Which of this app's saves lock and which take themselves back is the Undo section's, at the foot of this plan: a stack with no undo icon anywhere in it is a finding rather than a reading. Ctrl+Z reaches the same undo a step at a time and Ctrl+Shift+Z puts it back, each saying nothing beyond what the headline says, and each standing down — headline unmoved — while the keyboard is in a text field or a modal is open. At a phone width the strip is the icon and the caret alone, the command's name being read in the dropdown instead
      ✓ Walked in full — see the same line under `reading_desk_page`.
      ✓ On this page specifically: arriving from a `Save changes` on `books_listing` **through the nav**, the
        strip reads the command, the caret is live, and the stack holds one entry with an "Undo Save changes"
        icon. Narrowed to 520px the strip is the icon and caret alone and the name moves into the dropdown.
- [x] whole-page plugin `weather`: bundle loads, mounts non-empty, console clean; if the route declares params, exercise the page with and without them
      ✓ The bundle loads and mounts non-empty: "Current conditions" over the Sydney / London / Tokyo
        switcher. Console clean.
      ✓ Interactive: picking **London** renders Temperature 14°C / 57.2°F, Wind 5.8 km/h, Feels Cool.
      ✓ The route declares no params, so there is nothing to exercise with and without.

## Dashboard
### Section "Catalogue"
- [x] count `Published books` (books) shows a plausible number
      ✓ Reads **2** as admin, against two `published` books in the database. Unchanged by the
        `draft` book this section's own add landed, which is the count's filter working.
- [x] count `Active clubs` (clubs) shows a plausible number
      ✓ Reads **2**, against Dune Readers and Earthsea Circle, both `active`.
- [x] add button opens modal `edit_book` and a submit lands
      ✓ **Add a book** opens `edit_book` at once as **New Book**, with its three tabs
        (Details / Metadata / Pricing) and Title, Author Id and Summary — the first two
        required — over the Cover image uploader on the first. Nothing is written to the
        address bar. Title *Dashboard Walk Book*
        plus Ursula K. Le Guin from the author search saved clean: the modal closed, the strip read
        **Save changes**, and the row is in `books` as `draft` under her `author_id`. Console clean.
### Section "Circulation" (visible only to: admin, librarian)
- [x] section appears for the gated roles and is absent for the rest
      ✓ Walked as all five seeded accounts through the Dev Mode Header's user switch. **admin**
        and **librarian** draw Circulation; **circulation**, and the patrons, do not — the section's
        `roles: [admin, librarian]` reading exactly as declared. The `circulation` account's own
        Catalogue counts read 1 and 0 rather than 2 and 2, which is that grant's filter working
        (notes ledger), not a count bug.
- [x] count `On loan` (loans) shows a plausible number
      ✓ Reads **1**, against the backdrop's one `active` loan. Still 1 after this section's own
        add, which creates into `requested` — the filter working.
- [x] count `Overdue` (loans) shows a plausible number
      ✓ Reads **0**; no loan is `overdue`.
- [x] add button opens modal `edit_loan` and a submit lands
      ✓ **Check out a book** opens `edit_loan` as **New Loan** with Book, Member and Due date, all three required.
        Dune + Alice Reader + 2026-12-01 saved clean and the row is in `loans` as `requested` with
        that due date; strip reads **Save changes**, console clean.
        ● The deliberately-invalid submit (the submit policy's one per form) is **#1315**: Save with
        every field empty answers *Invalid property 'book_id': Unable to typecast as string* in the
        modal and **Save changes — Invalid input** in the strip, rather than saying the field is
        required. Refused cleanly, wrongly worded — confirmed, not re-filed.
### Section "My membership"
- [ ] count `Books I have out` (loans) shows a plausible number
      ⚠ **#1351** and **#1352** — this widget cannot be read at all, and taking it down takes
        the whole page with it. The section is gated `visible_if: .me`, so it is drawn only for a
        user who has a `members` row; for such a user (`alice@example.com`, `bob@example.com`) `/`
        renders the dev header and the nav rail and **nothing else** — the page shell is not in the
        DOM, the console is clean and the server log is clean. `patron@example.com`, who has no
        `members` row, gets the dashboard because `visible_if` drops the section before its widget
        can run.
        The widget's own query is refused: `POST /keystone/query` over `loans` filtered by
        `member_id` answers **200** with *Not permitted to filter or sort 'loans' by property
        'member_id'* — `loans`' `member` policy views `book_id`, `book_title`, `borrowed_on`,
        `due_on` and `renewals`, and deliberately not `member_id`. Editing the widget to filter on
        `status` instead makes Bob's dashboard render in full, *My membership | 0 | Books I have
        out* among it, which is the control that separates the two halves: **#1352** is the config
        naming a property its own reader cannot filter by, **#1351** is a refused widget query
        unmounting the page instead of the widget.

## Dashboard customization
The signed-in user's own saved dashboards, on top of the template above. Everything here is per-owner: walk it as one user, then sign in as a second and confirm none of the first's dashboards are reachable.
- [x] the dashboard switcher lists "Default Dashboard" plus every saved dashboard of the signed-in user, and picking one navigates to it (`/?dashboard=<name>`, or `/` for the primary)
      ✓ Walked as admin with three dashboards in play. The switcher lists *Default Dashboard*
        plus each saved one, and picking navigates: a saved one to `/?dashboard=Walk%20Renamed`, the
        primary to bare `/`, and the template to `/?dashboard=~default` — a sentinel rather than a
        name, which is unambiguous and is what the header then reads back. A second account
        (librarian) sees *Default Dashboard* alone, none of admin's three: per-owner, as the section
        header asks.
        ⚠ **#1360** — the other half of per-owner is silent. Opening another owner's
        `?dashboard=…` link, or any name this user does not have, renders a blank page: no fallback,
        no message, clean console. Not a leak — nothing of the other owner's is shown — but nothing
        says so either.
- [x] "Clone dashboard", behind the [[Header Bar]]'s **More** ellipsis and in no panel anywhere: a name, save, and the clone opens holding the same sections and widgets as what it was cloned from — including a clone of the resolved default
      ✓ **More** holds it and no panel anywhere does. The modal is *Clone dashboard* with Name
        and **Make this my primary dashboard**. Cloning the resolved default produced a dashboard
        whose two sections and six widgets match the default's cell for cell — same titles, same
        order, same 200×100 boxes at the same coordinates — and the clone's `dashboard_config` in
        `custom_dashboards` carries the same placements.
- [ ] cloning under a name the same user already used is refused with a clean error, and the modal stays open with the typed name
      ⚠ **#1353** — refused, and the modal does stay open with *Walk Copy* still typed in, but
        the sentence is the database's: *error returned from database: duplicate key value violates
        unique constraint "custom_dashboards__idx_26eaj9s01w6"*, with **Save changes — Failed** in
        the [[Command Strip]]. The gate is right; only the wording is the layer below's.
- [ ] **Customize** in the [[Header Bar]] enters edit mode — an ordinary header button rather than a toggle, there being no panel left to hold one and no toggle-shaped item in the bar: press it and the button itself goes, the "Editing dashboard: <name>" message and the "Cancel" / "Save changes" pair saying which way the page is facing instead. Per-widget and per-section removal appear on the grid, and Cancel restores what was on screen before and brings Customize back
      ✓ Pressing it takes the button itself away and leaves *Editing dashboard: Walk Copy* with
        **Add section**, **Cancel** and **Save changes** — an ordinary header button rather than a
        toggle, and no panel anywhere to hold one. **Cancel** restores the grid as it was, drops the
        removal controls and brings **Customize** back.
        ⚠ **#1354** — per-*section* removal appears (one **Remove** in each `deapOq_sectionHeader`)
        and per-*widget* removal does not: over six widgets the page carries exactly two Remove
        buttons, and a widget's cell is a bare `deapOq_dragSource` with no button, no menu and
        nothing revealed by hover or click.
- [x] **Add section** is in the [[Header Bar]] and only while customizing: it is not there before Customize is pressed, it stands at the head of the row ahead of Cancel and Save changes, it opens the same add-section modal, a titled section lands on the grid unsaved, and Cancel takes it away with the rest of the edit
      ✓ Absent before **Customize** is pressed — the bar holds only Back / switcher / Next /
        Customize / More — and present after. It stands at the head of the row at x=613 with Cancel
        at 754 and Save changes at 852, so ahead of both. It opens *Add section to dashboard* (Title),
        a titled section lands on the grid unsaved, and **Cancel** takes it away with the rest of the
        edit: the grid goes back to Catalogue and Circulation.
- [ ] drag a widget to another cell and resize it, then save — reload and the layout is what was saved, not what it was before
      ✓ The drag half holds. *Published books* dragged from (62,229) to the empty cell at
        (277,344) moves live, **Save changes** commits it, and a reload brings it back at (277,344)
        — the saved `placement` reading `{"x":4,"y":0,"width":1,"height":1}`, which the grid renders
        as row 1 column 1 consistently in both directions.
        ⚠ **#1355** — the resize half has no surface. No element in the page carries a resize handle;
        `elementFromPoint` at a widget's bottom-right corner is the drag source itself and its cursor
        is `move`, the same as at the centre. Every widget's saved `width`/`height` stays 1/1.
- [x] leaving edit mode with unsaved layout changes warns before the page unloads; saving first leaves no warning
      ✓ The `beforeunload` guard is exactly as described: dispatching it cancels nothing at rest
        and nothing in edit mode until something moves, cancels once a widget has been dragged, and
        stops cancelling again after **Save changes**.
        ⚠ **#1356** — a discovery beside the line: the guard covers the browser's unload and not the
        app's own router. With an unsaved drag on screen, clicking **Library** in the nav rail
        navigates at once — no dialog, nothing in the strip — and the edit is gone.
- [x] "Edit details", in the header bar's **More** menu above Clone, renames the current dashboard, and its delete lands back on `/` with the dashboard gone from the switcher
      ✓ **More** on a saved dashboard reads *Edit details* then *Clone dashboard*, in that order.
        *Edit dashboard* opens with the name prefilled; renaming *Walk Copy* to *Walk Renamed* moved
        the header, the switcher entry and the URL together. **Delete** asks Yes/No and, on Yes, lands
        on `/` — the primary — with the dashboard gone from the switcher and from `custom_dashboards`.
        ● The strip names that delete **Yes** rather than Delete, which is the standing
        confirm-gated-command naming bug — confirmed, not re-filed.
- [x] "Make this my primary dashboard", from both Edit details and Clone: the chosen dashboard is what `/` serves afterwards, and the one that held it before is demoted rather than duplicated
      ✓ From **Edit details**: ticking it on *Walk Renamed* and saving moved the address to bare
        `/`, and `/` served *Walk Renamed* from then on. From **Clone**: cloning as *Walk Primary*
        with the box ticked made that one primary and left *Walk Renamed* demoted rather than
        duplicated — `custom_dashboards` holds exactly one row with `primary` true throughout.
- [x] "Pin to Dashboard" on a listing page, with a filter and a sort applied: choose a dashboard and one of its sections, save, and the widget is in *that* section, counting what the listing was showing — and clicking it comes back to *that* listing page with the same filter and sort, not to another page over the same model
      ✓ Walked from `books_listing` at `?filter_status=d~eq~published&sort=title_desc`. **More →
        Pin to Dashboard** opens *Pin to dashboard* with Dashboard, Section and a Label prefilled
        *Books*; the Dashboard select offers the saved dashboards only, which is right since the
        template cannot be changed. Saving into *Walk Renamed* → *Circulation* put the widget in that
        section reading **2 · Published books, Z to A** — the count the listing was showing — and
        clicking it returns to `/library/books?filter_status=d~eq~published&sort=title_desc`, the same
        page with the same filter and the same sort, Dune first.
- [ ] the pin action in an add modal's footer: choose which prefilled fields ride along, save, and the button lands in the chosen section and opens the modal prefilled
      ✓ The mechanism works. **Pin to Dashboard** in `edit_book`'s footer opens the same modal with
        a **Prefill field values** table, one row per field with its own **Enabled** checkbox; enabling
        only *Feature on the dashboard*, labelling the pin *Feature a new book* and saving put that
        button in the chosen Catalogue section, and clicking it opens `edit_book` with the checkbox
        ticked and Replacement price empty — the one prefill enabled and not the one left off.
        ⚠ **#1358** — the table's inventory is short: it lists the modal's explicit field blocks
        (`number_field`, `checkbox_field`) and none of the `record_fields` ones, so Title, Author Id
        and Summary — typed in, and the obvious things to carry over — cannot be chosen at all.
        ⚠ **#1359** — saving this pin lands on `/?filter_status=d~eq~published&sort=title_desc`,
        carrying the listing's own parameters onto the dashboard route; the listing's own pin lands
        cleanly on `/?dashboard=…`.
- [x] the default dashboard — pick "Default Dashboard" from the switcher — offers none of this of its own: the header bar draws **Customize** disabled carrying *Currently viewing the default dashboard. Create a copy to make changes.* as its reason, on the pointer and as the button's own accessible description both, and its **More** menu holds "Clone dashboard" alone — the panel's dead "Edit details" is carried nowhere
      ✓ **Customize** is `disabled` and carries *Currently viewing the default dashboard. Create a
        copy to make changes.* as `aria-description` on the button itself, so a keyboard reader is
        told why; hovering the wrapper draws the same sentence as a `_popup_` above the button, so a
        pointer reader is too. Its **More** menu holds **Clone dashboard** and nothing else — no
        *Edit details*, which is the panel's dead entry carried nowhere.
- [x] neither dashboard page draws a [[Panel]] of any kind: no tab rail down the side of the grid and no root-panel button in the mobile header — append `?panel=…` to this page's URL and it opens nothing at all. Everything the panel carried is in the [[Header Bar]] above, which is where every line here is walked
      ✓ Both pages' content is `_contentWithNoPanel_`, and nothing in either carries a panel or
        tab-rail class. At 520px the mobile header holds the nav menu button and **Home** and no
        panel button. `?panel=root` and `?panel=item&panel_id=1` on either page open nothing at all —
        the grid and the header bar are unchanged and Customize keeps its right enabled/disabled state.
        ⚠ **#1357** — a discovery from appending those: *any* extra query parameter makes the
        switcher fall back to its placeholder **Select option** while the page underneath still
        resolves the right dashboard. `/?foo=bar` does it as surely as `?panel=root`.

## Account page
The page the signed-in account reads itself on, and the one place it changes what it reads (`/account`, reached from the user menu's own name at the top of it). The same page for every role: what it shows is whoever is walking it.
- [x] the page reads the account back: **First name**, **Last name** and **Email** each hold the signed-in user's own value and each copies on a click, and nothing on this page writes anything without a modal or a route in front of it
      ✓ `/account` reads *Manage account* over First name **Ada**, Last name **Admin** and Email
        **admin@example.com** — the signed-in account's own row. Walked again as Alice Reader through
        the user switch: the same page reads Alice / Reader / alice@example.com, so what it shows is
        whoever is walking it.
        ✓ Each of the three carries its own **Copy**, and all three copy the value beside them — the
        clipboard took *Ada*, *Admin* and *admin@example.com* from the three buttons in order.
        ✓ Nothing writes: with `features.account_management` off the three change buttons are inert,
        and there is no field on the page that can be typed into.
- [x] the page draws no [[Panel]] at all: no docked root panel, no tab rail down the side to open one from, and no panel button in the mobile header — append `?panel=…` to this page's URL and it opens nothing at all. Each change stands beside the section it changes instead: **Change name** beside the two name fields, **Change password** beside a **Password** section whose row is a label with no value to read back, and **Change email** beside the Email field. The panel's **Need help?** belongs beside no section and is drawn nowhere at all
      ✓ The content is `_contentWithNoPanel_`, nothing in the page carries a panel or tab-rail
        class, and `?panel=…` opens nothing. At 520px the mobile header holds the nav button and Home
        and no panel button.
        ✓ Each change stands beside its own section: **Change name** at (402, 222) beside the First
        name / Last name pair at (62, 118)–(62, 221); **Change password** at (402, 298) beside the
        **Password** section at (62, 282), whose row is a label with a blank where a value would be;
        **Change email** at (402, 387) beside the Email row.
        ✓ **Need help?** is nowhere in the page — the panel's one item that belonged beside no
        section is drawn nowhere at all.
- [x] all three changes are drawn disabled, `features.account_management` being off in this project: **Change name**, **Change password** and **Change email** each stand beside its own section reading *Account management disabled* — on the pointer and as the button's own accessible description, so a keyboard reader is told why too — and pressing one opens nothing
      ✓ All three carry `disabled` and `aria-description="Account management disabled"`, so a
        keyboard reader is told why; hovering one draws the same sentence as a `_popup_`, so a pointer
        reader is too. Pressing **Change email** opens nothing — no modal, no navigation, nothing in
        the [[Command Strip]].

## Credentials page
The admin page the project's Statically Defined Credentials are listed and set on (`/credentials`, from the **Credentials** entry in the user menu). The entry is drawn only for a session the server says may list them, so walk it as a role the `credentials` spec's view policy permits — and confirm the entry is absent, and the route refused, for one it does not.
- [x] the table lists one row per declared credential, with `Name`, `Kind`, `Base URL`, `Source`, `Identifier` and `Status`: 8 database-sourced here — `anthropic_api`, `e2b_main`, `file_storage_main`, `isbndb_main`, `notifications_main`, `open_ai_api`, `system_email_main` and `turnstile_main` — each reading its External API's kind under `Kind`, `Database` under `Source`, and `Set` or `Not set` under `Status` by whether its secret has been entered on this page
      ✓ Eight rows, one per entry in `config/system_credentials.yaml`, in the order the plan names
        them. Each reads its External API's kind under **Kind** — `api_key` for `anthropic_api`,
        `e2b_main`, `isbndb_main`, `open_ai_api` and `turnstile_main`, `aws_sigv4` for
        `file_storage_main`, `http_bearer` for `notifications_main`, `http_basic` for
        `system_email_main` — `Database` under **Source**, its API's base URL where that API declares
        one (`file_storage_main` and `system_email_main` declare none and their cell is blank), a
        blank **Identifier**, and **Not set** under **Status**. Setting one flipped its Status to
        **Set** and nothing else moved.
        ✓ The gate: the user menu draws **Credentials** for admin and does not for librarian or for a
        patron.
        ● The route half is the standing no-route-level-refusal bug: `/credentials` typed by hand as
        librarian or as a patron *serves* the page rather than refusing it. It degrades to an
        empty-but-non-leaking shell — the six column headers over no rows, no credential named — which
        is the `loans_listing` shape of that issue rather than the `reviews_listing` one. Confirmed as
        known, not re-filed.
- [x] the page draws no [[Panel]] at all: no temp panel is passed for a row's click or an address to name, no tab rail down the side of the table, and no panel button in the mobile header — append `?panel=…` to this page's URL and it opens nothing at all
      ✓ The content is `_contentWithNoPanel_`, nothing in the page carries a panel or tab-rail
        class, and a row's click passes no temp panel — the address bar is untouched by any of it.
        `?panel=root` and `?panel=item&panel_id=anthropic_api` both open nothing: the same 48 cells,
        the same table. At 520px the mobile header holds the nav button and **Home** and no panel
        button.
- [ ] a row that can be set here opens its modal on the click: click `anthropic_api` and `set_credential` opens at once, prefilled with that row's name and its kind, labelled **Set credential** where `Status` reads *Not set* and **Update credential** where it does not. Save and the row's `Status` reads back the other way with no reload, and nothing is written to the address bar by any of it
      ✓ The click opens `set_credential` at once, and the save is right: filling API key and
        pressing the footer's primary button closes the modal, the row's **Status** reads **Set**
        with no reload, a `credentials` row lands, and nothing is written to the address bar.
        ⚠ **#1362** — the prefill and the two labels are not. The modal carries neither the row's
        name nor its kind; **Base URL** opens empty although the row beside the click shows
        `https://api.anthropic.com`; and the title reads *Set credential* on a row whose Status is
        already **Set**, so nothing warns that an existing secret is about to be overwritten.
        ⚠ **#1361** — the footer's primary button has no label at all: `<span class="_text_">` is
        empty, there is no `aria-label` and no icon, so Save is a blank coloured square. It works; it
        just says nothing, to a reader or to a screen reader.
- [x] the same entry is the row's own [[Row Context Menu]], and the only item in it: the ellipsis in the first column, a right-click anywhere on the row, and Shift+F10 or the Menu key each open a menu holding that one **Set credential** / **Update credential**, which opens the same modal with the same prefill
      ✓ The ellipsis in the Name cell (`Show row menu`), a right-click anywhere on the row, and
        `Shift+F10` and the Menu key on a focused cell each open the same one-item menu. The item is
        the only thing in it, and it is the one that knows the row: **Set credential** on a `Not set`
        row and **Update credential** on the Set one. It opens the same modal with the same prefill as
        the row click — which is to say the same missing prefill, and the same *Set credential* title
        under an **Update credential** menu entry (#1362).

## Onboarding
The gate a user assigned an [[Onboarding Process]] is held inside (ADR-0110): a Focus Layout showing the first step whose precondition does not hold, with **Sign out as the only way off** — no skip, no dismiss, and every other route redirected back to `/onboarding` with a `return_to`. Walk each process on an account that has just been assigned it rather than on a seeded one, and watch what the gate does *by itself* after each save: moving on is the whole claim, and a form that saves and then sits there is the failure these lines catch.

### Process `member` — "Become a member"
- [x] get an account into the process: sign up through the email door (`/sign_up`) and verify the code from the Dev Mail Store — `new_user_onboarding` on `authentication.email_and_password` stamps every self-service signup with this process. Then try to reach an ordinary page — the gate takes the browser instead, the address is `/onboarding?return_to=…` naming where the account was heading, and the nav, header and page behind it are gone rather than drawn under the box
      ✓ `wanda@example.com` created through `/sign_up` and verified with the code from the Dev
        Mail Store (`/api/__dev/emails/1`): the finish lands signed in, `GET /session.json` answering
        `wanda@example.com` with roles `[self]`, and the browser on `/onboarding` —
        `new_user_onboarding` having stamped the process on the signup.
        ✓ The gate takes every other route: `/library/books` becomes
        `/onboarding?return_to=%2Flibrary%2Fbooks` and `/account` becomes
        `/onboarding?return_to=%2Faccount`, each naming where the account was heading. Bare `/` becomes
        `/onboarding` with no `return_to`, there being no destination to name.
        ✓ Nothing is drawn behind the box: no nav rail, no page header, no [[Header Bar]] and no
        [[Command Strip]] are in the DOM at all — the whole app is gone rather than greyed under it.
- [ ] step 1 of 1, `join` — the box carries the heading "Join the library" and the sentence "Tell us how you would like to be known around the library, and we will set up your membership.", the progress reads 1 of 1, and the form under it is modal `join_library`'s own blocks rather than a dialog drawn inside the box. Fill it and save: the save's own outcome is reported where the box can show it, the step's precondition (`.membership`) then holds, and the gate moves on without being asked — to the step after it, or out of the gate entirely where this is the last
      ✓ The box carries the heading **Join the library** and the sentence *Tell us how you would
        like to be known around the library, and we will set up your membership.* — both the process
        step's own — and under them `join_library`'s blocks themselves rather than a dialog drawn
        inside the box: the markdown welcome, **Display name**, and **Membership tier** offering
        Bronze / Silver / Gold from its itemset.
        ✓ The save's outcome is reported where the box can show it, in both directions. Saving with
        the fields empty leaves the step in place and writes no member; saving *Wanda the Reader* /
        *Silver* writes `members` (silver, active) and the gate then **moves on without being asked**,
        landing on the `return_to` it was carrying.
        ⚠ **#1364** — the progress is the one clause with nothing to read. It is a bare
        `<div class="_progress_" style="--progress: 100%">`: full before the step is done, carrying no
        "1 of 1" anywhere in the DOM, and with no role, value or label for a screen reader.
        ⚠ **#1363** — the empty save's refusal reads *Workflow 'users/join_library' requires
        user_input and none was supplied*, which names a workflow path at a brand-new account on the
        first screen it ever sees. Refused cleanly; worded from the layer below.
- [x] **Sign out is the only way off**: the corner of the box signs the account out and lands on the sign-in screen, and signing back in returns to the same step rather than into the app. Nothing else in the box leaves it — no close, no skip, and the browser's Back comes straight back to the gate
      ✓ The corner's **Sign out** is the only control in the box besides the step's own Save —
        no close, no skip, and the dev header's buttons are the only other things on screen. It lands
        on `/sign_in`, and signing back in as the same account returns to the **same step** rather
        than into the app.
        ✓ The browser's Back comes straight back to the gate: `history.back()` from
        `/onboarding?return_to=%2Flibrary%2Fbooks` stays there, with a `window.__mark` set beforehand
        still readable afterwards, so the app was never remounted.
- [x] finishing the last step lets the account in *and keeps it in*: the browser lands on wherever the `return_to` named, the ordinary nav and header are back, and a reload — or a fresh sign-in as the same account — goes nowhere near the gate, the assignment having been cleared rather than merely stepped past
      ✓ The save landed the browser on `/library/books`, the `return_to` it was carrying, with the
        nav rail, the page header and the [[Command Strip]] back — the strip reading **Finish
        onboarding**. Console clean throughout.
        ✓ It stays in: reloading `/library/books` stays there, and signing out and back in as
        `wanda@example.com` lands on `/` rather than anywhere near the gate. The assignment was
        cleared rather than stepped past.
        ⚠ Worth naming because this is where a new member's first landing goes: `/` is **blank** for
        her, which is **#1351** — she now has a `members` row, so the dashboard's *My membership*
        section survives its `visible_if` and its refused widget query takes the page down. The gate
        releases the account correctly and delivers it to an empty page.

## Modals
- [x] `about_library` — **no entry point found in any page or dashboard**: find how it opens (record action set, workflow UI action, …) or report it as unreachable config
      ⚠ **#1366** — unreachable config, confirmed. `about_library` declares **no `subject:` at
        all**, so there is nothing for any `modals:` list to match it against: no record action set
        can name it and no workflow UI action reaches it. Its text (*About this library*) appears
        nowhere in the app — not in the nav, the user menu, the dashboard, a page header or a row
        menu.
- [x] `edit_author` — covered above via: author_page (edit); author_page (record action); authors_listing (add); authors_listing (row edit); authors_listing (record action)
      ✓ Cross-checked against this run's own record: `edit_author` is walked and submitted on
        `author_page` (edit, record action) and on `authors_listing` (add, row edit, record action),
        all five in session 02's and session 05's sections above.
- [x] `edit_book` — covered above via: book_page (edit); book_page (record action); books_listing (add); books_listing (row edit); books_listing (record action); dashboard section "Catalogue"
      ✓ Cross-checked: `edit_book` is walked on `book_page` (edit, record action) and
        `books_listing` (add, row edit, record action) in sessions 02 and 05, and from the dashboard's
        Catalogue **Add a book** in this session's Dashboard section.
- [x] the calendar on modal `edit_book` (`published_on`): each of those opens a month grid of its own rather than the browser's date control — a day clicked in the grid lands in the field, the keyboard walks the grid and picks with Enter, the input beside it can still be typed into, and the value that saves is the day that was chosen
      ✓ Its own month grid — `_calendar_xbuas_6`, 42 day cells under M T W T F S S — rather than
        the browser's date control: the field is `type=text` and no `input[type=date]` exists in the
        modal.
        ✓ A day clicked in the grid lands in the field: clicking **15** on September 2026 wrote
        `2026-09-15` and closed the grid.
        ✓ The keyboard walks the grid and picks with Enter, driven from the input the way a combobox
        is: with the grid open on July 1999, Right / Right / Down moved the `_focused_` day 4 → 5 → 6
        → 13 and Enter wrote `1999-07-13` and closed it.
        ✓ The input beside it can still be typed into: typing `2026-01-15` into a fresh modal put it in
        the field, and opening the grid then showed **January 2026** with 15 selected.
        ✓ The value that saves is the day that was chosen — see the precision line below.
        A nuance rather than a finding: after a day has been *picked*, a later typed value does not
        move the grid's month on the next open — it reopens on the month last picked. A fresh modal
        follows the typed value, and the committed value is right either way.
- [x] date precision on modal `edit_book`: save, reload the page and read the row back in `psql` — the day fields there (`published_on`) come back bare days, with no time anywhere on them, and the day stored is the day the grid was pointed at rather than the one either side of it, which is what a reader in a zone behind or ahead of the server's own is here to catch
      ✓ Saved *Date Precision Book* with **1 July 1999** clicked in the grid, and psql reads
        `published_on | 1999-07-01 | date` — a bare day, no time anywhere on it, and the day clicked
        rather than either side of it. The server session is `Australia/Melbourne`, eleven hours ahead
        of UTC, which is the zone that would show the slip if there were one.
- [x] `edit_club` — covered above via: club_page (edit); club_page (record action); clubs_listing (add); clubs_listing (row edit); clubs_listing (record action)
      ✓ Cross-checked: walked on `club_page` (edit, record action) and `clubs_listing` (add, row
        edit, record action) in sessions 03 and 06.
- [x] `edit_event` — covered above via: events_listing (add); events_listing (row edit); events_listing (record action)
      ✓ Cross-checked: walked on `events_listing` (add, row edit, record action) in session 03,
        and again from the add button in this session for the calendar lines below.
- [x] the calendar on modal `edit_event` (`starts_at`): each of those opens a month grid of its own rather than the browser's date control — a day clicked in the grid lands in the field, the keyboard walks the grid and picks with Enter, the input beside it can still be typed into, and the value that saves is the day that was chosen
      ✓ The same month grid rather than the browser's control, on a field that is a date input and
        a time input side by side. Clicking **3** on September 2026 wrote `2026-09-03` with the time
        defaulting to `00:00:00`; Down then Right then Enter from the date input moved the focused day
        a week and a day and wrote `2026-09-11`; and both inputs take typing — `2027-03-01` and
        `19:45:30`, to the second.
- [ ] date precision on modal `edit_event`: save, reload the page and read the row back in `psql` — the date-time fields there (`starts_at`) come back with the time they were given, to the second, and the day stored is the day the grid was pointed at rather than the one either side of it, which is what a reader in a zone behind or ahead of the server's own is here to catch
      ⚠ **#1365** — the seconds survive and the day does not. *Date Precision Event* saved with
        **2027-03-01 19:45:30** reads back in psql as
      
            Date Precision Event | 2027-03-02 06:45:30+11 | 2027-03-01 19:45:30
                                   (starts_at)              (at time zone 'UTC')
      
        The wall clock is written into a `timestamptz` as though it were UTC, so the stored day is
        **the one after** the day the grid was pointed at — which is exactly the slip this line exists
        to catch, at a server and browser both on `Australia/Melbourne`. The backdrop's own row does
        the same (`2026-07-02 04:00:00+10` for an 18:00 event), and the API round-trips the reader's
        wall clock unchanged and offset-less, which is why the app looks right to itself and is the
        same serialisation behind #1326.
- [x] `edit_loan` — covered above via: loans_listing (add); loans_listing (record action); dashboard section "Circulation"
      ✓ Cross-checked: walked on `loans_listing` (add, record action) in session 03 and on
        `members_listing` in session 04, and from the dashboard's Circulation **Check out a book** in
        this session's Dashboard section.
- [x] the calendar on modal `edit_loan` (`due_on`): each of those opens a month grid of its own rather than the browser's date control — a day clicked in the grid lands in the field, the keyboard walks the grid and picks with Enter, the input beside it can still be typed into, and the value that saves is the day that was chosen
      ✓ The same month grid rather than the browser's control. Clicking **30** wrote `2026-10-30`;
        Right then Enter from the input wrote `2026-10-31`; and the input takes `2027-01-01` typed
        straight in. An empty **Due date** opens the grid on the *following* month (October, walked on
        28 September) rather than the current one — sensible for a due date, and noted rather than
        filed.
- [x] date precision on modal `edit_loan`: save, reload the page and read the row back in `psql` — the day fields there (`due_on`) come back bare days, with no time anywhere on them, and the day stored is the day the grid was pointed at rather than the one either side of it, which is what a reader in a zone behind or ahead of the server's own is here to catch
      ✓ Saved with **2027-01-01** and psql reads `due_on | 2027-01-01 | date` — a bare day, no
        time, the day that was chosen. Same `date` storage as `books.published_on`, and unaffected by
        the `timestamptz` problem #1365 describes for `events.starts_at`.
- [x] `edit_member` — covered above via: member_page (edit); member_page (record action); members_listing (row edit); members_listing (record action)
      ✓ Cross-checked: walked on `member_page` (edit, record action) and `members_listing` (row
        edit, record action) in sessions 04 and 06.
- [x] `invite_user` — covered above via: users_listing (record action)
      ✓ Cross-checked: walked as `users_listing`'s record action in session 04.
- [x] `join_library` — covered above via: users_listing (record action); onboarding `member` (step `join`)
      ✓ Cross-checked on both: as `users_listing`'s record action in session 04, and as the
        `member` process's `join` step in this session's Onboarding section, where its blocks are drawn
        by the gate itself and its save creates the membership.
- [x] `moderate_review` — covered above via: review_page (edit); reviews_listing (row edit)
      ✓ Cross-checked: walked on `review_page` (edit) and `reviews_listing` (row edit) in sessions
        04 and 06, and on `book_page`'s reviews tab besides.
- [x] `onboard_member` — covered above via: member_page (record action); members_listing (add); members_listing (record action)
      ✓ Cross-checked: walked on `members_listing` (add, record action) in session 04. The
        `member_page` (record action) half of this line is **#1348** — the generator resolves
        `modals: ["*"]` over every modal naming the model and so asks a record page to open a
        `kind: new_record` modal, which no record page offers. Already filed; the modal itself is
        covered.
- [x] `set_credential` — covered above via: credentials page
      ✓ Covered in this session's Credentials page section: opened from a row's click and from the
        row's own [[Row Context Menu]], and submitted — with #1361 and #1362 against how it is drawn.
- [x] `suspend_member` — covered above via: member_page (record action); members_listing (record action)
      ✓ Cross-checked: walked on `members_listing` (record action, from one row's menu and over a
        three-row [[Selection]]) in session 04 and on `member_page` (**More → Suspend member**) in
        session 06 — the ratchet that took the malformed-URL bug out of the known issues.
- [x] `venue_details` — **no entry point found in any page or dashboard**: find how it opens (record action set, workflow UI action, …) or report it as unreachable config
      ⚠ **#1366** — unreachable config, confirmed. Its subject is `kind: data` naming the
        `address` *schema* rather than a model, so `events_listing`'s `record_actions.modals: ["*"]`
        cannot resolve it: session 03's walk of that page found it absent from the row's actions, and
        it is absent from the page's **More** menu, the nav and the dashboard. The `venue` cell opens
        the inline object editor (#1324) rather than this modal, and `events` has no record page.
        Both `events_listing.yaml` and `address.yaml` carry comments saying the address *is* shown by
        it, so the config describes an entry point that does not exist — and `edit_event` leaves
        `venue` out on the strength of that comment.
- [x] `write_review` — covered above via: books_listing (page action); reviews_listing (add)
      ✓ Cross-checked: walked as `books_listing`'s page action in session 02 — the seeded,
        nothing-selected launcher the notes file's journey also covers — and as `reviews_listing`'s add
        in session 04.

## Documents
A [[Run-Created File]] has no uploader and reaches the app only through the run that made it, so what is under test is that the PDF **arrives, opens, and is the right document** — not how it was authored.

- [x] `event_worksheet` via `events/event_worksheet` (node `render`): do the thing that fires this workflow, then find the record it wrote to. The file property shows a file rather than an empty slot; opening it downloads a PDF that actually renders; the content is this document and not a stale or blank one. A run that settles `done` with the slot still empty is the failure this catches — check the run's steps for a `render_document` error rather than assuming the trigger did not fire.
      ✓ The trigger is `on_create` into `scheduled`, so adding a club event fires it: creating
        *Date Precision Event* under Dune Readers with capacity 20 left a `events/event_worksheet` run
        at **done** in `workflow_runs`, beside the `plan_club_session` run the same create started.
        ✓ The file property shows a file rather than an empty slot: the row's **Worksheet File Id**
        cell draws a chip with an icon and the name
        `worksheet-3ae9512b-….pdf`, and `file_uploads` holds a 34,829-byte `application/pdf` that
        `events.worksheet_file_id` points at. The seeded `completed` event's cell is empty, the
        trigger's `statuses: [scheduled]` never having reached it.
        ✓ It opens and renders. `GET /api/records/events/<id>/files/worksheet_file_id` signs a URL,
        the signed URL answers **200 application/pdf** with the filename in `Content-Disposition`, and
        the four pages render: the club's logo and name over the event's title and the club's tagline;
        a details table (Club, Starts, Venue, Format `in_person`, Places 20); *This session's book* —
        Dune, its cover, its author and its summary; *Discussion questions* with four ruled prompts;
        *Who came*, a twenty-row table matching the capacity that was set; and an organiser checklist
        over a footer reading *Dune Readers · worksheet generated 2026-09-28*. Running headers on
        pages 2–4 name the club and this event. It is this document for this record, not a stale or
        blank one.
        ⚠ **#1367** — two lines of the book block print raw data: the genre reads `science_fiction`
        rather than the itemset's *Science Fiction* the rest of the app shows, and Dune's null
        `page_count` prints as a bare `·  pages`.
        ⚠ The **Starts** row reads `2027-03-01T19:45:30+00:00` for a time entered as local — **#1365**
        reaching a document a reader can print.

## Undo
An ordinary save is taken back by **compensation** — the reverse of what it did, sent as a real write through the same client (ADR-0099), so an undo fires the tracking triggers, is recorded the way any other write of that model is recorded, and is refused by the same policies a forward write is. Whether an entry can be taken back at all is decided at save time from the spec, which is why the lines below are derived from each model's own permissions rather than asked of the server. A [[Locked Command]] greys the icon on every entry older than it.

- [x] an ordinary edit undoes: on `authors_listing`, open row edit modal `edit_author` on an existing `authors` record, change one property and save. The entry that save leaves in the strip's history wears an undo icon rather than a lock — click it and the property reads what it read before, in the row behind the modal and in the modal reopened on that record, with the strip's headline naming the undo rather than the save. What the undo sends is only the property the save moved: every other property of that record comes out of it as it went in. And it is an ordinary write rather than a rollback — the record's `updated_at` moves forward again rather than back to where the save found it.
      ✓ Row edit `edit_author` on Frank Herbert, Bio set to *Undo-walk bio.*, saved. The entry in
        the strip's history is **Save changes** carrying `_act_` — an undo icon, `aria-label="Undo
        Save changes"` — rather than `_lock_`. Clicking it puts the Bio back to empty in the row and
        in the modal reopened on that record, and the strip's headline reads **Undo Save changes**
        rather than the save's name.
        ✓ Only the property the save moved comes back: `name`, `website`, `nationality` and `status`
        are byte for byte what they were, checked in the database.
        ✓ It is an ordinary write rather than a rollback — `updated_at` moved **forward**, from the
        seed's `13:52:04` to `14:44:41`, rather than back to where the save found it.
- [x] a delete locks the stack, and everything under it: `books`'s spec declares a `delete` permission (on the `admin` policy, reaching `draft`), and modal `edit_book` draws the Delete button for it. Make an undoable save first — the edit above, or one of the transitions below — then open `edit_book` on a `books` record the permission reaches and delete it. Its own entry wears a lock: there is no soft delete, so nothing here brings the record back. Open the caret and the undoable entry *beneath* it has lost its icon too, and Ctrl+Z moves nothing while that lock is on top
      ✓ Walked in one history: a row edit on Dune (Summary) first, leaving an undoable **Save
        changes**; then `edit_book` opened on *Dashboard Walk Book*, a `draft` the `admin` policy's
        `delete` permission reaches, which is where the **Delete** button appears at all. Yes on the
        confirm, and the record is gone from the listing and from `books` — no soft delete, nothing
        brings it back.
        ✓ Its own entry wears `_lock_`, titled *This cannot be undone*.
        ✓ The undoable entry **beneath** it has lost its icon: the stack reads
        `Yes → LOCK` over `Save changes → NONE`.
        ✓ `Ctrl+Z` with that lock on top moves nothing — the headline does not change, the stack does
        not change, no record moves and the console stays clean. No *Undo — Failed* appears, which is
        the notes ledger's rule rather than a regression.
        ● The entry is named **Yes** rather than *Delete* — the standing confirm-gated-command naming
        bug, confirmed here on `books`.
- [x] `authors` transitions: the spec permits `active` → `retired` and the move back under the same `admin` policy, so make that move — from whichever of this model's surfaces transitions a record: the status menu a selected row's status cell opens, the record's own panel, or a drag between a board's columns — and its entry wears an undo icon. Take it back and the record is in `active` again, the reverse standing in its lifecycle history as a write of its own rather than the forward row having been taken away. Every move this spec permits has a permitted reverse, so no `authors` transition locks
      ✓ Made from the status cell's own transition menu on `authors_listing` (Active / Retired,
        both offered). Frank Herbert `active` → `retired` lands and its entry carries the undo icon.
        Taking it back puts him in `active`, and `authors_lifecycles` holds **two** rows — one
        `retired`, one `active` — so the reverse stands as a write of its own rather than the forward
        row having been removed.
        ✓ The spec's only move is `active` ↔ `retired` and both directions are permitted, so nothing
        here locks, which is what the line says.
- [x] `books` transitions: the spec permits `published` → `archived` and the move back under the same `admin` policy, so make that move — from whichever of this model's surfaces transitions a record: the status menu a selected row's status cell opens, the record's own panel, or a drag between a board's columns — and its entry wears an undo icon. Take it back and the record is in `published` again, the reverse standing in its lifecycle history as a write of its own rather than the forward row having been taken away. `draft` → `published` is the other way: the `admin` policy holds no permission for the move back, so that entry wears a lock instead — and every entry beneath it in the stack loses its icon behind that lock
      ✓ **The undoable half.** A Wizard of Earthsea `published` → `archived` from the status cell's
        menu: the entry carries the undo icon, and taking it back puts the book in `published` again.
        (The `stamp_summary_on_archive` workflow's rewrite of the summary is not undone with the
        status — the notes ledger's rule, not a finding; the summary was put back through
        `/keystone/mutate`.)
        ✓ **The locking half.** Dune Messiah `draft` → `published`, which the `admin` policy holds no
        permission to reverse: the entry wears `_lock_` with
        `aria-label="Change status cannot be undone"`, and the menu itself greys `Archived` on a
        `draft` row and `Draft` on a `published` one, so the permission is visible before the move as
        well as after it.
        ✓ **Everything beneath the lock loses its icon.** Built deliberately: two undoable row-edit
        saves and an older transition, then a `draft` → `published` on top. The stack then reads
      
            Change status → LOCK
            Save changes  → NONE
            Save changes  → NONE
            Change status → NONE
      
        and `Ctrl+Z` moves nothing.
- [x] `clubs` transitions: the spec permits `active` → `archived` and the move back under the same `admin` policy, so make that move — from whichever of this model's surfaces transitions a record: the status menu a selected row's status cell opens, the record's own panel, or a drag between a board's columns — and its entry wears an undo icon. Take it back and the record is in `active` again, the reverse standing in its lifecycle history as a write of its own rather than the forward row having been taken away. Every move this spec permits has a permitted reverse, so no `clubs` transition locks
      ✓ Dune Readers `active` → `archived` from the status cell's menu (Active / Archived, both
        offered): the entry carries the undo icon, and taking it back puts the club in `active`. Every
        move this spec permits has a permitted reverse, so nothing here locks.
- [x] `events` transitions: no move this spec permits has a permitted reverse, so no `events` transition undoes. Take `scheduled` → `cancelled`: the `admin` policy holds no permission for the move back, so that entry wears a lock instead — and every entry beneath it in the stack loses its icon behind that lock
      ✓ *Date Precision Event* `scheduled` → `cancelled` from the status cell's menu: the entry
        wears `_lock_`, *Change status cannot be undone*. No `events` move has a permitted reverse, so
        no `events` transition undoes — as the line says. The event is left `cancelled`.
- [x] `loans` transitions: no move this spec permits has a permitted reverse, so no `loans` transition undoes. Take `requested` → `active`: the `admin` policy holds no permission for the move back, so that entry wears a lock instead — and every entry beneath it in the stack loses its icon behind that lock
      ✓ `requested` → `active` from the status cell's menu in the **Table** view (this listing opens
        on its Board, which has no status cell), on a loan due 2026-10-20 — inside the spec's sixty-day
        term. The entry wears `_lock_`, *Change status cannot be undone*, and the **Save changes** that
        created the loan, beneath it, has lost its icon. No `loans` move has a permitted reverse.
        ● Walked first on a loan due 2026-12-01 and refused, which is the noise ledger's
        `loan_term_within_limit` entry working exactly as written: the client's pre-check says nothing
        (`checked_out_at` is still null), the card rolls back, the strip reads **Change status —
        Invalid input**, and the rule's own sentence — *A loan can run for at most 60 days from
        checkout; bring the due date back in.* — is under the caret. Nothing enters the stack.
        The menu also greys `Overdue` and `Returned` from `requested`, the permissions reaching
        neither.
- [x] `members` transitions: the spec permits `active` → `suspended` and the move back under the same `admin` policy, so make that move — from whichever of this model's surfaces transitions a record: the status menu a selected row's status cell opens, the record's own panel, or a drag between a board's columns — and its entry wears an undo icon. Take it back and the record is in `active` again, the reverse standing in its lifecycle history as a write of its own rather than the forward row having been taken away. Every move this spec permits has a permitted reverse, so no `members` transition locks
      ✓ Alice Reader `active` → `suspended` from the status cell's menu (Active / Suspended, both
        offered): the entry carries the undo icon, and taking it back puts her in `active`. Every move
        this spec permits has a permitted reverse, so nothing here locks.
- [x] `reviews` transitions: the spec permits `published` → `hidden` and the move back under the same `admin` policy, so make that move — from whichever of this model's surfaces transitions a record: the status menu a selected row's status cell opens, the record's own panel, or a drag between a board's columns — and its entry wears an undo icon. Take it back and the record is in `published` again, the reverse standing in its lifecycle history as a write of its own rather than the forward row having been taken away. Every move this spec permits has a permitted reverse, so no `reviews` transition locks
      ✓ Made from the record page rather than the listing — `reviews_listing` draws no status
        column, so the [[Record Page Actions]] cluster's status button is this model's transition
        surface. *A desert masterpiece* `published` → `hidden` from that button's menu: the entry
        carries the undo icon, and taking it back puts the review in `published`, with the header's
        status chip following both ways. `reviews_lifecycles` holds one `hidden` row and one
        `published` row, the reverse standing as its own write. Every move this spec permits has a
        permitted reverse, so nothing here locks.

## Journeys

The notes file's hand-written flows, walked last and recorded here. The plan generates none of
these; they are the judgments a surface walk cannot make.

- [ ] **The desks actually stream.**
      — **Unreachable in this harness.** The journey needs LLM credentials set for itself, contra
      the plan's default, and this pass has none: the eight rows on `/credentials` all read
      *Not set*, and nothing in this environment carries a key. A desk walked without them
      cannot answer whether a reply renders progressively, because no reply arrives. Said so
      rather than ticked.
- [x] **A workflow button is a spec permission, and the UI agrees.**
      ✓ **Positive.** As `librarian@example.com` on an **active** member's record page, **More**
        holds **Suspend member**. It opens `suspend_member` (a Reason field) rather than
        dispatching straight away; filling Reason and saving starts the run, which settles
        **done** with all three nodes — `entry`, `suspend`, `notify` — done, and the `members`
        row reaches `suspended`.
      ✓ Reloading the now-suspended member takes **both** suspend entries out of **More**
        (the plain `Suspend member` and the gated `Suspend this member`), leaving Copy Member ID
        and Lend that book again — the permission naming `active` only.
      ✓ **Negative.** As a patron on her own member row: **More** holds Copy Member ID and a
        disabled Lend that book again, and the string *suspend* appears nowhere in the page. Nor
        on `members_listing`, which shows her the one row her grant reaches. Another member's
        record page is not served to her at all.
      ⚠ **#1369** — the page the run was launched from does not notice it: the status chip still
        reads **Active** and both suspend entries are still offered until a reload. An ordinary
        transition from the status chip does refresh; the workflow path does not.
      ● The strip names the run **Save changes**, after the modal's button rather than the
        action — **#1331**'s shape on a record page rather than over a [[Selection]].
      ● Another member's record page renders blank for the patron rather than refusing — the
        standing no-route-level-refusal issue, in its record-page shape.
- [x] **A cover round-trips visibly.**
      ✓ A PNG sent to `edit_book`'s `file_upload_field` on *Date Precision Book* shows as
        *walk-cover.png / File attached* in the form, and after **Save changes** the book's
        record page draws it: one `<img>` whose `naturalWidth`/`naturalHeight` are the file's own
        4×4, `complete: true`, laid out at 278×278, served through
        `/api/file_downloads/<token>`. `books.cover_image_id` points at the `file_uploads` row.
      ✓ Reopening the form and pressing **Remove** puts the field back to *No File Chosen*, and
        after the save the page draws no image at all and `cover_image_id` is NULL.
- [ ] **Curation lands where users look.**
      — **Unreachable in this harness**, for the same reason as the streaming desks: the journey
      says "with LLM credentials set" and this pass has none. `books/curate_book` and the review
      moderation it names cannot run.
- [x] **The UI agrees with the server about roles.**
      ✓ As a patron, `books_listing` draws no **Add Book** — the header holds Filters, Sort,
        Customize columns, More and the three view switches and nothing else — a row carries only
        **Show row menu** and no pencil, and the page contains **zero** `[data-inline-cell]`
        elements, so no cell can be opened for editing. `authors_listing` is the same, with no
        **Add Author**.
      ✓ The board offers nothing to drag either: three columns and **no cards at all**, which is
        **#1322** — the reader's policy does not include the ordering property — confirmed as
        known rather than re-filed. Console clean throughout.
      ✓ Nothing mutating is clickable, so nothing can be denied on click. The clean-refusal half
        was walked instead where the server *can* refuse an allowed-looking write — see the
        in-place edit journey below, where revoking the role under an open editor produces
        **Save changes — Not allowed** with the reason under the caret.
- [x] **A page-level launcher opens seeded, with nothing selected.**
      ✓ On `books_listing` with **no row checked**, **More → Recommend a book** opens the modal
        at once: sampled 220ms after the click it reads *Loading… | Cancel*, its own loading
        state, and it settles as **New Review** — creating into `reviews`, not `books`.
      ✓ It lands seeded: **I recommend this book** ticked and **Rating (1–5)** reading **5**,
        with Book, Member and Headline empty for the reader to fill.
- [ ] **A gated launcher tells the truth, in order.**
      ✓ The gate is right on every member, and each predicate speaks for itself. Walked as admin
        with exactly one row checked at a time:
          · **Alice Reader** (a phone and two loans) — **enabled**.
          · **Nora Newcomer** (a phone, no loans) — disabled, *"This member has never borrowed a
            book, so there is nothing to reissue."* — the tier-2 binding's message.
          · **Wanda the Reader** (a loan, no phone) — disabled, *"Add a contact number for this
            member before lending to them."* — the tier-1 property's message. Only the first
            failing predicate is shown, and each member shows its own.
          · **Bob Bookworm** (`suspended`) — Lend that book again enabled, and **both** suspend
            entries gone.
      ✓ **Suspend this member** shows on every member **except the acting user's own membership
        row** — paired by creating an `Ada Admin` member row, where it is absent and every other
        row keeps it.
      ✓ **No flip, and nothing moves.** Polled every 25ms from the click that opens the menu:
        the button is already in its final state at the menu's first paint (88ms) and the item
        count (7) and the button's y never change. The journey accepts a flip; this build does
        not need one, so there is nothing to watch.
      ✓ Pressing the enabled one opens the modal **immediately** — *Loading… | Cancel* at 41ms —
        and settles at 323ms.
      ⚠ **#1370** — and settles **empty**. `<form class="_form_tm010_1"></form>`: no Book, no
        Member, no Due date, so nothing is prefilled because nothing is drawn. The same
        `edit_loan` opened by the loans listing's **Add Loan** draws its three fields; both the
        listing's launcher and `member_page`'s draw none.
- [ ] **A listing hands over its state and gets it back.**
      ✓ **The handover.** `books_listing` at `?filter_status=d~eq~published&sort=title_desc`,
        opening a book from a row: the record URL carries
        `?ref_filter_status=…&ref_sort=title_desc` and **nothing under the bare names**.
      ✓ **The tabs.** Both `ref_` parameters survive Overview → Reviews → History → Reading time
        → Overview → Reviews unchanged. A sort applied *inside* the Reviews tab writes
        `&sort=rating_desc` alongside them, and leaving the tab and coming back **starts it
        fresh** — the `ref_` pair stays, the tab's own sort is gone.
      ✓ **The tab's own handover.** Opening a review from the Reviews tab writes
        `?ref_filter_book_id=s~<the book>` onto the review's URL — the tab's fixed filter,
        handed over as its own `ref_`.
      ✓ **No history at all.** Navigating to a record URL with `about:blank` behind it, the
        arrow still lands on `/library/books`: the target is computed from the listing's route
        rather than taken from history.
      ⚠ **#1350** (commented with both repros) — the return trip is where it fails, on the
        listing that declares `default_filters`:
          · the back arrow from that review lands on
            `?ref_filter_book_id=s~<book>&filter_status=d~eq~published` and the listing shows
            **both** reviews in the database, so it is not filtered to the book at all; the
            Filters modal offers a Status row and no Book Id row, so the filter is neither
            visible nor removable;
          · clearing the seeded `status: published` filter gives `?unfiltered=1`, handed over as
            `ref_unfiltered=1`, and the arrow brings back
            `?ref_unfiltered=1&filter_status=d~eq~published` — the default re-seeded over the
            reader's cleared state.
        Both are the same mechanism this issue already names: the arrow converts no `ref_`
        parameter back, and whatever the listing seeds on arrival is what the reader gets.
- [ ] **A review edits in place.**
      ✓ Rows read in the **block's** authored order — Headline, Rating, Recommended, Body, Tags
        — not the model's, which starts with `book_id`.
      ✓ **The safety story holds.** The page carries exactly three edit affordances: **Edit
        Headline**, **Edit Recommended**, **Edit Body**. There is **no Edit Rating**, though the
        config names `rating`: no policy's `update` permission covers it and the ceiling drops
        it.
      ✓ A scalar opens **in place in the value column** (the input at x=549 against labels at
        x=333) holding the current value; the markdown body instead **stacks to full width**
        (x=334, 1028 wide) and **only its own row reflows** — Headline, Rating, Recommended and
        Body labels are unmoved and only Tags is pushed down.
      ✓ The value **saves on blur**, and **the row carries no status line of its own** — no
        *Saving* or *Saved* anywhere in the page. The status is read in the [[Command Strip]],
        which names the command **Save changes** rather than the journey's *Saving* / *Saved*.
      ✓ **A run of edits to one property collapses to a single entry**: four successive headline
        edits leave one *Save changes* in the strip's stack.
      ✓ Typing and then **switching tabs mid-edit does not lose the edit** — History and back,
        and the editor is still open with the typed text — and **navigating away while unsaved
        warns**: `beforeunload` is cancelled while a draft is open and not while it is not.
      ✓ **A refused save keeps the text on screen and shows why.** Revoking `admin_role` under an
        open headline editor and blurring gives **Save changes — Not allowed** in the strip with
        *Not permitted to update 'reviews' record … (status: published)* under the caret, and the
        row goes on showing the rejected text while the database keeps the stored value. (Worth
        knowing beside **#1329**, which calls the same shape a fault on a listing cell: the two
        surfaces are specified to disagree about whether the rejected value should stay.)
      — **The embedded image is unreachable in this harness.** The editor's **Attach a file**
        opens the platform's own picker and puts no `input[type=file]` in the DOM, so Marionette
        has nothing to send a path to. The claim-reconcile clause was not walked.
      ● **#1349** — re-confirmed and narrowed (commented on the issue). The *body* draft's plain
        banner discards correctly; the *headline* draft's **"…and this record has changed since"**
        banner **saves** the draft on **Discard**.
- [ ] **A blocked action asks for a step-up, and then completes.**
      ⚠ **#1371** — none of the four flows can be walked, because the step-up modal does not
        exist. The server is right and says so precisely: with the acting session's proof two
        hours old, `POST /keystone/mutate` answers
        `{"code":"step_up_required","step_up":"fresh_session"}` beside its message, and
        `keystone-client` carries both fields. Nothing in `packages/elevater/src` reads either,
        so the app draws the generic refusal — the edit modal left open over *Not permitted to
        update 'members' record …*, **Save changes — Not allowed** in the strip — and offers no
        password form and no way back.
      ⚠ The proactive arm is worse than the journey allows for: with the session already stale on
        load, `/community/members/<id>` renders **blank** and `/community/members` renders its
        headers over **0 items**. The records do not stay reachable-looking with a step-up behind
        the first click; they vanish.
      — Cancel on either arm, and the digest-less dead end that should link the password reset,
        have nothing to be walked against until the modal exists.
      **The journey's own fixture is wrong and was corrected here.** `sessions.authenticated_at`
      is `timestamp without time zone` holding **UTC**, so `now() - interval '2 hours'` in a psql
      session on `Australia/Melbourne` writes a stamp eight hours in the *future* of UTC and the
      session reads as freshly authenticated — which is why a first pass saw the write succeed.
      `(now() at time zone 'UTC') - interval '2 hours'` is the fixture that works. Measured from
      both sides with the corrected form, the window is exactly the hour the server declares.
- [x] **Every kind of record tab brings its own scroll box.**
      ✓ On a book's **Reading time** tab the page has **exactly one** scroller — `f1z8ra_scroll`
        at y=156, 642 visible over 1706 — and the document itself does not scroll at all
        (`scrollHeight - clientHeight === 0`).
      ✓ Scrolling it to the foot leaves the record's title at y=70, the tab list at y=68 and the
        header bar at y=104 exactly where they were, and the last of the 44 pace rows is reached
        inside the box.
      ✓ The tab's own title — **Reading time** — is in the header bar under the record's title,
        and the content draws **no second bar**: no `_header_131jw`, `_pageHeader_` or
        `_title_1n1vi` anywhere inside the scroll box.
      ✓ The control holds. On **Overview** the same plugin is mounted as a block and is **not** a
        scroller of its own: the page's one scroller is the blocks box
        (`f1z8ra_scroll BMwDMq_blocks`, 640 visible over 3163), which is the block mount being
        unchanged.
- [x] **A long history scrolls inside the History tab.**
      ✓ A book moved through nine `published` ⇄ `archived` pairs carries 19 rows in
        `books_lifecycles`, and its **History** tab draws them all — Archived / Published down to
        the original Draft.
      ✓ The table scrolls **inside the tab**: one scroller, `f1z8ra_scroll` at y=156, 642 visible
        over 700, the document not scrolling, the record's title fixed at y=70 throughout, and
        the last row (*Draft · 29 Sep 2026 00:34 · Ada Admin*) fully inside the box at the foot.
      — The truncation note does not appear at this length, so the clause about where it sits
        had nothing to judge. The journey's wording already allows for that ("where the
        truncation note appears").

---

793 checklist items generated. Anything that looks wrong beyond these lines is a discovery — report it too.
