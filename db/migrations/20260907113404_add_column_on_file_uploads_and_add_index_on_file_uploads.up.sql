ALTER TABLE file_uploads
ADD COLUMN workflow_run_id uuid;
CREATE INDEX file_uploads__idx_cp7eedsmj8 ON file_uploads USING btree (workflow_run_id);
