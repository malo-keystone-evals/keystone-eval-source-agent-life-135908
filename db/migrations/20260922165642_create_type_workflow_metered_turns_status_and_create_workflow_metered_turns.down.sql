ALTER TABLE workflow_metered_turns DROP CONSTRAINT IF EXISTS workflow_metered_turns__fk_du20axrhlu;
ALTER TABLE workflow_metered_turns DROP CONSTRAINT IF EXISTS workflow_metered_turns__fk_19x89djdd01;
ALTER TABLE workflow_metered_turns DROP CONSTRAINT IF EXISTS workflow_metered_turns__fk_ebvix7u20l;
DROP INDEX IF EXISTS workflow_metered_turns__idx_nrcbxny9wa;
DROP INDEX IF EXISTS workflow_metered_turns__idx_s1gk7xkfhp;
DROP INDEX IF EXISTS workflow_metered_turns__idx_1vxk7frens6;
DROP INDEX IF EXISTS workflow_metered_turns__idx_cp7eedsmj8;
DROP INDEX IF EXISTS workflow_metered_turns__idx_2xbktrfjrz;
DROP INDEX IF EXISTS workflow_metered_turns__idx_17uevxtspsa;
DROP INDEX IF EXISTS workflow_metered_turns__idx_1bcf3rnsxcn;
DROP INDEX IF EXISTS workflow_metered_turns__idx_cqp3buimje;
DROP INDEX IF EXISTS workflow_metered_turns__idx_32tpuue0yx;
DROP INDEX IF EXISTS workflow_metered_turns__idx_138s9n3hgel;
DROP INDEX IF EXISTS workflow_metered_turns__idx_1qge5z9aj6m;
DROP INDEX IF EXISTS workflow_metered_turns__idx_96gi63yqyb;
ALTER TABLE workflow_runs
DROP COLUMN IF EXISTS trigger_record_model;
ALTER TABLE workflow_runs
DROP COLUMN IF EXISTS trigger_record_id;
DROP TABLE workflow_metered_turns;
DROP TYPE IF EXISTS workflow_metered_turns_status;
