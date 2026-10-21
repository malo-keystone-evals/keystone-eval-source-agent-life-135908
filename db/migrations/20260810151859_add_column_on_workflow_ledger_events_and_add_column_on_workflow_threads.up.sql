ALTER TABLE workflow_ledger_events
ADD COLUMN file_upload_id uuid;
ALTER TABLE workflow_threads
ADD COLUMN participant_ids uuid[] DEFAULT '{}'::uuid[] NOT NULL;
CREATE INDEX workflow_threads__idx_b_vc39s382xu ON workflow_threads USING gin (participant_ids);
ALTER TABLE workflow_ledger_events
ALTER COLUMN payload TYPE jsonb USING payload::jsonb;
ALTER TABLE workflow_ledger_events ADD CONSTRAINT workflow_ledger_events__fk_uv2dde4l57 FOREIGN KEY (file_upload_id) REFERENCES file_uploads (id) ON DELETE RESTRICT;
