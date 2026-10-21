ALTER TABLE workflow_ledger_events
ADD COLUMN author_id uuid;
CREATE INDEX workflow_ledger_events__idx_orzmbtcyyh ON workflow_ledger_events USING btree (author_id);
ALTER TABLE workflow_ledger_events ADD CONSTRAINT workflow_ledger_events__fk_orzmbtcyyh FOREIGN KEY (author_id) REFERENCES users (id);

-- Backfill from the payload the column denormalises. Every event already
-- carries its writer in `payload->>'author'` — the column is a second copy for
-- SQL to work with, not a new fact — so an existing transcript keeps its
-- attribution rather than starting blank.
--
-- Runs after the foreign key, so a payload naming a user who no longer exists
-- would fail loudly rather than write a dangling reference. That cannot happen
-- today (nothing deletes users, and the id came from a live session), and if it
-- ever does it is worth hearing about.
UPDATE workflow_ledger_events
SET author_id = (payload ->> 'author')::uuid
WHERE payload ->> 'author' IS NOT NULL;
