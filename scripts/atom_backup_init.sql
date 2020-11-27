--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
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


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: contract; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.contract (
    contract_id integer NOT NULL,
    contract character varying(250),
    contract_number character varying(50),
    contract_date date,
    project_id integer,
    contractor_id integer,
    contragent_id integer,
    is_finished boolean DEFAULT false,
    amount numeric(12,2),
    file character varying(250)
);


ALTER TABLE public.contract OWNER TO atom;

--
-- Name: contract_contract_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.contract_contract_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contract_contract_id_seq OWNER TO atom;

--
-- Name: contract_contract_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.contract_contract_id_seq OWNED BY public.contract.contract_id;


--
-- Name: contractor; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.contractor (
    contractor_id integer NOT NULL,
    contractor character varying(50)
);


ALTER TABLE public.contractor OWNER TO atom;

--
-- Name: contractor_contractor_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.contractor_contractor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contractor_contractor_id_seq OWNER TO atom;

--
-- Name: contractor_contractor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.contractor_contractor_id_seq OWNED BY public.contractor.contractor_id;


--
-- Name: contragent; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.contragent (
    contragent_id integer NOT NULL,
    contragent character varying(50)
);


ALTER TABLE public.contragent OWNER TO atom;

--
-- Name: contragent_contragent_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.contragent_contragent_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contragent_contragent_id_seq OWNER TO atom;

--
-- Name: contragent_contragent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.contragent_contragent_id_seq OWNED BY public.contragent.contragent_id;


--
-- Name: dev_group; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.dev_group (
    dev_group_id integer NOT NULL,
    dev_group character varying(250)
);


ALTER TABLE public.dev_group OWNER TO atom;

--
-- Name: dev_group_dev_group_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.dev_group_dev_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dev_group_dev_group_id_seq OWNER TO atom;

--
-- Name: dev_group_dev_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.dev_group_dev_group_id_seq OWNED BY public.dev_group.dev_group_id;


--
-- Name: dev_type; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.dev_type (
    dev_type_id integer NOT NULL,
    dev_type character varying(250),
    dev_type_short character varying(10),
    cell_style character varying(120),
    font_style character varying(120),
    cell_border character varying(100),
    cell_bgcolor character varying(100),
    is_personell boolean,
    param_measure character varying(12),
    param_default_value numeric(12,2),
    is_show boolean DEFAULT false,
    dev_group_id integer,
    is_int_param boolean DEFAULT true
);


ALTER TABLE public.dev_type OWNER TO atom;

--
-- Name: dev_type_dev_type_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.dev_type_dev_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dev_type_dev_type_id_seq OWNER TO atom;

--
-- Name: dev_type_dev_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.dev_type_dev_type_id_seq OWNED BY public.dev_type.dev_type_id;


--
-- Name: developments; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.developments (
    developments_id integer NOT NULL,
    personell_id integer,
    dev_date date,
    subject_id integer,
    dev_type_id integer,
    param numeric(12,2)
);


ALTER TABLE public.developments OWNER TO atom;

--
-- Name: developments_developments_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.developments_developments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.developments_developments_id_seq OWNER TO atom;

--
-- Name: developments_developments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.developments_developments_id_seq OWNED BY public.developments.developments_id;


--
-- Name: estimate; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.estimate (
    estimate_id integer NOT NULL,
    contract_id integer,
    specification_id integer,
    goods_id integer,
    amount numeric(12,3),
    price_goods numeric(12,2),
    price_job numeric(12,2)
);


ALTER TABLE public.estimate OWNER TO atom;

--
-- Name: estimate_estimate_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.estimate_estimate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estimate_estimate_id_seq OWNER TO atom;

--
-- Name: estimate_estimate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.estimate_estimate_id_seq OWNED BY public.estimate.estimate_id;


--
-- Name: goods; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.goods (
    goods_id integer NOT NULL,
    goods character varying(250),
    measure_id integer,
    art character varying(50),
    code character varying(50)
);


ALTER TABLE public.goods OWNER TO atom;

--
-- Name: goods_goods_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.goods_goods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goods_goods_id_seq OWNER TO atom;

--
-- Name: goods_goods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.goods_goods_id_seq OWNED BY public.goods.goods_id;


--
-- Name: measure; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.measure (
    measure_id integer NOT NULL,
    measure character varying(50),
    measure_short character varying(15)
);


ALTER TABLE public.measure OWNER TO atom;

--
-- Name: measure_measure_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.measure_measure_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.measure_measure_id_seq OWNER TO atom;

--
-- Name: measure_measure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.measure_measure_id_seq OWNED BY public.measure.measure_id;


--
-- Name: module_role; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.module_role (
    module_role_id integer NOT NULL,
    module_id integer,
    role_id integer
);


ALTER TABLE public.module_role OWNER TO atom;

--
-- Name: module_role_module_role_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.module_role_module_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.module_role_module_role_id_seq OWNER TO atom;

--
-- Name: module_role_module_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.module_role_module_role_id_seq OWNED BY public.module_role.module_role_id;


--
-- Name: modules; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.modules (
    module_id integer NOT NULL,
    module_name character varying(64),
    module_file_name character varying(64),
    module_title character varying(64),
    module_icon character varying(64)
);


ALTER TABLE public.modules OWNER TO atom;

--
-- Name: modules_module_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.modules_module_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.modules_module_id_seq OWNER TO atom;

--
-- Name: modules_module_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.modules_module_id_seq OWNED BY public.modules.module_id;


--
-- Name: personell; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.personell (
    personell_id integer NOT NULL,
    p_name character varying(100),
    p_patronymic character varying(100),
    p_surname character varying(100),
    role_id integer,
    personell_id_barcode character(48),
    p_login character varying(30),
    p_passwd character varying(32),
    male boolean DEFAULT true,
    create_date timestamp without time zone DEFAULT now(),
    update_date timestamp without time zone,
    birthday date,
    create_personell_id integer,
    update_personell_id integer,
    address character varying(150),
    email character varying(100),
    photo character varying(255),
    active boolean DEFAULT true
);


ALTER TABLE public.personell OWNER TO atom;

--
-- Name: personell_personell_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.personell_personell_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personell_personell_id_seq OWNER TO atom;

--
-- Name: personell_personell_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.personell_personell_id_seq OWNED BY public.personell.personell_id;


--
-- Name: project; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.project (
    project_id integer NOT NULL,
    project character varying(250),
    subject_id integer,
    is_finished boolean DEFAULT false
);


ALTER TABLE public.project OWNER TO atom;

--
-- Name: project_project_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.project_project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_project_id_seq OWNER TO atom;

--
-- Name: project_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.project_project_id_seq OWNED BY public.project.project_id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.roles (
    role_id integer NOT NULL,
    role_name character varying(64),
    role_alias character varying(64)
);


ALTER TABLE public.roles OWNER TO atom;

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_role_id_seq OWNER TO atom;

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


--
-- Name: specification; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.specification (
    specification_id integer NOT NULL,
    project_id integer,
    goods_id integer,
    is_ordered boolean DEFAULT false,
    is_finished boolean DEFAULT false,
    amount numeric(12,3)
);


ALTER TABLE public.specification OWNER TO atom;

--
-- Name: specification_specification_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.specification_specification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.specification_specification_id_seq OWNER TO atom;

--
-- Name: specification_specification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.specification_specification_id_seq OWNED BY public.specification.specification_id;


--
-- Name: subject; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.subject (
    subject_id integer NOT NULL,
    subject character varying(250),
    adress character varying(250)
);


ALTER TABLE public.subject OWNER TO atom;

--
-- Name: subject_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.subject_subject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subject_subject_id_seq OWNER TO atom;

--
-- Name: subject_subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.subject_subject_id_seq OWNED BY public.subject.subject_id;


