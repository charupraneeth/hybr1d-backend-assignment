--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

-- Started on 2022-07-30 12:21:04

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

DROP DATABASE "Hybr1dAssignment";
--
-- TOC entry 3040 (class 1262 OID 18506)
-- Name: Hybr1dAssignment; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE "Hybr1dAssignment" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_India.1252';


\connect "Hybr1dAssignment"

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
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 3041 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 630 (class 1247 OID 18508)
-- Name: UserType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."UserType" AS ENUM (
    'buyer',
    'seller'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 200 (class 1259 OID 18513)
-- Name: Order; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Order" (
    id integer NOT NULL,
    "sellerId" integer NOT NULL,
    "buyerId" integer NOT NULL
);


--
-- TOC entry 201 (class 1259 OID 18516)
-- Name: Order_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Order_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3042 (class 0 OID 0)
-- Dependencies: 201
-- Name: Order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Order_id_seq" OWNED BY public."Order".id;


--
-- TOC entry 202 (class 1259 OID 18518)
-- Name: Product; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Product" (
    id integer NOT NULL,
    name text NOT NULL,
    price integer NOT NULL,
    "sellerId" integer NOT NULL
);


--
-- TOC entry 203 (class 1259 OID 18524)
-- Name: Product_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Product_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3043 (class 0 OID 0)
-- Dependencies: 203
-- Name: Product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Product_id_seq" OWNED BY public."Product".id;


--
-- TOC entry 204 (class 1259 OID 18526)
-- Name: User; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    type public."UserType" NOT NULL
);


--
-- TOC entry 205 (class 1259 OID 18532)
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3044 (class 0 OID 0)
-- Dependencies: 205
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- TOC entry 206 (class 1259 OID 18534)
-- Name: _OrderToProduct; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."_OrderToProduct" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


--
-- TOC entry 207 (class 1259 OID 18537)
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 2876 (class 2604 OID 18545)
-- Name: Order id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Order" ALTER COLUMN id SET DEFAULT nextval('public."Order_id_seq"'::regclass);


--
-- TOC entry 2877 (class 2604 OID 18546)
-- Name: Product id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Product" ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);


--
-- TOC entry 2878 (class 2604 OID 18547)
-- Name: User id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- TOC entry 3027 (class 0 OID 18513)
-- Dependencies: 200
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."Order" VALUES (3, 1, 5);
INSERT INTO public."Order" VALUES (4, 2, 6);


--
-- TOC entry 3029 (class 0 OID 18518)
-- Dependencies: 202
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."Product" VALUES (4, 'key', 13, 1);
INSERT INTO public."Product" VALUES (5, 'charger', 50, 1);
INSERT INTO public."Product" VALUES (6, 'pillow', 30, 1);
INSERT INTO public."Product" VALUES (7, 'earphones', 30, 2);
INSERT INTO public."Product" VALUES (8, 'Bottle', 5, 2);
INSERT INTO public."Product" VALUES (9, 'laptop', 67, 2);


--
-- TOC entry 3031 (class 0 OID 18526)
-- Dependencies: 204
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."User" VALUES (1, 'bob', '$2b$10$FlBMBUfzl.DfsrQ9nvufvukjQiFZESWz5SgiyCQEogNM7BC8uQN.6', 'seller');
INSERT INTO public."User" VALUES (2, 'bob3', '$2b$10$8CckhM1KFMlYOPrubGqcte1ywlbG0b/k0BajsRN8lPA/IBv52dWe6', 'seller');
INSERT INTO public."User" VALUES (3, 'bob5', '$2b$10$WB/.SBGe0wwTixILSIGk8ep3vB/YTzwLB4jL4DanRoNWZ4J0pu2qm', 'seller');
INSERT INTO public."User" VALUES (4, 'bob7', '$2b$10$9nC9H5ow6Psd8IWO2UD4cuQ2WeS6GxfwdbzRFXQGkyj.r.mnSu6Qe', 'seller');
INSERT INTO public."User" VALUES (5, 'bob2', '$2b$10$86Jpb2XyuJrAEbyH0b2Uw.Uz4Pprzfb/FLXkCE58TxQyr8i6brDwu', 'buyer');
INSERT INTO public."User" VALUES (6, 'bob4', '$2b$10$Yy.ZS/FSQdvM7yUT.Je6vOo0ZLun4qJtICXwwzsDeZrjVhwTmulS.', 'buyer');
INSERT INTO public."User" VALUES (7, 'bob6', '$2b$10$00mK5YtUjPPtZ8rsuEgEOO29eBpko5odw25qvwR0MOnsI77NTfAxa', 'buyer');
INSERT INTO public."User" VALUES (8, 'bob8', '$2b$10$9QL5KoMlHTnpQ1NVBksRNui92b/Ie6xAuDQS63vhuslItkqFzowAG', 'buyer');


