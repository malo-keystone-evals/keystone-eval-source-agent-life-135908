CREATE TABLE members_audits (
 id uuid NOT NULL CONSTRAINT members_audits_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 member_id uuid NOT NULL,
 created_by_id uuid,
 attribution jsonb,
 payload jsonb NOT NULL,
 created_at timestamp(6) without time zone NOT NULL
);
CREATE INDEX members_audits__idx_2611372kwb6 ON members_audits USING btree (member_id);
CREATE INDEX members_audits__idx_f4dh8jcckz ON members_audits USING btree (created_by_id);
CREATE INDEX members_audits__idx_s1gk7xkfhp ON members_audits USING btree (created_at);
CREATE OR REPLACE FUNCTION public.members__audit_tg()
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
    IF NOT (NEW.status IN ('active')) THEN
      RETURN NULL;
    END IF;
    audit_record_id := NEW.id;
    audit_payload := jsonb_build_object('kind', 'create', 'properties', jsonb_build_object(
      'status', to_jsonb(NEW.status),
      'user_id', to_jsonb(NEW.user_id),
      'display_name', to_jsonb(NEW.display_name),
      'membership_tier', to_jsonb(NEW.membership_tier),
      'joined_on', to_jsonb(NEW.joined_on),
      'phone', to_jsonb(NEW.phone),
      'active_loan_count', to_jsonb(NEW.active_loan_count)
    ));
  ELSIF TG_OP = 'UPDATE' THEN
    IF NOT (OLD.status IN ('active') OR NEW.status IN ('active')) THEN
      RETURN NULL;
    END IF;
    IF OLD.status IS DISTINCT FROM NEW.status THEN
      audit_changes := audit_changes || jsonb_build_object('status', jsonb_build_object('from', to_jsonb(OLD.status), 'to', to_jsonb(NEW.status)));
    END IF;
    IF OLD.user_id IS DISTINCT FROM NEW.user_id THEN
      audit_changes := audit_changes || jsonb_build_object('user_id', jsonb_build_object('from', to_jsonb(OLD.user_id), 'to', to_jsonb(NEW.user_id)));
    END IF;
    IF OLD.display_name IS DISTINCT FROM NEW.display_name THEN
      audit_changes := audit_changes || jsonb_build_object('display_name', jsonb_build_object('from', to_jsonb(OLD.display_name), 'to', to_jsonb(NEW.display_name)));
    END IF;
    IF OLD.membership_tier IS DISTINCT FROM NEW.membership_tier THEN
      audit_changes := audit_changes || jsonb_build_object('membership_tier', jsonb_build_object('from', to_jsonb(OLD.membership_tier), 'to', to_jsonb(NEW.membership_tier)));
    END IF;
    IF OLD.joined_on IS DISTINCT FROM NEW.joined_on THEN
      audit_changes := audit_changes || jsonb_build_object('joined_on', jsonb_build_object('from', to_jsonb(OLD.joined_on), 'to', to_jsonb(NEW.joined_on)));
    END IF;
    IF OLD.phone IS DISTINCT FROM NEW.phone THEN
      audit_changes := audit_changes || jsonb_build_object('phone', jsonb_build_object('from', to_jsonb(OLD.phone), 'to', to_jsonb(NEW.phone)));
    END IF;
    IF OLD.active_loan_count IS DISTINCT FROM NEW.active_loan_count THEN
      audit_changes := audit_changes || jsonb_build_object('active_loan_count', jsonb_build_object('from', to_jsonb(OLD.active_loan_count), 'to', to_jsonb(NEW.active_loan_count)));
    END IF;
    IF audit_changes = '{}'::jsonb THEN
      RETURN NULL;
    END IF;
    audit_record_id := NEW.id;
    audit_payload := jsonb_build_object('kind', 'update', 'changes', audit_changes);
  ELSE
    IF NOT (OLD.status IN ('active')) THEN
      RETURN NULL;
    END IF;
    audit_record_id := OLD.id;
    audit_payload := jsonb_build_object('kind', 'delete', 'properties', jsonb_build_object(
      'status', to_jsonb(OLD.status),
      'user_id', to_jsonb(OLD.user_id),
      'display_name', to_jsonb(OLD.display_name),
      'membership_tier', to_jsonb(OLD.membership_tier),
      'joined_on', to_jsonb(OLD.joined_on),
      'phone', to_jsonb(OLD.phone),
      'active_loan_count', to_jsonb(OLD.active_loan_count)
    ));
  END IF;
  INSERT INTO public.members_audits (member_id, created_by_id, attribution, payload, created_at)
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
CREATE TRIGGER members__audit_tg
  AFTER INSERT OR UPDATE OR DELETE ON public.members
  FOR EACH ROW EXECUTE FUNCTION public.members__audit_tg();
