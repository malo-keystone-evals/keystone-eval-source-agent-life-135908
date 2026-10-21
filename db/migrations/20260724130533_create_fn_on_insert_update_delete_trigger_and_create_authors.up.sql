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
CREATE UNIQUE INDEX share_tokens__idx_1vkjtjvdqpd ON share_tokens USING btree (model_name, record_id);
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
