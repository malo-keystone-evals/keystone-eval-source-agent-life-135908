ALTER TABLE authors
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'active'::varchar;
ALTER TABLE authors_lifecycles
ALTER COLUMN status TYPE varchar USING status::varchar;
DROP TRIGGER IF EXISTS authors__tg_nya7ph33b1 ON public.books;
ALTER TABLE books
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'draft'::varchar;
CREATE TRIGGER authors__tg_nya7ph33b1
  AFTER UPDATE OF status, author_id ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.authors__tg_nya7ph33b1();
ALTER TABLE books_lifecycles
ALTER COLUMN status TYPE varchar USING status::varchar;
ALTER TABLE clubs
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'active'::varchar;
ALTER TABLE clubs_lifecycles
ALTER COLUMN status TYPE varchar USING status::varchar;
ALTER TABLE credentials
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'active'::varchar;
ALTER TABLE credentials_lifecycles
ALTER COLUMN status TYPE varchar USING status::varchar;
ALTER TABLE events
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'scheduled'::varchar;
ALTER TABLE events_lifecycles
ALTER COLUMN status TYPE varchar USING status::varchar;
ALTER TABLE file_uploads
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'pending'::varchar;
DROP TRIGGER IF EXISTS members__tg_1chbo7gzbj8 ON public.loans;
ALTER TABLE loans
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'requested'::varchar;
CREATE TRIGGER members__tg_1chbo7gzbj8
  AFTER UPDATE OF status, member_id ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.members__tg_1chbo7gzbj8();
ALTER TABLE loans_lifecycles
ALTER COLUMN status TYPE varchar USING status::varchar;
ALTER TABLE members
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'active'::varchar;
ALTER TABLE members_lifecycles
ALTER COLUMN status TYPE varchar USING status::varchar;
ALTER TABLE recurring_tick_claims
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'scheduled'::varchar;
DROP TRIGGER IF EXISTS books__tg_13s7vshkcwf ON public.reviews;
DROP TRIGGER IF EXISTS books__tg_lrn7horfd9 ON public.reviews;
ALTER TABLE reviews
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'published'::varchar;
CREATE TRIGGER books__tg_13s7vshkcwf
  AFTER UPDATE OF status, book_id ON public.reviews
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_13s7vshkcwf();
CREATE TRIGGER books__tg_lrn7horfd9
  AFTER UPDATE OF status, rating ON public.reviews
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_lrn7horfd9();
ALTER TABLE reviews_lifecycles
ALTER COLUMN status TYPE varchar USING status::varchar;
ALTER TABLE sessions
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'active'::varchar;
ALTER TABLE share_tokens
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'active'::varchar;
ALTER TABLE user_auth_tokens
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'active'::varchar;
ALTER TABLE users
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'active'::varchar;
ALTER TABLE users_lifecycles
ALTER COLUMN status TYPE varchar USING status::varchar;
ALTER TABLE workflow_agent_messages
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'recorded'::varchar;
ALTER TABLE workflow_agent_states
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'active'::varchar;
ALTER TABLE workflow_errors
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'recorded'::varchar;
ALTER TABLE workflow_events
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'pending'::varchar;
ALTER TABLE workflow_ledger_events
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'settled'::varchar;
ALTER TABLE workflow_runs
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'pending'::varchar;
ALTER TABLE workflow_schedules
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'pending'::varchar;
ALTER TABLE workflow_steps
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'pending'::varchar;
ALTER TABLE workflow_threads
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE varchar USING status::varchar,
ALTER COLUMN status SET DEFAULT 'open'::varchar;
ALTER TABLE authors_lifecycles
DROP COLUMN IF EXISTS legacy_status;
ALTER TABLE books_lifecycles
DROP COLUMN IF EXISTS legacy_status;
ALTER TABLE clubs_lifecycles
DROP COLUMN IF EXISTS legacy_status;
ALTER TABLE credentials_lifecycles
DROP COLUMN IF EXISTS legacy_status;
ALTER TABLE events_lifecycles
DROP COLUMN IF EXISTS legacy_status;
ALTER TABLE loans_lifecycles
DROP COLUMN IF EXISTS legacy_status;
ALTER TABLE members_lifecycles
DROP COLUMN IF EXISTS legacy_status;
ALTER TABLE reviews_lifecycles
DROP COLUMN IF EXISTS legacy_status;
ALTER TABLE users_lifecycles
DROP COLUMN IF EXISTS legacy_status;
DROP TYPE IF EXISTS authors_status;
DROP TYPE IF EXISTS books_status;
DROP TYPE IF EXISTS clubs_status;
DROP TYPE IF EXISTS credentials_status;
DROP TYPE IF EXISTS events_status;
DROP TYPE IF EXISTS file_uploads_status;
DROP TYPE IF EXISTS loans_status;
DROP TYPE IF EXISTS members_status;
DROP TYPE IF EXISTS recurring_tick_claims_status;
DROP TYPE IF EXISTS reviews_status;
DROP TYPE IF EXISTS sessions_status;
DROP TYPE IF EXISTS share_tokens_status;
DROP TYPE IF EXISTS user_auth_tokens_status;
DROP TYPE IF EXISTS users_status;
DROP TYPE IF EXISTS workflow_agent_messages_status;
DROP TYPE IF EXISTS workflow_agent_states_status;
DROP TYPE IF EXISTS workflow_errors_status;
DROP TYPE IF EXISTS workflow_events_status;
DROP TYPE IF EXISTS workflow_ledger_events_status;
DROP TYPE IF EXISTS workflow_runs_status;
DROP TYPE IF EXISTS workflow_schedules_status;
DROP TYPE IF EXISTS workflow_steps_status;
DROP TYPE IF EXISTS workflow_threads_status;
