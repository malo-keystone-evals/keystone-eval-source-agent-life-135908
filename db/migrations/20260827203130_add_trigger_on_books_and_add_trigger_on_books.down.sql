CREATE OR REPLACE FUNCTION public.books__tg_d_efcow27wkc()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$

BEGIN
  NEW.author_identity := (SELECT authors.identity FROM authors WHERE authors.id = NEW.author_id);
  RETURN NEW;
END;

$$;
CREATE TRIGGER books__tg_d_efcow27wkc
  BEFORE INSERT OR UPDATE OF author_id ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_d_efcow27wkc();
CREATE OR REPLACE FUNCTION public.books__tg_c_1p70drudguy()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$

BEGIN
  NEW.average_rating := (CASE WHEN COALESCE(((NEW."review_count") > ((0.0)::double precision)), FALSE) THEN easel_round((easel_divide((NEW."rating_total"), (NEW."review_count"))), ((2.0)::double precision)) ELSE (0.0)::double precision END);
  RETURN NEW;
END;

$$;
CREATE TRIGGER books__tg_c_1p70drudguy
  BEFORE INSERT OR UPDATE OF review_count, rating_total ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_c_1p70drudguy();
DROP TRIGGER IF EXISTS books__tg_c_q1z7tchws ON public.books;
DROP FUNCTION IF EXISTS public.books__tg_c_q1z7tchws();
DROP TRIGGER IF EXISTS books__tg_d_1p70drudguy ON public.books;
DROP FUNCTION IF EXISTS public.books__tg_d_1p70drudguy();
DROP TRIGGER IF EXISTS books__tg_e_efcow27wkc ON public.books;
DROP FUNCTION IF EXISTS public.books__tg_e_efcow27wkc();
