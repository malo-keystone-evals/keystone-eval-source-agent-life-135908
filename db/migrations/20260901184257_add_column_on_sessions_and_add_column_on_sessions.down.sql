ALTER TABLE sessions
DROP COLUMN IF EXISTS authenticated_at;
ALTER TABLE sessions
DROP COLUMN IF EXISTS auth_method;
