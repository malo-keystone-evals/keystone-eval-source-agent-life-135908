ALTER TABLE users
ADD COLUMN password_reset_attempts integer DEFAULT 0;
UPDATE users
SET password_reset_attempts = (0);
ALTER TABLE users
ALTER COLUMN password_reset_attempts SET NOT NULL;
