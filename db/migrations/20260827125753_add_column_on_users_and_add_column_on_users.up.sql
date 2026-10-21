ALTER TABLE users
ADD COLUMN pending_email character varying;
ALTER TABLE users
ADD COLUMN email_change_token character varying;
ALTER TABLE users
ADD COLUMN email_change_sent_at timestamp(6) without time zone;
ALTER TABLE users
ADD COLUMN email_change_sends integer DEFAULT 0;
UPDATE users
SET email_change_sends = (0);
ALTER TABLE users
ALTER COLUMN email_change_sends SET NOT NULL;
CREATE INDEX users__idx_tsnupw2096 ON users USING btree (email_change_token);
