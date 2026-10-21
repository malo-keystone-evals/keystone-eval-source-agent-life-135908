CREATE TABLE loans_audits (
 id uuid NOT NULL CONSTRAINT loans_audits_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 loan_id uuid NOT NULL,
 created_by_id uuid,
 attribution jsonb,
 payload jsonb NOT NULL,
 created_at timestamp(6) without time zone NOT NULL
);
CREATE INDEX loans_audits__idx_253j3pgg0cn ON loans_audits USING btree (loan_id);
CREATE INDEX loans_audits__idx_f4dh8jcckz ON loans_audits USING btree (created_by_id);
CREATE INDEX loans_audits__idx_s1gk7xkfhp ON loans_audits USING btree (created_at);
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
