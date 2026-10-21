CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE OR REPLACE FUNCTION public.insert_update_delete_trigger()
  RETURNS trigger
  LANGUAGE plpgsql
  SECURITY DEFINER
AS $$
declare
    new_jsonb jsonb = to_jsonb(new);
    old_jsonb jsonb = to_jsonb(old);
begin
    insert into public.workflow_events(
        status,
        kind,
        record_id,
        model_name,
        new_data,
        old_data,
        user_id
    )
    select
        'pending',
        case TG_OP
            when 'INSERT' then 'create'
            when 'UPDATE' then 'update'
            when 'DELETE' then 'delete'
        end,
        coalesce(new.id, old.id),
        TG_TABLE_NAME,
        new_jsonb,
        old_jsonb,
        coalesce(new.updated_by_id, new.created_by_id);
    return coalesce(new, old);
end;
$$;
CREATE TABLE authors (
 id uuid NOT NULL CONSTRAINT authors_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('active')::character varying NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 identity character varying NOT NULL,
 name character varying NOT NULL,
 bio text,
 website character varying,
 nationality character varying,
 book_count integer DEFAULT 0
);
CREATE TABLE authors_lifecycles (
 id uuid NOT NULL CONSTRAINT authors_lifecycles_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying NOT NULL,
 author_id uuid NOT NULL,
 created_by_id uuid,
 create_attribution jsonb,
 created_at timestamp(6) without time zone NOT NULL
);
CREATE TABLE books (
 id uuid NOT NULL CONSTRAINT books_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('draft')::character varying NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 identity character varying NOT NULL,
 title character varying NOT NULL,
 author_id uuid NOT NULL,
 author_name character varying,
 summary text,
 webhook_secret text,
 slug character varying,
 isbn character varying,
 genre character varying,
 page_count integer,
 price_cents integer,
 published_on date,
 cover_url character varying,
 featured boolean DEFAULT false NOT NULL,
 review_count integer DEFAULT 0,
 rating_total integer DEFAULT 0,
 average_rating double precision,
 board_rank character varying
);
CREATE TABLE books_lifecycles (
 id uuid NOT NULL CONSTRAINT books_lifecycles_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying NOT NULL,
 book_id uuid NOT NULL,
 created_by_id uuid,
 create_attribution jsonb,
 created_at timestamp(6) without time zone NOT NULL
);
CREATE TABLE clubs (
 id uuid NOT NULL CONSTRAINT clubs_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('active')::character varying NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 identity character varying NOT NULL,
 name character varying NOT NULL,
 description text,
 current_book_id uuid,
 current_book_title character varying,
 capacity integer,
 meeting_format jsonb
);
CREATE TABLE clubs_lifecycles (
 id uuid NOT NULL CONSTRAINT clubs_lifecycles_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying NOT NULL,
 club_id uuid NOT NULL,
 created_by_id uuid,
 create_attribution jsonb,
 created_at timestamp(6) without time zone NOT NULL
);
CREATE TABLE credentials (
 id uuid NOT NULL CONSTRAINT credentials_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('active')::character varying NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 identity character varying NOT NULL,
 name character varying NOT NULL,
 kind character varying NOT NULL,
 external_api character varying NOT NULL,
 base_url character varying NOT NULL,
 data text
);
CREATE TABLE credentials_lifecycles (
 id uuid NOT NULL CONSTRAINT credentials_lifecycles_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying NOT NULL,
 credential_id uuid NOT NULL,
 created_by_id uuid,
 create_attribution jsonb,
 created_at timestamp(6) without time zone NOT NULL
);
CREATE TABLE events (
 id uuid NOT NULL CONSTRAINT events_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('scheduled')::character varying NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 identity character varying NOT NULL,
 club_id uuid NOT NULL,
 club_name character varying,
 title character varying NOT NULL,
 starts_at timestamp with time zone NOT NULL,
 capacity integer,
 venue jsonb
);
CREATE TABLE events_lifecycles (
 id uuid NOT NULL CONSTRAINT events_lifecycles_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying NOT NULL,
 event_id uuid NOT NULL,
 created_by_id uuid,
 create_attribution jsonb,
 created_at timestamp(6) without time zone NOT NULL
);
CREATE TABLE loans (
 id uuid NOT NULL CONSTRAINT loans_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('requested')::character varying NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 identity character varying NOT NULL,
 book_id uuid NOT NULL,
 book_title character varying,
 member_id uuid NOT NULL,
 borrowed_on date,
 due_on date NOT NULL,
 renewals integer DEFAULT 0 NOT NULL,
 board_rank character varying
);
CREATE TABLE loans_lifecycles (
 id uuid NOT NULL CONSTRAINT loans_lifecycles_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying NOT NULL,
 loan_id uuid NOT NULL,
 created_by_id uuid,
 create_attribution jsonb,
 created_at timestamp(6) without time zone NOT NULL,
 return_condition character varying
);
CREATE TABLE members (
 id uuid NOT NULL CONSTRAINT members_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('active')::character varying NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 identity character varying NOT NULL,
 user_id uuid NOT NULL,
 display_name character varying NOT NULL,
 membership_tier character varying DEFAULT 'bronze'::character varying NOT NULL,
 joined_on date,
 phone character varying,
 private_note text,
 active_loan_count integer DEFAULT 0
);
CREATE TABLE members_lifecycles (
 id uuid NOT NULL CONSTRAINT members_lifecycles_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying NOT NULL,
 member_id uuid NOT NULL,
 created_by_id uuid,
 create_attribution jsonb,
 created_at timestamp(6) without time zone NOT NULL
);
CREATE TABLE recurring_tick_claims (
 id uuid NOT NULL CONSTRAINT recurring_tick_claims_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('scheduled')::character varying NOT NULL,
 workflow_name text NOT NULL,
 scheduled_at timestamp with time zone NOT NULL
);
CREATE TABLE reviews (
 id uuid NOT NULL CONSTRAINT reviews_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('published')::character varying NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 identity character varying NOT NULL,
 book_id uuid NOT NULL,
 member_id uuid NOT NULL,
 rating integer NOT NULL,
 headline character varying NOT NULL,
 body text,
 recommended boolean DEFAULT true NOT NULL,
 tags jsonb
);
CREATE TABLE reviews_lifecycles (
 id uuid NOT NULL CONSTRAINT reviews_lifecycles_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying NOT NULL,
 review_id uuid NOT NULL,
 created_by_id uuid,
 create_attribution jsonb,
 created_at timestamp(6) without time zone NOT NULL
);
CREATE TABLE sessions (
 id uuid NOT NULL CONSTRAINT sessions_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('active')::character varying NOT NULL,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 token character varying NOT NULL,
 user_id uuid,
 expires_at timestamp(6) without time zone NOT NULL,
 client_ip character varying,
 user_agent character varying,
 data jsonb
);
CREATE TABLE share_tokens (
 id uuid NOT NULL CONSTRAINT share_tokens_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('active')::character varying NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 model_name character varying NOT NULL,
 record_id character varying NOT NULL,
 grant_name character varying NOT NULL,
 token character varying NOT NULL,
 expires_at timestamp with time zone
);
CREATE TABLE user_auth_tokens (
 id uuid NOT NULL CONSTRAINT user_auth_tokens_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('active')::character varying NOT NULL,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 token character varying NOT NULL,
 user_id uuid NOT NULL,
 expires_at timestamp(6) without time zone NOT NULL,
 grants jsonb
);
CREATE TABLE users (
 id uuid NOT NULL CONSTRAINT users_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('active')::character varying NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 identity character varying NOT NULL,
 first_name character varying NOT NULL,
 last_name character varying NOT NULL,
 email character varying NOT NULL,
 password_digest character varying,
 password_reset_token character varying,
 password_reset_sent_at timestamp(6) without time zone,
 admin_role boolean DEFAULT false NOT NULL,
 librarian_role boolean DEFAULT false NOT NULL,
 patron_role boolean DEFAULT false NOT NULL
);
CREATE TABLE users_lifecycles (
 id uuid NOT NULL CONSTRAINT users_lifecycles_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying NOT NULL,
 user_id uuid NOT NULL,
 created_by_id uuid,
 create_attribution jsonb,
 created_at timestamp(6) without time zone NOT NULL
);
CREATE TABLE workflow_errors (
 id uuid NOT NULL CONSTRAINT workflow_errors_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('recorded')::character varying NOT NULL,
 workflow_path character varying NOT NULL,
 node_id character varying NOT NULL,
 workflow_run_id uuid NOT NULL,
 workflow_step_id uuid NOT NULL,
 user_id uuid,
 index bigint,
 error_name character varying NOT NULL,
 error_message text NOT NULL,
 error_detail jsonb,
 handled boolean DEFAULT false NOT NULL,
 created_at timestamp with time zone DEFAULT now() NOT NULL,
 updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE TABLE workflow_events (
 id uuid NOT NULL CONSTRAINT workflow_events_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('pending')::character varying NOT NULL,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 kind character varying NOT NULL,
 record_id uuid NOT NULL,
 model_name character varying NOT NULL,
 new_data jsonb,
 old_data jsonb,
 user_id uuid
);
CREATE TABLE workflow_runs (
 id uuid NOT NULL CONSTRAINT workflow_runs_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('pending')::character varying NOT NULL,
 user_id uuid,
 run_as text DEFAULT 'system' NOT NULL,
 grant_anchor jsonb,
 workflow_path character varying NOT NULL,
 input jsonb NOT NULL,
 output jsonb,
 workflow_event_id uuid,
 created_at timestamp with time zone DEFAULT now() NOT NULL,
 updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE TABLE workflow_schedules (
 id uuid NOT NULL CONSTRAINT workflow_schedules_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('pending')::character varying NOT NULL,
 workflow_path character varying NOT NULL,
 model_name text NOT NULL,
 record_id uuid NOT NULL,
 user_input jsonb,
 user_id uuid,
 run_as text DEFAULT 'system' NOT NULL,
 grant_anchor jsonb,
 fire_at timestamp with time zone NOT NULL,
 fired_at timestamp with time zone,
 workflow_run_id uuid,
 skip_reason text,
 created_at timestamp with time zone DEFAULT now() NOT NULL,
 updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE TABLE workflow_steps (
 id uuid NOT NULL CONSTRAINT workflow_steps_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('pending')::character varying NOT NULL,
 user_id uuid,
 run_as text DEFAULT 'system' NOT NULL,
 grant_anchor jsonb,
 workflow_path character varying,
 node_id character varying,
 workflow_run_id uuid NOT NULL,
 previous_task_id uuid,
 input jsonb NOT NULL,
 output jsonb,
 input_lineage jsonb,
 output_lineage jsonb,
 created_at timestamp with time zone DEFAULT now() NOT NULL,
 updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE INDEX authors__idx_b_jeophq1lin ON authors USING gin ("identity" gin_trgm_ops);
CREATE INDEX authors__idx_nrcbxny9wa ON authors USING btree (status);
CREATE INDEX authors__idx_s1gk7xkfhp ON authors USING btree (created_at);
CREATE INDEX authors__idx_1vxk7frens6 ON authors USING btree (updated_at);
CREATE INDEX authors__idx_505akd4e4a ON authors USING btree (name);
CREATE INDEX authors__idx_3avcyp1a9m ON authors USING btree (nationality);
CREATE INDEX authors_lifecycles__idx_nrcbxny9wa ON authors_lifecycles USING btree (status);
CREATE INDEX authors_lifecycles__idx_orzmbtcyyh ON authors_lifecycles USING btree (author_id);
CREATE INDEX authors_lifecycles__idx_f4dh8jcckz ON authors_lifecycles USING btree (created_by_id);
CREATE INDEX authors_lifecycles__idx_s1gk7xkfhp ON authors_lifecycles USING btree (created_at);
CREATE INDEX books__idx_b_jeophq1lin ON books USING gin ("identity" gin_trgm_ops);
CREATE INDEX books__idx_nrcbxny9wa ON books USING btree (status);
CREATE INDEX books__idx_s1gk7xkfhp ON books USING btree (created_at);
CREATE INDEX books__idx_1vxk7frens6 ON books USING btree (updated_at);
CREATE INDEX books__idx_2anppzdvtc2 ON books USING btree (title);
CREATE INDEX books__idx_orzmbtcyyh ON books USING btree (author_id);
CREATE INDEX books__idx_353s32ajd7 ON books USING btree (author_name);
CREATE INDEX books__idx_1pv9hzktdu9 ON books USING btree (slug);
CREATE INDEX books__idx_1vmpd4ey7b0 ON books USING btree (genre);
CREATE INDEX books__idx_1p282tezszy ON books USING btree (average_rating);
CREATE INDEX books__idx_13g8ae25thn ON books USING btree (board_rank);
CREATE INDEX books_lifecycles__idx_nrcbxny9wa ON books_lifecycles USING btree (status);
CREATE INDEX books_lifecycles__idx_49lbse7pzc ON books_lifecycles USING btree (book_id);
CREATE INDEX books_lifecycles__idx_f4dh8jcckz ON books_lifecycles USING btree (created_by_id);
CREATE INDEX books_lifecycles__idx_s1gk7xkfhp ON books_lifecycles USING btree (created_at);
CREATE INDEX clubs__idx_b_jeophq1lin ON clubs USING gin ("identity" gin_trgm_ops);
CREATE INDEX clubs__idx_nrcbxny9wa ON clubs USING btree (status);
CREATE INDEX clubs__idx_s1gk7xkfhp ON clubs USING btree (created_at);
CREATE INDEX clubs__idx_1vxk7frens6 ON clubs USING btree (updated_at);
CREATE INDEX clubs__idx_505akd4e4a ON clubs USING btree (name);
CREATE INDEX clubs__idx_c6obaxmf5f ON clubs USING btree (current_book_id);
CREATE INDEX clubs__idx_gte22n79bu ON clubs USING btree (current_book_title);
CREATE INDEX clubs_lifecycles__idx_nrcbxny9wa ON clubs_lifecycles USING btree (status);
CREATE INDEX clubs_lifecycles__idx_8w631ooexg ON clubs_lifecycles USING btree (club_id);
CREATE INDEX clubs_lifecycles__idx_f4dh8jcckz ON clubs_lifecycles USING btree (created_by_id);
CREATE INDEX clubs_lifecycles__idx_s1gk7xkfhp ON clubs_lifecycles USING btree (created_at);
CREATE INDEX credentials__idx_b_jeophq1lin ON credentials USING gin ("identity" gin_trgm_ops);
CREATE INDEX credentials__idx_nrcbxny9wa ON credentials USING btree (status);
CREATE INDEX credentials__idx_s1gk7xkfhp ON credentials USING btree (created_at);
CREATE INDEX credentials__idx_1vxk7frens6 ON credentials USING btree (updated_at);
CREATE UNIQUE INDEX credentials__idx_505akd4e4a ON credentials USING btree (name);
CREATE INDEX credentials__idx_19xg7e5ysfo ON credentials USING btree (kind);
CREATE INDEX credentials__idx_19st7tneq95 ON credentials USING btree (external_api);
CREATE INDEX credentials_lifecycles__idx_nrcbxny9wa ON credentials_lifecycles USING btree (status);
CREATE INDEX credentials_lifecycles__idx_29ps82dwq28 ON credentials_lifecycles USING btree (credential_id);
CREATE INDEX credentials_lifecycles__idx_f4dh8jcckz ON credentials_lifecycles USING btree (created_by_id);
CREATE INDEX credentials_lifecycles__idx_s1gk7xkfhp ON credentials_lifecycles USING btree (created_at);
CREATE INDEX events__idx_b_jeophq1lin ON events USING gin ("identity" gin_trgm_ops);
CREATE INDEX events__idx_nrcbxny9wa ON events USING btree (status);
CREATE INDEX events__idx_s1gk7xkfhp ON events USING btree (created_at);
CREATE INDEX events__idx_1vxk7frens6 ON events USING btree (updated_at);
CREATE INDEX events__idx_8w631ooexg ON events USING btree (club_id);
CREATE INDEX events__idx_1kkj4nj486d ON events USING btree (club_name);
CREATE INDEX events__idx_14269c5sb4d ON events USING btree (starts_at);
CREATE INDEX events_lifecycles__idx_nrcbxny9wa ON events_lifecycles USING btree (status);
CREATE INDEX events_lifecycles__idx_13qh02ll8p5 ON events_lifecycles USING btree (event_id);
CREATE INDEX events_lifecycles__idx_f4dh8jcckz ON events_lifecycles USING btree (created_by_id);
CREATE INDEX events_lifecycles__idx_s1gk7xkfhp ON events_lifecycles USING btree (created_at);
CREATE INDEX loans__idx_b_jeophq1lin ON loans USING gin ("identity" gin_trgm_ops);
CREATE INDEX loans__idx_nrcbxny9wa ON loans USING btree (status);
CREATE INDEX loans__idx_s1gk7xkfhp ON loans USING btree (created_at);
CREATE INDEX loans__idx_1vxk7frens6 ON loans USING btree (updated_at);
CREATE INDEX loans__idx_49lbse7pzc ON loans USING btree (book_id);
CREATE INDEX loans__idx_2ewvls61e9p ON loans USING btree (book_title);
CREATE INDEX loans__idx_2611372kwb6 ON loans USING btree (member_id);
CREATE INDEX loans__idx_1hzeii74p4z ON loans USING btree (due_on);
CREATE INDEX loans__idx_13g8ae25thn ON loans USING btree (board_rank);
CREATE INDEX loans_lifecycles__idx_nrcbxny9wa ON loans_lifecycles USING btree (status);
CREATE INDEX loans_lifecycles__idx_253j3pgg0cn ON loans_lifecycles USING btree (loan_id);
CREATE INDEX loans_lifecycles__idx_f4dh8jcckz ON loans_lifecycles USING btree (created_by_id);
CREATE INDEX loans_lifecycles__idx_s1gk7xkfhp ON loans_lifecycles USING btree (created_at);
CREATE INDEX members__idx_b_jeophq1lin ON members USING gin ("identity" gin_trgm_ops);
CREATE INDEX members__idx_nrcbxny9wa ON members USING btree (status);
CREATE INDEX members__idx_s1gk7xkfhp ON members USING btree (created_at);
CREATE INDEX members__idx_1vxk7frens6 ON members USING btree (updated_at);
CREATE UNIQUE INDEX members__idx_1bcf3rnsxcn ON members USING btree (user_id);
CREATE INDEX members__idx_9i9rm4nejt ON members USING btree (display_name);
CREATE INDEX members__idx_28n6n1jkc9p ON members USING btree (membership_tier);
CREATE INDEX members_lifecycles__idx_nrcbxny9wa ON members_lifecycles USING btree (status);
CREATE INDEX members_lifecycles__idx_2611372kwb6 ON members_lifecycles USING btree (member_id);
CREATE INDEX members_lifecycles__idx_f4dh8jcckz ON members_lifecycles USING btree (created_by_id);
CREATE INDEX members_lifecycles__idx_s1gk7xkfhp ON members_lifecycles USING btree (created_at);
CREATE INDEX recurring_tick_claims__idx_nrcbxny9wa ON recurring_tick_claims USING btree (status);
CREATE UNIQUE INDEX recurring_tick_claims__idx_76w3eykdky ON recurring_tick_claims USING btree (workflow_name, scheduled_at);
CREATE INDEX reviews__idx_b_jeophq1lin ON reviews USING gin ("identity" gin_trgm_ops);
CREATE INDEX reviews__idx_nrcbxny9wa ON reviews USING btree (status);
CREATE INDEX reviews__idx_s1gk7xkfhp ON reviews USING btree (created_at);
CREATE INDEX reviews__idx_1vxk7frens6 ON reviews USING btree (updated_at);
CREATE INDEX reviews__idx_49lbse7pzc ON reviews USING btree (book_id);
CREATE INDEX reviews__idx_2611372kwb6 ON reviews USING btree (member_id);
CREATE INDEX reviews__idx_1qj5dvs1zwd ON reviews USING btree (rating);
CREATE INDEX reviews_lifecycles__idx_nrcbxny9wa ON reviews_lifecycles USING btree (status);
CREATE INDEX reviews_lifecycles__idx_1uuprdlj513 ON reviews_lifecycles USING btree (review_id);
CREATE INDEX reviews_lifecycles__idx_f4dh8jcckz ON reviews_lifecycles USING btree (created_by_id);
CREATE INDEX reviews_lifecycles__idx_s1gk7xkfhp ON reviews_lifecycles USING btree (created_at);
CREATE INDEX sessions__idx_nrcbxny9wa ON sessions USING btree (status);
CREATE INDEX sessions__idx_s1gk7xkfhp ON sessions USING btree (created_at);
CREATE INDEX sessions__idx_1vxk7frens6 ON sessions USING btree (updated_at);
CREATE INDEX sessions__idx_1bcf3rnsxcn ON sessions USING btree (user_id);
CREATE INDEX sessions__idx_4npyfzfgkl ON sessions USING btree (expires_at);
CREATE INDEX sessions__idx_bx5ootaoyt ON sessions USING btree (client_ip);
CREATE INDEX sessions__idx_14edulivbi9 ON sessions USING btree (user_agent);
CREATE INDEX share_tokens__idx_nrcbxny9wa ON share_tokens USING btree (status);
CREATE INDEX share_tokens__idx_s1gk7xkfhp ON share_tokens USING btree (created_at);
CREATE INDEX share_tokens__idx_1vxk7frens6 ON share_tokens USING btree (updated_at);
CREATE UNIQUE INDEX share_tokens__idx_w01p453r7k ON share_tokens USING btree (token);
CREATE INDEX share_tokens__idx_4npyfzfgkl ON share_tokens USING btree (expires_at);
CREATE INDEX user_auth_tokens__idx_nrcbxny9wa ON user_auth_tokens USING btree (status);
CREATE INDEX user_auth_tokens__idx_s1gk7xkfhp ON user_auth_tokens USING btree (created_at);
CREATE INDEX user_auth_tokens__idx_1vxk7frens6 ON user_auth_tokens USING btree (updated_at);
CREATE UNIQUE INDEX user_auth_tokens__idx_w01p453r7k ON user_auth_tokens USING btree (token);
CREATE INDEX user_auth_tokens__idx_1bcf3rnsxcn ON user_auth_tokens USING btree (user_id);
CREATE INDEX user_auth_tokens__idx_4npyfzfgkl ON user_auth_tokens USING btree (expires_at);
CREATE INDEX users__idx_b_jeophq1lin ON users USING gin ("identity" gin_trgm_ops);
CREATE INDEX users__idx_nrcbxny9wa ON users USING btree (status);
CREATE INDEX users__idx_s1gk7xkfhp ON users USING btree (created_at);
CREATE INDEX users__idx_1vxk7frens6 ON users USING btree (updated_at);
CREATE UNIQUE INDEX users__idx_1hcztykds8l ON users USING btree (email);
CREATE INDEX users_lifecycles__idx_nrcbxny9wa ON users_lifecycles USING btree (status);
CREATE INDEX users_lifecycles__idx_1bcf3rnsxcn ON users_lifecycles USING btree (user_id);
CREATE INDEX users_lifecycles__idx_f4dh8jcckz ON users_lifecycles USING btree (created_by_id);
CREATE INDEX users_lifecycles__idx_s1gk7xkfhp ON users_lifecycles USING btree (created_at);
CREATE INDEX workflow_errors__idx_nrcbxny9wa ON workflow_errors USING btree (status);
CREATE INDEX workflow_errors__idx_cp7eedsmj8 ON workflow_errors USING btree (workflow_run_id);
CREATE INDEX workflow_errors__idx_1ax0wyt9cd ON workflow_errors USING btree (workflow_step_id);
CREATE INDEX workflow_errors__idx_2aod1jp9f98 ON workflow_errors USING btree (error_name);
CREATE INDEX workflow_errors__idx_1hfclfqed7t ON workflow_errors USING btree (handled);
CREATE INDEX workflow_errors__idx_s1gk7xkfhp ON workflow_errors USING btree (created_at);
CREATE INDEX workflow_events__idx_nrcbxny9wa ON workflow_events USING btree (status);
CREATE INDEX workflow_events__idx_s1gk7xkfhp ON workflow_events USING btree (created_at);
CREATE INDEX workflow_events__idx_1vxk7frens6 ON workflow_events USING btree (updated_at);
CREATE INDEX workflow_events__idx_21uvcicx0vt ON workflow_events USING btree (record_id);
CREATE INDEX workflow_events__idx_1bn8oj78r7m ON workflow_events USING btree (model_name);
CREATE INDEX workflow_events__idx_hruhhpsmy ON workflow_events USING btree (status, created_at);
CREATE INDEX workflow_runs__idx_nrcbxny9wa ON workflow_runs USING btree (status);
CREATE INDEX workflow_runs__idx_1bcf3rnsxcn ON workflow_runs USING btree (user_id);
CREATE INDEX workflow_runs__idx_s1gk7xkfhp ON workflow_runs USING btree (created_at);
CREATE INDEX workflow_runs__idx_1vxk7frens6 ON workflow_runs USING btree (updated_at);
CREATE INDEX workflow_schedules__idx_nrcbxny9wa ON workflow_schedules USING btree (status);
CREATE INDEX workflow_schedules__idx_1bcf3rnsxcn ON workflow_schedules USING btree (user_id);
CREATE INDEX workflow_schedules__idx_s1gk7xkfhp ON workflow_schedules USING btree (created_at);
CREATE INDEX workflow_schedules__idx_1vxk7frens6 ON workflow_schedules USING btree (updated_at);
CREATE INDEX workflow_schedules__idx_20v0nzsix90 ON workflow_schedules USING btree (status, fire_at);
CREATE INDEX workflow_steps__idx_nrcbxny9wa ON workflow_steps USING btree (status);
CREATE INDEX workflow_steps__idx_1bcf3rnsxcn ON workflow_steps USING btree (user_id);
CREATE INDEX workflow_steps__idx_cp7eedsmj8 ON workflow_steps USING btree (workflow_run_id);
CREATE INDEX workflow_steps__idx_s1gk7xkfhp ON workflow_steps USING btree (created_at);
CREATE INDEX workflow_steps__idx_1vxk7frens6 ON workflow_steps USING btree (updated_at);
ALTER TABLE authors ADD CONSTRAINT authors__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE authors ADD CONSTRAINT authors__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
ALTER TABLE authors_lifecycles ADD CONSTRAINT authors_lifecycles__fk_fp54hafh7b FOREIGN KEY (author_id) REFERENCES authors (id) ON DELETE CASCADE;
ALTER TABLE authors_lifecycles ADD CONSTRAINT authors_lifecycles__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE books ADD CONSTRAINT books__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE books ADD CONSTRAINT books__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
ALTER TABLE books ADD CONSTRAINT books__fk_orzmbtcyyh FOREIGN KEY (author_id) REFERENCES authors (id);
ALTER TABLE books_lifecycles ADD CONSTRAINT books_lifecycles__fk_caxcealeh7 FOREIGN KEY (book_id) REFERENCES books (id) ON DELETE CASCADE;
ALTER TABLE books_lifecycles ADD CONSTRAINT books_lifecycles__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE clubs ADD CONSTRAINT clubs__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE clubs ADD CONSTRAINT clubs__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
ALTER TABLE clubs ADD CONSTRAINT clubs__fk_dpb5is744z FOREIGN KEY (current_book_id) REFERENCES books (id) ON DELETE SET NULL;
ALTER TABLE clubs_lifecycles ADD CONSTRAINT clubs_lifecycles__fk_5t78xpivx3 FOREIGN KEY (club_id) REFERENCES clubs (id) ON DELETE CASCADE;
ALTER TABLE clubs_lifecycles ADD CONSTRAINT clubs_lifecycles__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE credentials ADD CONSTRAINT credentials__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE credentials ADD CONSTRAINT credentials__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
ALTER TABLE credentials_lifecycles ADD CONSTRAINT credentials_lifecycles__fk_w2kdwpibuj FOREIGN KEY (credential_id) REFERENCES credentials (id) ON DELETE CASCADE;
ALTER TABLE credentials_lifecycles ADD CONSTRAINT credentials_lifecycles__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE events ADD CONSTRAINT events__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE events ADD CONSTRAINT events__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
ALTER TABLE events ADD CONSTRAINT events__fk_5t78xpivx3 FOREIGN KEY (club_id) REFERENCES clubs (id) ON DELETE CASCADE;
ALTER TABLE events_lifecycles ADD CONSTRAINT events_lifecycles__fk_1jd0u96m12j FOREIGN KEY (event_id) REFERENCES events (id) ON DELETE CASCADE;
ALTER TABLE events_lifecycles ADD CONSTRAINT events_lifecycles__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE loans ADD CONSTRAINT loans__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE loans ADD CONSTRAINT loans__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
ALTER TABLE loans ADD CONSTRAINT loans__fk_vipvmhhi6k FOREIGN KEY (book_id) REFERENCES books (id) ON DELETE RESTRICT;
ALTER TABLE loans ADD CONSTRAINT loans__fk_l0gqbbuv78 FOREIGN KEY (member_id) REFERENCES members (id) ON DELETE RESTRICT;
ALTER TABLE loans_lifecycles ADD CONSTRAINT loans_lifecycles__fk_2757la1oekx FOREIGN KEY (loan_id) REFERENCES loans (id) ON DELETE CASCADE;
ALTER TABLE loans_lifecycles ADD CONSTRAINT loans_lifecycles__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE members ADD CONSTRAINT members__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE members ADD CONSTRAINT members__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
ALTER TABLE members ADD CONSTRAINT members__fk_1a8p97f8w74 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE;
ALTER TABLE members_lifecycles ADD CONSTRAINT members_lifecycles__fk_mg11otj5pc FOREIGN KEY (member_id) REFERENCES members (id) ON DELETE CASCADE;
ALTER TABLE members_lifecycles ADD CONSTRAINT members_lifecycles__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE reviews ADD CONSTRAINT reviews__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE reviews ADD CONSTRAINT reviews__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
ALTER TABLE reviews ADD CONSTRAINT reviews__fk_caxcealeh7 FOREIGN KEY (book_id) REFERENCES books (id) ON DELETE CASCADE;
ALTER TABLE reviews ADD CONSTRAINT reviews__fk_mg11otj5pc FOREIGN KEY (member_id) REFERENCES members (id) ON DELETE CASCADE;
ALTER TABLE reviews_lifecycles ADD CONSTRAINT reviews_lifecycles__fk_nga9ilgm2f FOREIGN KEY (review_id) REFERENCES reviews (id) ON DELETE CASCADE;
ALTER TABLE reviews_lifecycles ADD CONSTRAINT reviews_lifecycles__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE sessions ADD CONSTRAINT sessions__fk_1bcf3rnsxcn FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE share_tokens ADD CONSTRAINT share_tokens__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE share_tokens ADD CONSTRAINT share_tokens__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
ALTER TABLE user_auth_tokens ADD CONSTRAINT user_auth_tokens__fk_1bcf3rnsxcn FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE users ADD CONSTRAINT users__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE users ADD CONSTRAINT users__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
ALTER TABLE users_lifecycles ADD CONSTRAINT users_lifecycles__fk_1a8p97f8w74 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE;
ALTER TABLE users_lifecycles ADD CONSTRAINT users_lifecycles__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE workflow_errors ADD CONSTRAINT workflow_errors__fk_cp7eedsmj8 FOREIGN KEY (workflow_run_id) REFERENCES workflow_runs (id);
ALTER TABLE workflow_errors ADD CONSTRAINT workflow_errors__fk_1ax0wyt9cd FOREIGN KEY (workflow_step_id) REFERENCES workflow_steps (id);
ALTER TABLE workflow_errors ADD CONSTRAINT workflow_errors__fk_1bcf3rnsxcn FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE workflow_events ADD CONSTRAINT workflow_events__fk_1bcf3rnsxcn FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE workflow_runs ADD CONSTRAINT workflow_runs__fk_1bcf3rnsxcn FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE workflow_runs ADD CONSTRAINT workflow_runs__fk_1litfg97zuu FOREIGN KEY (workflow_event_id) REFERENCES workflow_events (id);
ALTER TABLE workflow_schedules ADD CONSTRAINT workflow_schedules__fk_1bcf3rnsxcn FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE workflow_schedules ADD CONSTRAINT workflow_schedules__fk_cp7eedsmj8 FOREIGN KEY (workflow_run_id) REFERENCES workflow_runs (id);
ALTER TABLE workflow_steps ADD CONSTRAINT workflow_steps__fk_1bcf3rnsxcn FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE workflow_steps ADD CONSTRAINT workflow_steps__fk_cp7eedsmj8 FOREIGN KEY (workflow_run_id) REFERENCES workflow_runs (id);
CREATE TRIGGER workflow_trigger_i_u_d
  BEFORE INSERT OR UPDATE OR DELETE ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.insert_update_delete_trigger();
CREATE TRIGGER workflow_trigger_i_u_d
  BEFORE INSERT OR UPDATE OR DELETE ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.insert_update_delete_trigger();
CREATE TRIGGER workflow_trigger_i_u_d
  BEFORE INSERT OR UPDATE OR DELETE ON public.members
  FOR EACH ROW EXECUTE FUNCTION public.insert_update_delete_trigger();
CREATE TRIGGER workflow_trigger_i_u_d
  BEFORE INSERT OR UPDATE OR DELETE ON public.reviews
  FOR EACH ROW EXECUTE FUNCTION public.insert_update_delete_trigger();
CREATE OR REPLACE FUNCTION public.events__tg_13u9h9ky2xn()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE events SET club_name = NEW.name WHERE club_id = NEW.id;
  RETURN NEW;
END;
$$;
CREATE TRIGGER events__tg_13u9h9ky2xn
  AFTER UPDATE OF name ON public.clubs
  FOR EACH ROW EXECUTE FUNCTION public.events__tg_13u9h9ky2xn();
UPDATE events
SET club_name = (SELECT clubs.name FROM clubs WHERE clubs.id = events.club_id);
CREATE OR REPLACE FUNCTION public.events__tg_a_bns6sg14do()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.identity := (COALESCE(new.title::text, '') || ' ') || COALESCE(new.starts_at::text, '');
  RETURN NEW;
END;
$$;
CREATE TRIGGER events__tg_a_bns6sg14do
  BEFORE INSERT OR UPDATE OF title, starts_at ON public.events
  FOR EACH ROW EXECUTE FUNCTION public.events__tg_a_bns6sg14do();
UPDATE events
SET identity = ((COALESCE(title::text, '') || ' ') || COALESCE(starts_at::text, ''));
CREATE OR REPLACE FUNCTION public.events__tg_b_axgtrxyf3w()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.club_name := (SELECT clubs.name FROM clubs WHERE clubs.id = NEW.club_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER events__tg_b_axgtrxyf3w
  BEFORE INSERT OR UPDATE OF club_id ON public.events
  FOR EACH ROW EXECUTE FUNCTION public.events__tg_b_axgtrxyf3w();
UPDATE events
SET club_name = (SELECT clubs.name FROM clubs WHERE clubs.id = events.club_id);
CREATE OR REPLACE FUNCTION public.reviews__tg_a_bns6sg14do()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.identity := (COALESCE(new.headline::text, '') || ' ') || COALESCE(new.rating::text, '');
  RETURN NEW;
END;
$$;
CREATE TRIGGER reviews__tg_a_bns6sg14do
  BEFORE INSERT OR UPDATE OF headline, rating ON public.reviews
  FOR EACH ROW EXECUTE FUNCTION public.reviews__tg_a_bns6sg14do();
UPDATE reviews
SET identity = ((COALESCE(headline::text, '') || ' ') || COALESCE(rating::text, ''));
CREATE OR REPLACE FUNCTION public.books__tg_1d2msfefd52()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE books SET author_name = NEW.name WHERE author_id = NEW.id;
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_1d2msfefd52
  AFTER UPDATE OF name ON public.authors
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_1d2msfefd52();
UPDATE books
SET author_name = (SELECT authors.name FROM authors WHERE authors.id = books.author_id);
CREATE OR REPLACE FUNCTION public.books__tg_8wt07j4ug2()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.status IN ('published') THEN
    UPDATE books
    SET review_count = review_count + 1
    WHERE books.id = NEW.book_id;
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_8wt07j4ug2
  AFTER INSERT ON public.reviews
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_8wt07j4ug2();
UPDATE books
SET review_count = (SELECT COUNT(reviews.id) FROM reviews WHERE reviews.book_id = books.id AND reviews.status IN ('published'));
CREATE OR REPLACE FUNCTION public.books__tg_pcl3q7sey0()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  IF OLD.status IN ('published') THEN
    UPDATE books
    SET review_count = review_count - 1
    WHERE books.id = OLD.book_id;
  END IF;
  RETURN OLD;
END;
$$;
CREATE TRIGGER books__tg_pcl3q7sey0
  AFTER DELETE ON public.reviews
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_pcl3q7sey0();
UPDATE books
SET review_count = (SELECT COUNT(reviews.id) FROM reviews WHERE reviews.book_id = books.id AND reviews.status IN ('published'));
CREATE OR REPLACE FUNCTION public.books__tg_13s7vshkcwf()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
DECLARE
  old_included boolean := OLD.status IN ('published');
  new_included boolean := NEW.status IN ('published');
  diff integer;
BEGIN
  IF OLD.book_id IS DISTINCT FROM NEW.book_id THEN
    IF old_included AND OLD.book_id IS NOT NULL THEN
      UPDATE books SET review_count = review_count - 1 WHERE books.id = OLD.book_id;
    END IF;
    IF new_included AND NEW.book_id IS NOT NULL THEN
      UPDATE books SET review_count = review_count + 1 WHERE books.id = NEW.book_id;
    END IF;
  ELSIF old_included <> new_included THEN
    diff := CASE WHEN new_included THEN 1 ELSE -1 END;
    UPDATE books SET review_count = review_count + diff WHERE books.id = NEW.book_id;
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_13s7vshkcwf
  AFTER UPDATE OF status, book_id ON public.reviews
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_13s7vshkcwf();
UPDATE books
SET review_count = (SELECT COUNT(reviews.id) FROM reviews WHERE reviews.book_id = books.id AND reviews.status IN ('published'));
CREATE OR REPLACE FUNCTION public.books__tg_1p0aixvlt7f()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.status IN ('published') THEN
    UPDATE books
    SET rating_total = rating_total + NEW.rating
    WHERE id = NEW.book_id;
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_1p0aixvlt7f
  AFTER INSERT ON public.reviews
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_1p0aixvlt7f();
UPDATE books
SET rating_total = (SELECT SUM(reviews.rating) FROM reviews WHERE reviews.book_id = books.id AND reviews.status IN ('published'));
CREATE OR REPLACE FUNCTION public.books__tg_1bky5rmihpo()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  IF OLD.status IN ('published') THEN
    UPDATE books
    SET rating_total = rating_total - OLD.rating
    WHERE id = OLD.book_id;
  END IF;
  RETURN OLD;
END;
$$;
CREATE TRIGGER books__tg_1bky5rmihpo
  AFTER DELETE ON public.reviews
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_1bky5rmihpo();
UPDATE books
SET rating_total = (SELECT SUM(reviews.rating) FROM reviews WHERE reviews.book_id = books.id AND reviews.status IN ('published'));
CREATE OR REPLACE FUNCTION public.books__tg_lrn7horfd9()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
DECLARE
  old_included boolean := OLD.status IN ('published');
  new_included boolean := NEW.status IN ('published');
BEGIN
  IF OLD.book_id IS DISTINCT FROM NEW.book_id THEN
    IF old_included AND OLD.book_id IS NOT NULL THEN
      UPDATE books SET rating_total = rating_total - OLD.rating WHERE books.id = OLD.book_id;
    END IF;
    IF new_included AND NEW.book_id IS NOT NULL THEN
      UPDATE books SET rating_total = rating_total + NEW.rating WHERE books.id = NEW.book_id;
    END IF;
  ELSIF old_included <> new_included THEN
    IF old_included THEN
      UPDATE books SET rating_total = rating_total - OLD.rating WHERE books.id = NEW.book_id;
    END IF;
    IF new_included THEN
      UPDATE books SET rating_total = rating_total + NEW.rating WHERE books.id = NEW.book_id;
    END IF;
  ELSIF OLD.rating <> NEW.rating AND old_included THEN
    UPDATE books SET rating_total = rating_total - OLD.rating + NEW.rating WHERE books.id = NEW.book_id;
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_lrn7horfd9
  AFTER UPDATE OF status, rating ON public.reviews
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_lrn7horfd9();
UPDATE books
SET rating_total = (SELECT SUM(reviews.rating) FROM reviews WHERE reviews.book_id = books.id AND reviews.status IN ('published'));
CREATE OR REPLACE FUNCTION public.books__tg_a_bns6sg14do()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.identity := COALESCE(new.title::text, '');
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_a_bns6sg14do
  BEFORE INSERT OR UPDATE OF title ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_a_bns6sg14do();
UPDATE books
SET identity = (COALESCE(title::text, ''));
CREATE OR REPLACE FUNCTION public.books__tg_b_bezvwbb8ng()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.author_name := (SELECT authors.name FROM authors WHERE authors.id = NEW.author_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_b_bezvwbb8ng
  BEFORE INSERT OR UPDATE OF author_id ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_b_bezvwbb8ng();
UPDATE books
SET author_name = (SELECT authors.name FROM authors WHERE authors.id = books.author_id);
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
UPDATE books
SET average_rating = (CASE WHEN review_count > 0 THEN round(rating_total::numeric / review_count, 2) ELSE 0 END);
CREATE OR REPLACE FUNCTION public.loans__tg_1rfakxmgrvd()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE loans SET book_title = NEW.title WHERE book_id = NEW.id;
  RETURN NEW;
END;
$$;
CREATE TRIGGER loans__tg_1rfakxmgrvd
  AFTER UPDATE OF title ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.loans__tg_1rfakxmgrvd();
UPDATE loans
SET book_title = (SELECT books.title FROM books WHERE books.id = loans.book_id);
CREATE OR REPLACE FUNCTION public.loans__tg_a_1gpcxb12ray()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.book_title := (SELECT books.title FROM books WHERE books.id = NEW.book_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER loans__tg_a_1gpcxb12ray
  BEFORE INSERT OR UPDATE OF book_id ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.loans__tg_a_1gpcxb12ray();
UPDATE loans
SET book_title = (SELECT books.title FROM books WHERE books.id = loans.book_id);
CREATE OR REPLACE FUNCTION public.loans__tg_b_bns6sg14do()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.identity := (COALESCE(new.book_title::text, '') || ' ') || COALESCE(new.due_on::text, '');
  RETURN NEW;
END;
$$;
CREATE TRIGGER loans__tg_b_bns6sg14do
  BEFORE INSERT OR UPDATE OF book_title, book_id, due_on ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.loans__tg_b_bns6sg14do();
UPDATE loans
SET identity = ((COALESCE(book_title::text, '') || ' ') || COALESCE(due_on::text, ''));
CREATE OR REPLACE FUNCTION public.credentials__tg_a_bns6sg14do()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.identity := (COALESCE(new.name::text, '') || ' ') || COALESCE(new.kind::text, '');
  RETURN NEW;
END;
$$;
CREATE TRIGGER credentials__tg_a_bns6sg14do
  BEFORE INSERT OR UPDATE OF name, kind ON public.credentials
  FOR EACH ROW EXECUTE FUNCTION public.credentials__tg_a_bns6sg14do();
UPDATE credentials
SET identity = ((COALESCE(name::text, '') || ' ') || COALESCE(kind::text, ''));
CREATE OR REPLACE FUNCTION public.members__tg_z6r89z7zqg()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.status IN ('active','overdue') THEN
    UPDATE members
    SET active_loan_count = active_loan_count + 1
    WHERE members.id = NEW.member_id;
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER members__tg_z6r89z7zqg
  AFTER INSERT ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.members__tg_z6r89z7zqg();
UPDATE members
SET active_loan_count = (SELECT COUNT(loans.id) FROM loans WHERE loans.member_id = members.id AND loans.status IN ('active','overdue'));
CREATE OR REPLACE FUNCTION public.members__tg_1394tyo8qly()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  IF OLD.status IN ('active','overdue') THEN
    UPDATE members
    SET active_loan_count = active_loan_count - 1
    WHERE members.id = OLD.member_id;
  END IF;
  RETURN OLD;
END;
$$;
CREATE TRIGGER members__tg_1394tyo8qly
  AFTER DELETE ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.members__tg_1394tyo8qly();
UPDATE members
SET active_loan_count = (SELECT COUNT(loans.id) FROM loans WHERE loans.member_id = members.id AND loans.status IN ('active','overdue'));
CREATE OR REPLACE FUNCTION public.members__tg_1chbo7gzbj8()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
DECLARE
  old_included boolean := OLD.status IN ('active','overdue');
  new_included boolean := NEW.status IN ('active','overdue');
  diff integer;
BEGIN
  IF OLD.member_id IS DISTINCT FROM NEW.member_id THEN
    IF old_included AND OLD.member_id IS NOT NULL THEN
      UPDATE members SET active_loan_count = active_loan_count - 1 WHERE members.id = OLD.member_id;
    END IF;
    IF new_included AND NEW.member_id IS NOT NULL THEN
      UPDATE members SET active_loan_count = active_loan_count + 1 WHERE members.id = NEW.member_id;
    END IF;
  ELSIF old_included <> new_included THEN
    diff := CASE WHEN new_included THEN 1 ELSE -1 END;
    UPDATE members SET active_loan_count = active_loan_count + diff WHERE members.id = NEW.member_id;
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER members__tg_1chbo7gzbj8
  AFTER UPDATE OF status, member_id ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.members__tg_1chbo7gzbj8();
UPDATE members
SET active_loan_count = (SELECT COUNT(loans.id) FROM loans WHERE loans.member_id = members.id AND loans.status IN ('active','overdue'));
CREATE OR REPLACE FUNCTION public.members__tg_a_bns6sg14do()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.identity := (COALESCE(new.display_name::text, '') || ' ') || COALESCE(new.membership_tier::text, '');
  RETURN NEW;
END;
$$;
CREATE TRIGGER members__tg_a_bns6sg14do
  BEFORE INSERT OR UPDATE OF display_name, membership_tier ON public.members
  FOR EACH ROW EXECUTE FUNCTION public.members__tg_a_bns6sg14do();
UPDATE members
SET identity = ((COALESCE(display_name::text, '') || ' ') || COALESCE(membership_tier::text, ''));
CREATE OR REPLACE FUNCTION public.users__tg_a_bns6sg14do()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.identity := (COALESCE(new.first_name::text, '') || ' ') || COALESCE(new.last_name::text, '');
  RETURN NEW;
END;
$$;
CREATE TRIGGER users__tg_a_bns6sg14do
  BEFORE INSERT OR UPDATE OF first_name, last_name ON public.users
  FOR EACH ROW EXECUTE FUNCTION public.users__tg_a_bns6sg14do();
UPDATE users
SET identity = ((COALESCE(first_name::text, '') || ' ') || COALESCE(last_name::text, ''));
CREATE OR REPLACE FUNCTION public.clubs__tg_1aqn6yp76au()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE clubs SET current_book_title = NEW.title WHERE current_book_id = NEW.id;
  RETURN NEW;
END;
$$;
CREATE TRIGGER clubs__tg_1aqn6yp76au
  AFTER UPDATE OF title ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.clubs__tg_1aqn6yp76au();
UPDATE clubs
SET current_book_title = (SELECT books.title FROM books WHERE books.id = clubs.current_book_id);
CREATE OR REPLACE FUNCTION public.clubs__tg_a_bns6sg14do()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.identity := COALESCE(new.name::text, '');
  RETURN NEW;
END;
$$;
CREATE TRIGGER clubs__tg_a_bns6sg14do
  BEFORE INSERT OR UPDATE OF name ON public.clubs
  FOR EACH ROW EXECUTE FUNCTION public.clubs__tg_a_bns6sg14do();
UPDATE clubs
SET identity = (COALESCE(name::text, ''));
CREATE OR REPLACE FUNCTION public.clubs__tg_b_27sx1q8xu34()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.current_book_title := (SELECT books.title FROM books WHERE books.id = NEW.current_book_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER clubs__tg_b_27sx1q8xu34
  BEFORE INSERT OR UPDATE OF current_book_id ON public.clubs
  FOR EACH ROW EXECUTE FUNCTION public.clubs__tg_b_27sx1q8xu34();
UPDATE clubs
SET current_book_title = (SELECT books.title FROM books WHERE books.id = clubs.current_book_id);
CREATE OR REPLACE FUNCTION public.authors__tg_25iedwg89y3()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  IF TRUE THEN
    UPDATE authors
    SET book_count = book_count + 1
    WHERE authors.id = NEW.author_id;
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER authors__tg_25iedwg89y3
  AFTER INSERT ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.authors__tg_25iedwg89y3();
UPDATE authors
SET book_count = (SELECT COUNT(books.id) FROM books WHERE books.author_id = authors.id AND TRUE);
CREATE OR REPLACE FUNCTION public.authors__tg_kphr16viq0()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  IF TRUE THEN
    UPDATE authors
    SET book_count = book_count - 1
    WHERE authors.id = OLD.author_id;
  END IF;
  RETURN OLD;
END;
$$;
CREATE TRIGGER authors__tg_kphr16viq0
  AFTER DELETE ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.authors__tg_kphr16viq0();
UPDATE authors
SET book_count = (SELECT COUNT(books.id) FROM books WHERE books.author_id = authors.id AND TRUE);
CREATE OR REPLACE FUNCTION public.authors__tg_nya7ph33b1()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
DECLARE
  old_included boolean := TRUE;
  new_included boolean := TRUE;
  diff integer;
BEGIN
  IF OLD.author_id IS DISTINCT FROM NEW.author_id THEN
    IF old_included AND OLD.author_id IS NOT NULL THEN
      UPDATE authors SET book_count = book_count - 1 WHERE authors.id = OLD.author_id;
    END IF;
    IF new_included AND NEW.author_id IS NOT NULL THEN
      UPDATE authors SET book_count = book_count + 1 WHERE authors.id = NEW.author_id;
    END IF;
  ELSIF old_included <> new_included THEN
    diff := CASE WHEN new_included THEN 1 ELSE -1 END;
    UPDATE authors SET book_count = book_count + diff WHERE authors.id = NEW.author_id;
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER authors__tg_nya7ph33b1
  AFTER UPDATE OF status, author_id ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.authors__tg_nya7ph33b1();
UPDATE authors
SET book_count = (SELECT COUNT(books.id) FROM books WHERE books.author_id = authors.id AND TRUE);
CREATE OR REPLACE FUNCTION public.authors__tg_a_bns6sg14do()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.identity := COALESCE(new.name::text, '');
  RETURN NEW;
END;
$$;
CREATE TRIGGER authors__tg_a_bns6sg14do
  BEFORE INSERT OR UPDATE OF name ON public.authors
  FOR EACH ROW EXECUTE FUNCTION public.authors__tg_a_bns6sg14do();
UPDATE authors
SET identity = (COALESCE(name::text, ''));
ALTER TABLE books
ADD COLUMN cover_image_id uuid;
CREATE TABLE file_uploads (
 id uuid NOT NULL CONSTRAINT file_uploads_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('pending')::character varying NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 identity character varying NOT NULL,
 filename character varying NOT NULL,
 content_type character varying NOT NULL,
 byte_size bigint NOT NULL,
 sha256 character varying NOT NULL,
 storage_key character varying NOT NULL
);
CREATE INDEX file_uploads__idx_b_jeophq1lin ON file_uploads USING gin ("identity" gin_trgm_ops);
CREATE INDEX file_uploads__idx_nrcbxny9wa ON file_uploads USING btree (status);
CREATE INDEX file_uploads__idx_s1gk7xkfhp ON file_uploads USING btree (created_at);
CREATE INDEX file_uploads__idx_1vxk7frens6 ON file_uploads USING btree (updated_at);
CREATE UNIQUE INDEX file_uploads__idx_2qmv1o92sj ON file_uploads USING btree (storage_key);
ALTER TABLE books ADD CONSTRAINT books__fk_99r1a07ss0 FOREIGN KEY (cover_image_id) REFERENCES file_uploads (id) ON DELETE RESTRICT;
ALTER TABLE file_uploads ADD CONSTRAINT file_uploads__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE file_uploads ADD CONSTRAINT file_uploads__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
CREATE OR REPLACE FUNCTION public.file_uploads__tg_a_bns6sg14do()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.identity := (COALESCE(new.filename::text, '') || ' ') || COALESCE(new.content_type::text, '');
  RETURN NEW;
END;
$$;
CREATE TRIGGER file_uploads__tg_a_bns6sg14do
  BEFORE INSERT OR UPDATE OF filename, content_type ON public.file_uploads
  FOR EACH ROW EXECUTE FUNCTION public.file_uploads__tg_a_bns6sg14do();
UPDATE file_uploads
SET identity = ((COALESCE(filename::text, '') || ' ') || COALESCE(content_type::text, ''));
CREATE TABLE workflow_agent_messages (
 id uuid NOT NULL CONSTRAINT workflow_agent_messages_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('recorded')::character varying NOT NULL,
 agent_state_id uuid NOT NULL,
 seq bigint NOT NULL,
 kind text NOT NULL,
 workflow_step_id uuid,
 part text NOT NULL,
 created_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE TABLE workflow_agent_states (
 id uuid NOT NULL CONSTRAINT workflow_agent_states_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('active')::character varying NOT NULL,
 workflow_path character varying NOT NULL,
 state_name character varying DEFAULT '' NOT NULL,
 state_key text NOT NULL,
 scope text NOT NULL,
 workflow_step_id uuid,
 fields jsonb DEFAULT '{}'::jsonb NOT NULL,
 committed_seq bigint DEFAULT 0 NOT NULL,
 outcome jsonb,
 lease_owner uuid,
 lease_expires_at timestamp with time zone,
 created_at timestamp with time zone DEFAULT now() NOT NULL,
 updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE INDEX workflow_agent_messages__idx_nrcbxny9wa ON workflow_agent_messages USING btree (status);
CREATE INDEX workflow_agent_messages__idx_195v08otirn ON workflow_agent_messages USING btree (agent_state_id);
CREATE INDEX workflow_agent_messages__idx_1ax0wyt9cd ON workflow_agent_messages USING btree (workflow_step_id);
CREATE UNIQUE INDEX workflow_agent_messages__idx_1izisr8bbl8 ON workflow_agent_messages USING btree (agent_state_id, seq);
CREATE INDEX workflow_agent_states__idx_nrcbxny9wa ON workflow_agent_states USING btree (status);
CREATE INDEX workflow_agent_states__idx_1ax0wyt9cd ON workflow_agent_states USING btree (workflow_step_id);
CREATE INDEX workflow_agent_states__idx_s1gk7xkfhp ON workflow_agent_states USING btree (created_at);
CREATE UNIQUE INDEX workflow_agent_states__idx_27jn3mlvq0b ON workflow_agent_states USING btree (workflow_path, state_name, state_key);
ALTER TABLE workflow_agent_messages ADD CONSTRAINT workflow_agent_messages__fk_141k639kh6z FOREIGN KEY (agent_state_id) REFERENCES workflow_agent_states (id) ON DELETE CASCADE;
ALTER TABLE workflow_agent_messages ADD CONSTRAINT workflow_agent_messages__fk_19x89djdd01 FOREIGN KEY (workflow_step_id) REFERENCES workflow_steps (id) ON DELETE SET NULL;
ALTER TABLE workflow_agent_states ADD CONSTRAINT workflow_agent_states__fk_qu66hmfi9m FOREIGN KEY (workflow_step_id) REFERENCES workflow_steps (id) ON DELETE CASCADE;
ALTER TABLE workflow_agent_messages
ADD COLUMN item_index integer;
ALTER TABLE workflow_agent_states
DROP COLUMN outcome;
CREATE TRIGGER workflow_trigger_i_u_d
  BEFORE INSERT OR UPDATE OR DELETE ON public.events
  FOR EACH ROW EXECUTE FUNCTION public.insert_update_delete_trigger();
ALTER TABLE workflow_runs
ADD COLUMN thread_id uuid;
ALTER TABLE workflow_steps
ADD COLUMN thread_id uuid;
CREATE TABLE workflow_threads (
 id uuid NOT NULL CONSTRAINT workflow_threads_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('open')::character varying NOT NULL,
 workflow_path character varying NOT NULL,
 record_model character varying,
 record_id uuid,
 user_id uuid,
 key text,
 created_by_id uuid,
 created_at timestamp with time zone DEFAULT now() NOT NULL,
 updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE INDEX workflow_runs__idx_2xbktrfjrz ON workflow_runs USING btree (thread_id);
CREATE INDEX workflow_steps__idx_2xbktrfjrz ON workflow_steps USING btree (thread_id);
CREATE INDEX workflow_threads__idx_nrcbxny9wa ON workflow_threads USING btree (status);
CREATE INDEX workflow_threads__idx_17uevxtspsa ON workflow_threads USING btree (workflow_path);
CREATE INDEX workflow_threads__idx_21uvcicx0vt ON workflow_threads USING btree (record_id);
CREATE INDEX workflow_threads__idx_1bcf3rnsxcn ON workflow_threads USING btree (user_id);
CREATE INDEX workflow_threads__idx_s1gk7xkfhp ON workflow_threads USING btree (created_at);
CREATE INDEX workflow_threads__idx_1vxk7frens6 ON workflow_threads USING btree (updated_at);
CREATE UNIQUE INDEX workflow_threads__idx_1c0bsn6b22s ON workflow_threads USING btree (workflow_path, record_model, record_id, user_id, key) NULLS NOT DISTINCT;
ALTER TABLE workflow_runs ADD CONSTRAINT workflow_runs__fk_2xbktrfjrz FOREIGN KEY (thread_id) REFERENCES workflow_threads (id);
ALTER TABLE workflow_steps ADD CONSTRAINT workflow_steps__fk_2xbktrfjrz FOREIGN KEY (thread_id) REFERENCES workflow_threads (id);
ALTER TABLE workflow_threads ADD CONSTRAINT workflow_threads__fk_1bcf3rnsxcn FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE workflow_threads ADD CONSTRAINT workflow_threads__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
CREATE TABLE workflow_ledger_events (
 id uuid NOT NULL CONSTRAINT workflow_ledger_events_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status character varying DEFAULT ('settled')::character varying NOT NULL,
 thread_id uuid NOT NULL,
 event_id text NOT NULL,
 seq bigint NOT NULL,
 workflow_run_id uuid,
 node_id text,
 scope text,
 kind text NOT NULL,
 payload text NOT NULL,
 created_at timestamp with time zone DEFAULT now() NOT NULL,
 updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE INDEX workflow_ledger_events__idx_nrcbxny9wa ON workflow_ledger_events USING btree (status);
CREATE INDEX workflow_ledger_events__idx_2xbktrfjrz ON workflow_ledger_events USING btree (thread_id);
CREATE INDEX workflow_ledger_events__idx_cp7eedsmj8 ON workflow_ledger_events USING btree (workflow_run_id);
CREATE UNIQUE INDEX workflow_ledger_events__idx_2efkqv4sv7i ON workflow_ledger_events USING btree (thread_id, event_id);
CREATE INDEX workflow_ledger_events__idx_12ayleo2n14 ON workflow_ledger_events USING btree (thread_id, seq);
ALTER TABLE workflow_ledger_events ADD CONSTRAINT workflow_ledger_events__fk_1bmqisa183n FOREIGN KEY (thread_id) REFERENCES workflow_threads (id) ON DELETE CASCADE;
ALTER TABLE workflow_ledger_events ADD CONSTRAINT workflow_ledger_events__fk_du20axrhlu FOREIGN KEY (workflow_run_id) REFERENCES workflow_runs (id) ON DELETE SET NULL;
CREATE INDEX workflow_threads__idx_1o5nedqh9nr ON workflow_threads USING btree (workflow_path, updated_at);
ALTER TABLE users
ADD COLUMN circulation_role boolean DEFAULT false NOT NULL;
ALTER TABLE user_auth_tokens
ADD COLUMN permission_mask jsonb;
ALTER TABLE workflow_ledger_events
ADD COLUMN file_upload_id uuid;
ALTER TABLE workflow_threads
ADD COLUMN participant_ids uuid[] DEFAULT '{}'::uuid[] NOT NULL;
CREATE INDEX workflow_threads__idx_b_vc39s382xu ON workflow_threads USING gin (participant_ids);
ALTER TABLE workflow_ledger_events
ALTER COLUMN payload TYPE jsonb USING payload::jsonb;
ALTER TABLE workflow_ledger_events ADD CONSTRAINT workflow_ledger_events__fk_uv2dde4l57 FOREIGN KEY (file_upload_id) REFERENCES file_uploads (id) ON DELETE RESTRICT;
ALTER TABLE workflow_ledger_events
ADD COLUMN author_id uuid;
CREATE INDEX workflow_ledger_events__idx_orzmbtcyyh ON workflow_ledger_events USING btree (author_id);
ALTER TABLE workflow_ledger_events ADD CONSTRAINT workflow_ledger_events__fk_orzmbtcyyh FOREIGN KEY (author_id) REFERENCES users (id);
ALTER TABLE loans
ALTER COLUMN borrowed_on SET DEFAULT CURRENT_DATE;
ALTER TABLE loans
ALTER COLUMN due_on SET DEFAULT CURRENT_DATE + INTERVAL '14 days';
ALTER TABLE members
ALTER COLUMN joined_on SET DEFAULT CURRENT_DATE;
ALTER TABLE loans_lifecycles
ADD COLUMN reshelve_by date DEFAULT CURRENT_DATE + INTERVAL '3 days';
ALTER TABLE books
ADD COLUMN author_identity character varying;
UPDATE books
SET author_identity = (SELECT authors.identity FROM authors WHERE authors.id = books.author_id);
ALTER TABLE clubs
ADD COLUMN current_book_identity character varying;
UPDATE clubs
SET current_book_identity = (SELECT books.identity FROM books WHERE books.id = clubs.current_book_id);
ALTER TABLE events
ADD COLUMN club_identity character varying;
UPDATE events
SET club_identity = (SELECT clubs.identity FROM clubs WHERE clubs.id = events.club_id);
ALTER TABLE loans
ADD COLUMN book_identity character varying;
UPDATE loans
SET book_identity = (SELECT books.identity FROM books WHERE books.id = loans.book_id);
ALTER TABLE loans
ADD COLUMN member_identity character varying;
UPDATE loans
SET member_identity = (SELECT members.identity FROM members WHERE members.id = loans.member_id);
ALTER TABLE members
ADD COLUMN user_identity character varying;
UPDATE members
SET user_identity = (SELECT users.identity FROM users WHERE users.id = members.user_id);
ALTER TABLE reviews
ADD COLUMN book_identity character varying;
UPDATE reviews
SET book_identity = (SELECT books.identity FROM books WHERE books.id = reviews.book_id);
ALTER TABLE reviews
ADD COLUMN member_identity character varying;
UPDATE reviews
SET member_identity = (SELECT members.identity FROM members WHERE members.id = reviews.member_id);
CREATE INDEX books__idx_11zybk5rve3 ON books USING btree (author_identity);
CREATE INDEX clubs__idx_25miapd4s7t ON clubs USING btree (current_book_identity);
CREATE INDEX events__idx_1rm4ckt19o ON events USING btree (club_identity);
CREATE INDEX loans__idx_2b3om97zzxr ON loans USING btree (book_identity);
CREATE INDEX loans__idx_doct46jiwk ON loans USING btree (member_identity);
CREATE INDEX members__idx_1036ohcgfv3 ON members USING btree (user_identity);
CREATE INDEX reviews__idx_2b3om97zzxr ON reviews USING btree (book_identity);
CREATE INDEX reviews__idx_doct46jiwk ON reviews USING btree (member_identity);
CREATE OR REPLACE FUNCTION public.reviews__tg_1a7p08tx457()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE reviews SET book_identity = NEW.identity WHERE book_id = NEW.id;
  RETURN NEW;
END;
$$;
CREATE TRIGGER reviews__tg_1a7p08tx457
  AFTER UPDATE OF identity, title ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.reviews__tg_1a7p08tx457();
UPDATE reviews
SET book_identity = (SELECT books.identity FROM books WHERE books.id = reviews.book_id);
CREATE OR REPLACE FUNCTION public.reviews__tg_161skkvlcs5()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE reviews SET member_identity = NEW.identity WHERE member_id = NEW.id;
  RETURN NEW;
END;
$$;
CREATE TRIGGER reviews__tg_161skkvlcs5
  AFTER UPDATE OF identity, display_name, membership_tier ON public.members
  FOR EACH ROW EXECUTE FUNCTION public.reviews__tg_161skkvlcs5();
UPDATE reviews
SET member_identity = (SELECT members.identity FROM members WHERE members.id = reviews.member_id);
CREATE OR REPLACE FUNCTION public.reviews__tg_b_27lnr5c8go9()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.book_identity := (SELECT books.identity FROM books WHERE books.id = NEW.book_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER reviews__tg_b_27lnr5c8go9
  BEFORE INSERT OR UPDATE OF book_id ON public.reviews
  FOR EACH ROW EXECUTE FUNCTION public.reviews__tg_b_27lnr5c8go9();
UPDATE reviews
SET book_identity = (SELECT books.identity FROM books WHERE books.id = reviews.book_id);
CREATE OR REPLACE FUNCTION public.reviews__tg_c_xohkoxknb7()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.member_identity := (SELECT members.identity FROM members WHERE members.id = NEW.member_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER reviews__tg_c_xohkoxknb7
  BEFORE INSERT OR UPDATE OF member_id ON public.reviews
  FOR EACH ROW EXECUTE FUNCTION public.reviews__tg_c_xohkoxknb7();
UPDATE reviews
SET member_identity = (SELECT members.identity FROM members WHERE members.id = reviews.member_id);
CREATE OR REPLACE FUNCTION public.members__tg_akc1kq77oy()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE members SET user_identity = NEW.identity WHERE user_id = NEW.id;
  RETURN NEW;
END;
$$;
CREATE TRIGGER members__tg_akc1kq77oy
  AFTER UPDATE OF identity, first_name, last_name ON public.users
  FOR EACH ROW EXECUTE FUNCTION public.members__tg_akc1kq77oy();
UPDATE members
SET user_identity = (SELECT users.identity FROM users WHERE users.id = members.user_id);
CREATE OR REPLACE FUNCTION public.members__tg_b_1z2vetxt9ya()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.user_identity := (SELECT users.identity FROM users WHERE users.id = NEW.user_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER members__tg_b_1z2vetxt9ya
  BEFORE INSERT OR UPDATE OF user_id ON public.members
  FOR EACH ROW EXECUTE FUNCTION public.members__tg_b_1z2vetxt9ya();
UPDATE members
SET user_identity = (SELECT users.identity FROM users WHERE users.id = members.user_id);
CREATE OR REPLACE FUNCTION public.clubs__tg_ozzn2wefc9()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE clubs SET current_book_identity = NEW.identity WHERE current_book_id = NEW.id;
  RETURN NEW;
END;
$$;
CREATE TRIGGER clubs__tg_ozzn2wefc9
  AFTER UPDATE OF identity, title ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.clubs__tg_ozzn2wefc9();
UPDATE clubs
SET current_book_identity = (SELECT books.identity FROM books WHERE books.id = clubs.current_book_id);
CREATE OR REPLACE FUNCTION public.clubs__tg_c_y9f5fwyzg0()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.current_book_identity := (SELECT books.identity FROM books WHERE books.id = NEW.current_book_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER clubs__tg_c_y9f5fwyzg0
  BEFORE INSERT OR UPDATE OF current_book_id ON public.clubs
  FOR EACH ROW EXECUTE FUNCTION public.clubs__tg_c_y9f5fwyzg0();
UPDATE clubs
SET current_book_identity = (SELECT books.identity FROM books WHERE books.id = clubs.current_book_id);
CREATE OR REPLACE FUNCTION public.books__tg_1aarvt5ujj4()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE books SET author_identity = NEW.identity WHERE author_id = NEW.id;
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_1aarvt5ujj4
  AFTER UPDATE OF identity, name ON public.authors
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_1aarvt5ujj4();
UPDATE books
SET author_identity = (SELECT authors.identity FROM authors WHERE authors.id = books.author_id);
CREATE OR REPLACE FUNCTION public.books__tg_d_efcow27wkc()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.author_identity := (SELECT authors.identity FROM authors WHERE authors.id = NEW.author_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_d_efcow27wkc
  BEFORE INSERT OR UPDATE OF author_id ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_d_efcow27wkc();
UPDATE books
SET author_identity = (SELECT authors.identity FROM authors WHERE authors.id = books.author_id);
CREATE OR REPLACE FUNCTION public.events__tg_a5wo8pkr82()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE events SET club_identity = NEW.identity WHERE club_id = NEW.id;
  RETURN NEW;
END;
$$;
CREATE TRIGGER events__tg_a5wo8pkr82
  AFTER UPDATE OF identity, name ON public.clubs
  FOR EACH ROW EXECUTE FUNCTION public.events__tg_a5wo8pkr82();
UPDATE events
SET club_identity = (SELECT clubs.identity FROM clubs WHERE clubs.id = events.club_id);
CREATE OR REPLACE FUNCTION public.events__tg_c_1pldvp5vlvx()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.club_identity := (SELECT clubs.identity FROM clubs WHERE clubs.id = NEW.club_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER events__tg_c_1pldvp5vlvx
  BEFORE INSERT OR UPDATE OF club_id ON public.events
  FOR EACH ROW EXECUTE FUNCTION public.events__tg_c_1pldvp5vlvx();
UPDATE events
SET club_identity = (SELECT clubs.identity FROM clubs WHERE clubs.id = events.club_id);
CREATE OR REPLACE FUNCTION public.loans__tg_1a7p08tx457()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE loans SET book_identity = NEW.identity WHERE book_id = NEW.id;
  RETURN NEW;
END;
$$;
CREATE TRIGGER loans__tg_1a7p08tx457
  AFTER UPDATE OF identity, title ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.loans__tg_1a7p08tx457();
UPDATE loans
SET book_identity = (SELECT books.identity FROM books WHERE books.id = loans.book_id);
CREATE OR REPLACE FUNCTION public.loans__tg_161skkvlcs5()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE loans SET member_identity = NEW.identity WHERE member_id = NEW.id;
  RETURN NEW;
END;
$$;
CREATE TRIGGER loans__tg_161skkvlcs5
  AFTER UPDATE OF identity, display_name, membership_tier ON public.members
  FOR EACH ROW EXECUTE FUNCTION public.loans__tg_161skkvlcs5();
UPDATE loans
SET member_identity = (SELECT members.identity FROM members WHERE members.id = loans.member_id);
CREATE OR REPLACE FUNCTION public.loans__tg_c_27lnr5c8go9()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.book_identity := (SELECT books.identity FROM books WHERE books.id = NEW.book_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER loans__tg_c_27lnr5c8go9
  BEFORE INSERT OR UPDATE OF book_id ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.loans__tg_c_27lnr5c8go9();
UPDATE loans
SET book_identity = (SELECT books.identity FROM books WHERE books.id = loans.book_id);
CREATE OR REPLACE FUNCTION public.loans__tg_d_xohkoxknb7()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.member_identity := (SELECT members.identity FROM members WHERE members.id = NEW.member_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER loans__tg_d_xohkoxknb7
  BEFORE INSERT OR UPDATE OF member_id ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.loans__tg_d_xohkoxknb7();
UPDATE loans
SET member_identity = (SELECT members.identity FROM members WHERE members.id = loans.member_id);
CREATE TABLE reviews__body_embeds (
 file_id uuid NOT NULL CONSTRAINT reviews__body_embeds_pk_id PRIMARY KEY,
 record_id uuid NOT NULL
);
CREATE INDEX reviews__body_embeds__idx_21uvcicx0vt ON reviews__body_embeds USING btree (record_id);
ALTER TABLE reviews__body_embeds ADD CONSTRAINT reviews__body_embeds__fk_1oezcimdixp FOREIGN KEY (file_id) REFERENCES file_uploads (id) ON DELETE RESTRICT;
ALTER TABLE reviews__body_embeds ADD CONSTRAINT reviews__body_embeds__fk_21uvcicx0vt FOREIGN KEY (record_id) REFERENCES reviews (id);
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
ALTER TABLE users
ADD COLUMN password_reset_attempts integer DEFAULT 0;
UPDATE users
SET password_reset_attempts = (0);
ALTER TABLE users
ALTER COLUMN password_reset_attempts SET NOT NULL;
ALTER TABLE users
ADD COLUMN password_reset_sends integer DEFAULT 0;
UPDATE users
SET password_reset_sends = (0);
ALTER TABLE users
ALTER COLUMN password_reset_sends SET NOT NULL;
ALTER TABLE workflow_steps
ADD COLUMN kind text DEFAULT 'normal' NOT NULL;
ALTER TABLE workflow_steps
ADD COLUMN bytes_written bigint;
CREATE TYPE pending_signups_status AS ENUM ('active');
CREATE TABLE pending_signups (
 id uuid NOT NULL CONSTRAINT pending_signups_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status pending_signups_status DEFAULT ('active')::pending_signups_status NOT NULL,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 email character varying NOT NULL,
 first_name character varying NOT NULL,
 last_name character varying NOT NULL,
 password_digest character varying NOT NULL,
 verification_code character varying,
 code_sent_at timestamp(6) without time zone,
 code_attempts integer DEFAULT 0 NOT NULL,
 code_sends integer DEFAULT 0 NOT NULL
);
CREATE INDEX pending_signups__idx_nrcbxny9wa ON pending_signups USING btree (status);
CREATE INDEX pending_signups__idx_s1gk7xkfhp ON pending_signups USING btree (created_at);
CREATE INDEX pending_signups__idx_1vxk7frens6 ON pending_signups USING btree (updated_at);
CREATE UNIQUE INDEX pending_signups__idx_1hcztykds8l ON pending_signups USING btree (email);
CREATE INDEX pending_signups__idx_2bzow4dzxz1 ON pending_signups USING btree (code_sent_at);
CREATE TYPE signup_ip_counters_status AS ENUM ('active');
CREATE TABLE signup_ip_counters (
 id uuid NOT NULL CONSTRAINT signup_ip_counters_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status signup_ip_counters_status DEFAULT ('active')::signup_ip_counters_status NOT NULL,
 client_ip character varying NOT NULL,
 hour_started_at timestamp(6) without time zone NOT NULL,
 hour_sends integer DEFAULT 0 NOT NULL,
 day_started_at timestamp(6) without time zone NOT NULL,
 day_sends integer DEFAULT 0 NOT NULL
);
CREATE INDEX signup_ip_counters__idx_nrcbxny9wa ON signup_ip_counters USING btree (status);
CREATE UNIQUE INDEX signup_ip_counters__idx_bx5ootaoyt ON signup_ip_counters USING btree (client_ip);
CREATE INDEX signup_ip_counters__idx_2compyc7obe ON signup_ip_counters USING btree (day_started_at);
ALTER TABLE workflow_errors DROP CONSTRAINT IF EXISTS workflow_errors__fk_cp7eedsmj8, ADD CONSTRAINT workflow_errors__fk_184kdgrcb59 FOREIGN KEY (workflow_run_id) REFERENCES workflow_runs (id) ON DELETE CASCADE;
ALTER TABLE workflow_errors DROP CONSTRAINT IF EXISTS workflow_errors__fk_1ax0wyt9cd, ADD CONSTRAINT workflow_errors__fk_qu66hmfi9m FOREIGN KEY (workflow_step_id) REFERENCES workflow_steps (id) ON DELETE CASCADE;
ALTER TABLE workflow_schedules DROP CONSTRAINT IF EXISTS workflow_schedules__fk_cp7eedsmj8, ADD CONSTRAINT workflow_schedules__fk_du20axrhlu FOREIGN KEY (workflow_run_id) REFERENCES workflow_runs (id) ON DELETE SET NULL;
ALTER TABLE workflow_steps DROP CONSTRAINT IF EXISTS workflow_steps__fk_cp7eedsmj8, ADD CONSTRAINT workflow_steps__fk_184kdgrcb59 FOREIGN KEY (workflow_run_id) REFERENCES workflow_runs (id) ON DELETE CASCADE;
CREATE TYPE users_status_new AS ENUM ('active', 'invited');
ALTER TABLE users
ALTER COLUMN status DROP DEFAULT;
ALTER TABLE users
ALTER COLUMN status TYPE users_status_new USING status::text::users_status_new;
ALTER TABLE users_lifecycles
ALTER COLUMN status TYPE users_status_new USING status::text::users_status_new;
DROP TYPE IF EXISTS users_status;
ALTER TYPE users_status_new RENAME TO users_status;
ALTER TABLE users
ALTER COLUMN status SET DEFAULT ('active')::users_status;
ALTER TABLE users
ADD COLUMN invitation_token character varying;
ALTER TABLE users
ADD COLUMN invitation_sent_at timestamp(6) without time zone;
CREATE INDEX workflow_runs__idx_1litfg97zuu ON workflow_runs USING btree (workflow_event_id);
CREATE INDEX workflow_schedules__idx_cp7eedsmj8 ON workflow_schedules USING btree (workflow_run_id);
CREATE INDEX users__idx_174eujr7tdc ON users USING btree (invitation_token);
DROP TRIGGER IF EXISTS books__tg_c_1p70drudguy ON public.books;
DROP FUNCTION IF EXISTS public.books__tg_c_1p70drudguy();
CREATE OR REPLACE FUNCTION public.books__tg_c_1p70drudguy()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.average_rating := (CASE WHEN COALESCE(((NEW."review_count") > ((0.0)::double precision)), FALSE) THEN ((CASE WHEN abs(((CASE WHEN abs(((CASE WHEN abs((NEW."rating_total")::numeric / NULLIF((NEW."review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE (NEW."rating_total") / NULLIF((NEW."review_count"), 0::double precision) END))::numeric * 100.0::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ((CASE WHEN abs((NEW."rating_total")::numeric / NULLIF((NEW."review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE (NEW."rating_total") / NULLIF((NEW."review_count"), 0::double precision) END)) * (100.0)::double precision END)) - trunc((CASE WHEN abs(((CASE WHEN abs((NEW."rating_total")::numeric / NULLIF((NEW."review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE (NEW."rating_total") / NULLIF((NEW."review_count"), 0::double precision) END))::numeric * 100.0::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ((CASE WHEN abs((NEW."rating_total")::numeric / NULLIF((NEW."review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE (NEW."rating_total") / NULLIF((NEW."review_count"), 0::double precision) END)) * (100.0)::double precision END))) >= 0.5::double precision THEN trunc((CASE WHEN abs(((CASE WHEN abs((NEW."rating_total")::numeric / NULLIF((NEW."review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE (NEW."rating_total") / NULLIF((NEW."review_count"), 0::double precision) END))::numeric * 100.0::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ((CASE WHEN abs((NEW."rating_total")::numeric / NULLIF((NEW."review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE (NEW."rating_total") / NULLIF((NEW."review_count"), 0::double precision) END)) * (100.0)::double precision END)) + sign((CASE WHEN abs(((CASE WHEN abs((NEW."rating_total")::numeric / NULLIF((NEW."review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE (NEW."rating_total") / NULLIF((NEW."review_count"), 0::double precision) END))::numeric * 100.0::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ((CASE WHEN abs((NEW."rating_total")::numeric / NULLIF((NEW."review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE (NEW."rating_total") / NULLIF((NEW."review_count"), 0::double precision) END)) * (100.0)::double precision END)) ELSE trunc((CASE WHEN abs(((CASE WHEN abs((NEW."rating_total")::numeric / NULLIF((NEW."review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE (NEW."rating_total") / NULLIF((NEW."review_count"), 0::double precision) END))::numeric * 100.0::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ((CASE WHEN abs((NEW."rating_total")::numeric / NULLIF((NEW."review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE (NEW."rating_total") / NULLIF((NEW."review_count"), 0::double precision) END)) * (100.0)::double precision END)) END) / (100.0)::double precision) ELSE (0.0)::double precision END);
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_c_1p70drudguy
  BEFORE INSERT OR UPDATE OF review_count, rating_total ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_c_1p70drudguy();
UPDATE books
SET average_rating = ((CASE WHEN COALESCE((("review_count") > ((0.0)::double precision)), FALSE) THEN ((CASE WHEN abs(((CASE WHEN abs(((CASE WHEN abs(("rating_total")::numeric / NULLIF(("review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ("rating_total") / NULLIF(("review_count"), 0::double precision) END))::numeric * 100.0::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ((CASE WHEN abs(("rating_total")::numeric / NULLIF(("review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ("rating_total") / NULLIF(("review_count"), 0::double precision) END)) * (100.0)::double precision END)) - trunc((CASE WHEN abs(((CASE WHEN abs(("rating_total")::numeric / NULLIF(("review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ("rating_total") / NULLIF(("review_count"), 0::double precision) END))::numeric * 100.0::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ((CASE WHEN abs(("rating_total")::numeric / NULLIF(("review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ("rating_total") / NULLIF(("review_count"), 0::double precision) END)) * (100.0)::double precision END))) >= 0.5::double precision THEN trunc((CASE WHEN abs(((CASE WHEN abs(("rating_total")::numeric / NULLIF(("review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ("rating_total") / NULLIF(("review_count"), 0::double precision) END))::numeric * 100.0::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ((CASE WHEN abs(("rating_total")::numeric / NULLIF(("review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ("rating_total") / NULLIF(("review_count"), 0::double precision) END)) * (100.0)::double precision END)) + sign((CASE WHEN abs(((CASE WHEN abs(("rating_total")::numeric / NULLIF(("review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ("rating_total") / NULLIF(("review_count"), 0::double precision) END))::numeric * 100.0::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ((CASE WHEN abs(("rating_total")::numeric / NULLIF(("review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ("rating_total") / NULLIF(("review_count"), 0::double precision) END)) * (100.0)::double precision END)) ELSE trunc((CASE WHEN abs(((CASE WHEN abs(("rating_total")::numeric / NULLIF(("review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ("rating_total") / NULLIF(("review_count"), 0::double precision) END))::numeric * 100.0::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ((CASE WHEN abs(("rating_total")::numeric / NULLIF(("review_count")::numeric, 0)) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric THEN NULL::double precision ELSE ("rating_total") / NULLIF(("review_count"), 0::double precision) END)) * (100.0)::double precision END)) END) / (100.0)::double precision) ELSE (0.0)::double precision END));
ALTER INDEX workflow_threads__idx_b_vc39s382xu RENAME TO workflow_threads__idx_b_2gjau9fcckq;
ALTER TABLE users
ADD COLUMN pending_email character varying;
ALTER TABLE users
ADD COLUMN email_change_token character varying;
ALTER TABLE users
ADD COLUMN email_change_sent_at timestamp(6) without time zone;
ALTER TABLE users
ADD COLUMN email_change_sends integer DEFAULT 0;
UPDATE users
SET email_change_sends = (0);
ALTER TABLE users
ALTER COLUMN email_change_sends SET NOT NULL;
CREATE INDEX users__idx_tsnupw2096 ON users USING btree (email_change_token);
CREATE OR REPLACE FUNCTION public.easel_divide(a double precision, b double precision)
  RETURNS double precision
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
declare
    magnitude numeric;
begin
    if a is null or b is null or b = 0::double precision then
        return null;
    end if;
    magnitude := abs(a::numeric / b::numeric);
    if magnitude >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric then
        return null;
    end if;
    if magnitude <> 0::numeric
        and magnitude * 404804506614621236704990693437834614099113299528284236713802716054860679135990693783920767402874248990374155728633623822779617474771586953734026799881477019843034848553132722728933815484186432682479535356945490137124014966849385397236206711298319112681620113024717539104666829230461005064372655017292012526615415482186989568::numeric <= 1::numeric then
        return 0::double precision;
    end if;
    return a / b;
end;
$$;
CREATE OR REPLACE FUNCTION public.easel_minus(a double precision, b double precision)
  RETURNS double precision
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
begin
    if a is null or b is null then
        return null;
    end if;
    if abs(a::numeric - b::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric then
        return null;
    end if;
    return a - b;
end;
$$;
CREATE OR REPLACE FUNCTION public.easel_modulo(a double precision, b double precision)
  RETURNS double precision
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
begin
    if a is null or b is null or b = 0::double precision then
        return null;
    end if;
    return a - b * trunc(a / b);
end;
$$;
CREATE OR REPLACE FUNCTION public.easel_plus(a double precision, b double precision)
  RETURNS double precision
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
begin
    if a is null or b is null then
        return null;
    end if;
    if abs(a::numeric + b::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric then
        return null;
    end if;
    return a + b;
end;
$$;
CREATE OR REPLACE FUNCTION public.easel_round(value double precision, digits double precision)
  RETURNS double precision
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
declare
    factor double precision := 1::double precision;
    remaining double precision;
    scaled double precision;
    rounded double precision;
begin
    if value is null or digits is null then
        return null;
    end if;
    if digits = 0::double precision then
        return case when abs(value - trunc(value)) >= 0.5::double precision
            then trunc(value) + sign(value)
            else trunc(value) end;
    end if;
    if abs(digits) >= 309::double precision then
        return null;
    end if;
    remaining := abs(digits);
    while remaining >= 1::double precision loop
        factor := factor * 10::double precision;
        remaining := remaining - 1::double precision;
    end loop;
    if digits > 0::double precision then
        if abs(value::numeric * factor::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric then
            return null;
        end if;
        scaled := value * factor;
        rounded := case when abs(scaled - trunc(scaled)) >= 0.5::double precision
            then trunc(scaled) + sign(scaled)
            else trunc(scaled) end;
        return rounded / factor;
    end if;
    scaled := value / factor;
    rounded := case when abs(scaled - trunc(scaled)) >= 0.5::double precision
        then trunc(scaled) + sign(scaled)
        else trunc(scaled) end;
    if abs(rounded::numeric * factor::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric then
        return null;
    end if;
    return rounded * factor;
end;
$$;
CREATE OR REPLACE FUNCTION public.easel_slice(value text, start_at double precision, stop_at double precision)
  RETURNS text
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
declare
    char_count integer;
    from_index integer;
    to_index integer;
begin
    if value is null or start_at is null then
        return null;
    end if;
    char_count := char_length(value);
    from_index := least(greatest(case when start_at < 0::double precision
        then char_count + start_at::integer
        else start_at::integer end, 0), char_count);
    if stop_at is null then
        to_index := char_count;
    else
        to_index := least(greatest(case when stop_at < 0::double precision
            then char_count + stop_at::integer
            else stop_at::integer end, 0), char_count);
    end if;
    return substr(value, from_index + 1, greatest(to_index - from_index, 0));
end;
$$;
CREATE OR REPLACE FUNCTION public.easel_times(a double precision, b double precision)
  RETURNS double precision
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
declare
    magnitude numeric;
begin
    if a is null or b is null then
        return null;
    end if;
    magnitude := abs(a::numeric * b::numeric);
    if magnitude >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric then
        return null;
    end if;
    if magnitude <> 0::numeric
        and magnitude * 404804506614621236704990693437834614099113299528284236713802716054860679135990693783920767402874248990374155728633623822779617474771586953734026799881477019843034848553132722728933815484186432682479535356945490137124014966849385397236206711298319112681620113024717539104666829230461005064372655017292012526615415482186989568::numeric <= 1::numeric then
        return 0::double precision;
    end if;
    return a * b;
end;
$$;
CREATE OR REPLACE FUNCTION public.easel_to_number(value text)
  RETURNS double precision
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
declare
    magnitude numeric;
begin
    if value is null then
        return null;
    end if;
    if lower(btrim(value)) in ('inf', '+inf', '-inf', 'infinity', '+infinity', '-infinity', 'nan', '+nan', '-nan') then
        return null;
    end if;
    magnitude := abs(value::numeric);
    if magnitude >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric then
        return null;
    end if;
    if magnitude <> 0::numeric
        and magnitude * 404804506614621236704990693437834614099113299528284236713802716054860679135990693783920767402874248990374155728633623822779617474771586953734026799881477019843034848553132722728933815484186432682479535356945490137124014966849385397236206711298319112681620113024717539104666829230461005064372655017292012526615415482186989568::numeric <= 1::numeric then
        return 0::double precision;
    end if;
    return value::double precision;
end;
$$;
CREATE OR REPLACE FUNCTION public.easel_truthy(value jsonb)
  RETURNS boolean
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
begin
    return case coalesce(jsonb_typeof(value), 'null')
        when 'null' then false
        when 'boolean' then (value #>> '{}') = 'true'
        when 'number' then (value #>> '{}')::double precision <> 0::double precision
        when 'string' then (value #>> '{}') <> ''
        else true
    end;
end;
$$;
DROP TRIGGER IF EXISTS books__tg_c_1p70drudguy ON public.books;
DROP FUNCTION IF EXISTS public.books__tg_c_1p70drudguy();
CREATE OR REPLACE FUNCTION public.books__tg_c_1p70drudguy()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.average_rating := (CASE WHEN COALESCE(((NEW."review_count") > ((0.0)::double precision)), FALSE) THEN easel_round((easel_divide((NEW."rating_total"), (NEW."review_count"))), ((2.0)::double precision)) ELSE (0.0)::double precision END);
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_c_1p70drudguy
  BEFORE INSERT OR UPDATE OF review_count, rating_total ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_c_1p70drudguy();
UPDATE books
SET average_rating = ((CASE WHEN COALESCE((("review_count") > ((0.0)::double precision)), FALSE) THEN easel_round((easel_divide(("rating_total"), ("review_count"))), ((2.0)::double precision)) ELSE (0.0)::double precision END));
CREATE OR REPLACE FUNCTION public.books__tg_c_q1z7tchws()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.isbn := upper(NEW."isbn");
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_c_q1z7tchws
  BEFORE INSERT OR UPDATE ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_c_q1z7tchws();
UPDATE books
SET isbn = (upper("isbn"));
CREATE OR REPLACE FUNCTION public.books__tg_d_1p70drudguy()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.average_rating := (CASE WHEN COALESCE(((NEW."review_count") > ((0.0)::double precision)), FALSE) THEN easel_round((easel_divide((NEW."rating_total"), (NEW."review_count"))), ((2.0)::double precision)) ELSE (0.0)::double precision END);
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_d_1p70drudguy
  BEFORE INSERT OR UPDATE OF review_count, rating_total ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_d_1p70drudguy();
UPDATE books
SET average_rating = ((CASE WHEN COALESCE((("review_count") > ((0.0)::double precision)), FALSE) THEN easel_round((easel_divide(("rating_total"), ("review_count"))), ((2.0)::double precision)) ELSE (0.0)::double precision END));
CREATE OR REPLACE FUNCTION public.books__tg_e_efcow27wkc()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.author_identity := (SELECT authors.identity FROM authors WHERE authors.id = NEW.author_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_e_efcow27wkc
  BEFORE INSERT OR UPDATE OF author_id ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_e_efcow27wkc();
UPDATE books
SET author_identity = (SELECT authors.identity FROM authors WHERE authors.id = books.author_id);
DROP TRIGGER IF EXISTS books__tg_d_efcow27wkc ON public.books;
DROP FUNCTION IF EXISTS public.books__tg_d_efcow27wkc();
DROP TRIGGER IF EXISTS books__tg_c_1p70drudguy ON public.books;
DROP FUNCTION IF EXISTS public.books__tg_c_1p70drudguy();
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
CREATE TYPE custom_dashboards_status AS ENUM ('active');
CREATE TABLE custom_dashboards (
 id uuid NOT NULL CONSTRAINT custom_dashboards_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status custom_dashboards_status DEFAULT ('active')::custom_dashboards_status NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 identity character varying NOT NULL,
 name character varying NOT NULL,
 owner_id uuid NOT NULL,
 dashboard_config json NOT NULL,
 "primary" boolean DEFAULT false NOT NULL
);
CREATE INDEX custom_dashboards__idx_b_jeophq1lin ON custom_dashboards USING gin ("identity" gin_trgm_ops);
CREATE INDEX custom_dashboards__idx_nrcbxny9wa ON custom_dashboards USING btree (status);
CREATE INDEX custom_dashboards__idx_s1gk7xkfhp ON custom_dashboards USING btree (created_at);
CREATE INDEX custom_dashboards__idx_1vxk7frens6 ON custom_dashboards USING btree (updated_at);
CREATE UNIQUE INDEX custom_dashboards__idx_26eaj9s01w6 ON custom_dashboards USING btree (owner_id, name);
CREATE UNIQUE INDEX custom_dashboards__idx_8ky5r5jn9g ON custom_dashboards USING btree (owner_id) WHERE "primary";
ALTER TABLE custom_dashboards ADD CONSTRAINT custom_dashboards__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE custom_dashboards ADD CONSTRAINT custom_dashboards__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
ALTER TABLE custom_dashboards ADD CONSTRAINT custom_dashboards__fk_8ky5r5jn9g FOREIGN KEY (owner_id) REFERENCES users (id);
CREATE OR REPLACE FUNCTION public.custom_dashboards__tg_a_bns6sg14do()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.identity := COALESCE(new.name::text, '');
  RETURN NEW;
END;
$$;
CREATE TRIGGER custom_dashboards__tg_a_bns6sg14do
  BEFORE INSERT OR UPDATE OF name ON public.custom_dashboards
  FOR EACH ROW EXECUTE FUNCTION public.custom_dashboards__tg_a_bns6sg14do();
UPDATE custom_dashboards
SET identity = (COALESCE(name::text, ''));
ALTER TABLE sessions
ADD COLUMN authenticated_at timestamp(6) without time zone;
ALTER TABLE sessions
ADD COLUMN auth_method character varying;
CREATE INDEX books__idx_1aks6s4a5vh ON books USING btree (featured);
ALTER TABLE loans
ADD COLUMN checked_out_at timestamp with time zone;
CREATE OR REPLACE FUNCTION public.loans__tg_c_1ox2f3yds9()
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
    NEW.checked_out_at := now();
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER loans__tg_c_1ox2f3yds9
  BEFORE INSERT OR UPDATE OF status ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.loans__tg_c_1ox2f3yds9();
CREATE OR REPLACE FUNCTION public.loans__tg_d_27lnr5c8go9()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.book_identity := (SELECT books.identity FROM books WHERE books.id = NEW.book_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER loans__tg_d_27lnr5c8go9
  BEFORE INSERT OR UPDATE OF book_id ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.loans__tg_d_27lnr5c8go9();
UPDATE loans
SET book_identity = (SELECT books.identity FROM books WHERE books.id = loans.book_id);
CREATE OR REPLACE FUNCTION public.loans__tg_e_xohkoxknb7()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.member_identity := (SELECT members.identity FROM members WHERE members.id = NEW.member_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER loans__tg_e_xohkoxknb7
  BEFORE INSERT OR UPDATE OF member_id ON public.loans
  FOR EACH ROW EXECUTE FUNCTION public.loans__tg_e_xohkoxknb7();
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
DROP TRIGGER IF EXISTS loans__tg_c_27lnr5c8go9 ON public.loans;
DROP FUNCTION IF EXISTS public.loans__tg_c_27lnr5c8go9();
DROP TRIGGER IF EXISTS loans__tg_d_xohkoxknb7 ON public.loans;
DROP FUNCTION IF EXISTS public.loans__tg_d_xohkoxknb7();
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
ALTER TABLE books
ADD COLUMN reviews_at_shelving integer;
CREATE OR REPLACE FUNCTION public.books__tg_e_2a6fcmtfc1w()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
DECLARE
  entering boolean;
BEGIN
  IF TG_OP = 'INSERT' THEN
    entering := NEW.status IN ('published', 'archived');
  ELSE
    entering := NEW.status IS DISTINCT FROM OLD.status AND NEW.status IN ('published', 'archived');
  END IF;
  IF entering THEN
    NEW.reviews_at_shelving := (SELECT COUNT(reviews.id) FROM reviews WHERE reviews.book_id = NEW.id AND reviews.status IN ('published'));
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_e_2a6fcmtfc1w
  BEFORE INSERT OR UPDATE OF status ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_e_2a6fcmtfc1w();
CREATE OR REPLACE FUNCTION public.books__tg_f_efcow27wkc()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.author_identity := (SELECT authors.identity FROM authors WHERE authors.id = NEW.author_id);
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_f_efcow27wkc
  BEFORE INSERT OR UPDATE OF author_id ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_f_efcow27wkc();
UPDATE books
SET author_identity = (SELECT authors.identity FROM authors WHERE authors.id = books.author_id);
DROP TRIGGER IF EXISTS books__tg_e_efcow27wkc ON public.books;
DROP FUNCTION IF EXISTS public.books__tg_e_efcow27wkc();
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
ALTER TABLE books
ALTER COLUMN board_rank TYPE character varying COLLATE "C" USING board_rank::character varying;
ALTER TABLE loans
ALTER COLUMN board_rank TYPE character varying COLLATE "C" USING board_rank::character varying;
ALTER TABLE file_uploads
ADD COLUMN workflow_run_id uuid;
CREATE INDEX file_uploads__idx_cp7eedsmj8 ON file_uploads USING btree (workflow_run_id);
ALTER TABLE members
ADD COLUMN statement_file_id uuid;
ALTER TABLE members ADD CONSTRAINT members__fk_1f3i9egnit4 FOREIGN KEY (statement_file_id) REFERENCES file_uploads (id) ON DELETE RESTRICT;
DROP TRIGGER IF EXISTS members__audit_tg ON public.members;
DROP FUNCTION IF EXISTS public.members__audit_tg();
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
      'active_loan_count', to_jsonb(NEW.active_loan_count),
      'statement_file_id', to_jsonb(NEW.statement_file_id)
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
    IF OLD.statement_file_id IS DISTINCT FROM NEW.statement_file_id THEN
      audit_changes := audit_changes || jsonb_build_object('statement_file_id', jsonb_build_object('from', to_jsonb(OLD.statement_file_id), 'to', to_jsonb(NEW.statement_file_id)));
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
      'active_loan_count', to_jsonb(OLD.active_loan_count),
      'statement_file_id', to_jsonb(OLD.statement_file_id)
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
ALTER TABLE clubs
ADD COLUMN logo_file_id uuid;
ALTER TABLE events
ADD COLUMN worksheet_file_id uuid;
ALTER TABLE clubs ADD CONSTRAINT clubs__fk_w890rj4ia5 FOREIGN KEY (logo_file_id) REFERENCES file_uploads (id) ON DELETE RESTRICT;
ALTER TABLE events ADD CONSTRAINT events__fk_1mipm004q89 FOREIGN KEY (worksheet_file_id) REFERENCES file_uploads (id) ON DELETE RESTRICT;
DROP TRIGGER IF EXISTS members__audit_tg ON public.members;
DROP FUNCTION IF EXISTS public.members__audit_tg();
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
CREATE TYPE user_preferences_status AS ENUM ('active');
CREATE TABLE user_preferences (
 id uuid NOT NULL CONSTRAINT user_preferences_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status user_preferences_status DEFAULT ('active')::user_preferences_status NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 owner_id uuid NOT NULL,
 key character varying NOT NULL,
 value json NOT NULL
);
CREATE INDEX user_preferences__idx_nrcbxny9wa ON user_preferences USING btree (status);
CREATE INDEX user_preferences__idx_s1gk7xkfhp ON user_preferences USING btree (created_at);
CREATE INDEX user_preferences__idx_1vxk7frens6 ON user_preferences USING btree (updated_at);
CREATE UNIQUE INDEX user_preferences__idx_4tphfxupia ON user_preferences USING btree (owner_id, key);
ALTER TABLE user_preferences ADD CONSTRAINT user_preferences__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE user_preferences ADD CONSTRAINT user_preferences__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
ALTER TABLE user_preferences ADD CONSTRAINT user_preferences__fk_8ky5r5jn9g FOREIGN KEY (owner_id) REFERENCES users (id);
CREATE TYPE sandbox_holds_status AS ENUM ('held', 'warm');
CREATE TABLE sandbox_holds (
 id uuid NOT NULL CONSTRAINT sandbox_holds_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status sandbox_holds_status DEFAULT ('held')::sandbox_holds_status NOT NULL,
 box_key text NOT NULL,
 box_id text,
 host text NOT NULL,
 class text NOT NULL,
 workflow_path character varying NOT NULL,
 thread_id uuid,
 holder uuid,
 cpu integer,
 memory_mib integer,
 lease_until timestamp with time zone NOT NULL,
 last_used_at timestamp with time zone NOT NULL,
 reclaimed_at timestamp with time zone,
 created_at timestamp with time zone DEFAULT now() NOT NULL,
 updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE INDEX sandbox_holds__idx_nrcbxny9wa ON sandbox_holds USING btree (status);
CREATE UNIQUE INDEX sandbox_holds__idx_1tst6aq2ogv ON sandbox_holds USING btree (box_key);
CREATE TYPE sandbox_holds_status_new AS ENUM ('held', 'warm', 'paused');
ALTER TABLE sandbox_holds
ALTER COLUMN status DROP DEFAULT;
ALTER TABLE sandbox_holds
ALTER COLUMN status TYPE sandbox_holds_status_new USING status::text::sandbox_holds_status_new;
DROP TYPE IF EXISTS sandbox_holds_status;
ALTER TYPE sandbox_holds_status_new RENAME TO sandbox_holds_status;
ALTER TABLE sandbox_holds
ALTER COLUMN status SET DEFAULT ('held')::sandbox_holds_status;
ALTER TABLE sandbox_holds
ADD COLUMN sandbox_name text;
ALTER TABLE users
ADD COLUMN onboarding character varying;
CREATE TYPE workflow_metered_turns_status AS ENUM ('recorded');
CREATE TABLE workflow_metered_turns (
 id uuid NOT NULL CONSTRAINT workflow_metered_turns_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status workflow_metered_turns_status DEFAULT ('recorded')::workflow_metered_turns_status NOT NULL,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 workflow_run_id uuid,
 workflow_step_id uuid,
 thread_id uuid,
 node_id character varying NOT NULL,
 workflow_path character varying NOT NULL,
 trigger_record_model character varying,
 trigger_record_id text,
 user_id uuid,
 credential_name character varying NOT NULL,
 provider character varying NOT NULL,
 model character varying NOT NULL,
 calls integer DEFAULT 0 NOT NULL,
 input bigint DEFAULT 0 NOT NULL,
 output bigint DEFAULT 0 NOT NULL,
 cache_read bigint DEFAULT 0 NOT NULL,
 cache_write bigint DEFAULT 0 NOT NULL,
 reasoning bigint DEFAULT 0 NOT NULL,
 extra_tokens jsonb,
 duration_ms bigint DEFAULT 0 NOT NULL,
 cost_microcents bigint,
 priced_from text
);
ALTER TABLE workflow_runs
ADD COLUMN trigger_record_model character varying;
ALTER TABLE workflow_runs
ADD COLUMN trigger_record_id text;
CREATE INDEX workflow_metered_turns__idx_nrcbxny9wa ON workflow_metered_turns USING btree (status);
CREATE INDEX workflow_metered_turns__idx_s1gk7xkfhp ON workflow_metered_turns USING btree (created_at);
CREATE INDEX workflow_metered_turns__idx_1vxk7frens6 ON workflow_metered_turns USING btree (updated_at);
CREATE INDEX workflow_metered_turns__idx_cp7eedsmj8 ON workflow_metered_turns USING btree (workflow_run_id);
CREATE INDEX workflow_metered_turns__idx_2xbktrfjrz ON workflow_metered_turns USING btree (thread_id);
CREATE INDEX workflow_metered_turns__idx_17uevxtspsa ON workflow_metered_turns USING btree (workflow_path);
CREATE INDEX workflow_metered_turns__idx_1bcf3rnsxcn ON workflow_metered_turns USING btree (user_id);
CREATE INDEX workflow_metered_turns__idx_cqp3buimje ON workflow_metered_turns USING btree (credential_name);
CREATE INDEX workflow_metered_turns__idx_32tpuue0yx ON workflow_metered_turns USING btree (model);
CREATE INDEX workflow_metered_turns__idx_1qge5z9aj6m ON workflow_metered_turns USING btree (workflow_path, trigger_record_model, trigger_record_id);
CREATE INDEX workflow_metered_turns__idx_96gi63yqyb ON workflow_metered_turns USING btree (model, cost_microcents);
ALTER TABLE workflow_metered_turns ADD CONSTRAINT workflow_metered_turns__fk_du20axrhlu FOREIGN KEY (workflow_run_id) REFERENCES workflow_runs (id) ON DELETE SET NULL;
ALTER TABLE workflow_metered_turns ADD CONSTRAINT workflow_metered_turns__fk_19x89djdd01 FOREIGN KEY (workflow_step_id) REFERENCES workflow_steps (id) ON DELETE SET NULL;
ALTER TABLE workflow_metered_turns ADD CONSTRAINT workflow_metered_turns__fk_ebvix7u20l FOREIGN KEY (thread_id) REFERENCES workflow_threads (id) ON DELETE SET NULL;
ALTER TABLE books
ADD COLUMN blurb_budget_usd double precision;
ALTER TABLE books
ADD COLUMN agent_cost_microcents bigint DEFAULT 0;
UPDATE books
SET agent_cost_microcents = (SELECT SUM(workflow_metered_turns.cost_microcents) FROM workflow_metered_turns WHERE workflow_metered_turns.trigger_record_model = 'books' AND workflow_metered_turns.trigger_record_id = books.id::text);
CREATE TYPE workflow_llm_spend_status AS ENUM ('recorded');
CREATE TABLE workflow_llm_spend (
 id uuid NOT NULL CONSTRAINT workflow_llm_spend_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status workflow_llm_spend_status DEFAULT ('recorded')::workflow_llm_spend_status NOT NULL,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 month date NOT NULL,
 dimension character varying NOT NULL,
 value text NOT NULL,
 cost_microcents bigint DEFAULT 0 NOT NULL,
 calls integer DEFAULT 0 NOT NULL,
 unpriced_calls integer DEFAULT 0 NOT NULL
);
CREATE INDEX workflow_llm_spend__idx_nrcbxny9wa ON workflow_llm_spend USING btree (status);
CREATE INDEX workflow_llm_spend__idx_s1gk7xkfhp ON workflow_llm_spend USING btree (created_at);
CREATE INDEX workflow_llm_spend__idx_1vxk7frens6 ON workflow_llm_spend USING btree (updated_at);
CREATE UNIQUE INDEX workflow_llm_spend__idx_8nu4wg0tiv ON workflow_llm_spend USING btree (month, dimension, value);
CREATE INDEX workflow_llm_spend__idx_27qc8qec4xx ON workflow_llm_spend USING btree (dimension, month);
ALTER TABLE workflow_metered_turns
ADD COLUMN model_profile character varying DEFAULT ('')::character varying;
UPDATE workflow_metered_turns
SET model_profile = (''::text);
ALTER TABLE workflow_metered_turns
ALTER COLUMN model_profile SET NOT NULL;
CREATE INDEX workflow_metered_turns__idx_15421bgo77z ON workflow_metered_turns USING btree (model_profile);
CREATE UNIQUE INDEX workflow_metered_turns__idx_vzr2x1wqvj ON workflow_metered_turns USING btree (workflow_step_id, model, model_profile);
CREATE INDEX workflow_threads__idx_1neuc78nwd0 ON workflow_threads USING btree (record_model, record_id);
ALTER TABLE books
ADD COLUMN cover_description text;
CREATE INDEX books__idx_1bu4u7m7cwp ON books USING btree (cover_image_id);
CREATE INDEX clubs__idx_1udg2lwpvcm ON clubs USING btree (logo_file_id);
CREATE INDEX events__idx_2emhqx4fv8e ON events USING btree (worksheet_file_id);
CREATE INDEX workflow_ledger_events__idx_1yuqutcxsn7 ON workflow_ledger_events USING btree (file_upload_id);
ALTER TABLE workflow_threads
ADD COLUMN spend_microcents bigint DEFAULT 0 NOT NULL;
ALTER TABLE workflow_threads
ADD COLUMN unpriced_calls integer DEFAULT 0 NOT NULL;
ALTER TABLE workflow_threads
ADD COLUMN title text;
CREATE TYPE workflow_runs_status_new AS ENUM ('pending', 'running', 'suspended', 'done');
ALTER TABLE workflow_runs
ALTER COLUMN status DROP DEFAULT;
ALTER TABLE workflow_runs
ALTER COLUMN status TYPE workflow_runs_status_new USING status::text::workflow_runs_status_new;
DROP TYPE IF EXISTS workflow_runs_status;
ALTER TYPE workflow_runs_status_new RENAME TO workflow_runs_status;
ALTER TABLE workflow_runs
ALTER COLUMN status SET DEFAULT ('pending')::workflow_runs_status;
ALTER TABLE books
ADD COLUMN co_author_ids uuid[] DEFAULT '{}'::uuid[] NOT NULL;
CREATE INDEX workflow_metered_turns__idx_ztzhuv22ha ON workflow_metered_turns USING btree (provider);
ALTER TABLE workflow_metered_turns ADD CONSTRAINT workflow_metered_turns__fk_2a6jnmoaiyq FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL;
CREATE INDEX books__idx_b_t2lm80wm4t ON books USING gin ("co_author_ids");
CREATE INDEX workflow_errors__idx_1bcf3rnsxcn ON workflow_errors USING btree (user_id);
CREATE INDEX workflow_events__idx_1bcf3rnsxcn ON workflow_events USING btree (user_id);
CREATE INDEX workflow_threads__idx_f4dh8jcckz ON workflow_threads USING btree (created_by_id);
CREATE TYPE inbound_auths_status AS ENUM ('active');
CREATE TABLE inbound_auths (
 id uuid NOT NULL CONSTRAINT inbound_auths_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status inbound_auths_status DEFAULT ('active')::inbound_auths_status NOT NULL,
 created_by_id uuid,
 updated_by_id uuid,
 create_attribution jsonb,
 update_attribution jsonb,
 created_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 updated_at timestamp(6) without time zone DEFAULT current_timestamp NOT NULL,
 identity character varying NOT NULL,
 name character varying NOT NULL,
 secret text
);
CREATE TABLE inbound_auths_lifecycles (
 id uuid NOT NULL CONSTRAINT inbound_auths_lifecycles_pk_id PRIMARY KEY DEFAULT gen_random_uuid(),
 status inbound_auths_status NOT NULL,
 legacy_status character varying,
 inbound_auth_id uuid NOT NULL,
 created_by_id uuid,
 create_attribution jsonb,
 created_at timestamp(6) without time zone NOT NULL
);
CREATE INDEX inbound_auths__idx_b_jeophq1lin ON inbound_auths USING gin ("identity" gin_trgm_ops);
CREATE INDEX inbound_auths__idx_nrcbxny9wa ON inbound_auths USING btree (status);
CREATE INDEX inbound_auths__idx_s1gk7xkfhp ON inbound_auths USING btree (created_at);
CREATE INDEX inbound_auths__idx_1vxk7frens6 ON inbound_auths USING btree (updated_at);
CREATE UNIQUE INDEX inbound_auths__idx_505akd4e4a ON inbound_auths USING btree (name);
CREATE INDEX inbound_auths_lifecycles__idx_nrcbxny9wa ON inbound_auths_lifecycles USING btree (status);
CREATE INDEX inbound_auths_lifecycles__idx_2kpc90uh14 ON inbound_auths_lifecycles USING btree (inbound_auth_id);
CREATE INDEX inbound_auths_lifecycles__idx_f4dh8jcckz ON inbound_auths_lifecycles USING btree (created_by_id);
CREATE INDEX inbound_auths_lifecycles__idx_s1gk7xkfhp ON inbound_auths_lifecycles USING btree (created_at);
ALTER TABLE inbound_auths ADD CONSTRAINT inbound_auths__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
ALTER TABLE inbound_auths ADD CONSTRAINT inbound_auths__fk_1bq8hp7lup6 FOREIGN KEY (updated_by_id) REFERENCES users (id);
ALTER TABLE inbound_auths_lifecycles ADD CONSTRAINT inbound_auths_lifecycles__fk_mfbsjvc1ah FOREIGN KEY (inbound_auth_id) REFERENCES inbound_auths (id) ON DELETE CASCADE;
ALTER TABLE inbound_auths_lifecycles ADD CONSTRAINT inbound_auths_lifecycles__fk_f4dh8jcckz FOREIGN KEY (created_by_id) REFERENCES users (id);
CREATE OR REPLACE FUNCTION public.inbound_auths__tg_a_bns6sg14do()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.identity := COALESCE(new.name::text, '');
  RETURN NEW;
END;
$$;
CREATE TRIGGER inbound_auths__tg_a_bns6sg14do
  BEFORE INSERT OR UPDATE OF name ON public.inbound_auths
  FOR EACH ROW EXECUTE FUNCTION public.inbound_auths__tg_a_bns6sg14do();
UPDATE inbound_auths
SET identity = (COALESCE(name::text, ''));
ALTER TABLE workflow_runs
ADD COLUMN parent_run_id uuid;
ALTER TABLE workflow_runs
ADD COLUMN parent_step_id uuid;
ALTER TABLE workflow_runs
ADD COLUMN parent_index integer;
CREATE INDEX workflow_runs__idx_q0n4crrsx3 ON workflow_runs USING btree (parent_run_id);
ALTER TABLE workflow_runs ADD CONSTRAINT workflow_runs__fk_q0n4crrsx3 FOREIGN KEY (parent_run_id) REFERENCES workflow_runs (id);
ALTER TABLE books
ADD COLUMN translator text;
