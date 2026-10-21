CREATE TYPE users_status_new AS ENUM ('active', 'invited');
ALTER TABLE users
ALTER COLUMN status DROP DEFAULT;
ALTER TABLE users
ALTER COLUMN status TYPE users_status_new USING status::text::users_status_new;
ALTER TABLE users_lifecycles
ALTER COLUMN status TYPE users_status_new USING status::text::users_status_new;
DROP TYPE IF EXISTS users_status;
ALTER TYPE users_status_new RENAME TO users_status;
ALTER TABLE users
ALTER COLUMN status SET DEFAULT ('active')::users_status;
ALTER TABLE users
ADD COLUMN invitation_token character varying;
ALTER TABLE users
ADD COLUMN invitation_sent_at timestamp(6) without time zone;
