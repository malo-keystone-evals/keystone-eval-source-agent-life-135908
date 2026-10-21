CREATE INDEX books__idx_b_t2lm80wm4t ON books USING gin ("co_author_ids");
CREATE INDEX workflow_errors__idx_1bcf3rnsxcn ON workflow_errors USING btree (user_id);
CREATE INDEX workflow_events__idx_1bcf3rnsxcn ON workflow_events USING btree (user_id);
CREATE INDEX workflow_threads__idx_f4dh8jcckz ON workflow_threads USING btree (created_by_id);
