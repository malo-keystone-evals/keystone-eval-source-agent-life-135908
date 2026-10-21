ALTER TABLE books
ADD COLUMN agent_cost_microcents bigint DEFAULT 0;
UPDATE books
SET agent_cost_microcents = (SELECT SUM(workflow_metered_turns.cost_microcents) FROM workflow_metered_turns WHERE workflow_metered_turns.trigger_record_model = 'books' AND workflow_metered_turns.trigger_record_id = books.id::text);
