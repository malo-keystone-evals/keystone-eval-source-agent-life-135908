ALTER TABLE workflow_runs DROP CONSTRAINT IF EXISTS workflow_runs__fk_q0n4crrsx3;
DROP INDEX IF EXISTS workflow_runs__idx_q0n4crrsx3;
ALTER TABLE workflow_runs
DROP COLUMN IF EXISTS parent_run_id;
ALTER TABLE workflow_runs
DROP COLUMN IF EXISTS parent_step_id;
ALTER TABLE workflow_runs
DROP COLUMN IF EXISTS parent_index;
