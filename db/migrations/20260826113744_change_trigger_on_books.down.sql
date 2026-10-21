DROP TRIGGER IF EXISTS books__tg_c_1p70drudguy ON public.books;
DROP FUNCTION IF EXISTS public.books__tg_c_1p70drudguy();
CREATE OR REPLACE FUNCTION public.books__tg_c_1p70drudguy()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$

BEGIN
  NEW.average_rating := CASE WHEN new.review_count > 0 THEN round(new.rating_total::numeric / new.review_count, 2) ELSE 0 END;
  RETURN NEW;
END;

$$;
CREATE TRIGGER books__tg_c_1p70drudguy
  BEFORE INSERT OR UPDATE OF review_count, rating_total ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_c_1p70drudguy();
