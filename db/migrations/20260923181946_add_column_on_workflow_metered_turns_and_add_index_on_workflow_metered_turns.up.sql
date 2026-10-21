ALTER TABLE workflow_metered_turns
ADD COLUMN model_profile character varying DEFAULT ('')::character varying;
UPDATE workflow_metered_turns
SET model_profile = (''::text);
ALTER TABLE workflow_metered_turns
ALTER COLUMN model_profile SET NOT NULL;
CREATE INDEX workflow_metered_turns__idx_15421bgo77z ON workflow_metered_turns USING btree (model_profile);
CREATE UNIQUE INDEX workflow_metered_turns__idx_vzr2x1wqvj ON workflow_metered_turns USING btree (workflow_step_id, model, model_profile);
-- The unique index this one supersedes. `keystone-dev sync` adds the new index
-- and leaves the old one, because an index is dropped only under `--cleanup`
-- (`push_index_diff`) and cleanup here would also sweep unrelated drift — so
-- the drop is written by hand.
--
-- It is not optional. `(workflow_step_id, model)` still enforces one row per
-- model per step, so the second of two profiles naming the same model id at
-- different reasoning efforts would be rejected outright rather than merged:
-- the upsert targets the three-column index while the two-column one refuses
-- the row. Leaving it is the failure mode ADR-0112 widened the key to prevent.
DROP INDEX IF EXISTS workflow_metered_turns__idx_138s9n3hgel;
