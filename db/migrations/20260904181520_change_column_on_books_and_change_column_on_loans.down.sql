ALTER TABLE books
ALTER COLUMN board_rank TYPE varchar USING board_rank::varchar;
ALTER TABLE loans
ALTER COLUMN board_rank TYPE varchar USING board_rank::varchar;
