-- Hand-written: spend attributed to a since-deleted user would fail the new
-- FK below. Null it first — the same outcome `on_delete: set null` gives a
-- user deleted from here on: the spend stays, the attribution goes.
UPDATE workflow_metered_turns
SET user_id = NULL
WHERE user_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM users WHERE users.id = workflow_metered_turns.user_id);
CREATE INDEX workflow_metered_turns__idx_ztzhuv22ha ON workflow_metered_turns USING btree (provider);
ALTER TABLE workflow_metered_turns ADD CONSTRAINT workflow_metered_turns__fk_2a6jnmoaiyq FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL;
