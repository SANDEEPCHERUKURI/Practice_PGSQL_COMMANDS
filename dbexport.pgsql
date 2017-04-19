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
1	Paul	32	California                                        	20000
2	Allen	25	Texas                                             	15000
3	Teddy	23	Norway                                            	20000
4	Mark	25	Rich-Mond                                         	65000
5	David	27	Texas                                             	85000
6	Kim	22	South-Hall                                        	45000
7	James	24	Houston                                           	10000
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
-- PostgreSQL database dump complete
--

