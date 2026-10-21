CREATE TYPE user_preferences_status AS ENUM ('active');
CREATE TABLE user_preferences (
 id uuid NOT NULL CONSTRAINT user_preferences_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status user_preferences_status DEFAULT ('active')::user_preferences_status NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 owner_id uuid NOT NULL,
 key character varying NOT NULL,
 value json NOT NULL
);
CREATE INDEX user_preferences__idx_nrcbxny9wa ON user_preferences USING btree (status);
CREATE INDEX user_preferences__idx_s1gk7xkfhp ON user_preferences USING btree (created_at);
CREATE INDEX user_preferences__idx_1vxk7frens6 ON user_preferences USING btree (updated_at);
CREATE UNIQUE INDEX user_preferences__idx_4tphfxupia ON user_preferences USING btree (owner_id, key);
ALTER TABLE user_preferences ADD CONSTRAINT user_preferences__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE user_preferences ADD CONSTRAINT user_preferences__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
ALTER TABLE user_preferences ADD CONSTRAINT user_preferences__fk_8ky5r5jn9g FOREIGN KEY (owner_id) REFERENCES users (id);
