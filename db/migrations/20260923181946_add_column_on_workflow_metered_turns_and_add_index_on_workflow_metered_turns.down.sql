CREATE UNIQUE INDEX IF NOT EXISTS workflow_metered_turns__idx_138s9n3hgel ON workflow_metered_turns USING btree (workflow_step_id, model);
DROP INDEX IF EXISTS workflow_metered_turns__idx_15421bgo77z;
DROP INDEX IF EXISTS workflow_metered_turns__idx_vzr2x1wqvj;
ALTER TABLE workflow_metered_turns
DROP COLUMN IF EXISTS model_profile;
