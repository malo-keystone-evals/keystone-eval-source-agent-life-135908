CREATE TYPE authors_status AS ENUM ('active', 'retired');
CREATE TYPE books_status AS ENUM ('draft', 'published', 'archived');
CREATE TYPE clubs_status AS ENUM ('active', 'archived');
CREATE TYPE credentials_status AS ENUM ('active');
CREATE TYPE events_status AS ENUM ('scheduled', 'cancelled', 'completed');
CREATE TYPE file_uploads_status AS ENUM ('pending', 'attached', 'detached');
CREATE TYPE loans_status AS ENUM ('requested', 'active', 'overdue', 'returned');
CREATE TYPE members_status AS ENUM ('active', 'suspended');
CREATE TYPE recurring_tick_claims_status AS ENUM ('scheduled');
CREATE TYPE reviews_status AS ENUM ('published', 'hidden');
CREATE TYPE sessions_status AS ENUM ('active');
CREATE TYPE share_tokens_status AS ENUM ('active');
CREATE TYPE user_auth_tokens_status AS ENUM ('active');
CREATE TYPE users_status AS ENUM ('active');
CREATE TYPE workflow_agent_messages_status AS ENUM ('recorded');
CREATE TYPE workflow_agent_states_status AS ENUM ('active');
CREATE TYPE workflow_errors_status AS ENUM ('recorded');
CREATE TYPE workflow_events_status AS ENUM ('pending', 'processed', 'ignored');
CREATE TYPE workflow_ledger_events_status AS ENUM ('settled');
CREATE TYPE workflow_runs_status AS ENUM ('pending', 'running', 'done');
CREATE TYPE workflow_schedules_status AS ENUM ('pending', 'fired', 'skipped');
CREATE TYPE workflow_steps_status AS ENUM ('pending', 'running', 'done');
CREATE TYPE workflow_threads_status AS ENUM ('open');
ALTER TABLE authors_lifecycles
ADD COLUMN legacy_status character varying;
ALTER TABLE books_lifecycles
ADD COLUMN legacy_status character varying;
ALTER TABLE clubs_lifecycles
ADD COLUMN legacy_status character varying;
ALTER TABLE credentials_lifecycles
ADD COLUMN legacy_status character varying;
ALTER TABLE events_lifecycles
ADD COLUMN legacy_status character varying;
ALTER TABLE loans_lifecycles
ADD COLUMN legacy_status character varying;
ALTER TABLE members_lifecycles
ADD COLUMN legacy_status character varying;
ALTER TABLE reviews_lifecycles
ADD COLUMN legacy_status character varying;
ALTER TABLE users_lifecycles
ADD COLUMN legacy_status character varying;
ALTER TABLE authors
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE authors_status USING status::authors_status,
ALTER COLUMN status SET DEFAULT ('active')::authors_status;
ALTER TABLE authors_lifecycles
ALTER COLUMN status TYPE authors_status USING status::authors_status;
DROP TRIGGER IF EXISTS authors__tg_nya7ph33b1 ON public.books;
ALTER TABLE books
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE books_status USING status::books_status,
ALTER COLUMN status SET DEFAULT ('draft')::books_status;
CREATE TRIGGER authors__tg_nya7ph33b1
  AFTER UPDATE OF status, author_id ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.authors__tg_nya7ph33b1();
ALTER TABLE books_lifecycles
ALTER COLUMN status TYPE books_status USING status::books_status;
ALTER TABLE clubs
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE clubs_status USING status::clubs_status,
ALTER COLUMN status SET DEFAULT ('active')::clubs_status;
ALTER TABLE clubs_lifecycles
ALTER COLUMN status TYPE clubs_status USING status::clubs_status;
ALTER TABLE credentials
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE credentials_status USING status::credentials_status,
ALTER COLUMN status SET DEFAULT ('active')::credentials_status;
ALTER TABLE credentials_lifecycles
ALTER COLUMN status TYPE credentials_status USING status::credentials_status;
ALTER TABLE events
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE events_status USING status::events_status,
ALTER COLUMN status SET DEFAULT ('scheduled')::events_status;
ALTER TABLE events_lifecycles
ALTER COLUMN status TYPE events_status USING status::events_status;
ALTER TABLE file_uploads
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE file_uploads_status USING status::file_uploads_status,
ALTER COLUMN status SET DEFAULT ('pending')::file_uploads_status;
DROP TRIGGER IF EXISTS members__tg_1chbo7gzbj8 ON public.loans;
ALTER TABLE loans
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE loans_status USING status::loans_status,
ALTER COLUMN status SET DEFAULT ('requested')::loans_status;
CREATE TRIGGER members__tg_1chbo7gzbj8
  AFTER UPDATE OF status, member_id ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.members__tg_1chbo7gzbj8();
