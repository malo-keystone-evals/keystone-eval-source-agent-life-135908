CREATE TYPE workflow_metered_turns_status AS ENUM ('recorded');
CREATE TABLE workflow_metered_turns (
 id uuid NOT NULL CONSTRAINT workflow_metered_turns_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status workflow_metered_turns_status DEFAULT ('recorded')::workflow_metered_turns_status NOT NULL,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 workflow_run_id uuid,
 workflow_step_id uuid,
 thread_id uuid,
 node_id character varying NOT NULL,
 workflow_path character varying NOT NULL,
 trigger_record_model character varying,
 trigger_record_id text,
 user_id uuid,
 credential_name character varying NOT NULL,
 provider character varying NOT NULL,
 model character varying NOT NULL,
 calls integer DEFAULT 0 NOT NULL,
 input bigint DEFAULT 0 NOT NULL,
 output bigint DEFAULT 0 NOT NULL,
 cache_read bigint DEFAULT 0 NOT NULL,
 cache_write bigint DEFAULT 0 NOT NULL,
 reasoning bigint DEFAULT 0 NOT NULL,
 extra_tokens jsonb,
 duration_ms bigint DEFAULT 0 NOT NULL,
 cost_microcents bigint,
 priced_from text
);
ALTER TABLE workflow_runs
ADD COLUMN trigger_record_model character varying;
ALTER TABLE workflow_runs
ADD COLUMN trigger_record_id text;
CREATE INDEX workflow_metered_turns__idx_nrcbxny9wa ON workflow_metered_turns USING btree (status);
CREATE INDEX workflow_metered_turns__idx_s1gk7xkfhp ON workflow_metered_turns USING btree (created_at);
CREATE INDEX workflow_metered_turns__idx_1vxk7frens6 ON workflow_metered_turns USING btree (updated_at);
CREATE INDEX workflow_metered_turns__idx_cp7eedsmj8 ON workflow_metered_turns USING btree (workflow_run_id);
CREATE INDEX workflow_metered_turns__idx_2xbktrfjrz ON workflow_metered_turns USING btree (thread_id);
CREATE INDEX workflow_metered_turns__idx_17uevxtspsa ON workflow_metered_turns USING btree (workflow_path);
CREATE INDEX workflow_metered_turns__idx_1bcf3rnsxcn ON workflow_metered_turns USING btree (user_id);
CREATE INDEX workflow_metered_turns__idx_cqp3buimje ON workflow_metered_turns USING btree (credential_name);
CREATE INDEX workflow_metered_turns__idx_32tpuue0yx ON workflow_metered_turns USING btree (model);
CREATE UNIQUE INDEX workflow_metered_turns__idx_138s9n3hgel ON workflow_metered_turns USING btree (workflow_step_id, model);
CREATE INDEX workflow_metered_turns__idx_1qge5z9aj6m ON workflow_metered_turns USING btree (workflow_path, trigger_record_model, trigger_record_id);
CREATE INDEX workflow_metered_turns__idx_96gi63yqyb ON workflow_metered_turns USING btree (model, cost_microcents);
ALTER TABLE workflow_metered_turns ADD CONSTRAINT workflow_metered_turns__fk_du20axrhlu FOREIGN KEY (workflow_run_id) REFERENCES workflow_runs (id) ON DELETE SET NULL;
ALTER TABLE workflow_metered_turns ADD CONSTRAINT workflow_metered_turns__fk_19x89djdd01 FOREIGN KEY (workflow_step_id) REFERENCES workflow_steps (id) ON DELETE SET NULL;
ALTER TABLE workflow_metered_turns ADD CONSTRAINT workflow_metered_turns__fk_ebvix7u20l FOREIGN KEY (thread_id) REFERENCES workflow_threads (id) ON DELETE SET NULL;
