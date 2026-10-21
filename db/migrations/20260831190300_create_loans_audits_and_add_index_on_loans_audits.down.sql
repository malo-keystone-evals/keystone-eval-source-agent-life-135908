DROP INDEX IF EXISTS loans_audits__idx_253j3pgg0cn;
DROP INDEX IF EXISTS loans_audits__idx_f4dh8jcckz;
DROP INDEX IF EXISTS loans_audits__idx_s1gk7xkfhp;
DROP TRIGGER IF EXISTS loans__audit_tg ON public.loans;
DROP FUNCTION IF EXISTS public.loans__audit_tg();
DROP TABLE loans_audits;
