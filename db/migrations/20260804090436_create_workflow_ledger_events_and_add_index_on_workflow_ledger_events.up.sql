CREATE TABLE workflow_ledger_events (
 id uuid NOT NULL CONSTRAINT workflow_ledger_events_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('settled')::character varying NOT NULL,
 thread_id uuid NOT NULL,
 event_id text NOT NULL,
 seq bigint NOT NULL,
 workflow_run_id uuid,
 node_id text,
 scope text,
 kind text NOT NULL,
 payload text NOT NULL,
 created_at timestamp with time zone DEFAULT now() NOT NULL,
 updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE INDEX workflow_ledger_events__idx_nrcbxny9wa ON workflow_ledger_events USING btree (status);
CREATE INDEX workflow_ledger_events__idx_2xbktrfjrz ON workflow_ledger_events USING btree (thread_id);
CREATE INDEX workflow_ledger_events__idx_cp7eedsmj8 ON workflow_ledger_events USING btree (workflow_run_id);
CREATE UNIQUE INDEX workflow_ledger_events__idx_2efkqv4sv7i ON workflow_ledger_events USING btree (thread_id, event_id);
CREATE INDEX workflow_ledger_events__idx_12ayleo2n14 ON workflow_ledger_events USING btree (thread_id, seq);
ALTER TABLE workflow_ledger_events ADD CONSTRAINT workflow_ledger_events__fk_1bmqisa183n FOREIGN KEY (thread_id) REFERENCES workflow_threads (id) ON DELETE CASCADE;
ALTER TABLE workflow_ledger_events ADD CONSTRAINT workflow_ledger_events__fk_du20axrhlu FOREIGN KEY (workflow_run_id) REFERENCES workflow_runs (id) ON DELETE SET NULL;
