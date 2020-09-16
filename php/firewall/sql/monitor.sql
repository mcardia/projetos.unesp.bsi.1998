
/* -------------------------------------------------------- 
  phpPgAdmin 2.4a DB Dump
  http://sourceforge.net/projects/phppgadmin/
  Host: localhost:5432
  Database  : "monitor"
  2002-04-10 22:04:27
-------------------------------------------------------- */ 

/* -------------------------------------------------------- 
  Sequences 
-------------------------------------------------------- */ 
CREATE SEQUENCE "bases_id_seq" start 8 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('bases_id_seq'); 
CREATE SEQUENCE "bases_tipo_id_seq" start 3 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('bases_tipo_id_seq'); 
CREATE SEQUENCE "contatos_id_seq" start 3 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('contatos_id_seq'); 
CREATE SEQUENCE "estatistica_id_seq" start 904 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('estatistica_id_seq'); 
CREATE SEQUENCE "ftp_id_seq" start 4 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('ftp_id_seq'); 
CREATE SEQUENCE "http_id_seq" start 14 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('http_id_seq'); 
CREATE SEQUENCE "mail_id_seq" start 5 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('mail_id_seq'); 
CREATE SEQUENCE "outros_id_seq" start 3 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('outros_id_seq'); 
CREATE SEQUENCE "proxy_id_seq" start 2 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('proxy_id_seq'); 
CREATE SEQUENCE "status_id_seq" start 4 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('status_id_seq'); 
CREATE SEQUENCE "tipo_servidor_id_seq" start 7 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('tipo_servidor_id_seq'); 

/* -------------------------------------------------------- 
  Table structure for table "bases" 
-------------------------------------------------------- */
CREATE TABLE "bases" (
   "id" int4 DEFAULT nextval('bases_id_seq'::text) NOT NULL,
   "servidor" varchar(40) DEFAULT '' NOT NULL,
   "host" varchar(255) DEFAULT '' NOT NULL,
   "id_tipo" int4 DEFAULT '0' NOT NULL,
   "id_status" int4 DEFAULT '0' NOT NULL,
   CONSTRAINT "bases_pkey" PRIMARY KEY ("id")
);
GRANT ALL ON "bases" TO "postgres";
GRANT ALL ON "bases" TO "sa";


/* -------------------------------------------------------- 
  Dumping data for table "bases" 
-------------------------------------------------------- */ 

/* -------------------------------------------------------- 
  Table structure for table "bases_tipo" 
-------------------------------------------------------- */
CREATE TABLE "bases_tipo" (
   "id" int4 DEFAULT nextval('bases_tipo_id_seq'::text) NOT NULL,
   "tipo" varchar(40) DEFAULT '' NOT NULL,
   CONSTRAINT "bases_tipo_pkey" PRIMARY KEY ("id")
);
GRANT ALL ON "bases_tipo" TO "postgres";
GRANT ALL ON "bases_tipo" TO "sa";


/* -------------------------------------------------------- 
  Dumping data for table "bases_tipo" 
-------------------------------------------------------- */ 
INSERT INTO "bases_tipo" ("id", "tipo") VALUES(1, 'MySQL');
INSERT INTO "bases_tipo" ("id", "tipo") VALUES(2, 'MS-SQL');

/* -------------------------------------------------------- 
  Table structure for table "contatos" 
-------------------------------------------------------- */
CREATE TABLE "contatos" (
   "id" int4 DEFAULT nextval('contatos_id_seq'::text) NOT NULL,
   "nome" varchar(255) DEFAULT '' NOT NULL,
   "prefixo" char(2),
   "celular" varchar(8),
   "email" varchar(255),
   "id_celular" int4,
   "id_email" int4,
   CONSTRAINT "contatos_pkey" PRIMARY KEY ("id")
);
GRANT ALL ON "contatos" TO "postgres";
GRANT ALL ON "contatos" TO "sa";


/* -------------------------------------------------------- 
  Dumping data for table "contatos" 
-------------------------------------------------------- */ 

/* -------------------------------------------------------- 
  Table structure for table "estatistica" 
-------------------------------------------------------- */
CREATE TABLE "estatistica" (
   "id" int4 DEFAULT nextval('estatistica_id_seq'::text) NOT NULL,
   "id_servidor" int4 DEFAULT '0' NOT NULL,
   "id_tipo" int4 DEFAULT '0' NOT NULL,
   "data" timestamp DEFAULT '0001-01-01 00:00:00' NOT NULL,
   "erros" int4 DEFAULT '0' NOT NULL,
   "ok" int4 DEFAULT '0' NOT NULL,
   CONSTRAINT "estatistica_pkey" PRIMARY KEY ("id")
);
GRANT ALL ON "estatistica" TO "postgres";
GRANT ALL ON "estatistica" TO "sa";


