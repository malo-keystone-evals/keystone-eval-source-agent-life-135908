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
