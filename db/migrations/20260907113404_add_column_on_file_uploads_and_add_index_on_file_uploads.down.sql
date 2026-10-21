DROP INDEX IF EXISTS file_uploads__idx_cp7eedsmj8;
ALTER TABLE file_uploads
DROP COLUMN IF EXISTS workflow_run_id;
