CREATE TABLE workflow_agent_messages (
 id uuid NOT NULL CONSTRAINT workflow_agent_messages_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('recorded')::character varying NOT NULL,
 agent_state_id uuid NOT NULL,
 seq bigint NOT NULL,
 kind text NOT NULL,
 workflow_step_id uuid,
 part text NOT NULL,
 created_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE TABLE workflow_agent_states (
 id uuid NOT NULL CONSTRAINT workflow_agent_states_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('active')::character varying NOT NULL,
 workflow_path character varying NOT NULL,
 state_name character varying DEFAULT '' NOT NULL,
 state_key text NOT NULL,
 scope text NOT NULL,
 workflow_step_id uuid,
 fields jsonb DEFAULT '{}'::jsonb NOT NULL,
 committed_seq bigint DEFAULT 0 NOT NULL,
 outcome jsonb,
 lease_owner uuid,
 lease_expires_at timestamp with time zone,
 created_at timestamp with time zone DEFAULT now() NOT NULL,
 updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE INDEX workflow_agent_messages__idx_nrcbxny9wa ON workflow_agent_messages USING btree (status);
CREATE INDEX workflow_agent_messages__idx_195v08otirn ON workflow_agent_messages USING btree (agent_state_id);
CREATE INDEX workflow_agent_messages__idx_1ax0wyt9cd ON workflow_agent_messages USING btree (workflow_step_id);
CREATE UNIQUE INDEX workflow_agent_messages__idx_1izisr8bbl8 ON workflow_agent_messages USING btree (agent_state_id, seq);
CREATE INDEX workflow_agent_states__idx_nrcbxny9wa ON workflow_agent_states USING btree (status);
CREATE INDEX workflow_agent_states__idx_1ax0wyt9cd ON workflow_agent_states USING btree (workflow_step_id);
CREATE INDEX workflow_agent_states__idx_s1gk7xkfhp ON workflow_agent_states USING btree (created_at);
CREATE UNIQUE INDEX workflow_agent_states__idx_27jn3mlvq0b ON workflow_agent_states USING btree (workflow_path, state_name, state_key);
ALTER TABLE workflow_agent_messages ADD CONSTRAINT workflow_agent_messages__fk_141k639kh6z FOREIGN KEY (agent_state_id) REFERENCES workflow_agent_states (id) ON DELETE CASCADE;
ALTER TABLE workflow_agent_messages ADD CONSTRAINT workflow_agent_messages__fk_19x89djdd01 FOREIGN KEY (workflow_step_id) REFERENCES workflow_steps (id) ON DELETE SET NULL;
ALTER TABLE workflow_agent_states ADD CONSTRAINT workflow_agent_states__fk_qu66hmfi9m FOREIGN KEY (workflow_step_id) REFERENCES workflow_steps (id) ON DELETE CASCADE;
