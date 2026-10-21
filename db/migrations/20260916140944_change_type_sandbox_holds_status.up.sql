CREATE TYPE sandbox_holds_status_new AS ENUM ('held', 'warm', 'paused');
ALTER TABLE sandbox_holds
ALTER COLUMN status DROP DEFAULT;
ALTER TABLE sandbox_holds
ALTER COLUMN status TYPE sandbox_holds_status_new USING status::text::sandbox_holds_status_new;
DROP TYPE IF EXISTS sandbox_holds_status;
ALTER TYPE sandbox_holds_status_new RENAME TO sandbox_holds_status;
ALTER TABLE sandbox_holds
ALTER COLUMN status SET DEFAULT ('held')::sandbox_holds_status;
