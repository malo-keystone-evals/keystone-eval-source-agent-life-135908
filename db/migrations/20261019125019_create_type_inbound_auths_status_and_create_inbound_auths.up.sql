CREATE TYPE inbound_auths_status AS ENUM ('active');
CREATE TABLE inbound_auths (
 id uuid NOT NULL CONSTRAINT inbound_auths_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status inbound_auths_status DEFAULT ('active')::inbound_auths_status NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 identity character varying NOT NULL,
 name character varying NOT NULL,
 secret text
);
CREATE TABLE inbound_auths_lifecycles (
 id uuid NOT NULL CONSTRAINT inbound_auths_lifecycles_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status inbound_auths_status NOT NULL,
 legacy_status character varying,
 inbound_auth_id uuid NOT NULL,
 created_by_id uuid,
 create_attribution jsonb,
 created_at timestamp(6) without time zone NOT NULL
);
CREATE INDEX inbound_auths__idx_b_jeophq1lin ON inbound_auths USING gin ("identity" gin_trgm_ops);
CREATE INDEX inbound_auths__idx_nrcbxny9wa ON inbound_auths USING btree (status);
CREATE INDEX inbound_auths__idx_s1gk7xkfhp ON inbound_auths USING btree (created_at);
CREATE INDEX inbound_auths__idx_1vxk7frens6 ON inbound_auths USING btree (updated_at);
CREATE UNIQUE INDEX inbound_auths__idx_505akd4e4a ON inbound_auths USING btree (name);
CREATE INDEX inbound_auths_lifecycles__idx_nrcbxny9wa ON inbound_auths_lifecycles USING btree (status);
CREATE INDEX inbound_auths_lifecycles__idx_2kpc90uh14 ON inbound_auths_lifecycles USING btree (inbound_auth_id);
CREATE INDEX inbound_auths_lifecycles__idx_f4dh8jcckz ON inbound_auths_lifecycles USING btree (created_by_id);
CREATE INDEX inbound_auths_lifecycles__idx_s1gk7xkfhp ON inbound_auths_lifecycles USING btree (created_at);
ALTER TABLE inbound_auths ADD CONSTRAINT inbound_auths__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE inbound_auths ADD CONSTRAINT inbound_auths__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
ALTER TABLE inbound_auths_lifecycles ADD CONSTRAINT inbound_auths_lifecycles__fk_mfbsjvc1ah FOREIGN KEY (inbound_auth_id) REFERENCES inbound_auths (id) ON DELETE CASCADE;
ALTER TABLE inbound_auths_lifecycles ADD CONSTRAINT inbound_auths_lifecycles__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
CREATE OR REPLACE FUNCTION public.inbound_auths__tg_a_bns6sg14do()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.identity := COALESCE(new.name::text, '');
  RETURN NEW;
END;
$$;
CREATE TRIGGER inbound_auths__tg_a_bns6sg14do
  BEFORE INSERT OR UPDATE OF name ON public.inbound_auths
  FOR EACH ROW EXECUTE FUNCTION public.inbound_auths__tg_a_bns6sg14do();
UPDATE inbound_auths
SET identity = (COALESCE(name::text, ''));
