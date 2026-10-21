ALTER TABLE books
ADD COLUMN cover_image_id uuid;
CREATE TABLE file_uploads (
 id uuid NOT NULL CONSTRAINT file_uploads_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('pending')::character varying NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 identity character varying NOT NULL,
 filename character varying NOT NULL,
 content_type character varying NOT NULL,
 byte_size bigint NOT NULL,
 sha256 character varying NOT NULL,
 storage_key character varying NOT NULL
);
CREATE INDEX file_uploads__idx_b_jeophq1lin ON file_uploads USING gin ("identity" gin_trgm_ops);
CREATE INDEX file_uploads__idx_nrcbxny9wa ON file_uploads USING btree (status);
CREATE INDEX file_uploads__idx_s1gk7xkfhp ON file_uploads USING btree (created_at);
CREATE INDEX file_uploads__idx_1vxk7frens6 ON file_uploads USING btree (updated_at);
CREATE UNIQUE INDEX file_uploads__idx_2qmv1o92sj ON file_uploads USING btree (storage_key);
ALTER TABLE books ADD CONSTRAINT books__fk_99r1a07ss0 FOREIGN KEY (cover_image_id) REFERENCES file_uploads (id) ON DELETE RESTRICT;
ALTER TABLE file_uploads ADD CONSTRAINT file_uploads__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE file_uploads ADD CONSTRAINT file_uploads__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
CREATE OR REPLACE FUNCTION public.file_uploads__tg_a_bns6sg14do()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.identity := (COALESCE(new.filename::text, '') || ' ') || COALESCE(new.content_type::text, '');
  RETURN NEW;
END;
$$;
CREATE TRIGGER file_uploads__tg_a_bns6sg14do
  BEFORE INSERT OR UPDATE OF filename, content_type ON public.file_uploads
  FOR EACH ROW EXECUTE FUNCTION public.file_uploads__tg_a_bns6sg14do();
UPDATE file_uploads
SET identity = ((COALESCE(filename::text, '') || ' ') || COALESCE(content_type::text, ''));
