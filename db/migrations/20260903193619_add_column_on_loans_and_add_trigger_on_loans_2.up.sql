ALTER TABLE loans
ADD COLUMN member_tier_at_checkout character varying;
CREATE OR REPLACE FUNCTION public.loans__tg_d_vroj0n7x9d()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
DECLARE
  entering boolean;
BEGIN
  IF TG_OP = 'INSERT' THEN
    entering := NEW.status IN ('active');
  ELSE
    entering := NEW.status IS DISTINCT FROM OLD.status AND NEW.status IN ('active');
  END IF;
  IF entering THEN
    NEW.member_tier_at_checkout := (SELECT members.membership_tier FROM members WHERE members.id = NEW.member_id);
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER loans__tg_d_vroj0n7x9d
  BEFORE INSERT OR UPDATE OF status ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.loans__tg_d_vroj0n7x9d();
CREATE OR REPLACE FUNCTION public.loans__tg_e_27lnr5c8go9()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.book_identity := (SELECT books.identity FROM books WHERE books.id = NEW.book_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER loans__tg_e_27lnr5c8go9
  BEFORE INSERT OR UPDATE OF book_id ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.loans__tg_e_27lnr5c8go9();
UPDATE loans
SET book_identity = (SELECT books.identity FROM books WHERE books.id = loans.book_id);
CREATE OR REPLACE FUNCTION public.loans__tg_f_xohkoxknb7()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.member_identity := (SELECT members.identity FROM members WHERE members.id = NEW.member_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER loans__tg_f_xohkoxknb7
  BEFORE INSERT OR UPDATE OF member_id ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.loans__tg_f_xohkoxknb7();
UPDATE loans
SET member_identity = (SELECT members.identity FROM members WHERE members.id = loans.member_id);
DROP TRIGGER IF EXISTS loans__audit_tg ON public.loans;
DROP FUNCTION IF EXISTS public.loans__audit_tg();
CREATE OR REPLACE FUNCTION public.loans__audit_tg()
  RETURNS trigger
  LANGUAGE plpgsql
  SECURITY DEFINER
AS $$
DECLARE
  audit_record_id uuid;
  audit_changes jsonb := '{}'::jsonb;
  audit_payload jsonb;
BEGIN
  IF TG_OP = 'INSERT' THEN
    IF NOT (NEW.status IN ('requested', 'active', 'overdue', 'returned')) THEN
      RETURN NULL;
    END IF;
    audit_record_id := NEW.id;
    audit_payload := jsonb_build_object('kind', 'create', 'properties', jsonb_build_object(
      'status', to_jsonb(NEW.status),
      'book_id', to_jsonb(NEW.book_id),
      'book_title', to_jsonb(NEW.book_title),
      'member_id', to_jsonb(NEW.member_id),
      'borrowed_on', to_jsonb(NEW.borrowed_on),
      'due_on', to_jsonb(NEW.due_on),
      'checked_out_at', to_jsonb(NEW.checked_out_at),
      'member_tier_at_checkout', to_jsonb(NEW.member_tier_at_checkout),
      'renewals', to_jsonb(NEW.renewals)
    ));
  ELSIF TG_OP = 'UPDATE' THEN
    IF NOT (OLD.status IN ('requested', 'active', 'overdue', 'returned') OR NEW.status IN ('requested', 'active', 'overdue', 'returned')) THEN
      RETURN NULL;
    END IF;
    IF OLD.status IS DISTINCT FROM NEW.status THEN
      audit_changes := audit_changes || jsonb_build_object('status', jsonb_build_object('from', to_jsonb(OLD.status), 'to', to_jsonb(NEW.status)));
    END IF;
    IF OLD.book_id IS DISTINCT FROM NEW.book_id THEN
      audit_changes := audit_changes || jsonb_build_object('book_id', jsonb_build_object('from', to_jsonb(OLD.book_id), 'to', to_jsonb(NEW.book_id)));
    END IF;
    IF OLD.book_title IS DISTINCT FROM NEW.book_title THEN
      audit_changes := audit_changes || jsonb_build_object('book_title', jsonb_build_object('from', to_jsonb(OLD.book_title), 'to', to_jsonb(NEW.book_title)));
    END IF;
    IF OLD.member_id IS DISTINCT FROM NEW.member_id THEN
      audit_changes := audit_changes || jsonb_build_object('member_id', jsonb_build_object('from', to_jsonb(OLD.member_id), 'to', to_jsonb(NEW.member_id)));
    END IF;
    IF OLD.borrowed_on IS DISTINCT FROM NEW.borrowed_on THEN
      audit_changes := audit_changes || jsonb_build_object('borrowed_on', jsonb_build_object('from', to_jsonb(OLD.borrowed_on), 'to', to_jsonb(NEW.borrowed_on)));
    END IF;
    IF OLD.due_on IS DISTINCT FROM NEW.due_on THEN
      audit_changes := audit_changes || jsonb_build_object('due_on', jsonb_build_object('from', to_jsonb(OLD.due_on), 'to', to_jsonb(NEW.due_on)));
    END IF;
    IF OLD.checked_out_at IS DISTINCT FROM NEW.checked_out_at THEN
      audit_changes := audit_changes || jsonb_build_object('checked_out_at', jsonb_build_object('from', to_jsonb(OLD.checked_out_at), 'to', to_jsonb(NEW.checked_out_at)));
    END IF;
    IF OLD.member_tier_at_checkout IS DISTINCT FROM NEW.member_tier_at_checkout THEN
      audit_changes := audit_changes || jsonb_build_object('member_tier_at_checkout', jsonb_build_object('from', to_jsonb(OLD.member_tier_at_checkout), 'to', to_jsonb(NEW.member_tier_at_checkout)));
    END IF;
    IF OLD.renewals IS DISTINCT FROM NEW.renewals THEN
      audit_changes := audit_changes || jsonb_build_object('renewals', jsonb_build_object('from', to_jsonb(OLD.renewals), 'to', to_jsonb(NEW.renewals)));
    END IF;
    IF audit_changes = '{}'::jsonb THEN
      RETURN NULL;
    END IF;
    audit_record_id := NEW.id;
    audit_payload := jsonb_build_object('kind', 'update', 'changes', audit_changes);
  ELSE
    IF NOT (OLD.status IN ('requested', 'active', 'overdue', 'returned')) THEN
      RETURN NULL;
    END IF;
    audit_record_id := OLD.id;
    audit_payload := jsonb_build_object('kind', 'delete', 'properties', jsonb_build_object(
      'status', to_jsonb(OLD.status),
      'book_id', to_jsonb(OLD.book_id),
      'book_title', to_jsonb(OLD.book_title),
      'member_id', to_jsonb(OLD.member_id),
      'borrowed_on', to_jsonb(OLD.borrowed_on),
      'due_on', to_jsonb(OLD.due_on),
      'checked_out_at', to_jsonb(OLD.checked_out_at),
      'member_tier_at_checkout', to_jsonb(OLD.member_tier_at_checkout),
      'renewals', to_jsonb(OLD.renewals)
    ));
  END IF;
  INSERT INTO public.loans_audits (loan_id, created_by_id, attribution, payload, created_at)
  VALUES (
    audit_record_id,
    NULLIF(current_setting('keystone.audit_user_id', true), '')::uuid,
    NULLIF(current_setting('keystone.audit_attribution', true), '')::jsonb,
    audit_payload,
    now()
  );
  RETURN NULL;
END;
$$;
CREATE TRIGGER loans__audit_tg
  AFTER INSERT OR UPDATE OR DELETE ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.loans__audit_tg();
DROP TRIGGER IF EXISTS loans__tg_d_27lnr5c8go9 ON public.loans;
DROP FUNCTION IF EXISTS public.loans__tg_d_27lnr5c8go9();
DROP TRIGGER IF EXISTS loans__tg_e_xohkoxknb7 ON public.loans;
DROP FUNCTION IF EXISTS public.loans__tg_e_xohkoxknb7();