/* -------------------------------------------------------- 
  Dumping data for table "estatistica" 
-------------------------------------------------------- */ 
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(1, 1, 3, '2001-12-11 00:00:00-02', 1, 9);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(2, 1, 4, '2001-12-11 00:00:00-02', 5, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(3, 1, 1, '2001-12-11 00:00:00-02', 0, 7);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(4, 6, 1, '2001-12-11 00:00:00-02', 0, 7);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(5, 3, 1, '2001-12-11 00:00:00-02', 0, 7);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(6, 4, 1, '2001-12-11 00:00:00-02', 0, 7);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(7, 3, 2, '2001-12-11 00:00:00-02', 0, 14);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(8, 4, 2, '2001-12-11 00:00:00-02', 0, 14);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(9, 3, 5, '2001-12-11 00:00:00-02', 0, 7);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(10, 1, 5, '2001-12-11 00:00:00-02', 0, 7);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(11, 3, 4, '2001-12-11 00:00:00-02', 0, 5);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(12, 1, 1, '2001-12-12 00:00:00-02', 1, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(13, 6, 1, '2001-12-12 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(14, 3, 1, '2001-12-12 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(15, 4, 1, '2001-12-12 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(16, 3, 2, '2001-12-12 00:00:00-02', 0, 4);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(17, 4, 2, '2001-12-12 00:00:00-02', 0, 4);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(18, 1, 3, '2001-12-12 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(19, 3, 5, '2001-12-12 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(20, 1, 5, '2001-12-12 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(21, 1, 4, '2001-12-12 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(22, 3, 4, '2001-12-12 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(23, 1, 1, '2001-12-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(24, 6, 1, '2001-12-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(25, 3, 1, '2001-12-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(26, 4, 1, '2001-12-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(27, 3, 2, '2001-12-13 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(28, 4, 2, '2001-12-13 00:00:00-02', 13, 26);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(29, 1, 3, '2001-12-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(30, 3, 5, '2001-12-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(31, 1, 5, '2001-12-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(32, 1, 4, '2001-12-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(33, 3, 4, '2001-12-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(34, 1, 1, '2001-12-14 00:00:00-02', 0, 10);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(35, 6, 1, '2001-12-14 00:00:00-02', 0, 9);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(36, 3, 1, '2001-12-14 00:00:00-02', 0, 8);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(37, 4, 1, '2001-12-14 00:00:00-02', 0, 7);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(38, 3, 2, '2001-12-14 00:00:00-02', 0, 14);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(39, 4, 2, '2001-12-14 00:00:00-02', 0, 14);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(40, 1, 3, '2001-12-14 00:00:00-02', 0, 7);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(41, 3, 5, '2001-12-14 00:00:00-02', 0, 7);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(42, 1, 5, '2001-12-14 00:00:00-02', 0, 7);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(43, 1, 4, '2001-12-14 00:00:00-02', 4, 3);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(44, 3, 4, '2001-12-14 00:00:00-02', 0, 7);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(45, 1, 1, '2001-12-15 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(46, 6, 1, '2001-12-15 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(47, 3, 1, '2001-12-15 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(48, 4, 1, '2001-12-15 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(49, 3, 2, '2001-12-15 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(50, 4, 2, '2001-12-15 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(51, 1, 3, '2001-12-15 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(52, 3, 5, '2001-12-15 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(53, 1, 5, '2001-12-15 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(54, 1, 4, '2001-12-15 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(55, 3, 4, '2001-12-15 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(56, 1, 1, '2001-12-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(57, 6, 1, '2001-12-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(58, 3, 1, '2001-12-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(59, 4, 1, '2001-12-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(60, 3, 2, '2001-12-16 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(61, 4, 2, '2001-12-16 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(62, 1, 3, '2001-12-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(63, 3, 5, '2001-12-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(64, 1, 5, '2001-12-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(65, 1, 4, '2001-12-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(66, 3, 4, '2001-12-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(67, 1, 1, '2001-12-17 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(68, 6, 1, '2001-12-17 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(69, 3, 1, '2001-12-17 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(70, 4, 1, '2001-12-17 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(71, 3, 2, '2001-12-17 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(72, 4, 2, '2001-12-17 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(73, 1, 3, '2001-12-17 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(74, 3, 5, '2001-12-17 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(75, 1, 5, '2001-12-17 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(76, 1, 4, '2001-12-17 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(77, 3, 4, '2001-12-17 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(78, 1, 1, '2001-12-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(79, 6, 1, '2001-12-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(80, 3, 1, '2001-12-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(81, 4, 1, '2001-12-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(82, 3, 2, '2001-12-18 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(83, 4, 2, '2001-12-18 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(84, 1, 3, '2001-12-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(85, 3, 5, '2001-12-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(86, 1, 5, '2001-12-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(87, 1, 4, '2001-12-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(88, 3, 4, '2001-12-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(89, 1, 1, '2001-12-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(90, 6, 1, '2001-12-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(91, 3, 1, '2001-12-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(92, 4, 1, '2001-12-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(93, 3, 2, '2001-12-19 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(94, 4, 2, '2001-12-19 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(95, 1, 3, '2001-12-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(96, 3, 5, '2001-12-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(97, 1, 5, '2001-12-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(98, 1, 4, '2001-12-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(99, 3, 4, '2001-12-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(100, 1, 1, '2001-12-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(101, 6, 1, '2001-12-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(102, 3, 1, '2001-12-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(103, 4, 1, '2001-12-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(104, 3, 2, '2001-12-20 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(105, 4, 2, '2001-12-20 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(106, 1, 3, '2001-12-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(107, 3, 5, '2001-12-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(108, 1, 5, '2001-12-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(109, 1, 4, '2001-12-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(110, 3, 4, '2001-12-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(111, 1, 1, '2001-12-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(112, 6, 1, '2001-12-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(113, 3, 1, '2001-12-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(114, 4, 1, '2001-12-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(115, 3, 2, '2001-12-21 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(116, 4, 2, '2001-12-21 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(117, 1, 3, '2001-12-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(118, 3, 5, '2001-12-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(119, 1, 5, '2001-12-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(120, 1, 4, '2001-12-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(121, 3, 4, '2001-12-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(122, 1, 1, '2001-12-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(123, 6, 1, '2001-12-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(124, 3, 1, '2001-12-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(125, 4, 1, '2001-12-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(126, 3, 2, '2001-12-22 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(127, 4, 2, '2001-12-22 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(128, 1, 3, '2001-12-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(129, 3, 5, '2001-12-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(130, 1, 5, '2001-12-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(131, 1, 4, '2001-12-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(132, 3, 4, '2001-12-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(133, 1, 1, '2001-12-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(134, 6, 1, '2001-12-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(135, 3, 1, '2001-12-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(136, 4, 1, '2001-12-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(137, 3, 2, '2001-12-23 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(138, 4, 2, '2001-12-23 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(139, 1, 3, '2001-12-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(140, 3, 5, '2001-12-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(141, 1, 5, '2001-12-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(142, 1, 4, '2001-12-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(143, 3, 4, '2001-12-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(144, 1, 1, '2001-12-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(145, 6, 1, '2001-12-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(146, 3, 1, '2001-12-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(147, 4, 1, '2001-12-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(148, 3, 2, '2001-12-24 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(149, 4, 2, '2001-12-24 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(150, 1, 3, '2001-12-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(151, 3, 5, '2001-12-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(152, 1, 5, '2001-12-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(153, 1, 4, '2001-12-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(154, 3, 4, '2001-12-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(155, 1, 1, '2001-12-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(156, 6, 1, '2001-12-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(157, 3, 1, '2001-12-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(158, 4, 1, '2001-12-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(159, 3, 2, '2001-12-25 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(160, 4, 2, '2001-12-25 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(161, 1, 3, '2001-12-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(162, 3, 5, '2001-12-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(163, 1, 5, '2001-12-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(164, 1, 4, '2001-12-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(165, 3, 4, '2001-12-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(166, 1, 1, '2001-12-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(167, 6, 1, '2001-12-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(168, 3, 1, '2001-12-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(169, 4, 1, '2001-12-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(170, 3, 2, '2001-12-26 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(171, 4, 2, '2001-12-26 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(172, 1, 3, '2001-12-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(173, 3, 5, '2001-12-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(174, 1, 5, '2001-12-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(175, 1, 4, '2001-12-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(176, 3, 4, '2001-12-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(177, 1, 1, '2001-12-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(178, 6, 1, '2001-12-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(179, 3, 1, '2001-12-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(180, 4, 1, '2001-12-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(181, 3, 2, '2001-12-27 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(182, 4, 2, '2001-12-27 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(183, 1, 3, '2001-12-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(184, 3, 5, '2001-12-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(185, 1, 5, '2001-12-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(186, 1, 4, '2001-12-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(187, 3, 4, '2001-12-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(188, 1, 1, '2001-12-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(189, 6, 1, '2001-12-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(190, 3, 1, '2001-12-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(191, 4, 1, '2001-12-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(192, 3, 2, '2001-12-28 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(193, 4, 2, '2001-12-28 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(194, 1, 3, '2001-12-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(195, 3, 5, '2001-12-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(196, 1, 5, '2001-12-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(197, 1, 4, '2001-12-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(198, 3, 4, '2001-12-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(199, 1, 1, '2001-12-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(200, 6, 1, '2001-12-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(201, 3, 1, '2001-12-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(202, 4, 1, '2001-12-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(203, 3, 2, '2001-12-29 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(204, 4, 2, '2001-12-29 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(205, 1, 3, '2001-12-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(206, 3, 5, '2001-12-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(207, 1, 5, '2001-12-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(208, 1, 4, '2001-12-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(209, 3, 4, '2001-12-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(210, 1, 1, '2001-12-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(211, 6, 1, '2001-12-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(212, 3, 1, '2001-12-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(213, 4, 1, '2001-12-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(214, 3, 2, '2001-12-30 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(215, 4, 2, '2001-12-30 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(216, 1, 3, '2001-12-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(217, 3, 5, '2001-12-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(218, 1, 5, '2001-12-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(219, 1, 4, '2001-12-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(220, 3, 4, '2001-12-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(221, 1, 1, '2001-12-31 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(222, 6, 1, '2001-12-31 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(223, 3, 1, '2001-12-31 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(224, 4, 1, '2001-12-31 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(225, 3, 2, '2001-12-31 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(226, 4, 2, '2001-12-31 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(227, 1, 3, '2001-12-31 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(228, 3, 5, '2001-12-31 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(229, 1, 5, '2001-12-31 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(230, 1, 4, '2001-12-31 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(231, 3, 4, '2001-12-31 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(232, 1, 1, '2001-12-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(233, 6, 1, '2001-12-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(234, 3, 1, '2001-12-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(235, 4, 1, '2001-12-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(236, 3, 2, '2001-12-01 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(237, 4, 2, '2001-12-01 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(238, 1, 3, '2001-12-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(239, 3, 5, '2001-12-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(240, 1, 5, '2001-12-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(241, 1, 4, '2001-12-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(242, 3, 4, '2001-12-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(243, 1, 1, '2001-12-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(244, 6, 1, '2001-12-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(245, 3, 1, '2001-12-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(246, 4, 1, '2001-12-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(247, 3, 2, '2001-12-02 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(248, 4, 2, '2001-12-02 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(249, 1, 3, '2001-12-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(250, 3, 5, '2001-12-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(251, 1, 5, '2001-12-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(252, 1, 4, '2001-12-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(253, 3, 4, '2001-12-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(254, 1, 1, '2001-12-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(255, 6, 1, '2001-12-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(256, 3, 1, '2001-12-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(257, 4, 1, '2001-12-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(258, 3, 2, '2001-12-03 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(259, 4, 2, '2001-12-03 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(260, 1, 3, '2001-12-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(261, 3, 5, '2001-12-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(262, 1, 5, '2001-12-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(263, 1, 4, '2001-12-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(264, 3, 4, '2001-12-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(265, 1, 1, '2001-12-04 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(266, 6, 1, '2001-12-04 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(267, 3, 1, '2001-12-04 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(268, 4, 1, '2001-12-04 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(269, 3, 2, '2001-12-04 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(270, 4, 2, '2001-12-04 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(271, 1, 3, '2001-12-04 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(272, 3, 5, '2001-12-04 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(273, 1, 5, '2001-12-04 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(274, 1, 4, '2001-12-04 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(275, 3, 4, '2001-12-04 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(276, 1, 1, '2001-12-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(277, 6, 1, '2001-12-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(278, 3, 1, '2001-12-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(279, 4, 1, '2001-12-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(280, 3, 2, '2001-12-05 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(281, 4, 2, '2001-12-05 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(282, 1, 3, '2001-12-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(283, 3, 5, '2001-12-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(284, 1, 5, '2001-12-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(285, 1, 4, '2001-12-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(286, 3, 4, '2001-12-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(287, 1, 1, '2001-12-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(288, 6, 1, '2001-12-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(289, 3, 1, '2001-12-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(290, 4, 1, '2001-12-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(291, 3, 2, '2001-12-06 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(292, 4, 2, '2001-12-06 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(293, 1, 3, '2001-12-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(294, 3, 5, '2001-12-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(295, 1, 5, '2001-12-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(296, 1, 4, '2001-12-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(297, 3, 4, '2001-12-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(298, 1, 1, '2001-12-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(299, 6, 1, '2001-12-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(300, 3, 1, '2001-12-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(301, 4, 1, '2001-12-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(302, 3, 2, '2001-12-07 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(303, 4, 2, '2001-12-07 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(304, 1, 3, '2001-12-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(305, 3, 5, '2001-12-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(306, 1, 5, '2001-12-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(307, 1, 4, '2001-12-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(308, 3, 4, '2001-12-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(309, 1, 1, '2001-12-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(310, 6, 1, '2001-12-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(311, 3, 1, '2001-12-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(312, 4, 1, '2001-12-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(313, 3, 2, '2001-12-08 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(314, 4, 2, '2001-12-08 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(315, 1, 3, '2001-12-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(316, 3, 5, '2001-12-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(317, 1, 5, '2001-12-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(318, 1, 4, '2001-12-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(319, 3, 4, '2001-12-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(320, 1, 1, '2001-12-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(321, 6, 1, '2001-12-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(322, 3, 1, '2001-12-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(323, 4, 1, '2001-12-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(324, 3, 2, '2001-12-09 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(325, 4, 2, '2001-12-09 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(326, 1, 3, '2001-12-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(327, 3, 5, '2001-12-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(328, 1, 5, '2001-12-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(329, 1, 4, '2001-12-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(330, 3, 4, '2001-12-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(331, 1, 1, '2001-12-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(332, 6, 1, '2001-12-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(333, 3, 1, '2001-12-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(334, 4, 1, '2001-12-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(335, 3, 2, '2001-12-10 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(336, 4, 2, '2001-12-10 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(337, 1, 3, '2001-12-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(338, 3, 5, '2001-12-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(339, 1, 5, '2001-12-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(340, 1, 4, '2001-12-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(341, 3, 4, '2001-12-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(342, 1, 1, '2001-11-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(343, 6, 1, '2001-11-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(344, 3, 1, '2001-11-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(345, 4, 1, '2001-11-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(346, 3, 2, '2001-11-01 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(347, 4, 2, '2001-11-01 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(348, 1, 3, '2001-11-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(349, 3, 5, '2001-11-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(350, 1, 5, '2001-11-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(351, 1, 4, '2001-11-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(352, 3, 4, '2001-11-01 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(353, 1, 1, '2001-11-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(354, 6, 1, '2001-11-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(355, 3, 1, '2001-11-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(356, 4, 1, '2001-11-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(357, 3, 2, '2001-11-02 00:00:00-02', 2, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(358, 4, 2, '2001-11-02 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(359, 1, 3, '2001-11-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(360, 3, 5, '2001-11-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(361, 1, 5, '2001-11-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(362, 1, 4, '2001-11-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(363, 3, 4, '2001-11-02 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(364, 1, 1, '2001-11-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(365, 6, 1, '2001-11-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(366, 3, 1, '2001-11-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(367, 4, 1, '2001-11-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(368, 3, 2, '2001-11-03 00:00:00-02', 1, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(369, 4, 2, '2001-11-03 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(370, 1, 3, '2001-11-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(371, 3, 5, '2001-11-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(372, 1, 5, '2001-11-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(373, 1, 4, '2001-11-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(374, 3, 4, '2001-11-03 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(375, 1, 1, '2001-11-04 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(376, 6, 1, '2001-11-04 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(377, 3, 1, '2001-11-04 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(378, 4, 1, '2001-11-04 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(379, 3, 2, '2001-11-04 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(380, 4, 2, '2001-11-04 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(381, 1, 3, '2001-11-04 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(382, 3, 5, '2001-11-04 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(383, 1, 5, '2001-11-04 00:00:00-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(384, 1, 4, '2001-11-04 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(385, 3, 4, '2001-11-04 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(386, 1, 1, '2001-11-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(387, 6, 1, '2001-11-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(388, 3, 1, '2001-11-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(389, 4, 1, '2001-11-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(390, 3, 2, '2001-11-05 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(391, 4, 2, '2001-11-05 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(392, 1, 3, '2001-11-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(393, 3, 5, '2001-11-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(394, 1, 5, '2001-11-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(395, 1, 4, '2001-11-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(396, 3, 4, '2001-11-05 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(397, 1, 1, '2001-11-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(398, 6, 1, '2001-11-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(399, 3, 1, '2001-11-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(400, 4, 1, '2001-11-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(401, 3, 2, '2001-11-06 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(402, 4, 2, '2001-11-06 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(403, 1, 3, '2001-11-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(404, 3, 5, '2001-11-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(405, 1, 5, '2001-11-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(406, 1, 4, '2001-11-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(407, 3, 4, '2001-11-06 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(408, 1, 1, '2001-11-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(409, 6, 1, '2001-11-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(410, 3, 1, '2001-11-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(411, 4, 1, '2001-11-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(412, 3, 2, '2001-11-07 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(413, 4, 2, '2001-11-07 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(414, 1, 3, '2001-11-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(415, 3, 5, '2001-11-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(416, 1, 5, '2001-11-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(417, 1, 4, '2001-11-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(418, 3, 4, '2001-11-07 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(419, 1, 1, '2001-11-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(420, 6, 1, '2001-11-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(421, 3, 1, '2001-11-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(422, 4, 1, '2001-11-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(423, 3, 2, '2001-11-08 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(424, 4, 2, '2001-11-08 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(425, 1, 3, '2001-11-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(426, 3, 5, '2001-11-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(427, 1, 5, '2001-11-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(428, 1, 4, '2001-11-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(429, 3, 4, '2001-11-08 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(430, 1, 1, '2001-11-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(431, 6, 1, '2001-11-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(432, 3, 1, '2001-11-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(433, 4, 1, '2001-11-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(434, 3, 2, '2001-11-09 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(435, 4, 2, '2001-11-09 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(436, 1, 3, '2001-11-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(437, 3, 5, '2001-11-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(438, 1, 5, '2001-11-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(439, 1, 4, '2001-11-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(440, 3, 4, '2001-11-09 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(441, 1, 1, '2001-11-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(442, 6, 1, '2001-11-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(443, 3, 1, '2001-11-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(444, 4, 1, '2001-11-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(445, 3, 2, '2001-11-10 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(446, 4, 2, '2001-11-10 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(447, 1, 3, '2001-11-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(448, 3, 5, '2001-11-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(449, 1, 5, '2001-11-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(450, 1, 4, '2001-11-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(451, 3, 4, '2001-11-10 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(452, 1, 1, '2001-11-11 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(453, 6, 1, '2001-11-11 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(454, 3, 1, '2001-11-11 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(455, 4, 1, '2001-11-11 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(456, 3, 2, '2001-11-11 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(457, 4, 2, '2001-11-11 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(458, 1, 3, '2001-11-11 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(459, 3, 5, '2001-11-11 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(460, 1, 5, '2001-11-11 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(461, 1, 4, '2001-11-11 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(462, 3, 4, '2001-11-11 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(463, 1, 1, '2001-11-12 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(464, 6, 1, '2001-11-12 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(465, 3, 1, '2001-11-12 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(466, 4, 1, '2001-11-12 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(467, 3, 2, '2001-11-12 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(468, 4, 2, '2001-11-12 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(469, 1, 3, '2001-11-12 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(470, 3, 5, '2001-11-12 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(471, 1, 5, '2001-11-12 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(472, 1, 4, '2001-11-12 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(473, 3, 4, '2001-11-12 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(474, 1, 1, '2001-11-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(475, 6, 1, '2001-11-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(476, 3, 1, '2001-11-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(477, 4, 1, '2001-11-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(478, 3, 2, '2001-11-13 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(479, 4, 2, '2001-11-13 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(480, 1, 3, '2001-11-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(481, 3, 5, '2001-11-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(482, 1, 5, '2001-11-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(483, 1, 4, '2001-11-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(484, 3, 4, '2001-11-13 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(485, 1, 1, '2001-11-14 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(486, 6, 1, '2001-11-14 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(487, 3, 1, '2001-11-14 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(488, 4, 1, '2001-11-14 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(489, 3, 2, '2001-11-14 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(490, 4, 2, '2001-11-14 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(491, 1, 3, '2001-11-14 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(492, 3, 5, '2001-11-14 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(493, 1, 5, '2001-11-14 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(494, 1, 4, '2001-11-14 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(495, 3, 4, '2001-11-14 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(496, 1, 1, '2001-11-15 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(497, 6, 1, '2001-11-15 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(498, 3, 1, '2001-11-15 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(499, 4, 1, '2001-11-15 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(500, 3, 2, '2001-11-15 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(501, 4, 2, '2001-11-15 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(502, 1, 3, '2001-11-15 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(503, 3, 5, '2001-11-15 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(504, 1, 5, '2001-11-15 00:00:00-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(505, 1, 4, '2001-11-15 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(506, 3, 4, '2001-11-15 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(507, 1, 1, '2001-11-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(508, 6, 1, '2001-11-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(509, 3, 1, '2001-11-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(510, 4, 1, '2001-11-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(511, 3, 2, '2001-11-16 00:00:00-02', 2, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(512, 4, 2, '2001-11-16 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(513, 1, 3, '2001-11-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(514, 3, 5, '2001-11-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(515, 1, 5, '2001-11-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(516, 1, 4, '2001-11-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(517, 3, 4, '2001-11-16 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(518, 1, 1, '2001-11-17 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(519, 6, 1, '2001-11-17 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(520, 3, 1, '2001-11-17 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(521, 4, 1, '2001-11-17 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(522, 3, 2, '2001-11-17 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(523, 4, 2, '2001-11-17 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(524, 1, 3, '2001-11-17 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(525, 3, 5, '2001-11-17 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(526, 1, 5, '2001-11-17 00:00:00-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(527, 1, 4, '2001-11-17 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(528, 3, 4, '2001-11-17 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(529, 1, 1, '2001-11-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(530, 6, 1, '2001-11-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(531, 3, 1, '2001-11-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(532, 4, 1, '2001-11-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(533, 3, 2, '2001-11-18 00:00:00-02', 2, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(534, 4, 2, '2001-11-18 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(535, 1, 3, '2001-11-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(536, 3, 5, '2001-11-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(537, 1, 5, '2001-11-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(538, 1, 4, '2001-11-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(539, 3, 4, '2001-11-18 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(540, 1, 1, '2001-11-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(541, 6, 1, '2001-11-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(542, 3, 1, '2001-11-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(543, 4, 1, '2001-11-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(544, 3, 2, '2001-11-19 00:00:00-02', 1, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(545, 4, 2, '2001-11-19 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(546, 1, 3, '2001-11-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(547, 3, 5, '2001-11-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(548, 1, 5, '2001-11-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(549, 1, 4, '2001-11-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(550, 3, 4, '2001-11-19 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(551, 1, 1, '2001-11-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(552, 6, 1, '2001-11-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(553, 3, 1, '2001-11-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(554, 4, 1, '2001-11-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(555, 3, 2, '2001-11-20 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(556, 4, 2, '2001-11-20 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(557, 1, 3, '2001-11-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(558, 3, 5, '2001-11-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(559, 1, 5, '2001-11-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(560, 1, 4, '2001-11-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(561, 3, 4, '2001-11-20 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(562, 1, 1, '2001-11-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(563, 6, 1, '2001-11-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(564, 3, 1, '2001-11-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(565, 4, 1, '2001-11-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(566, 3, 2, '2001-11-21 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(567, 4, 2, '2001-11-21 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(568, 1, 3, '2001-11-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(569, 3, 5, '2001-11-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(570, 1, 5, '2001-11-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(571, 1, 4, '2001-11-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(572, 3, 4, '2001-11-21 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(573, 1, 1, '2001-11-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(574, 6, 1, '2001-11-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(575, 3, 1, '2001-11-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(576, 4, 1, '2001-11-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(577, 3, 2, '2001-11-22 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(578, 4, 2, '2001-11-22 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(579, 1, 3, '2001-11-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(580, 3, 5, '2001-11-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(581, 1, 5, '2001-11-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(582, 1, 4, '2001-11-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(583, 3, 4, '2001-11-22 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(584, 1, 1, '2001-11-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(585, 6, 1, '2001-11-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(586, 3, 1, '2001-11-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(587, 4, 1, '2001-11-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(588, 3, 2, '2001-11-23 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(589, 4, 2, '2001-11-23 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(590, 1, 3, '2001-11-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(591, 3, 5, '2001-11-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(592, 1, 5, '2001-11-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(593, 1, 4, '2001-11-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(594, 3, 4, '2001-11-23 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(595, 1, 1, '2001-11-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(596, 6, 1, '2001-11-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(597, 3, 1, '2001-11-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(598, 4, 1, '2001-11-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(599, 3, 2, '2001-11-24 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(600, 4, 2, '2001-11-24 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(601, 1, 3, '2001-11-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(602, 3, 5, '2001-11-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(603, 1, 5, '2001-11-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(604, 1, 4, '2001-11-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(605, 3, 4, '2001-11-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(606, 1, 1, '2001-11-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(607, 6, 1, '2001-11-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(608, 3, 1, '2001-11-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(609, 4, 1, '2001-11-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(610, 3, 2, '2001-11-25 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(611, 4, 2, '2001-11-25 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(612, 1, 3, '2001-11-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(613, 3, 5, '2001-11-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(614, 1, 5, '2001-11-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(615, 1, 4, '2001-11-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(616, 3, 4, '2001-11-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(617, 1, 1, '2001-11-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(618, 6, 1, '2001-11-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(619, 3, 1, '2001-11-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(620, 4, 1, '2001-11-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(621, 3, 2, '2001-11-26 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(622, 4, 2, '2001-11-26 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(623, 1, 3, '2001-11-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(624, 3, 5, '2001-11-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(625, 1, 5, '2001-11-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(626, 1, 4, '2001-11-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(627, 3, 4, '2001-11-26 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(628, 1, 1, '2001-11-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(629, 6, 1, '2001-11-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(630, 3, 1, '2001-11-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(631, 4, 1, '2001-11-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(632, 3, 2, '2001-11-27 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(633, 4, 2, '2001-11-27 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(634, 1, 3, '2001-11-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(635, 3, 5, '2001-11-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(636, 1, 5, '2001-11-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(637, 1, 4, '2001-11-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(638, 3, 4, '2001-11-27 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(639, 1, 1, '2001-11-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(640, 6, 1, '2001-11-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(641, 3, 1, '2001-11-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(642, 4, 1, '2001-11-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(643, 3, 2, '2001-11-28 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(644, 4, 2, '2001-11-28 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(645, 1, 3, '2001-11-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(646, 3, 5, '2001-11-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(647, 1, 5, '2001-11-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(648, 1, 4, '2001-11-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(649, 3, 4, '2001-11-28 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(650, 1, 1, '2001-11-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(651, 6, 1, '2001-11-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(652, 3, 1, '2001-11-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(653, 4, 1, '2001-11-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(654, 3, 2, '2001-11-29 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(655, 4, 2, '2001-11-29 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(656, 1, 3, '2001-11-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(657, 3, 5, '2001-11-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(658, 1, 5, '2001-11-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(659, 1, 4, '2001-11-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(660, 3, 4, '2001-11-29 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(661, 1, 1, '2001-11-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(662, 6, 1, '2001-11-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(663, 3, 1, '2001-11-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(664, 4, 1, '2001-11-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(665, 3, 2, '2001-11-30 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(666, 4, 2, '2001-11-30 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(667, 1, 3, '2001-11-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(668, 3, 5, '2001-11-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(669, 1, 5, '2001-11-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(670, 1, 4, '2001-11-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(671, 3, 4, '2001-11-30 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(672, 1, 1, '2002-01-24 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(673, 6, 1, '2002-01-24 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(674, 3, 1, '2002-01-24 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(675, 4, 1, '2002-01-24 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(676, 3, 2, '2002-01-24 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(677, 4, 2, '2002-01-24 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(678, 1, 3, '2002-01-24 00:00:00-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(679, 3, 5, '2002-01-24 00:00:00-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(680, 1, 5, '2002-01-24 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(681, 1, 4, '2002-01-24 00:00:00-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(682, 3, 4, '2002-01-24 00:00:00-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(683, 3, 2, '2002-01-25 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(684, 4, 2, '2002-01-25 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(685, 1, 1, '2002-01-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(686, 6, 1, '2002-01-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(687, 3, 1, '2002-01-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(688, 4, 1, '2002-01-25 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(689, 1, 6, '2002-01-31 00:00:00-02', 0, 3);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(690, 2, 6, '2002-01-31 00:00:00-02', 0, 3);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(691, 1, 1, '2002-01-31 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(692, 6, 1, '2002-01-31 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(693, 3, 1, '2002-01-31 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(694, 7, 1, '2002-01-31 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(695, 3, 2, '2002-01-31 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(696, 4, 2, '2002-01-31 00:00:00-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(697, 1, 3, '2002-01-31 00:00:00-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(698, 3, 5, '2002-01-31 00:00:00-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(699, 1, 5, '2002-01-31 00:00:00-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(700, 1, 4, '2002-01-31 00:00:00-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(701, 3, 4, '2002-01-31 00:00:00-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(702, 1, 1, '2002-01-31 12:05:24-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(703, 6, 1, '2002-01-31 12:05:25-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(704, 3, 1, '2002-01-31 12:05:26-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(705, 7, 1, '2002-01-31 12:05:26-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(706, 1, 1, '2002-01-31 12:06:17-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(707, 6, 1, '2002-01-31 12:06:19-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(708, 3, 1, '2002-01-31 12:06:20-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(709, 7, 1, '2002-01-31 12:06:20-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(710, 3, 2, '2002-01-31 12:06:24-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(711, 4, 2, '2002-01-31 12:06:25-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(712, 1, 3, '2002-01-31 12:06:38-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(713, 3, 5, '2002-01-31 12:06:38-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(714, 1, 5, '2002-01-31 12:06:40-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(715, 1, 4, '2002-01-31 12:06:41-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(716, 3, 4, '2002-01-31 12:06:44-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(717, 1, 6, '2002-01-31 12:06:44-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(718, 2, 6, '2002-01-31 12:06:44-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(719, 1, 1, '2002-02-08 15:40:31-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(720, 6, 1, '2002-02-08 15:40:34-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(721, 3, 1, '2002-02-08 15:40:35-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(722, 7, 1, '2002-02-08 15:40:37-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(723, 1, 1, '2002-02-08 15:42:10-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(724, 6, 1, '2002-02-08 15:42:13-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(725, 3, 1, '2002-02-08 15:42:14-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(726, 7, 1, '2002-02-08 15:42:16-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(727, 3, 2, '2002-02-08 15:42:25-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(728, 4, 2, '2002-02-08 15:42:32-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(729, 1, 3, '2002-02-08 15:42:48-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(730, 3, 5, '2002-02-08 15:42:54-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(731, 1, 5, '2002-02-08 15:42:58-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(732, 1, 4, '2002-02-08 15:43:03-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(733, 3, 4, '2002-02-08 15:43:07-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(734, 1, 6, '2002-02-08 15:43:07-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(735, 2, 6, '2002-02-08 15:43:08-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(736, 1, 1, '2002-02-08 16:10:07-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(737, 6, 1, '2002-02-08 16:10:10-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(738, 3, 1, '2002-02-08 16:10:10-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(739, 7, 1, '2002-02-08 16:10:13-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(740, 3, 2, '2002-02-08 16:10:25-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(741, 4, 2, '2002-02-08 16:10:29-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(742, 1, 3, '2002-02-08 16:10:46-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(743, 3, 5, '2002-02-08 16:10:50-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(744, 1, 5, '2002-02-08 16:10:52-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(745, 1, 4, '2002-02-08 16:10:56-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(746, 3, 4, '2002-02-08 16:11:04-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(747, 1, 6, '2002-02-08 16:11:04-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(748, 2, 6, '2002-02-08 16:11:04-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(749, 8, 1, '2002-02-08 16:11:35-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(750, 1, 1, '2002-02-08 16:11:38-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(751, 6, 1, '2002-02-08 16:11:41-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(752, 3, 1, '2002-02-08 16:11:42-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(753, 7, 1, '2002-02-08 16:11:44-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(754, 3, 2, '2002-02-08 16:11:45-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(755, 4, 2, '2002-02-08 16:11:46-02', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(756, 1, 3, '2002-02-08 16:12:03-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(757, 3, 5, '2002-02-08 16:12:06-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(758, 1, 5, '2002-02-08 16:12:07-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(759, 1, 4, '2002-02-08 16:12:11-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(760, 3, 4, '2002-02-08 16:12:15-02', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(761, 1, 6, '2002-02-08 16:12:16-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(762, 2, 6, '2002-02-08 16:12:16-02', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(764, 3, 2, '2002-02-22 17:40:20-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(765, 4, 2, '2002-02-22 17:40:31-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(766, 8, 1, '2002-02-22 17:49:11-03', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(767, 1, 1, '2002-02-22 17:49:20-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(768, 6, 1, '2002-02-22 17:49:24-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(769, 3, 1, '2002-02-22 17:49:29-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(770, 7, 1, '2002-02-22 17:49:35-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(771, 3, 2, '2002-02-22 17:49:44-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(772, 4, 2, '2002-02-22 17:49:52-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(773, 1, 3, '2002-02-22 17:50:16-03', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(774, 3, 5, '2002-02-22 17:50:40-03', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(775, 1, 5, '2002-02-22 17:50:43-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(776, 1, 6, '2002-02-22 17:50:43-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(777, 2, 6, '2002-02-22 17:50:45-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(778, 3, 2, '2002-02-22 18:13:36-03', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(779, 3, 2, '2002-02-22 18:14:14-03', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(780, 4, 2, '2002-02-22 18:14:20-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(781, 3, 5, '2002-03-01 16:43:02-03', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(782, 1, 5, '2002-03-01 16:43:02-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(783, 8, 1, '2002-03-01 00:00:21-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(784, 1, 1, '2002-03-01 00:00:21-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(785, 3, 2, '2002-03-01 00:00:29-03', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(786, 3, 2, '2002-03-01 00:00:34-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(787, 4, 2, '2002-03-01 00:00:34-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(788, 1, 3, '2002-03-01 00:00:36-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(789, 1, 5, '2002-03-01 00:00:42-03', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(790, 1, 6, '2002-03-01 00:00:42-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(791, 2, 6, '2002-03-01 00:00:42-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(792, 8, 1, '2002-03-02 00:00:02-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(793, 1, 1, '2002-03-02 00:00:02-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(794, 3, 2, '2002-03-02 00:00:07-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(795, 4, 2, '2002-03-02 00:00:07-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(796, 1, 3, '2002-03-02 00:00:07-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(797, 1, 5, '2002-03-02 00:00:13-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(798, 1, 6, '2002-03-02 00:00:13-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(799, 2, 6, '2002-03-02 00:00:14-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(800, 8, 1, '2002-03-03 00:00:01-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(801, 1, 1, '2002-03-03 00:00:02-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(802, 3, 2, '2002-03-03 00:00:04-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(803, 4, 2, '2002-03-03 00:00:04-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(804, 4, 2, '2002-03-03 00:00:05-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(805, 1, 3, '2002-03-03 00:00:05-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(806, 1, 5, '2002-03-03 00:00:08-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(807, 1, 6, '2002-03-03 00:00:08-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(808, 2, 6, '2002-03-03 00:00:08-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(809, 8, 1, '2002-03-04 00:00:02-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(810, 1, 1, '2002-03-04 00:00:02-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(811, 3, 2, '2002-03-04 00:00:04-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(812, 4, 2, '2002-03-04 00:00:05-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(813, 1, 3, '2002-03-04 00:00:05-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(814, 1, 5, '2002-03-04 00:00:06-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(815, 1, 6, '2002-03-04 00:00:06-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(816, 2, 6, '2002-03-04 00:00:06-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(817, 8, 1, '2002-03-05 00:00:01-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(818, 1, 1, '2002-03-05 00:00:01-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(819, 3, 2, '2002-03-05 00:00:06-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(820, 4, 2, '2002-03-05 00:00:07-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(821, 1, 3, '2002-03-05 00:00:07-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(822, 1, 5, '2002-03-05 00:00:09-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(823, 1, 6, '2002-03-05 00:00:09-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(824, 2, 6, '2002-03-05 00:00:09-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(825, 8, 1, '2002-03-06 00:00:01-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(826, 1, 1, '2002-03-06 00:00:02-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(827, 3, 2, '2002-03-06 00:00:03-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(828, 4, 2, '2002-03-06 00:00:03-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(829, 1, 3, '2002-03-06 00:00:03-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(830, 1, 5, '2002-03-06 00:00:07-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(831, 1, 6, '2002-03-06 00:00:07-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(832, 2, 6, '2002-03-06 00:00:07-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(833, 8, 1, '2002-03-07 00:00:02-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(834, 1, 1, '2002-03-07 00:00:02-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(835, 3, 2, '2002-03-07 00:00:04-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(836, 4, 2, '2002-03-07 00:00:04-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(837, 1, 3, '2002-03-07 00:00:04-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(838, 1, 5, '2002-03-07 00:00:06-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(839, 1, 6, '2002-03-07 00:00:06-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(840, 2, 6, '2002-03-07 00:00:06-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(841, 8, 1, '2002-03-08 00:00:02-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(842, 1, 1, '2002-03-08 00:00:02-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(843, 3, 2, '2002-03-08 00:00:05-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(844, 4, 2, '2002-03-08 00:00:05-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(845, 1, 3, '2002-03-08 00:00:05-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(846, 1, 5, '2002-03-08 00:00:09-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(847, 1, 6, '2002-03-08 00:00:09-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(848, 2, 6, '2002-03-08 00:00:09-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(849, 8, 1, '2002-03-09 00:00:02-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(850, 1, 1, '2002-03-09 00:00:03-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(851, 3, 2, '2002-03-09 00:00:05-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(852, 4, 2, '2002-03-09 00:00:07-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(853, 1, 3, '2002-03-09 00:00:07-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(854, 1, 5, '2002-03-09 00:00:08-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(855, 1, 6, '2002-03-09 00:00:08-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(856, 2, 6, '2002-03-09 00:00:08-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(857, 8, 1, '2002-03-10 00:00:02-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(858, 1, 1, '2002-03-10 00:00:02-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(859, 3, 2, '2002-03-10 00:00:07-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(860, 4, 2, '2002-03-10 00:00:07-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(861, 1, 3, '2002-03-10 00:00:07-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(862, 1, 5, '2002-03-10 00:00:08-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(863, 1, 6, '2002-03-10 00:00:08-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(864, 2, 6, '2002-03-10 00:00:10-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(865, 8, 1, '2002-03-11 00:00:02-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(866, 1, 1, '2002-03-11 00:00:04-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(867, 3, 2, '2002-03-11 00:00:10-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(868, 4, 2, '2002-03-11 00:00:12-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(869, 1, 3, '2002-03-11 00:00:12-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(870, 1, 5, '2002-03-11 00:00:17-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(871, 1, 6, '2002-03-11 00:00:17-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(872, 2, 6, '2002-03-11 00:00:17-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(873, 8, 1, '2002-03-12 00:00:03-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(874, 1, 1, '2002-03-12 00:00:03-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(875, 3, 2, '2002-03-12 00:00:12-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(876, 4, 2, '2002-03-12 00:00:12-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(877, 1, 3, '2002-03-12 00:00:12-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(878, 1, 5, '2002-03-12 00:00:17-03', 1, 0);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(879, 1, 6, '2002-03-12 00:00:17-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(880, 2, 6, '2002-03-12 00:00:17-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(881, 8, 1, '2002-03-13 00:00:06-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(882, 1, 1, '2002-03-13 00:00:06-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(883, 3, 2, '2002-03-13 00:00:11-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(884, 4, 2, '2002-03-13 00:00:12-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(885, 1, 3, '2002-03-13 00:00:12-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(886, 1, 5, '2002-03-13 00:00:17-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(887, 1, 6, '2002-03-13 00:00:17-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(888, 2, 6, '2002-03-13 00:00:18-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(889, 8, 1, '2002-03-14 00:00:02-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(890, 1, 1, '2002-03-14 00:00:02-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(891, 3, 2, '2002-03-14 00:00:06-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(892, 4, 2, '2002-03-14 00:00:07-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(893, 1, 3, '2002-03-14 00:00:07-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(894, 1, 5, '2002-03-14 00:00:07-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(895, 1, 6, '2002-03-14 00:00:07-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(896, 2, 6, '2002-03-14 00:00:07-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(897, 8, 1, '2002-03-14 00:00:55-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(898, 1, 1, '2002-03-14 00:00:56-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(899, 3, 2, '2002-03-14 00:01:00-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(900, 4, 2, '2002-03-14 00:01:01-03', 0, 2);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(901, 1, 3, '2002-03-14 00:01:01-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(902, 1, 5, '2002-03-14 00:01:10-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(903, 1, 6, '2002-03-14 00:01:10-03', 0, 1);
INSERT INTO "estatistica" ("id", "id_servidor", "id_tipo", "data", "erros", "ok") VALUES(904, 2, 6, '2002-03-14 00:01:11-03', 0, 1);

/* -------------------------------------------------------- 
  Table structure for table "ftp" 
-------------------------------------------------------- */
CREATE TABLE "ftp" (
   "id" int4 DEFAULT nextval('ftp_id_seq'::text) NOT NULL,
   "servidor" varchar(40) DEFAULT '' NOT NULL,
   "host" varchar(255) DEFAULT '' NOT NULL,
   "port" int4 DEFAULT '0' NOT NULL,
   "id_status" int4 DEFAULT '0' NOT NULL,
   CONSTRAINT "ftp_pkey" PRIMARY KEY ("id")
);


/* -------------------------------------------------------- 
  Dumping data for table "ftp" 
-------------------------------------------------------- */ 

/* -------------------------------------------------------- 
  Table structure for table "http" 
-------------------------------------------------------- */
CREATE TABLE "http" (
   "id" int4 DEFAULT nextval('http_id_seq'::text) NOT NULL,
   "servidor" varchar(40) DEFAULT '' NOT NULL,
   "host" varchar(255) DEFAULT '' NOT NULL,
   "port" int4 DEFAULT '0' NOT NULL,
   "id_ssl" int4,
   "port_ssl" int4,
   "id_status" int4 DEFAULT '0' NOT NULL,
   CONSTRAINT "http_pkey" PRIMARY KEY ("id")
);


/* -------------------------------------------------------- 
  Dumping data for table "http" 
-------------------------------------------------------- */ 
INSERT INTO "http" ("id", "servidor", "host", "port", "id_ssl", "port_ssl", "id_status") VALUES(8, 'MSCO', 'www.msco.com.br', 80, 0, 443, 1);

/* -------------------------------------------------------- 
  Table structure for table "mail" 
-------------------------------------------------------- */
CREATE TABLE "mail" (
   "id" int4 DEFAULT nextval('mail_id_seq'::text) NOT NULL,
   "servidor" varchar(40) DEFAULT '' NOT NULL,
   "host_pop3" varchar(255),
   "host_smtp" varchar(255),
   "port_pop3" int4,
   "port_smtp" int4,
   "id_status_smtp" int4 DEFAULT '0' NOT NULL,
   "id_status_pop3" int4 DEFAULT '0' NOT NULL,
   CONSTRAINT "mail_pkey" PRIMARY KEY ("id")
);


/* -------------------------------------------------------- 
  Dumping data for table "mail" 
-------------------------------------------------------- */ 

/* -------------------------------------------------------- 
  Table structure for table "outros" 
-------------------------------------------------------- */
CREATE TABLE "outros" (
   "id" int4 DEFAULT nextval('outros_id_seq'::text) NOT NULL,
   "servidor" varchar(40) DEFAULT '' NOT NULL,
   "host" varchar(255) DEFAULT '' NOT NULL,
   "port" int4,
   "id_tcp" int4,
   "id_status" int4,
   CONSTRAINT "outros_pkey" PRIMARY KEY ("id")
);


/* -------------------------------------------------------- 
  Dumping data for table "outros" 
-------------------------------------------------------- */ 

/* -------------------------------------------------------- 
  Table structure for table "proxy" 
-------------------------------------------------------- */
CREATE TABLE "proxy" (
   "id" int4 DEFAULT nextval('proxy_id_seq'::text) NOT NULL,
   "servidor" varchar(40) DEFAULT '' NOT NULL,
   "host" varchar(255) DEFAULT '' NOT NULL,
   "port" int4 DEFAULT '0' NOT NULL,
   "id_status" int4 DEFAULT '0' NOT NULL,
   CONSTRAINT "proxy_pkey" PRIMARY KEY ("id")
);


/* -------------------------------------------------------- 
  Dumping data for table "proxy" 
-------------------------------------------------------- */ 

/* -------------------------------------------------------- 
  Table structure for table "status" 
-------------------------------------------------------- */
CREATE TABLE "status" (
   "id" int4 DEFAULT nextval('status_id_seq'::text) NOT NULL,
   "status" varchar(30) DEFAULT '' NOT NULL,
   CONSTRAINT "status_pkey" PRIMARY KEY ("id")
);


/* -------------------------------------------------------- 
  Dumping data for table "status" 
-------------------------------------------------------- */ 
INSERT INTO "status" ("id", "status") VALUES(1, 'Funcionando');
INSERT INTO "status" ("id", "status") VALUES(2, 'Com problemas');
INSERT INTO "status" ("id", "status") VALUES(3, 'Instável');

/* -------------------------------------------------------- 
  Table structure for table "tipo_servidor" 
-------------------------------------------------------- */
CREATE TABLE "tipo_servidor" (
   "id" int4 DEFAULT nextval('tipo_servidor_id_seq'::text) NOT NULL,
   "tipo" varchar(20) DEFAULT '' NOT NULL,
   CONSTRAINT "tipo_servidor_pkey" PRIMARY KEY ("id")
);


/* -------------------------------------------------------- 
  Dumping data for table "tipo_servidor" 
-------------------------------------------------------- */ 
INSERT INTO "tipo_servidor" ("id", "tipo") VALUES(1, 'http');
INSERT INTO "tipo_servidor" ("id", "tipo") VALUES(2, 'mail');
INSERT INTO "tipo_servidor" ("id", "tipo") VALUES(3, 'proxy');
INSERT INTO "tipo_servidor" ("id", "tipo") VALUES(4, 'bases');
INSERT INTO "tipo_servidor" ("id", "tipo") VALUES(5, 'ftp');
INSERT INTO "tipo_servidor" ("id", "tipo") VALUES(6, 'outros');

/* No Views found */

/* No Functions found */

/* No Triggers found */
