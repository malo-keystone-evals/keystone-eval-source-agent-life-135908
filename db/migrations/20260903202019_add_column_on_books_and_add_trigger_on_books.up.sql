ALTER TABLE books
ADD COLUMN reviews_at_shelving integer;
CREATE OR REPLACE FUNCTION public.books__tg_e_2a6fcmtfc1w()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
DECLARE
  entering boolean;
BEGIN
  IF TG_OP = 'INSERT' THEN
    entering := NEW.status IN ('published', 'archived');
  ELSE
    entering := NEW.status IS DISTINCT FROM OLD.status AND NEW.status IN ('published', 'archived');
  END IF;
  IF entering THEN
    NEW.reviews_at_shelving := (SELECT COUNT(reviews.id) FROM reviews WHERE reviews.book_id = NEW.id AND reviews.status IN ('published'));
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_e_2a6fcmtfc1w
  BEFORE INSERT OR UPDATE OF status ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_e_2a6fcmtfc1w();
CREATE OR REPLACE FUNCTION public.books__tg_f_efcow27wkc()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.author_identity := (SELECT authors.identity FROM authors WHERE authors.id = NEW.author_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_f_efcow27wkc
  BEFORE INSERT OR UPDATE OF author_id ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_f_efcow27wkc();
UPDATE books
SET author_identity = (SELECT authors.identity FROM authors WHERE authors.id = books.author_id);
DROP TRIGGER IF EXISTS books__tg_e_efcow27wkc ON public.books;
DROP FUNCTION IF EXISTS public.books__tg_e_efcow27wkc();
