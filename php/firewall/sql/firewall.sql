
/* -------------------------------------------------------- 
  phpPgAdmin 2.4a DB Dump
  http://sourceforge.net/projects/phppgadmin/
  Host: localhost:5432
  Database  : "firewall"
  2002-04-10 22:04:27
-------------------------------------------------------- */ 

/* -------------------------------------------------------- 
  Sequences 
-------------------------------------------------------- */ 
CREATE SEQUENCE "controle_id_seq" start 251 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('controle_id_seq'); 
CREATE SEQUENCE "cron_id_seq" start 13 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('cron_id_seq'); 
CREATE SEQUENCE "crt_pais_id_seq" start 9 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('crt_pais_id_seq'); 
CREATE SEQUENCE "ids_id_seq" start 20 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('ids_id_seq'); 
CREATE SEQUENCE "interfaces_id_seq" start 11 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('interfaces_id_seq'); 
CREATE SEQUENCE "nat_id_seq" start 69 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('nat_id_seq'); 
CREATE SEQUENCE "proxy_users_id_seq" start 16 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('proxy_users_id_seq'); 
CREATE SEQUENCE "regras_id_seq" start 75 increment 1 maxvalue 2147483647 minvalue 1 cache 1; 
SELECT NEXTVAL('regras_id_seq'); 

/* -------------------------------------------------------- 
  Table structure for table "controle" 
-------------------------------------------------------- */
CREATE TABLE "controle" (
   "id" int4 DEFAULT nextval('controle_id_seq'::text) NOT NULL,
   "servico" varchar(20) NOT NULL,
   "acao" varchar(7),
   CONSTRAINT "controle_pkey" PRIMARY KEY ("id")
);


/* -------------------------------------------------------- 
  Dumping data for table "controle" 
-------------------------------------------------------- */ 

/* -------------------------------------------------------- 
  Table structure for table "cron" 
-------------------------------------------------------- */
CREATE TABLE "cron" (
   "id" int4 DEFAULT nextval('cron_id_seq'::text) NOT NULL,
   "minutos" varchar(255) NOT NULL,
   "horas" varchar(255) NOT NULL,
   "dias" varchar(255) NOT NULL,
   "meses" varchar(255) NOT NULL,
   "semanas" varchar(255) NOT NULL,
   "programa" varchar(255) NOT NULL,
   CONSTRAINT "cron_pkey" PRIMARY KEY ("id")
);


/* -------------------------------------------------------- 
  Dumping data for table "cron" 
-------------------------------------------------------- */ 
INSERT INTO "cron" ("id", "minutos", "horas", "dias", "meses", "semanas", "programa") VALUES(13, '00', '*', '*', '*', '*', '/usr/local/netmon -A');

/* -------------------------------------------------------- 
  Table structure for table "ctr_pais" 
-------------------------------------------------------- */
CREATE TABLE "ctr_pais" (
   "id" int4 DEFAULT nextval('crt_pais_id_seq'::text) NOT NULL,
   "des_url" char(40),
   "cmd_iptables" varchar(255),
   "ordem" int4,
   CONSTRAINT "ctr_pais_pkey" PRIMARY KEY ("id")
);


/* -------------------------------------------------------- 
  Dumping data for table "ctr_pais" 
-------------------------------------------------------- */ 

/* -------------------------------------------------------- 
  Table structure for table "ids" 
-------------------------------------------------------- */
CREATE TABLE "ids" (
   "id" int4 DEFAULT nextval('ids_id_seq'::text) NOT NULL,
   "num_ipin" char(15) DEFAULT 'any' NOT NULL,
   "num_maskin" int4 NOT NULL,
   "num_portin" int4 NOT NULL,
   "num_ipout" char(15) DEFAULT 'any' NOT NULL,
   "num_maskout" int4 NOT NULL,
   "num_portout" int4 NOT NULL,
   "content" char(50) NOT NULL,
   "msg" char(50) NOT NULL,
   "des_alert" char(255),
   CONSTRAINT "ids_pkey" PRIMARY KEY ("id")
);


/* -------------------------------------------------------- 
  Dumping data for table "ids" 
-------------------------------------------------------- */ 

/* -------------------------------------------------------- 
  Table structure for table "ids_conf" 
-------------------------------------------------------- */
CREATE TABLE "ids_conf" (
   "ide_ativo" int4 NOT NULL
);


/* -------------------------------------------------------- 
  Dumping data for table "ids_conf" 
-------------------------------------------------------- */ 
INSERT INTO "ids_conf" ("ide_ativo") VALUES(1);

/* -------------------------------------------------------- 
  Table structure for table "interfaces" 
-------------------------------------------------------- */
CREATE TABLE "interfaces" (
   "id" int4 DEFAULT nextval('interfaces_id_seq'::text) NOT NULL,
   "des_if" char(5) NOT NULL,
   "num_ip" char(15) NOT NULL,
   "num_mask" char(15) NOT NULL,
   "num_network" char(15) NOT NULL,
   "num_broadcast" char(15) NOT NULL,
   "num_gateway" char(15),
   "ide_dhcp" int4 NOT NULL,
   "ide_nat" int4 NOT NULL,
   "ide_dhcp_serv" int4,
   CONSTRAINT "interfaces_pkey" PRIMARY KEY ("id")
);
CREATE  UNIQUE INDEX "des_if_interfaces_ukey" ON "interfaces" ("des_if");
CREATE  UNIQUE INDEX "num_ip_interfaces_ukey" ON "interfaces" ("num_ip");


