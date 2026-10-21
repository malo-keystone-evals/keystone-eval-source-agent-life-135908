ALTER TABLE workflow_runs DROP CONSTRAINT IF EXISTS workflow_runs__fk_2xbktrfjrz;
ALTER TABLE workflow_steps DROP CONSTRAINT IF EXISTS workflow_steps__fk_2xbktrfjrz;
ALTER TABLE workflow_threads DROP CONSTRAINT IF EXISTS workflow_threads__fk_1bcf3rnsxcn;
ALTER TABLE workflow_threads DROP CONSTRAINT IF EXISTS workflow_threads__fk_f4dh8jcckz;
DROP INDEX IF EXISTS workflow_runs__idx_2xbktrfjrz;
DROP INDEX IF EXISTS workflow_steps__idx_2xbktrfjrz;
DROP INDEX IF EXISTS workflow_threads__idx_nrcbxny9wa;
DROP INDEX IF EXISTS workflow_threads__idx_17uevxtspsa;
DROP INDEX IF EXISTS workflow_threads__idx_21uvcicx0vt;
DROP INDEX IF EXISTS workflow_threads__idx_1bcf3rnsxcn;
DROP INDEX IF EXISTS workflow_threads__idx_s1gk7xkfhp;
DROP INDEX IF EXISTS workflow_threads__idx_1vxk7frens6;
DROP INDEX IF EXISTS workflow_threads__idx_1c0bsn6b22s;
ALTER TABLE workflow_runs
DROP COLUMN IF EXISTS thread_id;
ALTER TABLE workflow_steps
DROP COLUMN IF EXISTS thread_id;
DROP TABLE workflow_threads;
