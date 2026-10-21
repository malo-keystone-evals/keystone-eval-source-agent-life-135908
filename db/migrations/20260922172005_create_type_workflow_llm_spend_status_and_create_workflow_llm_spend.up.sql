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
