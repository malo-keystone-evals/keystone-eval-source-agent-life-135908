CREATE TYPE workflow_runs_status_new AS ENUM ('pending', 'running', 'suspended', 'done');
ALTER TABLE workflow_runs
ALTER COLUMN status DROP DEFAULT;
ALTER TABLE workflow_runs
ALTER COLUMN status TYPE workflow_runs_status_new USING status::text::workflow_runs_status_new;
DROP TYPE IF EXISTS workflow_runs_status;
ALTER TYPE workflow_runs_status_new RENAME TO workflow_runs_status;
ALTER TABLE workflow_runs
ALTER COLUMN status SET DEFAULT ('pending')::workflow_runs_status;
