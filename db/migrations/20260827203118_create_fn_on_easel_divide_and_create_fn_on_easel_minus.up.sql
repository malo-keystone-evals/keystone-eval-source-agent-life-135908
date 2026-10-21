CREATE OR REPLACE FUNCTION public.easel_divide(a double precision, b double precision)
  RETURNS double precision
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
declare
    magnitude numeric;
begin
    if a is null or b is null or b = 0::double precision then
        return null;
    end if;
    magnitude := abs(a::numeric / b::numeric);
    if magnitude >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric then
        return null;
    end if;
    if magnitude <> 0::numeric
        and magnitude * 404804506614621236704990693437834614099113299528284236713802716054860679135990693783920767402874248990374155728633623822779617474771586953734026799881477019843034848553132722728933815484186432682479535356945490137124014966849385397236206711298319112681620113024717539104666829230461005064372655017292012526615415482186989568::numeric <= 1::numeric then
        return 0::double precision;
    end if;
    return a / b;
end;
$$;
CREATE OR REPLACE FUNCTION public.easel_minus(a double precision, b double precision)
  RETURNS double precision
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
begin
    if a is null or b is null then
        return null;
    end if;
    if abs(a::numeric - b::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric then
        return null;
    end if;
    return a - b;
end;
$$;
CREATE OR REPLACE FUNCTION public.easel_modulo(a double precision, b double precision)
  RETURNS double precision
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
begin
    if a is null or b is null or b = 0::double precision then
        return null;
    end if;
    return a - b * trunc(a / b);
end;
$$;
CREATE OR REPLACE FUNCTION public.easel_plus(a double precision, b double precision)
  RETURNS double precision
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
begin
    if a is null or b is null then
        return null;
    end if;
    if abs(a::numeric + b::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric then
        return null;
    end if;
    return a + b;
end;
$$;
CREATE OR REPLACE FUNCTION public.easel_round(value double precision, digits double precision)
  RETURNS double precision
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
declare
    factor double precision := 1::double precision;
    remaining double precision;
    scaled double precision;
    rounded double precision;
begin
    if value is null or digits is null then
        return null;
    end if;
    if digits = 0::double precision then
        return case when abs(value - trunc(value)) >= 0.5::double precision
            then trunc(value) + sign(value)
            else trunc(value) end;
    end if;
    if abs(digits) >= 309::double precision then
        return null;
    end if;
    remaining := abs(digits);
    while remaining >= 1::double precision loop
        factor := factor * 10::double precision;
        remaining := remaining - 1::double precision;
    end loop;
    if digits > 0::double precision then
        if abs(value::numeric * factor::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric then
            return null;
        end if;
        scaled := value * factor;
        rounded := case when abs(scaled - trunc(scaled)) >= 0.5::double precision
            then trunc(scaled) + sign(scaled)
            else trunc(scaled) end;
        return rounded / factor;
    end if;
    scaled := value / factor;
    rounded := case when abs(scaled - trunc(scaled)) >= 0.5::double precision
        then trunc(scaled) + sign(scaled)
        else trunc(scaled) end;
    if abs(rounded::numeric * factor::numeric) >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric then
        return null;
    end if;
    return rounded * factor;
end;
$$;
CREATE OR REPLACE FUNCTION public.easel_slice(value text, start_at double precision, stop_at double precision)
  RETURNS text
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
declare
    char_count integer;
    from_index integer;
    to_index integer;
begin
    if value is null or start_at is null then
        return null;
    end if;
    char_count := char_length(value);
    from_index := least(greatest(case when start_at < 0::double precision
        then char_count + start_at::integer
        else start_at::integer end, 0), char_count);
    if stop_at is null then
        to_index := char_count;
    else
        to_index := least(greatest(case when stop_at < 0::double precision
            then char_count + stop_at::integer
            else stop_at::integer end, 0), char_count);
    end if;
    return substr(value, from_index + 1, greatest(to_index - from_index, 0));
end;
$$;
CREATE OR REPLACE FUNCTION public.easel_times(a double precision, b double precision)
  RETURNS double precision
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
declare
    magnitude numeric;
begin
    if a is null or b is null then
        return null;
    end if;
    magnitude := abs(a::numeric * b::numeric);
    if magnitude >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric then
        return null;
    end if;
    if magnitude <> 0::numeric
        and magnitude * 404804506614621236704990693437834614099113299528284236713802716054860679135990693783920767402874248990374155728633623822779617474771586953734026799881477019843034848553132722728933815484186432682479535356945490137124014966849385397236206711298319112681620113024717539104666829230461005064372655017292012526615415482186989568::numeric <= 1::numeric then
        return 0::double precision;
    end if;
    return a * b;
end;
$$;
CREATE OR REPLACE FUNCTION public.easel_to_number(value text)
  RETURNS double precision
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
declare
    magnitude numeric;
begin
    if value is null then
        return null;
    end if;
    if lower(btrim(value)) in ('inf', '+inf', '-inf', 'infinity', '+infinity', '-infinity', 'nan', '+nan', '-nan') then
        return null;
    end if;
    magnitude := abs(value::numeric);
    if magnitude >= 179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497792::numeric then
        return null;
    end if;
    if magnitude <> 0::numeric
        and magnitude * 404804506614621236704990693437834614099113299528284236713802716054860679135990693783920767402874248990374155728633623822779617474771586953734026799881477019843034848553132722728933815484186432682479535356945490137124014966849385397236206711298319112681620113024717539104666829230461005064372655017292012526615415482186989568::numeric <= 1::numeric then
        return 0::double precision;
    end if;
    return value::double precision;
end;
$$;
CREATE OR REPLACE FUNCTION public.easel_truthy(value jsonb)
  RETURNS boolean
  LANGUAGE plpgsql
  IMMUTABLE
  PARALLEL SAFE
AS $$
begin
    return case coalesce(jsonb_typeof(value), 'null')
        when 'null' then false
        when 'boolean' then (value #>> '{}') = 'true'
        when 'number' then (value #>> '{}')::double precision <> 0::double precision
        when 'string' then (value #>> '{}') <> ''
        else true
    end;
end;
$$;
DROP TRIGGER IF EXISTS books__tg_c_1p70drudguy ON public.books;
DROP FUNCTION IF EXISTS public.books__tg_c_1p70drudguy();
CREATE OR REPLACE FUNCTION public.books__tg_c_1p70drudguy()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.average_rating := (CASE WHEN COALESCE(((NEW."review_count") > ((0.0)::double precision)), FALSE) THEN easel_round((easel_divide((NEW."rating_total"), (NEW."review_count"))), ((2.0)::double precision)) ELSE (0.0)::double precision END);
  RETURN NEW;
END;
$$;
CREATE TRIGGER books__tg_c_1p70drudguy
  BEFORE INSERT OR UPDATE OF review_count, rating_total ON public.books
  FOR EACH ROW EXECUTE FUNCTION public.books__tg_c_1p70drudguy();
UPDATE books
SET average_rating = ((CASE WHEN COALESCE((("review_count") > ((0.0)::double precision)), FALSE) THEN easel_round((easel_divide(("rating_total"), ("review_count"))), ((2.0)::double precision)) ELSE (0.0)::double precision END));
