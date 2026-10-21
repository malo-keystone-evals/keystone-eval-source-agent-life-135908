ALTER TABLE workflow_runs
ADD COLUMN thread_id uuid;
ALTER TABLE workflow_steps
ADD COLUMN thread_id uuid;
CREATE TABLE workflow_threads (
 id uuid NOT NULL CONSTRAINT workflow_threads_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('open')::character varying NOT NULL,
 workflow_path character varying NOT NULL,
 record_model character varying,
 record_id uuid,
 user_id uuid,
 key text,
 created_by_id uuid,
 created_at timestamp with time zone DEFAULT now() NOT NULL,
 updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE INDEX workflow_runs__idx_2xbktrfjrz ON workflow_runs USING btree (thread_id);
CREATE INDEX workflow_steps__idx_2xbktrfjrz ON workflow_steps USING btree (thread_id);
CREATE INDEX workflow_threads__idx_nrcbxny9wa ON workflow_threads USING btree (status);
CREATE INDEX workflow_threads__idx_17uevxtspsa ON workflow_threads USING btree (workflow_path);
CREATE INDEX workflow_threads__idx_21uvcicx0vt ON workflow_threads USING btree (record_id);
CREATE INDEX workflow_threads__idx_1bcf3rnsxcn ON workflow_threads USING btree (user_id);
CREATE INDEX workflow_threads__idx_s1gk7xkfhp ON workflow_threads USING btree (created_at);
CREATE INDEX workflow_threads__idx_1vxk7frens6 ON workflow_threads USING btree (updated_at);
CREATE UNIQUE INDEX workflow_threads__idx_1c0bsn6b22s ON workflow_threads USING btree (workflow_path, record_model, record_id, user_id, key) NULLS NOT DISTINCT;
ALTER TABLE workflow_runs ADD CONSTRAINT workflow_runs__fk_2xbktrfjrz FOREIGN KEY (thread_id) REFERENCES workflow_threads (id);
ALTER TABLE workflow_steps ADD CONSTRAINT workflow_steps__fk_2xbktrfjrz FOREIGN KEY (thread_id) REFERENCES workflow_threads (id);
ALTER TABLE workflow_threads ADD CONSTRAINT workflow_threads__fk_1bcf3rnsxcn FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE workflow_threads ADD CONSTRAINT workflow_threads__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
