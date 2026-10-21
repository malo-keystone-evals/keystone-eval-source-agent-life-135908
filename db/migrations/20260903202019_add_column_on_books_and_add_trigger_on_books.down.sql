ALTER TABLE books
DROP COLUMN IF EXISTS reviews_at_shelving;
CREATE OR REPLACE FUNCTION public.books__tg_e_efcow27wkc()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$

BEGIN
  NEW.author_identity := (SELECT authors.identity FROM authors WHERE authors.id = NEW.author_id);
  RETURN NEW;
END;

$$;
CREATE TRIGGER books__tg_e_efcow27wkc
  BEFORE INSERT OR UPDATE OF author_id ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_e_efcow27wkc();
DROP TRIGGER IF EXISTS books__tg_e_2a6fcmtfc1w ON public.books;
DROP FUNCTION IF EXISTS public.books__tg_e_2a6fcmtfc1w();
DROP TRIGGER IF EXISTS books__tg_f_efcow27wkc ON public.books;
DROP FUNCTION IF EXISTS public.books__tg_f_efcow27wkc();
