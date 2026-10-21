ALTER TABLE books
ADD COLUMN co_author_ids uuid[] DEFAULT '{}'::uuid[] NOT NULL;