--
-- Name: unit; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.unit (
    unit_id integer NOT NULL,
    unit character varying(100),
    post character varying(100),
    p_unit_id integer,
    personell_id integer,
    terminal_bool boolean DEFAULT true,
    itr boolean,
    active boolean DEFAULT false
);


ALTER TABLE public.unit OWNER TO atom;

--
-- Name: unit_unit_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.unit_unit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unit_unit_id_seq OWNER TO atom;

--
-- Name: unit_unit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.unit_unit_id_seq OWNED BY public.unit.unit_id;


--
-- Name: work_plan; Type: TABLE; Schema: public; Owner: atom
--

CREATE TABLE public.work_plan (
    work_plan_id integer NOT NULL,
    personell_id integer,
    work_date date,
    subject_id integer
);


ALTER TABLE public.work_plan OWNER TO atom;

--
-- Name: work_plan_work_plan_id_seq; Type: SEQUENCE; Schema: public; Owner: atom
--

CREATE SEQUENCE public.work_plan_work_plan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_plan_work_plan_id_seq OWNER TO atom;

--
-- Name: work_plan_work_plan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atom
--

ALTER SEQUENCE public.work_plan_work_plan_id_seq OWNED BY public.work_plan.work_plan_id;


--
-- Name: contract contract_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.contract ALTER COLUMN contract_id SET DEFAULT nextval('public.contract_contract_id_seq'::regclass);


--
-- Name: contractor contractor_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.contractor ALTER COLUMN contractor_id SET DEFAULT nextval('public.contractor_contractor_id_seq'::regclass);


--
-- Name: contragent contragent_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.contragent ALTER COLUMN contragent_id SET DEFAULT nextval('public.contragent_contragent_id_seq'::regclass);


--
-- Name: dev_group dev_group_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.dev_group ALTER COLUMN dev_group_id SET DEFAULT nextval('public.dev_group_dev_group_id_seq'::regclass);


--
-- Name: dev_type dev_type_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.dev_type ALTER COLUMN dev_type_id SET DEFAULT nextval('public.dev_type_dev_type_id_seq'::regclass);


--
-- Name: developments developments_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.developments ALTER COLUMN developments_id SET DEFAULT nextval('public.developments_developments_id_seq'::regclass);


--
-- Name: estimate estimate_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.estimate ALTER COLUMN estimate_id SET DEFAULT nextval('public.estimate_estimate_id_seq'::regclass);


--
-- Name: goods goods_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.goods ALTER COLUMN goods_id SET DEFAULT nextval('public.goods_goods_id_seq'::regclass);


--
-- Name: measure measure_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.measure ALTER COLUMN measure_id SET DEFAULT nextval('public.measure_measure_id_seq'::regclass);


--
-- Name: module_role module_role_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.module_role ALTER COLUMN module_role_id SET DEFAULT nextval('public.module_role_module_role_id_seq'::regclass);


--
-- Name: modules module_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.modules ALTER COLUMN module_id SET DEFAULT nextval('public.modules_module_id_seq'::regclass);


--
-- Name: personell personell_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.personell ALTER COLUMN personell_id SET DEFAULT nextval('public.personell_personell_id_seq'::regclass);


--
-- Name: project project_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.project ALTER COLUMN project_id SET DEFAULT nextval('public.project_project_id_seq'::regclass);


--
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);


--
-- Name: specification specification_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.specification ALTER COLUMN specification_id SET DEFAULT nextval('public.specification_specification_id_seq'::regclass);


--
-- Name: subject subject_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.subject ALTER COLUMN subject_id SET DEFAULT nextval('public.subject_subject_id_seq'::regclass);


--
-- Name: unit unit_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.unit ALTER COLUMN unit_id SET DEFAULT nextval('public.unit_unit_id_seq'::regclass);


--
-- Name: work_plan work_plan_id; Type: DEFAULT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.work_plan ALTER COLUMN work_plan_id SET DEFAULT nextval('public.work_plan_work_plan_id_seq'::regclass);


--
-- Data for Name: contract; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.contract (contract_id, contract, contract_number, contract_date, project_id, contractor_id, contragent_id, is_finished, amount, file) FROM stdin;
1	Разработка проектов систем сильных и слабых токов Бассейна	\N	\N	4	1	1	f	477278.45	\N
2	Монтаж СКС  "Бассейн" 	\N	\N	2	1	1	f	3091534.76	\N
3	Монтаж  системы телевидения "Бассейн"	\N	\N	3	1	1	f	233179.00	\N
4	Монтаж электропроводки для розеток и освещения 0, 1-го, 2-го и технического этажей	\N	\N	5	1	1	f	6693630.11	\N
5	Подогрев 1-го и 2-го этажей	\N	\N	5	1	1	f	577343.27	\N
6	Подогрев	\N	\N	5	2	1	f	453428.78	\N
7	Монтаж этажных щитов	\N	\N	5	3	1	f	2027252.18	\N
8	Монтаж магистрального лотка и силовых кабелей	\N	\N	5	3	1	f	2320041.03	\N
9	Монтаж  ВРУ бассейна	\N	\N	5	1	1	f	3255905.42	\N
10	Заземление и уравнивание потенциалов внутри здания	\N	\N	5	2	1	f	1066677.15	\N
\.


--
-- Data for Name: contractor; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.contractor (contractor_id, contractor) FROM stdin;
1	ООО проВидец
2	ИП Волков
3	ИП Щукин
\.


--
-- Data for Name: contragent; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.contragent (contragent_id, contragent) FROM stdin;
1	МТ-Стандарт
\.


--
-- Data for Name: dev_group; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.dev_group (dev_group_id, dev_group) FROM stdin;
\.


--
-- Data for Name: dev_type; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.dev_type (dev_type_id, dev_type, dev_type_short, cell_style, font_style, cell_border, cell_bgcolor, is_personell, param_measure, param_default_value, is_show, dev_group_id, is_int_param) FROM stdin;
3	Отгул	Ог		color:blue;	\N	\N	f	\N	\N	f	\N	t
2	Отпуск	О		color:#66CDAA;	\N	\N	f	\N	\N	f	\N	t
6	Пожелания	\N	\N	\N	1px solid RGB(255, 127, 80)	\N	t	\N	\N	f	\N	t
5	План		RGBA(240, 230, 140, 0.5)	\N	\N	RGBA(240, 230, 140, 0.5)	f	\N	\N	f	\N	t
4	Командировочные	₽	\N	color: DarkRed;font-weight:bold;	\N	\N	f	руб	500.00	f	\N	t
7	Выходной	в	\N	\N	\N	\N	\N	\N	\N	f	\N	t
1	Явка	Я		color:black;	\N	\N	f	час	8.00	t	\N	t
\.


