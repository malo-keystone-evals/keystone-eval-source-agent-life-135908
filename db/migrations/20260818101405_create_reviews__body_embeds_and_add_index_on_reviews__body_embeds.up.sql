CREATE TABLE reviews__body_embeds (
 file_id uuid NOT NULL CONSTRAINT reviews__body_embeds_pk_id PRIMARY KEY,
 record_id uuid NOT NULL
);
CREATE INDEX reviews__body_embeds__idx_21uvcicx0vt ON reviews__body_embeds USING btree (record_id);
ALTER TABLE reviews__body_embeds ADD CONSTRAINT reviews__body_embeds__fk_1oezcimdixp FOREIGN KEY (file_id) REFERENCES file_uploads (id) ON DELETE RESTRICT;
ALTER TABLE reviews__body_embeds ADD CONSTRAINT reviews__body_embeds__fk_21uvcicx0vt FOREIGN KEY (record_id) REFERENCES reviews (id);
