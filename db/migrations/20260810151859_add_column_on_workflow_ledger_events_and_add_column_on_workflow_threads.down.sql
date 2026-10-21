ALTER TABLE workflow_ledger_events
ALTER COLUMN payload TYPE text USING payload::text;
ALTER TABLE workflow_ledger_events DROP CONSTRAINT IF EXISTS workflow_ledger_events__fk_uv2dde4l57;
DROP INDEX IF EXISTS workflow_threads__idx_b_vc39s382xu;
ALTER TABLE workflow_ledger_events
DROP COLUMN IF EXISTS file_upload_id;
ALTER TABLE workflow_threads
DROP COLUMN IF EXISTS participant_ids;
