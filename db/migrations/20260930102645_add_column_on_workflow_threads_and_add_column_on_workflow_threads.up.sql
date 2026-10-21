ALTER TABLE workflow_threads
ADD COLUMN spend_microcents bigint DEFAULT 0 NOT NULL;
ALTER TABLE workflow_threads
ADD COLUMN unpriced_calls integer DEFAULT 0 NOT NULL;