ALTER TABLE loans_lifecycles
ALTER COLUMN status TYPE loans_status USING status::loans_status;
ALTER TABLE members
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE members_status USING status::members_status,
ALTER COLUMN status SET DEFAULT ('active')::members_status;
ALTER TABLE members_lifecycles
ALTER COLUMN status TYPE members_status USING status::members_status;
ALTER TABLE recurring_tick_claims
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE recurring_tick_claims_status USING status::recurring_tick_claims_status,
ALTER COLUMN status SET DEFAULT ('scheduled')::recurring_tick_claims_status;
DROP TRIGGER IF EXISTS books__tg_13s7vshkcwf ON public.reviews;
DROP TRIGGER IF EXISTS books__tg_lrn7horfd9 ON public.reviews;
ALTER TABLE reviews
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE reviews_status USING status::reviews_status,
ALTER COLUMN status SET DEFAULT ('published')::reviews_status;
CREATE TRIGGER books__tg_13s7vshkcwf
  AFTER UPDATE OF status, book_id ON public.reviews
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_13s7vshkcwf();
CREATE TRIGGER books__tg_lrn7horfd9
  AFTER UPDATE OF status, rating ON public.reviews
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_lrn7horfd9();
ALTER TABLE reviews_lifecycles
ALTER COLUMN status TYPE reviews_status USING status::reviews_status;
ALTER TABLE sessions
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE sessions_status USING status::sessions_status,
ALTER COLUMN status SET DEFAULT ('active')::sessions_status;
ALTER TABLE share_tokens
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE share_tokens_status USING status::share_tokens_status,
ALTER COLUMN status SET DEFAULT ('active')::share_tokens_status;
ALTER TABLE user_auth_tokens
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE user_auth_tokens_status USING status::user_auth_tokens_status,
ALTER COLUMN status SET DEFAULT ('active')::user_auth_tokens_status;
ALTER TABLE users
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE users_status USING status::users_status,
ALTER COLUMN status SET DEFAULT ('active')::users_status;
ALTER TABLE users_lifecycles
ALTER COLUMN status TYPE users_status USING status::users_status;
ALTER TABLE workflow_agent_messages
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE workflow_agent_messages_status USING status::workflow_agent_messages_status,
ALTER COLUMN status SET DEFAULT ('recorded')::workflow_agent_messages_status;
ALTER TABLE workflow_agent_states
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE workflow_agent_states_status USING status::workflow_agent_states_status,
ALTER COLUMN status SET DEFAULT ('active')::workflow_agent_states_status;
ALTER TABLE workflow_errors
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE workflow_errors_status USING status::workflow_errors_status,
ALTER COLUMN status SET DEFAULT ('recorded')::workflow_errors_status;
ALTER TABLE workflow_events
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE workflow_events_status USING status::workflow_events_status,
ALTER COLUMN status SET DEFAULT ('pending')::workflow_events_status;
ALTER TABLE workflow_ledger_events
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE workflow_ledger_events_status USING status::workflow_ledger_events_status,
ALTER COLUMN status SET DEFAULT ('settled')::workflow_ledger_events_status;
ALTER TABLE workflow_runs
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE workflow_runs_status USING status::workflow_runs_status,
ALTER COLUMN status SET DEFAULT ('pending')::workflow_runs_status;
ALTER TABLE workflow_schedules
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE workflow_schedules_status USING status::workflow_schedules_status,
ALTER COLUMN status SET DEFAULT ('pending')::workflow_schedules_status;
ALTER TABLE workflow_steps
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE workflow_steps_status USING status::workflow_steps_status,
ALTER COLUMN status SET DEFAULT ('pending')::workflow_steps_status;
ALTER TABLE workflow_threads
ALTER COLUMN status DROP DEFAULT,
ALTER COLUMN status TYPE workflow_threads_status USING status::workflow_threads_status,
ALTER COLUMN status SET DEFAULT ('open')::workflow_threads_status;