--
-- TOC entry 3033 (class 0 OID 18534)
-- Dependencies: 206
-- Data for Name: _OrderToProduct; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."_OrderToProduct" VALUES (3, 5);
INSERT INTO public."_OrderToProduct" VALUES (4, 8);


--
-- TOC entry 3034 (class 0 OID 18537)
-- Dependencies: 207
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public._prisma_migrations VALUES ('7387d373-0da7-4e78-a80d-4cf7b3ab08e8', '2e1cf6818d11c2c0fbcf4be7f81bde23e36514f419ad67e7fadd6035b57da1e1', '2022-07-29 23:30:56.971087+05:30', '20220729084015_init_postgres', NULL, NULL, '2022-07-29 23:30:56.9583+05:30', 1);
INSERT INTO public._prisma_migrations VALUES ('063f6f21-f596-48c0-9b06-a37de0d2ccb9', '9d032abeaf27b3b63be1af29496eb8e2e25da8e550c3eb5cb465f34cdd9e2aad', '2022-07-29 23:30:56.992496+05:30', '20220729134321_add_catalog', NULL, NULL, '2022-07-29 23:30:56.972126+05:30', 1);
INSERT INTO public._prisma_migrations VALUES ('b7929b75-1ac5-4ee4-8220-5eb52db05eb8', 'a57024dd7ac8f84edc5cbc6aea5e048250e14d3ef41918fd280b13f85d90f2ba', '2022-07-29 23:30:57.011933+05:30', '20220729153742_add_order', NULL, NULL, '2022-07-29 23:30:56.993503+05:30', 1);
INSERT INTO public._prisma_migrations VALUES ('a7bca23d-e97a-4346-9ef5-49b7278fd4e1', '9224353b28639d085903567b73bbcae3ac83a8826d8968bef310044576293c5c', '2022-07-29 23:30:57.024359+05:30', '20220729173507_add_order_with_seller_id', NULL, NULL, '2022-07-29 23:30:57.012755+05:30', 1);
INSERT INTO public._prisma_migrations VALUES ('5712b2e1-470d-446f-a1ba-7ea8093ac723', '0e980a308ef48a6d88a953ba0e9c844a91030cbaea3182975b1111e1ecfe604f', '2022-07-29 23:31:08.644691+05:30', '20220729180108_add_buyer_to_order', NULL, NULL, '2022-07-29 23:31:08.639903+05:30', 1);


--
-- TOC entry 3045 (class 0 OID 0)
-- Dependencies: 201
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Order_id_seq"', 4, true);


--
-- TOC entry 3046 (class 0 OID 0)
-- Dependencies: 203
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Product_id_seq"', 9, true);


--
-- TOC entry 3047 (class 0 OID 0)
-- Dependencies: 205
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."User_id_seq"', 8, true);


--
-- TOC entry 2882 (class 2606 OID 18549)
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- TOC entry 2884 (class 2606 OID 18551)
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- TOC entry 2886 (class 2606 OID 18553)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 2891 (class 2606 OID 18555)
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 2887 (class 1259 OID 18556)
-- Name: User_username_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "User_username_key" ON public."User" USING btree (username);


--
-- TOC entry 2888 (class 1259 OID 18557)
-- Name: _OrderToProduct_AB_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "_OrderToProduct_AB_unique" ON public."_OrderToProduct" USING btree ("A", "B");


--
-- TOC entry 2889 (class 1259 OID 18558)
-- Name: _OrderToProduct_B_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "_OrderToProduct_B_index" ON public."_OrderToProduct" USING btree ("B");


--
-- TOC entry 2892 (class 2606 OID 18559)
-- Name: Order Order_buyerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_buyerId_fkey" FOREIGN KEY ("buyerId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2893 (class 2606 OID 18564)
-- Name: Order Order_sellerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_sellerId_fkey" FOREIGN KEY ("sellerId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2894 (class 2606 OID 18569)
-- Name: Product Product_sellerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_sellerId_fkey" FOREIGN KEY ("sellerId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2895 (class 2606 OID 18574)
-- Name: _OrderToProduct _OrderToProduct_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_OrderToProduct"
    ADD CONSTRAINT "_OrderToProduct_A_fkey" FOREIGN KEY ("A") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2896 (class 2606 OID 18579)
-- Name: _OrderToProduct _OrderToProduct_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_OrderToProduct"
    ADD CONSTRAINT "_OrderToProduct_B_fkey" FOREIGN KEY ("B") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2022-07-30 12:21:04

--
-- PostgreSQL database dump complete
--

