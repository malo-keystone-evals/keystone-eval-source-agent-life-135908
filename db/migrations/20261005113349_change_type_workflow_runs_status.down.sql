-- A suspended run has no place in the old type; it is over as far as the old engine is concerned.
UPDATE workflow_runs SET status = 'done' WHERE status::text = 'suspended';
CREATE TYPE workflow_runs_status_new AS ENUM ('pending', 'running', 'done');
ALTER TABLE workflow_runs
ALTER COLUMN status DROP DEFAULT;
ALTER TABLE workflow_runs
ALTER COLUMN status TYPE workflow_runs_status_new USING status::text::workflow_runs_status_new;
DROP TYPE IF EXISTS workflow_runs_status;
ALTER TYPE workflow_runs_status_new RENAME TO workflow_runs_status;
ALTER TABLE workflow_runs
ALTER COLUMN status SET DEFAULT 'pending'::workflow_runs_status;
