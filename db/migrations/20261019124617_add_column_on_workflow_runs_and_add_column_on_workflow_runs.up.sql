ALTER TABLE workflow_runs
ADD COLUMN parent_run_id uuid;
ALTER TABLE workflow_runs
ADD COLUMN parent_step_id uuid;
ALTER TABLE workflow_runs
ADD COLUMN parent_index integer;
CREATE INDEX workflow_runs__idx_q0n4crrsx3 ON workflow_runs USING btree (parent_run_id);
ALTER TABLE workflow_runs ADD CONSTRAINT workflow_runs__fk_q0n4crrsx3 FOREIGN KEY (parent_run_id) REFERENCES workflow_runs (id);
