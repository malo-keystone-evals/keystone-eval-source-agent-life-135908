DROP INDEX IF EXISTS users__idx_tsnupw2096;
ALTER TABLE users
DROP COLUMN IF EXISTS pending_email;
ALTER TABLE users
DROP COLUMN IF EXISTS email_change_token;
ALTER TABLE users
DROP COLUMN IF EXISTS email_change_sent_at;
ALTER TABLE users
DROP COLUMN IF EXISTS email_change_sends;
