CREATE TYPE custom_dashboards_status AS ENUM ('active');
CREATE TABLE custom_dashboards (
 id uuid NOT NULL CONSTRAINT custom_dashboards_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status custom_dashboards_status DEFAULT ('active')::custom_dashboards_status NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 identity character varying NOT NULL,
 name character varying NOT NULL,
 owner_id uuid NOT NULL,
 dashboard_config json NOT NULL,
 "primary" boolean DEFAULT false NOT NULL
);
CREATE INDEX custom_dashboards__idx_b_jeophq1lin ON custom_dashboards USING gin ("identity" gin_trgm_ops);
CREATE INDEX custom_dashboards__idx_nrcbxny9wa ON custom_dashboards USING btree (status);
CREATE INDEX custom_dashboards__idx_s1gk7xkfhp ON custom_dashboards USING btree (created_at);
CREATE INDEX custom_dashboards__idx_1vxk7frens6 ON custom_dashboards USING btree (updated_at);
CREATE UNIQUE INDEX custom_dashboards__idx_26eaj9s01w6 ON custom_dashboards USING btree (owner_id, name);
CREATE UNIQUE INDEX custom_dashboards__idx_8ky5r5jn9g ON custom_dashboards USING btree (owner_id) WHERE "primary";
ALTER TABLE custom_dashboards ADD CONSTRAINT custom_dashboards__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE custom_dashboards ADD CONSTRAINT custom_dashboards__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
ALTER TABLE custom_dashboards ADD CONSTRAINT custom_dashboards__fk_8ky5r5jn9g FOREIGN KEY (owner_id) REFERENCES users (id);
CREATE OR REPLACE FUNCTION public.custom_dashboards__tg_a_bns6sg14do()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.identity := COALESCE(new.name::text, '');
  RETURN NEW;
END;
$$;
CREATE TRIGGER custom_dashboards__tg_a_bns6sg14do
  BEFORE INSERT OR UPDATE OF name ON public.custom_dashboards
  FOR EACH ROW EXECUTE FUNCTION public.custom_dashboards__tg_a_bns6sg14do();
UPDATE custom_dashboards
SET identity = (COALESCE(name::text, ''));
