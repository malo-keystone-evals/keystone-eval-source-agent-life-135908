CREATE TRIGGER workflow_trigger_i_u_d
  BEFORE INSERT OR UPDATE OR DELETE ON public.events
  FOR EACH ROW EXECUTE FUNCTION public.insert_update_delete_trigger();
