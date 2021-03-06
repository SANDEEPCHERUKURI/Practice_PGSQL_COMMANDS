--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: emp_stamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION emp_stamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NEW.empname IS NULL THEN
            RAISE EXCEPTION 'empname cannot be null';
        END IF;
        IF NEW.salary IS NULL THEN
            RAISE EXCEPTION '% cannot have null salary', NEW.empname;
        END IF;

        IF NEW.salary < 0 THEN
            RAISE EXCEPTION '% cannot have a negative salary', NEW.empname;
        END IF;

        
        NEW.last_date := current_timestamp;
        NEW.last_user := current_user;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.emp_stamp() OWNER TO postgres;

--
-- Name: example_cursor(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION example_cursor() RETURNS void
    LANGUAGE plpgsql
    AS $$

declare
cur1 cursor for select * from company;
tst company%ROWTYPE;
begin
open cur1;
fetch cur1 into tst;
loop


RAISE NOTICE 'id %,name %,age %,address %,salary %',
tst.id,tst.name,tst.age,tst.address,tst.salary;
FETCH  cur1 into tst;
EXIT WHEN NOT FOUND;
end loop;
end;
$$;


ALTER FUNCTION public.example_cursor() OWNER TO postgres;

--
-- Name: get_film_titles(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_film_titles(id_no integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE 
 titles TEXT DEFAULT '';
 company   RECORD;
 cur_films CURSOR(id_no INTEGER) 
 FOR SELECT 
 FROM company
 WHERE id = id_no;
BEGIN
   -- Open the cursor
   OPEN cur_films(id_no);
 
   LOOP
    -- fetch row into the film
      FETCH cur_films INTO company;
    -- exit when no more row to fetch
      EXIT WHEN NOT FOUND;
 
    -- build the output
      IF company.name LIKE '%ful%' THEN 
         titles := titles || ',' || company.name || ':' || company.id;
      END IF;
   END LOOP;
  
   -- Close the cursor
   CLOSE cur_films;
 
   RETURN titles;
END; $$;


ALTER FUNCTION public.get_film_titles(id_no integer) OWNER TO postgres;

--
-- Name: minmax(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION minmax(a integer, b integer, c integer, OUT min integer, OUT max integer) RETURNS record
    LANGUAGE plpgsql
    AS $$
begin
min=least(a,b,c);
max=greatest(a,b,c);
end;
$$;


ALTER FUNCTION public.minmax(a integer, b integer, c integer, OUT min integer, OUT max integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE company (
    id integer NOT NULL,
    name text NOT NULL,
    age integer NOT NULL,
    address character(50),
    salary real
);


ALTER TABLE company OWNER TO postgres;

--
-- Name: myfunction(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION myfunction() RETURNS SETOF company
    LANGUAGE plpgsql
    AS $$
DECLARE 
cur CURSOR FOR SELECT * FROM company;
rec company%ROWTYPE;
 BEGIN
 OPEN cur;
 -- RAISE NOTICE 'id,name,age,salary';
loop
FETCH cur INTO rec;
RAISE NOTICE 'id %,name %,age %,salary %',rec.id,rec.name,rec.age,rec.salary;
   if not found then
        exit ;
   end if;
end loop;
RETURN;
END;
$$;


ALTER FUNCTION public.myfunction() OWNER TO postgres;

--
-- Name: sal_inc(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sal_inc(a integer) RETURNS void
    LANGUAGE plpgsql
    AS $$

begin
update company set salary=(salary+1)*(500);
end;
$$;


ALTER FUNCTION public.sal_inc(a integer) OWNER TO postgres;

--
-- Name: sqr(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sqr(INOUT a integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
a=a*a;
end;
$$;


ALTER FUNCTION public.sqr(INOUT a integer) OWNER TO postgres;

--
-- Name: total(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION total() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
total integer;
begin
select count(*) into total from company;
return total;
end;
$$;


ALTER FUNCTION public.total() OWNER TO postgres;

--
-- Name: emp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE emp (
    empname text,
    salary integer,
    last_date timestamp without time zone,
    last_user text
);


ALTER TABLE emp OWNER TO postgres;

--
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE student (
    id text NOT NULL,
    name text NOT NULL,
    age integer NOT NULL
);


ALTER TABLE student OWNER TO postgres;

--
-- Name: sub; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sub (
    sub_id text NOT NULL,
    sub_name text NOT NULL
);


ALTER TABLE sub OWNER TO postgres;

--
-- Name: subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE subjects (
    id text NOT NULL,
    sub_id text NOT NULL,
    sub_marks integer NOT NULL
);


ALTER TABLE subjects OWNER TO postgres;

--
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY company (id, name, age, address, salary) FROM stdin;
1	Paul	32	California                                        	500
2	Allen	25	Texas                                             	500
3	Teddy	23	Norway                                            	500
4	Mark	25	Rich-Mond                                         	500
5	David	27	Texas                                             	500
6	Kim	22	South-Hall                                        	500
7	James	24	Houston                                           	500
\.


--
-- Data for Name: emp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY emp (empname, salary, last_date, last_user) FROM stdin;
sandeep	0	2017-04-20 19:20:37.767003	postgres
saandy	50020	2017-04-20 19:38:42.475528	postgres
\.


--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY student (id, name, age) FROM stdin;
1	Sandeep	23
2	SaiRaj	24
3	Kt	24
4	arun	29
5	puram	27
\.


--
-- Data for Name: sub; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sub (sub_id, sub_name) FROM stdin;
001	maths
002	sci
003	sol
004	eng
005	tel
\.


--
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY subjects (id, sub_id, sub_marks) FROM stdin;
1	001	90
2	002	92
3	003	94
4	004	96
5	005	70
\.


--
-- Name: company company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY company
    ADD CONSTRAINT company_pkey PRIMARY KEY (id);


--
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);


--
-- Name: id_no; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX id_no ON student USING btree (id);


--
-- Name: s_no; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX s_no ON student USING btree (name);


--
-- Name: emp emp_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER emp_stamp BEFORE INSERT OR UPDATE ON emp FOR EACH ROW EXECUTE PROCEDURE emp_stamp();


--
-- PostgreSQL database dump complete
--

