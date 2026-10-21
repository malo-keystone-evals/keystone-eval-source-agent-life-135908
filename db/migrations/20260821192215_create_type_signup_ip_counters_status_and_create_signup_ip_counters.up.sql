CREATE TYPE signup_ip_counters_status AS ENUM ('active');
CREATE TABLE signup_ip_counters (
 id uuid NOT NULL CONSTRAINT signup_ip_counters_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status signup_ip_counters_status DEFAULT ('active')::signup_ip_counters_status NOT NULL,
 client_ip character varying NOT NULL,
 hour_started_at timestamp(6) without time zone NOT NULL,
 hour_sends integer DEFAULT 0 NOT NULL,
 day_started_at timestamp(6) without time zone NOT NULL,
 day_sends integer DEFAULT 0 NOT NULL
);
CREATE INDEX signup_ip_counters__idx_nrcbxny9wa ON signup_ip_counters USING btree (status);
CREATE UNIQUE INDEX signup_ip_counters__idx_bx5ootaoyt ON signup_ip_counters USING btree (client_ip);
CREATE INDEX signup_ip_counters__idx_2compyc7obe ON signup_ip_counters USING btree (day_started_at);