--
-- Data for Name: developments; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.developments (developments_id, personell_id, dev_date, subject_id, dev_type_id, param) FROM stdin;
46	8	2020-11-04	3	5	\N
47	8	2020-11-05	3	5	\N
48	8	2020-11-06	3	5	\N
49	8	2020-11-07	3	5	\N
50	8	2020-11-08	3	5	\N
51	8	2020-11-09	3	5	\N
52	8	2020-11-10	3	5	\N
53	8	2020-11-11	3	5	\N
54	8	2020-11-12	3	5	\N
55	8	2020-11-13	3	5	\N
56	8	2020-11-14	3	5	\N
57	8	2020-11-15	3	5	\N
58	8	2020-11-16	3	5	\N
59	8	2020-11-17	3	5	\N
60	8	2020-11-18	3	5	\N
61	8	2020-11-19	3	5	\N
62	8	2020-11-20	3	5	\N
63	8	2020-11-21	3	5	\N
64	9	2020-11-01	3	5	\N
65	9	2020-11-02	3	5	\N
66	9	2020-11-03	3	5	\N
67	9	2020-11-04	3	5	\N
68	9	2020-11-05	3	5	\N
69	9	2020-11-06	3	5	\N
70	9	2020-11-07	3	5	\N
71	9	2020-11-14	3	5	\N
72	9	2020-11-15	3	5	\N
73	9	2020-11-16	3	5	\N
74	9	2020-11-17	3	5	\N
75	9	2020-11-18	3	5	\N
76	9	2020-11-19	3	5	\N
77	9	2020-11-20	3	5	\N
78	9	2020-11-21	3	5	\N
79	9	2020-11-22	3	5	\N
80	9	2020-11-23	3	5	\N
81	9	2020-11-24	3	5	\N
82	9	2020-11-25	3	5	\N
83	9	2020-11-26	3	5	\N
84	9	2020-11-27	3	5	\N
85	9	2020-11-28	3	5	\N
86	9	2020-11-29	3	5	\N
87	9	2020-11-30	3	5	\N
88	10	2020-11-01	3	5	\N
89	10	2020-11-02	3	5	\N
90	10	2020-11-03	3	5	\N
91	10	2020-11-04	3	5	\N
92	10	2020-11-05	3	5	\N
93	10	2020-11-06	3	5	\N
94	10	2020-11-07	3	5	\N
95	10	2020-11-14	3	5	\N
96	10	2020-11-15	3	5	\N
97	10	2020-11-16	3	5	\N
98	10	2020-11-17	3	5	\N
99	10	2020-11-18	3	5	\N
100	10	2020-11-19	3	5	\N
101	10	2020-11-20	3	5	\N
102	10	2020-11-21	3	5	\N
103	10	2020-11-22	3	5	\N
104	10	2020-11-23	3	5	\N
105	10	2020-11-24	3	5	\N
106	10	2020-11-25	3	5	\N
107	10	2020-11-26	3	5	\N
108	10	2020-11-27	3	5	\N
109	10	2020-11-28	3	5	\N
110	10	2020-11-29	3	5	\N
111	10	2020-11-30	3	5	\N
112	11	2020-11-01	3	5	\N
113	11	2020-11-02	3	5	\N
114	11	2020-11-03	3	5	\N
115	11	2020-11-04	3	5	\N
116	11	2020-11-05	3	5	\N
117	11	2020-11-06	3	5	\N
118	11	2020-11-07	3	5	\N
119	11	2020-11-14	3	5	\N
120	11	2020-11-15	3	5	\N
121	11	2020-11-16	3	5	\N
122	11	2020-11-17	3	5	\N
123	11	2020-11-18	3	5	\N
124	11	2020-11-19	3	5	\N
125	11	2020-11-20	3	5	\N
126	11	2020-11-21	3	5	\N
127	11	2020-11-22	3	5	\N
128	11	2020-11-24	3	5	\N
129	11	2020-11-23	3	5	\N
130	11	2020-11-25	3	5	\N
131	11	2020-11-26	3	5	\N
135	11	2020-11-30	3	5	\N
136	12	2020-11-08	3	5	\N
137	12	2020-11-09	3	5	\N
138	12	2020-11-10	3	5	\N
139	12	2020-11-11	3	5	\N
140	12	2020-11-12	3	5	\N
141	12	2020-11-13	3	5	\N
142	12	2020-11-14	3	5	\N
143	12	2020-11-15	3	5	\N
144	12	2020-11-16	3	5	\N
145	12	2020-11-17	3	5	\N
146	12	2020-11-18	3	5	\N
147	12	2020-11-19	3	5	\N
148	12	2020-11-20	3	5	\N
149	12	2020-11-21	3	5	\N
150	12	2020-11-22	3	5	\N
151	12	2020-11-23	3	5	\N
152	12	2020-11-24	3	5	\N
153	12	2020-11-25	3	5	\N
154	12	2020-11-26	3	5	\N
155	12	2020-11-27	3	5	\N
156	12	2020-11-28	3	5	\N
157	13	2020-11-01	3	5	\N
42	7	2020-11-01	3	1	8.00
158	13	2020-11-02	3	5	\N
159	13	2020-11-15	3	5	\N
160	13	2020-11-14	3	5	\N
161	13	2020-11-13	3	5	\N
162	13	2020-11-12	3	5	\N
163	13	2020-11-11	3	5	\N
164	13	2020-11-10	3	5	\N
165	13	2020-11-09	3	5	\N
166	13	2020-11-08	3	5	\N
167	13	2020-11-07	3	5	\N
168	13	2020-11-06	3	5	\N
169	13	2020-11-05	3	5	\N
170	13	2020-11-04	3	5	\N
171	13	2020-11-03	3	5	\N
172	13	2020-11-21	3	5	\N
173	13	2020-11-22	3	5	\N
174	13	2020-11-23	3	5	\N
175	13	2020-11-24	3	5	\N
176	13	2020-11-25	3	5	\N
177	13	2020-11-26	3	5	\N
178	13	2020-11-27	3	5	\N
179	13	2020-11-28	3	5	\N
180	13	2020-11-29	3	5	\N
181	13	2020-11-30	3	5	\N
182	14	2020-11-01	3	5	\N
183	14	2020-11-02	3	5	\N
184	14	2020-11-03	3	5	\N
185	14	2020-11-04	3	5	\N
186	14	2020-11-05	3	5	\N
187	14	2020-11-06	3	5	\N
188	14	2020-11-07	3	5	\N
189	14	2020-11-08	3	5	\N
190	14	2020-11-09	3	5	\N
191	14	2020-11-10	3	5	\N
192	14	2020-11-12	3	5	\N
193	14	2020-11-13	3	5	\N
194	14	2020-11-14	3	5	\N
195	14	2020-11-15	3	5	\N
196	14	2020-11-11	3	5	\N
197	14	2020-11-21	3	5	\N
198	14	2020-11-22	3	5	\N
199	14	2020-11-23	3	5	\N
200	14	2020-11-24	3	5	\N
201	14	2020-11-25	3	5	\N
202	14	2020-11-26	3	5	\N
203	14	2020-11-27	3	5	\N
204	14	2020-11-28	3	5	\N
205	14	2020-11-29	3	5	\N
206	14	2020-11-30	3	5	\N
207	15	2020-11-01	3	5	\N
208	15	2020-11-02	3	5	\N
209	15	2020-11-03	3	5	\N
210	15	2020-11-04	3	5	\N
211	15	2020-11-05	3	5	\N
212	15	2020-11-06	3	5	\N
213	15	2020-11-07	3	5	\N
214	15	2020-11-08	3	5	\N
215	15	2020-11-09	3	5	\N
216	15	2020-11-10	3	5	\N
217	15	2020-11-11	3	5	\N
218	15	2020-11-12	3	5	\N
219	15	2020-11-14	3	5	\N
220	15	2020-11-15	3	5	\N
221	15	2020-11-13	3	5	\N
222	15	2020-11-21	3	5	\N
223	15	2020-11-22	3	5	\N
224	15	2020-11-23	3	5	\N
226	15	2020-11-24	3	5	\N
227	15	2020-11-25	3	5	\N
228	15	2020-11-26	3	5	\N
229	15	2020-11-27	3	5	\N
230	15	2020-11-28	3	5	\N
231	15	2020-11-29	3	5	\N
232	15	2020-11-30	3	5	\N
257	9	2020-11-01	3	1	8.00
258	9	2020-11-02	3	1	8.00
259	9	2020-11-03	3	1	8.00
260	9	2020-11-04	3	1	8.00
261	9	2020-11-05	3	1	8.00
262	10	2020-11-01	3	1	8.00
263	10	2020-11-02	3	1	8.00
264	10	2020-11-03	3	1	8.00
265	10	2020-11-04	3	1	8.00
266	10	2020-11-05	3	1	8.00
267	15	2020-11-01	3	1	8.00
268	15	2020-11-02	3	1	8.00
269	15	2020-11-03	3	1	8.00
270	15	2020-11-04	3	1	8.00
271	15	2020-11-05	3	1	8.00
272	14	2020-11-01	3	1	8.00
273	14	2020-11-02	3	1	8.00
274	14	2020-11-03	3	1	8.00
275	14	2020-11-04	3	1	8.00
276	14	2020-11-05	3	1	8.00
277	13	2020-11-01	3	1	8.00
278	13	2020-11-02	3	1	8.00
279	13	2020-11-03	3	1	8.00
280	13	2020-11-04	3	1	8.00
281	13	2020-11-05	3	1	8.00
282	8	2020-11-01	3	1	8.00
283	8	2020-11-02	3	1	8.00
284	8	2020-11-03	3	1	8.00
285	8	2020-11-04	3	1	8.00
286	8	2020-11-05	3	1	8.00
287	11	2020-11-01	3	1	8.00
288	11	2020-11-02	3	1	8.00
295	1	2020-11-01	3	1	8.00
296	1	2020-11-02	3	1	8.00
297	1	2020-11-03	3	1	8.00
233	7	2020-11-01	3	4	500.00
234	9	2020-11-01	3	4	500.00
235	9	2020-11-02	3	4	500.00
236	9	2020-11-03	3	4	500.00
237	8	2020-11-01	3	4	500.00
238	8	2020-11-02	3	4	500.00
239	8	2020-11-03	3	4	500.00
240	10	2020-11-01	3	4	500.00
241	10	2020-11-02	3	4	500.00
242	10	2020-11-03	3	4	500.00
243	13	2020-11-01	3	4	500.00
244	13	2020-11-02	3	4	500.00
245	11	2020-11-01	3	4	500.00
246	11	2020-11-02	3	4	500.00
247	11	2020-11-03	3	4	500.00
248	11	2020-11-04	3	4	500.00
249	15	2020-11-01	3	4	500.00
250	15	2020-11-02	3	4	500.00
251	15	2020-11-03	3	4	500.00
252	15	2020-11-04	3	4	500.00
253	14	2020-11-01	3	4	500.00
254	14	2020-11-02	3	4	500.00
255	14	2020-11-03	3	4	500.00
256	14	2020-11-04	3	4	500.00
302	7	2020-11-06	3	4	500.00
303	7	2020-11-07	3	4	500.00
304	7	2020-11-08	3	4	500.00
305	7	2020-11-09	3	4	500.00
306	7	2020-11-10	3	4	500.00
307	7	2020-11-11	3	4	500.00
308	7	2020-11-12	3	4	500.00
309	7	2020-11-13	3	4	500.00
310	7	2020-11-14	3	4	500.00
311	7	2020-11-15	3	4	500.00
312	7	2020-11-16	3	4	500.00
313	7	2020-11-17	3	4	500.00
314	7	2020-11-18	3	4	500.00
315	7	2020-11-19	3	4	500.00
316	7	2020-11-20	3	4	500.00
317	7	2020-11-21	3	4	500.00
318	7	2020-11-22	3	4	500.00
319	7	2020-11-23	3	4	500.00
320	7	2020-11-24	3	4	500.00
321	7	2020-11-25	3	4	507.00
298	1	2020-11-04	3	1	8.00
299	1	2020-11-05	3	1	8.00
300	4	2020-11-03	3	1	8.00
301	4	2020-11-04	3	1	8.00
324	9	2020-11-06	3	1	8.00
325	10	2020-11-06	3	1	8.00
326	7	2020-11-06	3	1	8.00
327	14	2020-11-06	3	1	8.00
328	13	2020-11-06	3	1	8.00
329	1	2020-11-06	3	1	8.00
330	8	2020-11-06	3	1	8.00
331	15	2020-11-06	3	1	\N
332	9	2020-11-04	3	4	\N
333	9	2020-11-05	3	4	\N
334	9	2020-11-06	3	4	\N
335	9	2020-11-07	3	4	\N
336	10	2020-11-04	3	4	\N
337	10	2020-11-05	3	4	\N
338	10	2020-11-06	3	4	\N
339	10	2020-11-07	3	4	\N
340	15	2020-11-05	3	4	\N
341	15	2020-11-06	3	4	\N
342	15	2020-11-07	3	4	\N
343	15	2020-11-08	3	4	\N
344	15	2020-11-09	3	4	\N
345	15	2020-11-10	3	4	\N
346	15	2020-11-11	3	4	\N
347	15	2020-11-12	3	4	\N
348	15	2020-11-13	3	4	\N
349	15	2020-11-14	3	4	\N
350	14	2020-11-05	3	4	\N
351	14	2020-11-06	3	4	\N
352	14	2020-11-07	3	4	\N
353	14	2020-11-08	3	4	\N
354	14	2020-11-09	3	4	\N
355	14	2020-11-10	3	4	\N
356	14	2020-11-11	3	4	\N
357	14	2020-11-12	3	4	\N
358	14	2020-11-13	3	4	\N
359	14	2020-11-14	3	4	\N
360	16	2020-11-04	3	4	\N
361	16	2020-11-03	3	4	\N
362	16	2020-11-02	3	4	\N
363	16	2020-11-01	3	4	\N
364	16	2020-11-14	3	4	\N
365	16	2020-11-13	3	4	\N
366	16	2020-11-12	3	4	\N
367	16	2020-11-11	3	4	\N
368	16	2020-11-10	3	4	\N
369	16	2020-11-09	3	4	\N
370	16	2020-11-08	3	4	\N
371	16	2020-11-07	3	4	\N
372	16	2020-11-06	3	4	\N
373	16	2020-11-05	3	4	\N
374	8	2020-11-04	3	4	\N
375	8	2020-11-05	3	4	\N
376	8	2020-11-06	3	4	\N
377	8	2020-11-07	3	4	\N
378	8	2020-11-08	3	4	\N
379	8	2020-11-09	3	4	\N
380	8	2020-11-10	3	4	\N
381	8	2020-11-11	3	4	\N
382	8	2020-11-12	3	4	\N
383	8	2020-11-13	3	4	\N
384	8	2020-11-14	3	4	\N
385	13	2020-11-03	3	4	\N
386	13	2020-11-04	3	4	\N
387	13	2020-11-05	3	4	\N
388	13	2020-11-06	3	4	\N
389	13	2020-11-07	3	4	\N
390	13	2020-11-08	3	4	\N
391	13	2020-11-09	3	4	\N
392	13	2020-11-10	3	4	\N
393	13	2020-11-11	3	4	\N
394	13	2020-11-12	3	4	\N
395	13	2020-11-13	3	4	\N
396	13	2020-11-14	3	4	\N
397	9	2020-11-07	3	1	\N
398	10	2020-11-07	3	1	\N
399	7	2020-11-07	3	1	\N
400	14	2020-11-07	3	1	\N
401	13	2020-11-07	3	1	\N
402	1	2020-11-07	3	1	\N
403	8	2020-11-07	3	1	\N
404	16	2020-11-01	3	1	\N
405	16	2020-11-02	3	1	\N
406	16	2020-11-03	3	1	\N
407	16	2020-11-04	3	1	\N
408	16	2020-11-05	3	1	\N
409	16	2020-11-06	3	1	\N
410	16	2020-11-07	3	1	\N
411	4	2020-11-21	4	5	6.00
412	4	2020-11-22	4	5	6.00
413	4	2020-11-23	4	5	6.00
414	4	2020-11-24	4	5	6.00
415	4	2020-11-25	4	5	6.00
416	4	2020-11-26	4	5	6.00
417	4	2020-11-27	4	5	6.00
418	4	2020-11-28	4	5	6.00
419	3	2020-11-21	4	5	6.00
420	3	2020-11-22	4	5	6.00
421	3	2020-11-23	4	5	6.00
422	3	2020-11-24	4	5	6.00
423	3	2020-11-25	4	5	6.00
424	3	2020-11-26	4	5	6.00
425	3	2020-11-27	4	5	6.00
426	3	2020-11-28	4	5	6.00
433	3	2020-11-18	4	1	8.00
436	4	2020-11-18	4	1	8.00
438	15	2020-11-07	3	1	4.00
439	7	2020-11-08	3	1	8.00
440	14	2020-11-08	3	1	8.00
441	13	2020-11-08	3	1	8.00
442	1	2020-11-08	3	1	8.00
443	16	2020-11-08	3	1	8.00
444	8	2020-11-08	3	1	8.00
445	10	2020-11-08	3	7	\N
446	12	2020-11-08	3	1	8.00
447	12	2020-11-07	3	7	\N
448	9	2020-11-08	3	7	\N
449	12	2020-11-01	3	7	\N
450	12	2020-11-02	3	7	\N
451	12	2020-11-03	3	7	\N
452	12	2020-11-04	3	7	\N
453	12	2020-11-05	3	7	\N
454	12	2020-11-06	3	7	\N
455	7	2020-11-02	3	7	\N
456	7	2020-11-03	3	7	\N
457	7	2020-11-04	3	7	\N
469	7	2020-10-31	3	1	8.00
470	9	2020-10-31	3	1	8.00
471	10	2020-10-31	3	1	8.00
472	13	2020-10-31	3	1	8.00
473	14	2020-10-31	3	1	8.00
474	15	2020-10-31	3	1	8.00
475	16	2020-10-31	3	1	8.00
432	3	2020-11-17	4	1	10.00
476	3	2020-11-18	4	5	8.00
477	11	2020-10-31	3	1	8.00
490	7	2020-10-26	3	1	8.00
491	9	2020-10-26	3	1	8.00
492	10	2020-10-26	3	1	8.00
493	13	2020-10-26	3	1	8.00
494	14	2020-10-26	3	1	8.00
479	1	2020-10-30	3	1	8.00
495	15	2020-10-26	3	1	8.00
496	16	2020-10-26	3	1	8.00
497	11	2020-10-26	3	1	8.00
498	12	2020-10-26	3	1	8.00
499	1	2020-10-26	3	1	8.00
500	7	2020-10-27	3	1	8.00
501	9	2020-10-27	3	1	8.00
502	10	2020-10-27	3	1	8.00
503	13	2020-10-27	3	1	8.00
504	14	2020-10-27	3	1	8.00
505	15	2020-10-27	3	1	8.00
506	16	2020-10-27	3	1	8.00
507	11	2020-10-27	3	1	8.00
508	12	2020-10-27	3	1	8.00
509	1	2020-10-27	3	1	8.00
510	7	2020-10-28	3	1	8.00
511	9	2020-10-28	3	1	8.00
512	10	2020-10-28	3	1	8.00
513	13	2020-10-28	3	1	8.00
514	14	2020-10-28	3	1	8.00
515	15	2020-10-28	3	1	8.00
516	16	2020-10-28	3	1	8.00
517	11	2020-10-28	3	1	8.00
518	12	2020-10-28	3	1	8.00
519	1	2020-10-28	3	1	8.00
520	7	2020-10-29	3	1	8.00
521	9	2020-10-29	3	1	8.00
522	10	2020-10-29	3	1	8.00
523	13	2020-10-29	3	1	8.00
524	14	2020-10-29	3	1	8.00
525	15	2020-10-29	3	1	8.00
526	16	2020-10-29	3	1	8.00
527	11	2020-10-29	3	1	8.00
528	12	2020-10-29	3	1	8.00
529	1	2020-10-29	3	1	8.00
530	7	2020-10-30	3	1	8.00
531	9	2020-10-30	3	1	8.00
532	10	2020-10-30	3	1	8.00
533	13	2020-10-30	3	1	8.00
534	14	2020-10-30	3	1	8.00
535	15	2020-10-30	3	1	8.00
536	16	2020-10-30	3	1	8.00
537	11	2020-10-30	3	1	8.00
538	12	2020-10-30	3	1	8.00
539	7	2020-10-25	3	1	8.00
540	9	2020-10-25	3	1	8.00
541	10	2020-10-25	3	1	8.00
542	13	2020-10-25	3	1	8.00
543	14	2020-10-25	3	1	8.00
544	15	2020-10-25	3	1	8.00
545	16	2020-10-25	3	1	8.00
546	11	2020-10-25	3	1	8.00
547	12	2020-10-25	3	1	8.00
548	1	2020-10-25	3	1	8.00
549	4	2020-11-15	4	1	8.00
550	3	2020-11-15	4	1	8.00
551	7	2020-10-24	3	1	8.00
552	9	2020-10-24	3	1	8.00
553	10	2020-10-24	3	1	8.00
554	13	2020-10-24	3	1	8.00
555	11	2020-10-24	3	1	8.00
556	12	2020-10-24	3	1	8.00
557	1	2020-10-24	3	1	8.00
558	12	2020-10-31	3	1	8.00
\.


