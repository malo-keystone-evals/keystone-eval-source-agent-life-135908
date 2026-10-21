DROP INDEX IF EXISTS books__idx_1bu4u7m7cwp;
DROP INDEX IF EXISTS clubs__idx_1udg2lwpvcm;
DROP INDEX IF EXISTS events__idx_2emhqx4fv8e;
DROP INDEX IF EXISTS workflow_ledger_events__idx_1yuqutcxsn7;
ALTER TABLE books
DROP COLUMN IF EXISTS cover_description;
