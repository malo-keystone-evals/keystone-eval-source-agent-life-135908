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
