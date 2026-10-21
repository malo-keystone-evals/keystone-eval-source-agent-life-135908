DROP INDEX IF EXISTS members_audits__idx_2611372kwb6;
DROP INDEX IF EXISTS members_audits__idx_f4dh8jcckz;
DROP INDEX IF EXISTS members_audits__idx_s1gk7xkfhp;
DROP TRIGGER IF EXISTS members__audit_tg ON public.members;
DROP FUNCTION IF EXISTS public.members__audit_tg();
DROP TABLE members_audits;
