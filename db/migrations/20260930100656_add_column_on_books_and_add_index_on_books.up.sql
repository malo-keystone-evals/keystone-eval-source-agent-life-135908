ALTER TABLE books
ADD COLUMN cover_description text;
CREATE INDEX books__idx_1bu4u7m7cwp ON books USING btree (cover_image_id);
CREATE INDEX clubs__idx_1udg2lwpvcm ON clubs USING btree (logo_file_id);
CREATE INDEX events__idx_2emhqx4fv8e ON events USING btree (worksheet_file_id);
CREATE INDEX workflow_ledger_events__idx_1yuqutcxsn7 ON workflow_ledger_events USING btree (file_upload_id);