--
-- Data for Name: estimate; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.estimate (estimate_id, contract_id, specification_id, goods_id, amount, price_goods, price_job) FROM stdin;
39	2	\N	101	8540.000	74.70	\N
40	2	\N	67	3900.000	\N	50.00
41	2	\N	103	4640.000	\N	150.00
42	2	\N	104	300.000	10.60	\N
43	2	\N	105	100.000	17.00	\N
44	2	\N	106	25.000	24.20	\N
45	2	\N	107	20.000	32.80	\N
46	2	\N	108	270.000	51.80	\N
47	2	\N	109	750.000	3.20	\N
48	2	\N	110	250.000	4.16	\N
49	2	\N	111	62.000	6.11	\N
50	2	\N	112	50.000	14.12	\N
51	2	\N	113	270.000	\N	50.00
52	2	\N	114	270.000	39.24	\N
53	2	\N	115	120.000	\N	350.00
54	2	\N	26	6.000	2000.00	\N
55	2	\N	117	144.000	495.00	\N
56	2	\N	118	70.000	\N	500.00
57	2	\N	117	70.000	495.00	\N
58	2	\N	120	50.000	\N	0.00
59	2	\N	121	1.000	2044.00	\N
60	2	\N	122	1.000	5500.00	\N
61	2	\N	123	1.000	58677.00	\N
62	2	\N	124	2.000	2298.00	\N
63	2	\N	125	7.000	762.00	\N
64	2	\N	126	2.000	4741.00	\N
65	2	\N	127	1.000	2748.00	\N
66	2	\N	128	2.000	3842.00	\N
67	2	\N	63	340.000	\N	150.00
68	2	\N	22	300.000	91.50	\N
69	2	\N	15	340.000	39.23	\N
70	2	\N	132	24.000	\N	600.00
71	2	\N	115	48.000	\N	250.00
72	2	\N	134	3.000	13003.00	\N
73	2	\N	135	3.000	2943.00	\N
74	2	\N	136	4.000	19100.00	\N
75	2	\N	137	4.000	8000.00	\N
76	2	\N	138	3.000	39.00	\N
77	2	\N	139	4.000	2780.00	\N
78	2	\N	140	24.000	110.00	\N
\.


