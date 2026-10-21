ALTER TABLE books DROP CONSTRAINT IF EXISTS books__fk_99r1a07ss0;
ALTER TABLE file_uploads DROP CONSTRAINT IF EXISTS file_uploads__fk_f4dh8jcckz;
ALTER TABLE file_uploads DROP CONSTRAINT IF EXISTS file_uploads__fk_1bq8hp7lup6;
DROP INDEX IF EXISTS file_uploads__idx_b_jeophq1lin;
DROP INDEX IF EXISTS file_uploads__idx_nrcbxny9wa;
DROP INDEX IF EXISTS file_uploads__idx_s1gk7xkfhp;
DROP INDEX IF EXISTS file_uploads__idx_1vxk7frens6;
DROP INDEX IF EXISTS file_uploads__idx_2qmv1o92sj;
ALTER TABLE books
DROP COLUMN IF EXISTS cover_image_id;
DROP TRIGGER IF EXISTS file_uploads__tg_a_bns6sg14do ON public.file_uploads;
DROP FUNCTION IF EXISTS public.file_uploads__tg_a_bns6sg14do();
DROP TABLE file_uploads;
