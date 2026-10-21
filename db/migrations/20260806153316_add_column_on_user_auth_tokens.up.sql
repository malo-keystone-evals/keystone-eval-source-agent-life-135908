ALTER TABLE user_auth_tokens
ADD COLUMN permission_mask jsonb;