--
-- Data for Name: goods; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.goods (goods_id, goods, measure_id, art, code) FROM stdin;
101	Кабель на основе витой пары Cat.6A, U/UTP, 4 пары, не содержит галогенов, LSHF, 305 м (цена за 1 м)	\N	\N	\N
67	Прокладка кабеля UTP, Cat.6A по лотку	\N	\N	\N
103	Прокладка кабеля UTP, Cat.6A в гофротрубе по стенам и потолкам	\N	\N	\N
104	Труба гофрированная ПВХ 20 мм с протяжкой легкая серая (100м)	\N	\N	\N
105	Труба гофрированная ПВХ 25 мм с протяжкой легкая серая (50м)	\N	\N	\N
106	Труба гофрированная ПВХ 32 мм с протяжкой легкая серая (25м)	\N	\N	\N
107	Труба гофрированная ПВХ 40 мм с протяжкой легкая серая (20м)	\N	\N	\N
108	Труба гофрированная ПВХ 50 мм с протяжкой легкая серая (30м)	\N	\N	\N
109	Держатель с защелкой 20 мм для труб	\N	\N	\N
110	Держатель с защелкой 25 мм для труб	\N	\N	\N
111	Держатель с защелкой 32 мм для труб	\N	\N	\N
112	Держатель с защелкой 40 мм для труб	\N	\N	\N
113	Прокладка кабеля ИКБ-Т-А8-6,0 по лотку	\N	\N	\N
14	Кабель  UTP, Cat.6A	4	BC6-4GY	BC6-4GY
16	Лоток перфорированный 200х80х3000мм DKC/S5 Combitech	4	35304ZL	35304ZL
17	Лоток 100х80х3000мм DKC/S5 Combitech	4	35302HDZ	35302HDZ
18	Труба гофрированная ПВХ 20 мм	4	91920	91920
19	Труба гофрированная ПВХ 25 мм с протяжкой легкая серая	4	91925	91925
20	Труба гофрированная ПВХ 32	4	91932	91932
21	Труба гофрированная ПВХ 40 мм	4	91940	91940
23	Держатель с защелкой 20 мм для труб (51020)	1	51020	51020
24	Держатель с защелкой 40 мм для труб (51020)	1	51040	51040
25	Держатель с защелкой 32 мм для труб (51020)	1	51032	51032
27	Розеточный модуль типа Keystone Cat.6A,	1	KJ458-C6A	KJ458-C6A
28	Розетка RJ45 двухмодульная	1		
29	Коннектор RJ45 UTP, категории 6	1	16B-U5-03BL	16B-U5-03BL
30	Шкаф напольный Hyperline TTB-4288-AS-RAL9004	1	TTB-4288-AS-RAL9004	TTB-4288-AS-RAL9004
31	Полка стационарная, глубина 650 мм, с боковым креплением, нагрузка до 20 кг, для шкафов серии TTB, TTR, TTC2, 485х650мм (ШхГ), цвет черный	1	TSH3L-650-RAL9004	TSH3L-650-RAL9004
32	Кабельный организатор пластиковый с крышкой, 19", 1U	1	CM-1U-PL-COV	CM-1U-PL-COV
33	Металлический вертикальный кабельный организатор с крышкой 42U, для шкафов TTB, TTC2 шириной 800 мм, черный	1	CMV-42U-ML	CMV-42U-ML
34	Блок розеток для 19" шкафов, горизонтальный, с выключателем с подсветкой, 8 розеток Schuko (10А), 250В, без кабеля питания, входная розетка IEC 60320 C14, 482.6х44.4х44.4мм (ШхВхГ)	1	SHE19-8SH-S-IEC	SHE19-8SH-S-IEC
35	Модуль вентиляторный потолочный с 2-мя вентиляторами для установки в шкафы серий TTC2, TTB и TWB, с подшипниками и крепежными элементами, цвет черный	1	TFAB-T2FR-RAL9004	TFAB-T2FR-RAL9004
114	Кабель ИКБ-Т-А8-6,0	\N	\N	\N
37	Кабель коаксиальный DG113 ZH	4		
26	Коммутационная панель модульная 19" 1U, 24 порта типа Keystone, незагруж., промарк. Cat.6A	1	24U-HDMMP- C6A	24U-HDMMP- C6A
118	Установка и терминирование розетки RJ-45 Cat-6А (розетки RG 45х2)	\N	\N	\N
117	Розеточный модуль типа Keystone экран. Cat.6A, RJ45/110, T568A/B, серия MT	\N	\N	\N
120	Установка и терминирование конектора RJ-45	\N	\N	\N
121	Разъем RJ-458P8C под витую пару категория 6 универсальный 100 шт	\N	\N	\N
122	Сборка и установка шкафа	\N	\N	\N
123	Шкаф напольный 19-дюймовый 42U 2055x800х800мм передняя стеклянная дверь со стальными перфорированными боковинами задняя двер	\N	\N	\N
47	Оконечный мультисвич polytron PSG 908 P	1	9268070	9268070
48	Оптический преобразователь Euro Fibre Virtual Quattro	1		
49	Оптический делитель  OSF 300	1		
50	Розетка SAT-TV оконечная	1		
52	Патчкорд оптический FC/UPC SM 3m	1		
53	Патчкорд оптический FC/UPC-SC/UPC SM 3 метра	1		
54	Патчкорд оптический SC/UPC 3m	1		
124	Полка стационарная усиленная 19" глубина 650 мм	\N	\N	\N
125	Организатор кабельный с пластиковыми кольцами и крышкой 19 1U	\N	\N	\N
126	Организатор кабельный металлический вертикальный с крышкой 42U для шкафов TTC/TSC шириной 800 черный	\N	\N	\N
51	F-коннектор	1		
127	Блок розеток для 19" шкафов горизонтальный 8 розеток	\N	\N	\N
63	Прокладка кабеля в гофро трубе по стенам и потолкам и конструкциям	\N	\N	\N
22	Труба гофрированная двустенная 50 мм с протяжкой с муфтой красная (100м)	4	121950	9741793
15	ИКБ-Т-А8-6,0	4	ИКБ-Т-А8-6,0	ИКБ-Т-А8-6,0
115	Терминирование разъемов патч-панели	\N	\N	\N
128	Модуль вентиляторный потолочный с 2-мя вентиляторами для установки в шкафы серий TTC2, TTB и TWB, с подшипникам	\N	\N	\N
132	Сварка оптического кабеля	\N	\N	\N
134	Лоток FMT1 оптический для модульных патч-панелей CFAPPBL под 1 держатель (FMT1)	\N	\N	\N
135	Патч-панель CFAPPBL1 19д для установки до 4 адаптерных панелей FAP / FMP прямая	\N	\N	\N
136	Панель для 6 SC дуплексных одномодовых оптических адаптеров (FAP6WBUDSCZ)	\N	\N	\N
137	Кассета ВО сварных соединений, 12 поз.	\N	\N	\N
138	Термоусаживаемая гильза (КДЗС), 60мм, уп-ка 10шт.	\N	\N	\N
139	Держатель сплайс-кассет PANDUIT FSTHE FST6, до 4 кассет для FMT, размеры 44,5x115,8x204,7 мм	\N	\N	\N
140	Пигтейл SM 9/125 (OS2) SC/APC 1 м LSZH	\N	\N	\N
\.


