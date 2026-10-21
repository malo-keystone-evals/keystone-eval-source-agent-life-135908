CREATE TYPE pending_signups_status AS ENUM ('active');
CREATE TABLE pending_signups (
 id uuid NOT NULL CONSTRAINT pending_signups_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status pending_signups_status DEFAULT ('active')::pending_signups_status NOT NULL,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 email character varying NOT NULL,
 first_name character varying NOT NULL,
 last_name character varying NOT NULL,
 password_digest character varying NOT NULL,
 verification_code character varying,
 code_sent_at timestamp(6) without time zone,
 code_attempts integer DEFAULT 0 NOT NULL,
 code_sends integer DEFAULT 0 NOT NULL
);
CREATE INDEX pending_signups__idx_nrcbxny9wa ON pending_signups USING btree (status);
CREATE INDEX pending_signups__idx_s1gk7xkfhp ON pending_signups USING btree (created_at);
CREATE INDEX pending_signups__idx_1vxk7frens6 ON pending_signups USING btree (updated_at);
CREATE UNIQUE INDEX pending_signups__idx_1hcztykds8l ON pending_signups USING btree (email);
CREATE INDEX pending_signups__idx_2bzow4dzxz1 ON pending_signups USING btree (code_sent_at);