/* -------------------------------------------------------- 
  Dumping data for table "interfaces" 
-------------------------------------------------------- */ 
INSERT INTO "interfaces" ("id", "des_if", "num_ip", "num_mask", "num_network", "num_broadcast", "num_gateway", "ide_dhcp", "ide_nat", "ide_dhcp_serv") VALUES(11, 'eth2 ', '192.10.10.1    ', '255.255.255.0  ', '192.10.10.0    ', '192.10.10.255  ', '...            ', 0, 0, 1);
INSERT INTO "interfaces" ("id", "des_if", "num_ip", "num_mask", "num_network", "num_broadcast", "num_gateway", "ide_dhcp", "ide_nat", "ide_dhcp_serv") VALUES(10, 'eth1 ', '192.168.10.1   ', '255.255.255.0  ', '192.168.10.0   ', '192.168.10.255 ', '...            ', 0, 0, 1);
INSERT INTO "interfaces" ("id", "des_if", "num_ip", "num_mask", "num_network", "num_broadcast", "num_gateway", "ide_dhcp", "ide_nat", "ide_dhcp_serv") VALUES(9, 'eth0 ', '200.204.99.186 ', '255.255.255.192', '200.204.99.128 ', '200.204.99.191 ', '200.204.99.129 ', 0, 1, 0);

/* -------------------------------------------------------- 
  Table structure for table "nat" 
-------------------------------------------------------- */
CREATE TABLE "nat" (
   "id" int4 DEFAULT nextval('nat_id_seq'::text) NOT NULL,
   "ide_ipin" int4,
   "num_ipin" char(15),
   "num_maskin" int4,
   "ide_portin" int4,
   "num_portin" int4,
   "ide_ipout" int4,
   "num_ipout" char(15),
   "num_maskout" int4,
   "ide_portout" int4,
   "num_portout" int4,
   "ide_iif" int4,
   "des_iif" char(5),
   "ide_oif" int4,
   "des_oif" char(5),
   "des_chain" char(15),
   "ide_protocolo" int4,
   "des_protocolo" char(4),
   "des_acao" char(15),
   "cmd_iptables" varchar(255),
   "ordem" int4,
   "ide_masq" int4,
   "ide_proxy" int4,
   CONSTRAINT "nat_pkey" PRIMARY KEY ("id")
);
CREATE  UNIQUE INDEX "ordem_nat_ukey" ON "nat" ("ordem");


/* -------------------------------------------------------- 
  Dumping data for table "nat" 
-------------------------------------------------------- */ 
INSERT INTO "nat" ("id", "ide_ipin", "num_ipin", "num_maskin", "ide_portin", "num_portin", "ide_ipout", "num_ipout", "num_maskout", "ide_portout", "num_portout", "ide_iif", "des_iif", "ide_oif", "des_oif", "des_chain", "ide_protocolo", "des_protocolo", "des_acao", "cmd_iptables", "ordem", "ide_masq", "ide_proxy") VALUES(69, NULL, '', NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, '', NULL, 'eth0 ', 'POSTROUTING    ', NULL, '', 'MASQUERADE     ', '/usr/sbin/iptables -A POSTROUTING -t nat -o eth0 -j MASQUERADE ', 1, 1, 0);

/* -------------------------------------------------------- 
  Table structure for table "proxy_conf" 
-------------------------------------------------------- */
CREATE TABLE "proxy_conf" (
   "ide_ativo" int4 NOT NULL,
   "ide_transparente" int4 NOT NULL,
   "ide_autenticado" int4 NOT NULL
);


/* -------------------------------------------------------- 
  Dumping data for table "proxy_conf" 
-------------------------------------------------------- */ 
INSERT INTO "proxy_conf" ("ide_ativo", "ide_transparente", "ide_autenticado") VALUES(1, 0, 0);

/* -------------------------------------------------------- 
  Table structure for table "proxy_users" 
-------------------------------------------------------- */
CREATE TABLE "proxy_users" (
   "id" int4 DEFAULT nextval('proxy_users_id_seq'::text) NOT NULL,
   "usuario" char(8) NOT NULL,
   "senha" char(8) NOT NULL,
   "ide_novo" int4 NOT NULL,
   CONSTRAINT "proxy_users_pkey" PRIMARY KEY ("id")
);
CREATE  UNIQUE INDEX "user_proxy_users_ukey" ON "proxy_users" ("usuario");


/* -------------------------------------------------------- 
  Dumping data for table "proxy_users" 
-------------------------------------------------------- */ 
INSERT INTO "proxy_users" ("id", "usuario", "senha", "ide_novo") VALUES(2, 'mcardia ', '12345   ', 1);
INSERT INTO "proxy_users" ("id", "usuario", "senha", "ide_novo") VALUES(16, 'teste2  ', '12345   ', 1);