--
-- Data for Name: measure; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.measure (measure_id, measure, measure_short) FROM stdin;
1	штуки	шт
2	пачка	пач
3	коробка	кор
4	метр	м
5	упаковка	уп
6	килограмм	кг
7	грамм	г
8	миллиграмм	мг
9	литр	л
10	миллилитр	мл
\.


--
-- Data for Name: module_role; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.module_role (module_role_id, module_id, role_id) FROM stdin;
5	1	3
6	2	3
7	3	4
8	3	2
\.


--
-- Data for Name: modules; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.modules (module_id, module_name, module_file_name, module_title, module_icon) FROM stdin;
1	tabel	tabel	табель	calendar-multiple-check
2	personell	personell	персонал	account
3	tViewer	tViewer	Табель	calendar-clock
\.


--
-- Data for Name: personell; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.personell (personell_id, p_name, p_patronymic, p_surname, role_id, personell_id_barcode, p_login, p_passwd, male, create_date, update_date, birthday, create_personell_id, update_personell_id, address, email, photo, active) FROM stdin;
2	Юрий	Федорович	Зайцев	2	\N	Юрий	202cb962ac59075b964b07152d234b70	t	2020-10-21 19:27:44.966315	\N	\N	\N	\N	\N	\N	\N	t
3	Валерий	Юрьевич		1	\N	Валера	202cb962ac59075b964b07152d234b70	t	2020-10-21 19:27:44.966315	\N	\N	\N	\N	\N	\N	\N	t
4	Виталий	Юрьевич	Куницын	1	\N	Виталий	202cb962ac59075b964b07152d234b70	t	2020-10-26 23:07:01.019096	\N	\N	\N	\N	\N	\N	\N	t
7	Александр	Васильевич	Волков	1	\N	АВ	202cb962ac59075b964b07152d234b70	t	2020-11-06 02:22:15.128661	\N	\N	\N	\N	\N	\N	\N	t
8	Василий	Васильевич	Собакин	1	\N	ВВ	202cb962ac59075b964b07152d234b70	t	2020-11-06 02:22:15.128661	\N	\N	\N	\N	\N	\N	\N	t
9	Алексей	Григорьевич	Кулик	1	\N	АГ	202cb962ac59075b964b07152d234b70	t	2020-11-06 02:22:15.128661	\N	\N	\N	\N	\N	\N	\N	t
10	Артём	Николаевич	Медведев	1	\N	АН	202cb962ac59075b964b07152d234b70	t	2020-11-06 02:22:15.128661	\N	\N	\N	\N	\N	\N	\N	t
11	Владимир		Лисицын	1	\N	ВП	202cb962ac59075b964b07152d234b70	t	2020-11-06 02:22:15.128661	\N	\N	\N	\N	\N	\N	\N	t
12	Игорь	Николаевич	Ежов	1	\N	ИНС	202cb962ac59075b964b07152d234b70	t	2020-11-06 02:22:15.128661	\N	\N	\N	\N	\N	\N	\N	t
13	Иван	Викторович	Воронов	1	\N	ИВС	202cb962ac59075b964b07152d234b70	t	2020-11-06 02:22:15.128661	\N	\N	\N	\N	\N	\N	\N	t
14	Максим	Григорьевич	Гусев	1	\N	МГГ	202cb962ac59075b964b07152d234b70	t	2020-11-06 02:22:15.128661	\N	\N	\N	\N	\N	\N	\N	t
15	Алексей	Алексеевич	Уткин	1	\N	ААП	202cb962ac59075b964b07152d234b70	t	2020-11-06 02:22:15.128661	\N	\N	\N	\N	\N	\N	\N	t
16	Алексей		Котов	1	\N	АП	202cb962ac59075b964b07152d234b70	t	2020-11-06 02:22:15.128661	\N	\N	\N	\N	\N	\N	\N	t
1	Роман	Юрьевич	Зайцев	3	\N	Роман	202cb962ac59075b964b07152d234b70	t	2020-10-21 19:27:44.966315	\N	\N	\N	\N	\N	\N	\N	t
\.


