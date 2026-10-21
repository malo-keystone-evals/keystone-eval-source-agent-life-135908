ALTER TABLE workflow_ledger_events DROP CONSTRAINT IF EXISTS workflow_ledger_events__fk_orzmbtcyyh;
DROP INDEX IF EXISTS workflow_ledger_events__idx_orzmbtcyyh;
ALTER TABLE workflow_ledger_events
DROP COLUMN IF EXISTS author_id;
