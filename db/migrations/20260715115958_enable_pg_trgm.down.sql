-- Reverses 20260715115958_enable_pg_trgm. Guarded so dropping is safe even if
-- another object still depends on it (in which case Postgres refuses without
-- CASCADE — intentional, we don't force it).
DROP EXTENSION IF EXISTS pg_trgm;