--
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.project (project_id, project, subject_id, is_finished) FROM stdin;
2	СКС	3	f
3	Телевидение	3	f
4	Проектирование	3	f
5	Электрика	3	f
6	Заземление	3	f
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.roles (role_id, role_name, role_alias) FROM stdin;
1	Сотрудник	\N
2	Руководитель	\N
3	прораб	\N
4	менеджер	\N
\.


--
-- Data for Name: specification; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.specification (specification_id, project_id, goods_id, is_ordered, is_finished, amount) FROM stdin;
1	2	15	f	f	270.000
2	2	16	f	f	35.000
3	2	17	f	f	86.000
4	2	18	f	f	295.000
5	2	19	f	f	34.000
6	2	20	f	f	19.000
7	2	21	f	f	9.000
8	2	22	f	f	250.000
9	2	23	f	f	68.000
10	2	24	f	f	4.000
11	2	25	f	f	4.000
12	2	23	f	f	2.000
13	2	26	f	f	6.000
14	2	28	f	f	35.000
15	2	29	f	f	50.000
16	2	30	f	f	1.000
17	2	32	f	f	7.000
18	2	33	f	f	2.000
19	2	34	f	f	1.000
21	2	14	f	f	7238.000
22	2	27	f	f	120.000
23	2	31	f	f	2.000
24	2	35	f	f	1.000
25	3	37	f	f	426.000
26	3	14	f	f	30.000
27	3	47	f	f	1.000
28	3	48	f	f	2.000
29	3	49	f	f	1.000
30	3	50	f	f	7.000
31	3	51	f	f	23.000
32	3	52	f	f	2.000
33	3	53	f	f	4.000
34	3	54	f	f	1.000
35	3	28	f	f	2.000
\.


--
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.subject (subject_id, subject, adress) FROM stdin;
3	Шушенское	\N
4	Нижневартовск	\N
\.


--
-- Data for Name: unit; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.unit (unit_id, unit, post, p_unit_id, personell_id, terminal_bool, itr, active) FROM stdin;
1	ООО проВидец	Директор	\N	2	t	t	t
2	ООО проВидец	Прораб	1	4	t	t	t
3	ООО проВидец	Инженер	1	1	t	t	t
4	ООО проВидец	Водитель	1	3	t	t	t
\.


--
-- Data for Name: work_plan; Type: TABLE DATA; Schema: public; Owner: atom
--

COPY public.work_plan (work_plan_id, personell_id, work_date, subject_id) FROM stdin;
2	2	2020-10-27	4
5	2	2020-10-31	4
6	1	2020-10-26	3
7	1	2020-10-29	3
9	4	2020-10-26	4
10	4	2020-10-27	4
11	4	2020-10-31	4
23	1	2020-10-28	3
24	1	2020-10-27	3
25	1	2020-10-25	3
26	1	2020-10-24	3
27	1	2020-10-23	3
28	1	2020-10-22	3
29	1	2020-10-20	3
30	1	2020-10-21	3
65	1	2020-10-07	3
68	1	2020-10-11	3
69	1	2020-10-12	3
72	4	2020-10-01	3
73	4	2020-10-02	3
74	4	2020-10-03	3
75	4	2020-10-04	3
76	4	2020-10-05	3
77	4	2020-10-06	3
78	1	2020-10-08	3
79	1	2020-10-09	3
80	1	2020-10-10	3
81	1	2020-10-13	3
82	1	2020-10-14	3
83	4	2020-10-15	3
84	4	2020-10-16	3
85	4	2020-10-17	3
86	4	2020-10-18	3
87	4	2020-10-19	3
88	4	2020-10-30	3
89	4	2020-10-31	3
\.


--
-- Name: contract_contract_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.contract_contract_id_seq', 10, true);


--
-- Name: contractor_contractor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.contractor_contractor_id_seq', 4, true);


--
-- Name: contragent_contragent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.contragent_contragent_id_seq', 2, true);


--
-- Name: dev_group_dev_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.dev_group_dev_group_id_seq', 1, false);


--
-- Name: dev_type_dev_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.dev_type_dev_type_id_seq', 7, true);


--
-- Name: developments_developments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.developments_developments_id_seq', 559, true);


--
-- Name: estimate_estimate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.estimate_estimate_id_seq', 78, true);


--
-- Name: goods_goods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.goods_goods_id_seq', 140, true);


--
-- Name: measure_measure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.measure_measure_id_seq', 10, true);


--
-- Name: module_role_module_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.module_role_module_role_id_seq', 8, true);


--
-- Name: modules_module_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.modules_module_id_seq', 3, true);


--
-- Name: personell_personell_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.personell_personell_id_seq', 16, true);


--
-- Name: project_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.project_project_id_seq', 6, true);


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.roles_role_id_seq', 4, true);


--
-- Name: specification_specification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.specification_specification_id_seq', 35, true);


--
-- Name: subject_subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.subject_subject_id_seq', 4, true);


--
-- Name: unit_unit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.unit_unit_id_seq', 4, true);


--
-- Name: work_plan_work_plan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atom
--

SELECT pg_catalog.setval('public.work_plan_work_plan_id_seq', 96, true);


--
-- Name: contract contract_file_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_file_key UNIQUE (file);


--
-- Name: contract contract_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_pkey PRIMARY KEY (contract_id);


--
-- Name: contractor contractor_contractor_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.contractor
    ADD CONSTRAINT contractor_contractor_key UNIQUE (contractor);