/* -------------------------------------------------------- 
  Table structure for table "regras" 
-------------------------------------------------------- */
CREATE TABLE "regras" (
   "id" int4 DEFAULT nextval('regras_id_seq'::text) NOT NULL,
   "ide_ipin" int4,
   "num_ipin" char(15),
   "num_maskin" int4,
   "ide_portin" int4,
   "num_portin" int4,
   "ide_ipout" int4,
   "num_ipout" char(15),
   "num_maskout" int4,
   "ide_portout" int4,
   "num_portout" int4,
   "ide_iif" int4,
   "des_iif" char(5),
   "ide_oif" int4,
   "des_oif" char(5),
   "des_chain" char(15),
   "ide_protocolo" int4,
   "des_protocolo" char(4),
   "des_estado" char(40),
   "des_acao" char(15),
   "ide_log" int4,
   "cmd_iptables" varchar(255),
   "ordem" int4,
   CONSTRAINT "regras_pkey" PRIMARY KEY ("id")
);
CREATE  UNIQUE INDEX "ordem_regras_ukey" ON "regras" ("ordem");


/* -------------------------------------------------------- 
  Dumping data for table "regras" 
-------------------------------------------------------- */ 
INSERT INTO "regras" ("id", "ide_ipin", "num_ipin", "num_maskin", "ide_portin", "num_portin", "ide_ipout", "num_ipout", "num_maskout", "ide_portout", "num_portout", "ide_iif", "des_iif", "ide_oif", "des_oif", "des_chain", "ide_protocolo", "des_protocolo", "des_estado", "des_acao", "ide_log", "cmd_iptables", "ordem") VALUES(73, 0, '               ', 0, 0, 0, 0, '               ', 0, 0, 0, 0, '     ', 0, '     ', 'INPUT          ', 0, '    ', '                                        ', 'DROP           ', 0, '/usr/sbin/iptables -A INPUT -j DROP', 5);
INSERT INTO "regras" ("id", "ide_ipin", "num_ipin", "num_maskin", "ide_portin", "num_portin", "ide_ipout", "num_ipout", "num_maskout", "ide_portout", "num_portout", "ide_iif", "des_iif", "ide_oif", "des_oif", "des_chain", "ide_protocolo", "des_protocolo", "des_estado", "des_acao", "ide_log", "cmd_iptables", "ordem") VALUES(72, 0, '               ', 0, 0, 0, 0, '               ', 0, 0, 0, 1, 'eth0 ', 0, '     ', 'INPUT          ', 0, '    ', 'NEW                                     ', 'ACCEPT         ', 0, '/usr/sbin/iptables -A INPUT -m state --state NEW -i ! eth0 -j ACCEPT', 4);
INSERT INTO "regras" ("id", "ide_ipin", "num_ipin", "num_maskin", "ide_portin", "num_portin", "ide_ipout", "num_ipout", "num_maskout", "ide_portout", "num_portout", "ide_iif", "des_iif", "ide_oif", "des_oif", "des_chain", "ide_protocolo", "des_protocolo", "des_estado", "des_acao", "ide_log", "cmd_iptables", "ordem") VALUES(71, 0, '               ', 0, 0, 0, 0, '               ', 0, 0, 0, 0, '     ', 0, '     ', 'INPUT          ', 0, '    ', 'ESTABLISHED,RELATED                     ', 'ACCEPT         ', 0, '/usr/sbin/iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT', 3);
INSERT INTO "regras" ("id", "ide_ipin", "num_ipin", "num_maskin", "ide_portin", "num_portin", "ide_ipout", "num_ipout", "num_maskout", "ide_portout", "num_portout", "ide_iif", "des_iif", "ide_oif", "des_oif", "des_chain", "ide_protocolo", "des_protocolo", "des_estado", "des_acao", "ide_log", "cmd_iptables", "ordem") VALUES(75, 0, '               ', 0, 0, 0, 0, '               ', 0, 0, 22, 0, '     ', 0, '     ', 'INPUT          ', 0, 'TCP ', '                                        ', 'ACCEPT         ', 0, '/usr/sbin/iptables -A INPUT -p tcp --dport 22 -j ACCEPT', 1);
INSERT INTO "regras" ("id", "ide_ipin", "num_ipin", "num_maskin", "ide_portin", "num_portin", "ide_ipout", "num_ipout", "num_maskout", "ide_portout", "num_portout", "ide_iif", "des_iif", "ide_oif", "des_oif", "des_chain", "ide_protocolo", "des_protocolo", "des_estado", "des_acao", "ide_log", "cmd_iptables", "ordem") VALUES(69, 0, '               ', 0, 0, 0, 0, '               ', 0, 0, 80, 0, '     ', 0, '     ', 'INPUT          ', 0, 'TCP ', '                                        ', 'ACCEPT         ', 0, '/usr/sbin/iptables -A INPUT -p tcp --dport 80 -j ACCEPT', 2);

/* No Views found */

/* No Functions found */

/* No Triggers found */
