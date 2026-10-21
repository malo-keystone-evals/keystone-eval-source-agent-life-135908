CREATE TABLE workflow_thread_files (
 id uuid NOT NULL CONSTRAINT workflow_thread_files_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('linked')::character varying NOT NULL,
 thread_id uuid NOT NULL,
 file_upload_id uuid NOT NULL,
 created_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE INDEX workflow_thread_files__idx_nrcbxny9wa ON workflow_thread_files USING btree (status);
CREATE INDEX workflow_thread_files__idx_2xbktrfjrz ON workflow_thread_files USING btree (thread_id);
CREATE UNIQUE INDEX workflow_thread_files__idx_1yuqutcxsn7 ON workflow_thread_files USING btree (file_upload_id);
CREATE INDEX workflow_thread_files__idx_s1gk7xkfhp ON workflow_thread_files USING btree (created_at);
ALTER TABLE workflow_thread_files ADD CONSTRAINT workflow_thread_files__fk_2xbktrfjrz FOREIGN KEY (thread_id) REFERENCES workflow_threads (id);
