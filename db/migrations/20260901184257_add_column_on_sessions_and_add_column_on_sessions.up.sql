ALTER TABLE sessions
ADD COLUMN authenticated_at timestamp(6) without time zone;
ALTER TABLE sessions
ADD COLUMN auth_method character varying;