--
-- Name: contractor contractor_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.contractor
    ADD CONSTRAINT contractor_pkey PRIMARY KEY (contractor_id);


--
-- Name: contragent contragent_contragent_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.contragent
    ADD CONSTRAINT contragent_contragent_key UNIQUE (contragent);


--
-- Name: contragent contragent_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.contragent
    ADD CONSTRAINT contragent_pkey PRIMARY KEY (contragent_id);


--
-- Name: dev_group dev_group_dev_group_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.dev_group
    ADD CONSTRAINT dev_group_dev_group_key UNIQUE (dev_group);


--
-- Name: dev_group dev_group_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.dev_group
    ADD CONSTRAINT dev_group_pkey PRIMARY KEY (dev_group_id);


--
-- Name: dev_type dev_type_dev_type_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.dev_type
    ADD CONSTRAINT dev_type_dev_type_key UNIQUE (dev_type);


--
-- Name: dev_type dev_type_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.dev_type
    ADD CONSTRAINT dev_type_pkey PRIMARY KEY (dev_type_id);


--
-- Name: developments developments_personell_id_dev_date_dev_type_id_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.developments
    ADD CONSTRAINT developments_personell_id_dev_date_dev_type_id_key UNIQUE (personell_id, dev_date, dev_type_id);


--
-- Name: developments developments_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.developments
    ADD CONSTRAINT developments_pkey PRIMARY KEY (developments_id);


--
-- Name: estimate estimate_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.estimate
    ADD CONSTRAINT estimate_pkey PRIMARY KEY (estimate_id);


--
-- Name: goods goods_goods_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.goods
    ADD CONSTRAINT goods_goods_key UNIQUE (goods);


--
-- Name: goods goods_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.goods
    ADD CONSTRAINT goods_pkey PRIMARY KEY (goods_id);


--
-- Name: measure measure_measure_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.measure
    ADD CONSTRAINT measure_measure_key UNIQUE (measure);


--
-- Name: measure measure_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.measure
    ADD CONSTRAINT measure_pkey PRIMARY KEY (measure_id);


--
-- Name: module_role module_role_module_id_role_id_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.module_role
    ADD CONSTRAINT module_role_module_id_role_id_key UNIQUE (module_id, role_id);


--
-- Name: module_role module_role_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.module_role
    ADD CONSTRAINT module_role_pkey PRIMARY KEY (module_role_id);


--
-- Name: modules modules_module_file_name_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_module_file_name_key UNIQUE (module_file_name);


--
-- Name: modules modules_module_icon_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_module_icon_key UNIQUE (module_icon);


--
-- Name: modules modules_module_name_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_module_name_key UNIQUE (module_name);


--
-- Name: modules modules_module_title_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_module_title_key UNIQUE (module_title);


--
-- Name: modules modules_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_pkey PRIMARY KEY (module_id);


--
-- Name: personell personell_p_login_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.personell
    ADD CONSTRAINT personell_p_login_key UNIQUE (p_login);


--
-- Name: personell personell_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.personell
    ADD CONSTRAINT personell_pkey PRIMARY KEY (personell_id);


--
-- Name: project project_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (project_id);


--
-- Name: project project_project_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_project_key UNIQUE (project);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: roles roles_role_name_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_role_name_key UNIQUE (role_name);


--
-- Name: specification specification_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.specification
    ADD CONSTRAINT specification_pkey PRIMARY KEY (specification_id);


--
-- Name: subject subject_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (subject_id);


--
-- Name: subject subject_subject_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT subject_subject_key UNIQUE (subject);


--
-- Name: unit unit_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.unit
    ADD CONSTRAINT unit_pkey PRIMARY KEY (unit_id);


--
-- Name: work_plan work_plan_personell_id_work_date_subject_id_key; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.work_plan
    ADD CONSTRAINT work_plan_personell_id_work_date_subject_id_key UNIQUE (personell_id, work_date, subject_id);


--
-- Name: work_plan work_plan_pkey; Type: CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.work_plan
    ADD CONSTRAINT work_plan_pkey PRIMARY KEY (work_plan_id);


--
-- Name: contract contract_contractor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_contractor_id_fkey FOREIGN KEY (contractor_id) REFERENCES public.contractor(contractor_id);


--
-- Name: contract contract_contragent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_contragent_id_fkey FOREIGN KEY (contragent_id) REFERENCES public.contragent(contragent_id);


--
-- Name: contract contract_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(project_id);


--
-- Name: dev_type dev_type_dev_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.dev_type
    ADD CONSTRAINT dev_type_dev_group_id_fkey FOREIGN KEY (dev_group_id) REFERENCES public.dev_group(dev_group_id);


--
-- Name: developments developments_dev_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.developments
    ADD CONSTRAINT developments_dev_type_id_fkey FOREIGN KEY (dev_type_id) REFERENCES public.dev_type(dev_type_id);


--
-- Name: developments developments_personell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.developments
    ADD CONSTRAINT developments_personell_id_fkey FOREIGN KEY (personell_id) REFERENCES public.personell(personell_id);


--
-- Name: developments developments_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.developments
    ADD CONSTRAINT developments_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subject(subject_id);


--
-- Name: estimate estimate_contract_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.estimate
    ADD CONSTRAINT estimate_contract_id_fkey FOREIGN KEY (contract_id) REFERENCES public.contract(contract_id);


--
-- Name: estimate estimate_goods_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.estimate
    ADD CONSTRAINT estimate_goods_id_fkey FOREIGN KEY (goods_id) REFERENCES public.goods(goods_id);


--
-- Name: estimate estimate_specification_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.estimate
    ADD CONSTRAINT estimate_specification_id_fkey FOREIGN KEY (specification_id) REFERENCES public.specification(specification_id);


--
-- Name: goods goods_measure_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.goods
    ADD CONSTRAINT goods_measure_id_fkey FOREIGN KEY (measure_id) REFERENCES public.measure(measure_id);


--
-- Name: module_role module_role_module_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.module_role
    ADD CONSTRAINT module_role_module_id_fkey FOREIGN KEY (module_id) REFERENCES public.modules(module_id);


--
-- Name: module_role module_role_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.module_role
    ADD CONSTRAINT module_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(role_id);


--
-- Name: personell personell_create_personell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.personell
    ADD CONSTRAINT personell_create_personell_id_fkey FOREIGN KEY (create_personell_id) REFERENCES public.personell(personell_id);


--
-- Name: personell personell_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.personell
    ADD CONSTRAINT personell_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(role_id);


--
-- Name: personell personell_update_personell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.personell
    ADD CONSTRAINT personell_update_personell_id_fkey FOREIGN KEY (update_personell_id) REFERENCES public.personell(personell_id);


--
-- Name: project project_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subject(subject_id);


--
-- Name: specification specification_goods_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.specification
    ADD CONSTRAINT specification_goods_id_fkey FOREIGN KEY (goods_id) REFERENCES public.goods(goods_id);


--
-- Name: specification specification_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.specification
    ADD CONSTRAINT specification_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(project_id);


--
-- Name: unit unit_p_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.unit
    ADD CONSTRAINT unit_p_unit_id_fkey FOREIGN KEY (p_unit_id) REFERENCES public.unit(unit_id);


--
-- Name: unit unit_personell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.unit
    ADD CONSTRAINT unit_personell_id_fkey FOREIGN KEY (personell_id) REFERENCES public.personell(personell_id);


--
-- Name: work_plan work_plan_personell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.work_plan
    ADD CONSTRAINT work_plan_personell_id_fkey FOREIGN KEY (personell_id) REFERENCES public.personell(personell_id);


--
-- Name: work_plan work_plan_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: atom
--

ALTER TABLE ONLY public.work_plan
    ADD CONSTRAINT work_plan_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subject(subject_id);


--
-- PostgreSQL database dump complete
--

