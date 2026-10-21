DROP INDEX IF EXISTS books__idx_11zybk5rve3;
DROP INDEX IF EXISTS clubs__idx_25miapd4s7t;
DROP INDEX IF EXISTS events__idx_1rm4ckt19o;
DROP INDEX IF EXISTS loans__idx_2b3om97zzxr;
DROP INDEX IF EXISTS loans__idx_doct46jiwk;
DROP INDEX IF EXISTS members__idx_1036ohcgfv3;
DROP INDEX IF EXISTS reviews__idx_2b3om97zzxr;
DROP INDEX IF EXISTS reviews__idx_doct46jiwk;
ALTER TABLE books
DROP COLUMN IF EXISTS author_identity;
ALTER TABLE clubs
DROP COLUMN IF EXISTS current_book_identity;
ALTER TABLE events
DROP COLUMN IF EXISTS club_identity;
ALTER TABLE loans
DROP COLUMN IF EXISTS book_identity;
ALTER TABLE loans
DROP COLUMN IF EXISTS member_identity;
ALTER TABLE members
DROP COLUMN IF EXISTS user_identity;
ALTER TABLE reviews
DROP COLUMN IF EXISTS book_identity;
ALTER TABLE reviews
DROP COLUMN IF EXISTS member_identity;
DROP TRIGGER IF EXISTS reviews__tg_1a7p08tx457 ON public.books;
DROP FUNCTION IF EXISTS public.reviews__tg_1a7p08tx457();
DROP TRIGGER IF EXISTS reviews__tg_161skkvlcs5 ON public.members;
DROP FUNCTION IF EXISTS public.reviews__tg_161skkvlcs5();
DROP TRIGGER IF EXISTS reviews__tg_b_27lnr5c8go9 ON public.reviews;
DROP FUNCTION IF EXISTS public.reviews__tg_b_27lnr5c8go9();
DROP TRIGGER IF EXISTS reviews__tg_c_xohkoxknb7 ON public.reviews;
DROP FUNCTION IF EXISTS public.reviews__tg_c_xohkoxknb7();
DROP TRIGGER IF EXISTS members__tg_akc1kq77oy ON public.users;
DROP FUNCTION IF EXISTS public.members__tg_akc1kq77oy();
DROP TRIGGER IF EXISTS members__tg_b_1z2vetxt9ya ON public.members;
DROP FUNCTION IF EXISTS public.members__tg_b_1z2vetxt9ya();
DROP TRIGGER IF EXISTS clubs__tg_ozzn2wefc9 ON public.books;
DROP FUNCTION IF EXISTS public.clubs__tg_ozzn2wefc9();
DROP TRIGGER IF EXISTS clubs__tg_c_y9f5fwyzg0 ON public.clubs;
DROP FUNCTION IF EXISTS public.clubs__tg_c_y9f5fwyzg0();
DROP TRIGGER IF EXISTS books__tg_1aarvt5ujj4 ON public.authors;
DROP FUNCTION IF EXISTS public.books__tg_1aarvt5ujj4();
DROP TRIGGER IF EXISTS books__tg_d_efcow27wkc ON public.books;
DROP FUNCTION IF EXISTS public.books__tg_d_efcow27wkc();
DROP TRIGGER IF EXISTS events__tg_a5wo8pkr82 ON public.clubs;
DROP FUNCTION IF EXISTS public.events__tg_a5wo8pkr82();
DROP TRIGGER IF EXISTS events__tg_c_1pldvp5vlvx ON public.events;
DROP FUNCTION IF EXISTS public.events__tg_c_1pldvp5vlvx();
DROP TRIGGER IF EXISTS loans__tg_1a7p08tx457 ON public.books;
DROP FUNCTION IF EXISTS public.loans__tg_1a7p08tx457();
DROP TRIGGER IF EXISTS loans__tg_161skkvlcs5 ON public.members;
DROP FUNCTION IF EXISTS public.loans__tg_161skkvlcs5();
DROP TRIGGER IF EXISTS loans__tg_c_27lnr5c8go9 ON public.loans;
DROP FUNCTION IF EXISTS public.loans__tg_c_27lnr5c8go9();
DROP TRIGGER IF EXISTS loans__tg_d_xohkoxknb7 ON public.loans;
DROP FUNCTION IF EXISTS public.loans__tg_d_xohkoxknb7();
