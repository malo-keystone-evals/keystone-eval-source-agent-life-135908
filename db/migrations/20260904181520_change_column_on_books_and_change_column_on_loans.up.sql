ALTER TABLE books
ALTER COLUMN board_rank TYPE character varying COLLATE "C" USING board_rank::character varying;
ALTER TABLE loans
ALTER COLUMN board_rank TYPE character varying COLLATE "C" USING board_rank::character varying;
