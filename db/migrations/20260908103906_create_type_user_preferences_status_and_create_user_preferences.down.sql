ALTER TABLE user_preferences DROP CONSTRAINT IF EXISTS user_preferences__fk_f4dh8jcckz;
ALTER TABLE user_preferences DROP CONSTRAINT IF EXISTS user_preferences__fk_1bq8hp7lup6;
ALTER TABLE user_preferences DROP CONSTRAINT IF EXISTS user_preferences__fk_8ky5r5jn9g;
DROP INDEX IF EXISTS user_preferences__idx_nrcbxny9wa;
DROP INDEX IF EXISTS user_preferences__idx_s1gk7xkfhp;
DROP INDEX IF EXISTS user_preferences__idx_1vxk7frens6;
DROP INDEX IF EXISTS user_preferences__idx_4tphfxupia;
DROP TABLE user_preferences;
DROP TYPE IF EXISTS user_preferences_status;
