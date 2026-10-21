CREATE OR REPLACE FUNCTION public.loans__tgi_26uvxhe3t28()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.status IN ('active', 'overdue') AND NOT (COALESCE(((NEW."renewals") <= ((3.0)::double precision)), FALSE)) THEN
    RAISE EXCEPTION USING
      ERRCODE = 'KS001',
      CONSTRAINT = 'renewals_within_limit',
      MESSAGE = 'invariant "renewals_within_limit" refused this save';
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER loans__tgi_26uvxhe3t28
  BEFORE INSERT OR UPDATE OF status, renewals ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.loans__tgi_26uvxhe3t28();
CREATE OR REPLACE FUNCTION public.loans__tgi_h2ncnhur2v()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.status IN ('active') AND NOT (COALESCE((((trunc(EXTRACT(EPOCH FROM (((to_char(NEW."due_on", 'YYYY-MM-DD'))::timestamp) - ((CASE WHEN (to_char(NEW."checked_out_at" AT TIME ZONE 'UTC', 'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"')) LIKE '%Z' OR (to_char(NEW."checked_out_at" AT TIME ZONE 'UTC', 'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"')) LIKE '%+__:__' OR (to_char(NEW."checked_out_at" AT TIME ZONE 'UTC', 'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"')) LIKE '%-__:__' THEN ((to_char(NEW."checked_out_at" AT TIME ZONE 'UTC', 'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'))::timestamptz AT TIME ZONE 'UTC') ELSE (to_char(NEW."checked_out_at" AT TIME ZONE 'UTC', 'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'))::timestamp END)))) * 1000)::double precision / 86400000.0::double precision)) <= ((60.0)::double precision)), FALSE)) THEN
    RAISE EXCEPTION USING
      ERRCODE = 'KS001',
      CONSTRAINT = 'loan_term_within_limit',
      MESSAGE = 'invariant "loan_term_within_limit" refused this save';
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER loans__tgi_h2ncnhur2v
  BEFORE INSERT OR UPDATE OF status, due_on, checked_out_at ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.loans__tgi_h2ncnhur2v();
