ALTER TABLE users
ADD COLUMN password_reset_sends integer DEFAULT 0;
UPDATE users
SET password_reset_sends = (0);
ALTER TABLE users
ALTER COLUMN password_reset_sends SET NOT NULL;
