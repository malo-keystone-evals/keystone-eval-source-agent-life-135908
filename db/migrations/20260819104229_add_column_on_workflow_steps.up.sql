ALTER TABLE workflow_steps
ADD COLUMN kind text DEFAULT 'normal' NOT NULL;
