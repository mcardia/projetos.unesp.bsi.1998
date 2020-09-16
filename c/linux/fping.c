/* 
 * fping: fast-ping, file-ping, favorite-ping, funky-ping
 *
 *   Ping a list of target hosts in a round robin fashion.
 *   A better ping overall.
 *
 */

/* 
 ***************************************************
 *
 * Standard RCS Header information (see co(1))
 *
 * $Author: schemers $
 *
 * $Date: 1997/01/08 20:29:33 $
 *
 * $Revision: 2.2 $
 *
 * $Locker:  $
 *
 * $Source: /afs/ir/group/networking/src/fping/fping-2.2/src/RCS/fping.c,v $
 *
 * $State: Exp $
 *
 * $Log: fping.c,v $
 * Revision 2.2  1997/01/08 20:29:33  schemers
 * changes for autoconf/automake
 *
 * Revision 2.1  1997/01/08 19:07:18  schemers
 * checked in RL "Bob"'s changes before configure'ing
 *
 * Revision 2.0  1994/10/31  21:26:23  schemers
 * many changes by RL "Bob" Morgan
 *   add timing data collection, loop mode, per-packet output, etc
 *
 * Revision 1.24  1993/12/10  23:11:39  schemers
 * commented out seteuid(getuid()) since it isn't needed
 *
 * Revision 1.23  1993/12/10  18:33:41  schemers
 * Took out the -f option for non-root users. This can be enabled by
 * defining ENABLE_F_OPTION before compiling. There is a call to
 * access before opening the file, but there is a race condition.
 * Reading from stdin is much safer.
 *
 * Revision 1.22  1993/11/16  19:49:24  schemers
 * Took out setuid(getuid()) and used access() system call to
 * check for access to the file specified with "-f".
 *
 * Revision 1.21  1993/07/20  18:08:19  schemers
 * commented out the test to make sure the ping packet came from the
 * same IP address as the one we sent to. This could cause problems on
 * multi-homed hosts.
 *
 * Revision 1.20  1993/02/23  00:16:38  schemers
 * fixed syntax error (should have compiled before checking in...)
 *
 * Revision 1.19  1993/02/23  00:15:15  schemers
 * turned off printing of "is alive" when -a is specified.
 *
 * Revision 1.18  1992/07/28  15:16:44  schemers
 * added a fflush(stdout) call before the summary is sent to stderr, so
 * everything shows up in the right order.
 *
 * Revision 1.17  1992/07/23  03:29:42  schemers
 * fixed declaration of timeval_diff.
 *
 * Revision 1.16  1992/07/22  19:24:37  schemers
 * Modified file reading so it would skip blanks lines or lines starting
 * with a '#'. Now you can do something like:
 *
 * fping -ad < /etc/hosts
 *
 * Revision 1.15  1992/07/21  17:07:18  schemers
 * Put in sanity checks so only root can specify "dangerous" options.
 * Changed usage to show switchs in alphabetical order.
 *
 * Revision 1.14  1992/07/21  16:40:52  schemers
 * Now when sendto returns an error, the host is considered unreachable and
 * and the error message (from errno) is displayed.
 *
 * Revision 1.13  1992/07/17  21:02:17  schemers
 * changed default timeout to 2500 msec (for WANs), and default try
 * to 3. This gives 10 second overall timeout.
 *
 * Added -e option for showing elapsed (round-trip) time on packets
 *
 * Modified -s option to inlude to round-trip stats
 *
 * Added #ifndef DEFAULT_* stuff its easier to change the defaults
 *
 * Reorganized main loop.
 *
 * cleaned up timeval stuff. removed set_timeval and timeval_expired
 * since they aren't needed anymore. Just use timeval_diff.
 *
 * Revision 1.12  1992/07/17  16:38:54  schemers
 * move socket create call so I could do a setuid(getuid()) before the
 * fopen call is made. Once the socket is created root privs aren't needed
 * to send stuff out on it.
 *
 * Revision 1.11  1992/07/17  16:28:38  schemers
 * moved num_timeout counter. It really was for debug purposes and didn't
 * make sense to the general public :-) Now it is the number of timeouts
 * (pings that didn't get received with the time limit).
 *
 * Revision 1.10  1992/07/16  16:24:38  schemers
 * changed usage() to use fprintf(stderr,"...");
 *
 * Revision 1.9  1992/07/16  16:00:04  schemers
 * Added _NO_PROTO stuff for older compilers, and _POSIX_SOURCE
 * for unistd.h, and _POSIX_SOURCE for stdlib.h. Also added
 * check for __cplusplus.
 *
 * Revision 1.8  1992/07/16  05:44:41  schemers
 * changed -a and -u to only show hostname in results. This is
 * for easier parsing. Also added -v flag
 *
 * Revision 1.7  1992/07/14  18:45:23  schemers
 * initialized last_time in add_host function
 *
 * Revision 1.6  1992/07/14  18:32:40  schemers
 * changed select to use FD_ macros
 *
 * Revision 1.5  1992/07/14  17:21:22  schemers
 * standardized exit status codes
 *
 * Revision 1.4  1992/06/26  15:25:35  schemers
 * changed name from rrping to fping
 *
 * Revision 1.3  1992/06/24  15:39:32  schemers
 * added -d option for unreachable systems
 *
 * Revision 1.2  1992/06/23  03:01:23  schemers
 * misc fixes from R.L. "Bob" Morgan
 *
 * Revision 1.1  1992/06/19  18:23:52  schemers
 * Initial revision
 *
 *--------------------------------------------------
 * Copyright (c) 1992, 1994, 1997 Board of Trustees
 *            Leland Stanford Jr. University
 ***************************************************
 */

/*
 * Redistribution and use in source and binary forms are permitted
 * provided that the above copyright notice and this paragraph are
 * duplicated in all such forms and that any documentation,
 * advertising materials, and other materials related to such
 * distribution and use acknowledge that the software was developed
 * by Stanford University.  The name of the University may not be used 
 * to endorse or promote products derived from this software without 
 * specific prior written permission.
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
 * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 */

#ifndef _NO_PROTO
#if !__STDC__ && !defined(__cplusplus) && !defined(FUNCPROTO) \
                                                 && !defined(_POSIX_SOURCE)
#define _NO_PROTO
#endif /* __STDC__ */
#endif /* _NO_PROTO */

#ifdef __cplusplus
extern "C" {
#endif

#include <config.h>


#include <stdio.h>
#include <errno.h>
#include <time.h>
#include <signal.h>

#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif

#ifdef HAVE_STDLIB_H
#include <stdlib.h>
#endif

#include <string.h>

#include <sys/types.h>
#include <sys/time.h>
#include <sys/socket.h>

#if HAVE_SYS_FILE_H
#include <sys/file.h>
#endif

#include <netinet/in_systm.h>
#include <netinet/in.h>

/* Linux has bizarre ip.h and ip_icmp.h */
#if defined(__linux__)
#include "linux.h"
#else
#include <netinet/ip.h>
#include <netinet/ip_icmp.h>
#endif

#include <arpa/inet.h>
#include <netdb.h>

#if (defined(__unix__) || defined(unix)) && !defined(USG)
#include <sys/param.h>
#endif

/* RS6000 has sys/select.h */
#ifdef HAVE_SYS_SELECT_H
#include <sys/select.h>
#endif

#include "options.h"

/* externals */

extern char *optarg;
extern int optind,opterr;
#if !(defined(BSD) && (BSD >= 199103))
//extern char *sys_errlist[];
#endif
extern int h_errno;

#ifdef __cplusplus
}
#endif

/* Ping packet defines */

/* data added after ICMP header for our nefarious purposes */

typedef struct ping_data {
     int                  ping_count;         /* counts up to -c count or 1 */
     struct timeval       ping_ts;            /* time sent */
} PING_DATA;

#define MIN_PING_DATA sizeof(PING_DATA)
#define	MAX_IP_PACKET 65536	/* (theoretical) max IP packet size */
#define SIZE_IP_HDR 20
#define SIZE_ICMP_HDR ICMP_MINLEN   /* from ip_icmp.h */
#define MAX_PING_DATA (MAX_IP_PACKET - SIZE_IP_HDR - SIZE_ICMP_HDR)
/* sized so as to be like traditional ping */
#define DEFAULT_PING_DATA_SIZE (MIN_PING_DATA + 44) 

/* maxima and minima */
#define MAX_COUNT 10000
#define MIN_INTERVAL 10                  /* in millisec */
#define MIN_PERHOST_INTERVAL 20          /* in millisec */
#define MIN_TIMEOUT 50                   /* in millisec */
#define MAX_RETRY 20

/* response time array flags */
#define RESP_WAITING -1
#define RESP_UNUSED -2

/* debugging flags */
#ifdef DEBUG
#define DBG_TRACE 1
#define DBG_SENT_TIMES 2
#define DBG_RANDOM_LOSE_FEW 4
#define DBG_RANDOM_LOSE_MANY 8
#define DBG_PRINT_PER_SYSTEM 16
#define DBG_REPORT_ALL_RTTS 32
#endif

/* Long names for ICMP packet types */
char *icmp_type_str[19] = {
  "ICMP Echo Reply",        /* 0 */
  "",
  "",
  "ICMP Unreachable",       /* 3 */
  "ICMP Source Quench",     /* 4 */
  "ICMP Redirect",          /* 5 */
  "",
  "",
  "ICMP Echo",              /* 8 */
  "",
  "",
  "ICMP Time Exceeded",     /* 11 */
  "ICMP Paramter Problem",  /* 12 */
  "ICMP Timestamp Request", /* 13 */
  "ICMP Timestamp Reply",   /* 14 */
  "ICMP Information Request", /* 15 */
  "ICMP Information Reply",   /* 16 */
  "ICMP Mask Request",      /* 17 */
  "ICMP Mask Reply"         /* 18 */
};
char *icmp_unreach_str[16] = {
  "ICMP Network Unreachable",    /* 0 */
  "ICMP Host Unreachable",       /* 1 */
  "ICMP Protocol Unreachable",   /* 2 */
  "ICMP Port Unreachable",       /* 3 */
  "ICMP Unreachable (Fragmentation Needed)",      /* 4 */
  "ICMP Unreachable (Source Route Failed)"        /* 5 */
  "ICMP Unreachable (Destination Network Unknown)",                /* 6 */
  "ICMP Unreachable (Destination Host Unknown)",                   /* 7 */
  "ICMP Unreachable (Source Host Isolated)",                       /* 8 */
  "ICMP Unreachable (Communication with Network Prohibited)",      /* 9 */
  "ICMP Unreachable (Communication with Host Prohibited)",         /* 10 */
  "ICMP Unreachable (Network Unreachable For Type Of Service)",    /* 11 */
  "ICMP Unreachable (Host Unreachable For Type Of Service)",       /* 12 */
  "ICMP Unreachable (Communication Administratively Prohibited)",  /* 13 */
  "ICMP Unreachable (Host Precedence Violation)",                  /* 14 */
  "ICMP Unreachable (Precedence cutoff in effect)"                 /* 15 */
};
#define	ICMP_UNREACH_MAXTYPE		15

/* entry used to keep track of each host we are pinging */

typedef struct host_entry {
     struct host_entry    *prev,*next;        /* doubly linked list */
     int                  i;                  /* index into array */
     char                 *name;              /* name as given by user */
     char                 *host;              /* text description of host */
     char                 *pad;               /* pad to align print names */
     struct sockaddr_in   saddr;              /* internet address */
     int                  timeout;            /* time to wait for response */
     u_char               running;            /* unset when through sending */
     u_char               waiting;            /* waiting for response */
     struct timeval       last_send_time;     /* time of last packet sent */
     int                  num_sent;           /* number of ping packets sent */
     int                  num_recv;           /* number of pings received */
     long                 max_reply;          /* longest response time */
     long                 min_reply;          /* shortest response time */
     int                  total_time;         /* sum of response times */
     int                  num_sent_i;         /* number of ping packets sent */
     int                  num_recv_i;         /* number of pings received */
     long                 max_reply_i;        /* longest response time */
     long                 min_reply_i;        /* shortest response time */
     int                  total_time_i;       /* sum of response times */
     int                  *resp_times;        /* individual response times */
#ifdef DEBUG
     int                  *sent_times;        /* per-sent-ping timestamp */
#endif
} HOST_ENTRY;

/* globals */

HOST_ENTRY *rrlist=NULL;    /* linked list of hosts be pinged */
HOST_ENTRY **table=NULL;    /* array of pointers to items in the list */
HOST_ENTRY *cursor;

char *prog;
int ident;                  /* our pid */
int s;                      /* socket */
u_int debugging = 0;

/* times get *100 because all times are calculated in 10 usec units, not ms */
u_int retry = DEFAULT_RETRY;
u_int timeout = DEFAULT_TIMEOUT * 100; 
u_int interval = DEFAULT_INTERVAL * 100;
u_int perhost_interval = DEFAULT_PERHOST_INTERVAL * 100;
float backoff = DEFAULT_BACKOFF_FACTOR;
u_int select_time = DEFAULT_SELECT_TIME * 100;
u_int ping_data_size = DEFAULT_PING_DATA_SIZE;
u_int ping_pkt_size;
u_int count = 1;
u_int trials;
u_int report_interval = 0;

/* global stats */
long max_reply=0;
long min_reply=1000000;
int total_replies=0;
double sum_replies=0;
int max_hostname_len = 0;
int num_jobs=0;                   /* number of hosts still to do */
int num_hosts;                    /* total number of hosts */
int num_alive=0,                  /* total number alive */
    num_unreachable=0,            /* total number unreachable */
    num_noaddress=0;              /* total number of addresses not found */
int num_timeout=0,                /* number of times select timed out */
    num_pingsent=0,               /* total pings sent */
    num_pingreceived=0,           /* total pings received */
    num_othericmprcvd=0;          /* total non-echo-reply ICMP received */

struct timeval current_time;      /* current time (pseudo) */
struct timeval start_time; 
struct timeval end_time;
struct timeval last_send_time;         /* time last ping was sent */
struct timeval last_report_time;       /* time last report was printed */
struct timezone tz;

/* switches */
int verbose_flag,quiet_flag,stats_flag,unreachable_flag,alive_flag;
int elapsed_flag,version_flag,count_flag,loop_flag;
int per_recv_flag,report_all_rtts_flag,name_flag,addr_flag,backoff_flag;
int multif_flag;
#ifdef DEBUG
int randomly_lose_flag,sent_times_flag,trace_flag,print_per_system_flag;
int lose_factor;
#endif

char *filename=NULL;               /* file containing hosts to ping */

/* forward declarations */

#ifdef _NO_PROTO

int add_name();
void add_addr();
char *na_cat();
char *cpystr();
void crash_and_burn();
void errno_crash_and_burn();
char *get_host_by_address();
int in_cksum();
void u_sleep();
int recvfrom_wto ();
void remove_job();
void send_ping();
int wait_for_reply();
long timeval_diff();
void print_per_system_stats();
void print_per_system_splits();
void print_global_stats();
int finish();
int handle_random_icmp();
char *sprint_tm();

#else

int add_name(char *name);
void add_addr(char *name, char *host, struct in_addr ipaddr);
char *na_cat(char *name, struct in_addr ipaddr);
char *cpystr(char *string);
void crash_and_burn(char *message);
void errno_crash_and_burn(char *message);
char *get_host_by_address(struct in_addr in);
int in_cksum(u_short *p, int n);
void u_sleep(int u_sec);
int recvfrom_wto (int s, char *buf, int len, struct sockaddr *saddr, int timo);
void remove_job(HOST_ENTRY *h);
void send_ping(int s,HOST_ENTRY *h);
long timeval_diff(struct timeval *a,struct timeval *b);
int wait_for_reply();
void print_per_system_stats();
void print_per_system_splits();
void print_global_stats();
int finish();
int handle_random_icmp(struct icmp *p, int psize, struct sockaddr_in *addr);
char *sprint_tm(int t);

#endif

#ifdef _NO_PROTO
int fping(char *host)
#else
int fping(char *host)
#endif
{
  int i, n;
  u_int lt, ht;
  int advance;
  struct protoent *proto;
  char *buf;

  max_reply=0;
  min_reply=1000000;
  total_replies=0;
  sum_replies=0;
  max_hostname_len = 0;
  num_jobs=0;                   /* number of hosts still to do */
  num_hosts=0;                    /* total number of hosts */
  num_alive=0;                  /* total number alive */
  num_unreachable=0;            /* total number unreachable */
  num_noaddress=0;              /* total number of addresses not found */
  num_timeout=0;                /* number of times select timed out */
  num_pingsent=0;               /* total pings sent */
  num_pingreceived=0;           /* total pings received */
  num_othericmprcvd=0;          /* total non-echo-reply ICMP received */


  if ((proto = getprotobyname("icmp")) == NULL) 
             crash_and_burn("icmp: unknown protocol");
  s = socket(AF_INET, SOCK_RAW, proto->p_proto);
  if (s<0) errno_crash_and_burn("can't create raw socket");

  /*seteuid(getuid());*/

  prog = "fping";
  ident = getpid() & 0xFFFF;

  verbose_flag = 1;
  backoff_flag = 1;

  opterr = 1;

  /* muck about based on various option settings */


  if (alive_flag || unreachable_flag) verbose_flag=0;
  if (count_flag) {
    if (verbose_flag)
      per_recv_flag = 1;
    alive_flag = unreachable_flag = verbose_flag = 0;
  }
  if (loop_flag) {
    if (!report_interval)
      per_recv_flag = 1;
    alive_flag = unreachable_flag = verbose_flag = 0;
  }

  trials = (count > retry+1) ? count : retry+1;

#ifdef DEBUG
  if (debugging & DBG_TRACE)
    trace_flag = 1;
  if ((debugging & DBG_SENT_TIMES) && !loop_flag)
    sent_times_flag = 1;
  if (debugging & DBG_RANDOM_LOSE_FEW) {
    randomly_lose_flag = 1;
    lose_factor = 1;     /* ie, 1/4 */
  }
  if (debugging & DBG_RANDOM_LOSE_MANY) {
    randomly_lose_flag = 1;
    lose_factor = 5;     /* ie, 3/4 */
  }
  if (debugging & DBG_PRINT_PER_SYSTEM)
    print_per_system_flag = 1;
  if ((debugging & DBG_REPORT_ALL_RTTS) && !loop_flag)
    report_all_rtts_flag = 1;

#endif

  /* handle host names supplied on command line or in a file */

  if ( ! add_name(host) ) return(0);
  num_hosts=1;
  
  if (!num_hosts) exit(2);

  /* allocate array to hold outstanding ping requests */

  table = (HOST_ENTRY **) malloc(sizeof(HOST_ENTRY *)*num_hosts);
  if (!table) crash_and_burn("Can't malloc array of hosts");

  cursor=rrlist;

  for( num_jobs=0; num_jobs < num_hosts; num_jobs++ ) {
      table[num_jobs]=cursor;
      cursor->i = num_jobs;
      /* as long as we're here, put this in so names print out nicely */
      if (count_flag || loop_flag) {
	n = max_hostname_len - strlen(cursor->host);
	buf = (char *) malloc(n + 1);
	if (!buf) crash_and_burn("can't malloc host pad");
	for (i = 0; i < n; i++)
	  buf[i] = ' ';
	buf[n] = '\0';
	cursor->pad = buf;
      }
      cursor=cursor->next;
  }

  ping_pkt_size = ping_data_size + SIZE_ICMP_HDR;
  gettimeofday(&start_time,&tz);
  current_time = start_time;
  if (report_interval)
    last_report_time = start_time;
  last_send_time.tv_sec = current_time.tv_sec - 10000;
#ifdef DEBUG
  if (randomly_lose_flag) 
    srandom(start_time.tv_usec);
#endif
  cursor=rrlist;
  advance = 0;

  /* main loop */
  while (num_jobs) {
    if (num_pingsent)
      while(wait_for_reply()) {  /* call wfr until we timeout */
	/* wait! */
      };
    if (cursor && advance) cursor = cursor->next;
    gettimeofday(&current_time,&tz);
    lt = timeval_diff(&current_time, &last_send_time);
    ht = timeval_diff(&current_time, &cursor->last_send_time);
    if (report_interval && 
	(loop_flag || count_flag) &&
	(timeval_diff(&current_time, &last_report_time)
	> report_interval)) {
      print_per_system_splits();
      gettimeofday(&current_time,&tz);
      lt = timeval_diff(&current_time, &last_send_time);
      ht = timeval_diff(&current_time, &cursor->last_send_time);
      last_report_time = current_time;
    }
      
    advance = 1;
    /* if it's OK to send while counting or looping or starting */
    if ((lt > interval) && (ht > perhost_interval)) {
      /* send if starting or looping */
      if ((cursor->num_sent == 0) || loop_flag) {
	send_ping(s, cursor);
	continue;
      }
      /* send if counting and count not exceeded */
      if (count_flag) {
	if (cursor->num_sent < count) {
	  send_ping(s,cursor);
	  continue;
	}
      }
    }
    /* is-it-alive mode, and timeout exceeded while waiting for a reply */
    /*   and we haven't exceeded our retries                            */
    if ((lt > interval) && !count_flag && !loop_flag &&
	!cursor->num_recv &&
	(ht > cursor->timeout) &&
	(cursor->waiting < retry+1)) {
      num_timeout++;
      /* try again */
      if (backoff_flag)
	cursor->timeout *= backoff;
      send_ping(s,cursor);
      continue;
    }
    /* didn't send, can we remove? */
    /* never remove if looping */
    if (loop_flag)
      continue;
    /* remove if counting and count exceeded */
    /* but allow time for the last one to come in */
    if (count_flag) {
      if ((cursor->num_sent >= count) &&
	  (ht > cursor->timeout)) {
	remove_job(cursor);
	continue;
      }
    } else {
      /* normal mode, and we got one */
      if (cursor->num_recv) {
	remove_job(cursor);
	continue;
      }
      /* normal mode, and timeout exceeded while waiting for a reply */
      /* and we've run out of retries, so node is unreachable */
      if ((ht > cursor->timeout) &&
	  (cursor->waiting >= retry+1)) {
	num_timeout++;
	remove_job(cursor);
	continue;
      }
    }
    /* could send to this host, so keep considering it */
    if (ht > interval)
      advance = 0;
  }
  return(finish());
}

#ifdef _NO_PROTO
int finish()
#else
int finish()
#endif
{
  int i;
  HOST_ENTRY *h;

  gettimeofday(&end_time,&tz);

  /* tot up unreachables */
  for (i = 0; i < num_hosts; i++) {
    h = table[i];
    if (!h->num_recv) {
      num_unreachable++;
      if(verbose_flag || unreachable_flag) {
	if ( verbose_flag )
		return(0);
      }
    }
  }

  if (num_noaddress) return(0);
  else if (num_alive != num_hosts) return(0); 
  
  return(1);
}

#ifdef _NO_PROTO
void print_per_system_stats ()
#else
void print_per_system_stats ()
#endif
{
  int i, avg;
  HOST_ENTRY *h;
  char *buf;
  int bufsize;

  bufsize = max_hostname_len + 1;
  buf = (char *) malloc(bufsize);
  if (!buf) crash_and_burn("can't malloc print buf");
  memset(buf, 0, bufsize);

  fflush(stdout);
  for (i = 0; i < num_hosts; i++) {
    h = table[i];
    if (! report_all_rtts_flag) {
      if (h->num_recv) {
	avg = h->total_time / h->num_recv;
      }
    }
  }
  free(buf);
}


#ifdef _NO_PROTO
void print_per_system_splits ()
#else
void print_per_system_splits ()
#endif
{
  int i, avg;
  HOST_ENTRY *h;
  char *buf;
  int bufsize;
  struct tm *curr_tm;

  bufsize = max_hostname_len + 1;
  buf = (char *) malloc(bufsize);
  if (!buf) crash_and_burn("can't malloc print buf");
  memset(buf, 0, bufsize);

  fflush(stdout);
  curr_tm = localtime((time_t *)&current_time.tv_sec);
  for (i = 0; i < num_hosts; i++) {
    h = table[i];
    if (h->num_recv_i) {
      avg = h->total_time_i / h->num_recv_i;
    }
    h->num_sent_i = h->num_recv_i = h->max_reply_i = h->min_reply_i = 
      h->total_time_i = 0;
  }
  free(buf);
}

#ifdef _NO_PROTO
void print_global_stats()
#else
void print_global_stats()
#endif
{
  fflush(stdout);
  if (total_replies==0) {
    min_reply=0; max_reply=0; total_replies=1; sum_replies=0;
  }

}

/*
 * 
 * Compose and transmit an ICMP_ECHO REQUEST packet.  The IP packet
 * will be added on by the kernel.  The ID field is our UNIX process ID,
 * and the sequence number is an index into an array of outstanding
 * ping requests. The sequence number will later be used to quickly
 * figure out who the ping reply came from.
 *
 */

#ifdef _NO_PROTO
void send_ping(s,h)
int s; HOST_ENTRY *h;
#else
void send_ping(int s,HOST_ENTRY *h)
#endif
{
  char *buffer;
  struct icmp *icp;
  PING_DATA *pdp;
  int n;

  buffer = (char *) malloc ((size_t)ping_pkt_size);
  if (!buffer) crash_and_burn("can't malloc ping packet");
  memset(buffer, 0, ping_pkt_size * sizeof(char));
  icp = (struct icmp *) buffer;

  icp->icmp_type = ICMP_ECHO;
  icp->icmp_code = 0;
  icp->icmp_cksum = 0;
  icp->icmp_seq = h->i;
  icp->icmp_id = ident;

  pdp = (PING_DATA *) (buffer + SIZE_ICMP_HDR);
  /* set the time at the very last possible point */
  gettimeofday(&h->last_send_time,&tz);
  pdp->ping_ts = h->last_send_time;
  pdp->ping_count = h->num_sent;

  icp->icmp_cksum = in_cksum( (u_short *)icp, ping_pkt_size );

  n = sendto( s, buffer, ping_pkt_size, 0, (struct sockaddr *)&h->saddr, 
                                               sizeof(struct sockaddr_in) );
  if( n < 0 || n != ping_pkt_size ) {
      num_unreachable++;
      remove_job(h); 
  } else {
       /* mark this trial as outstanding */
    if (!loop_flag)
      h->resp_times[h->num_sent] = RESP_WAITING;
#ifdef DEBUG
    if (sent_times_flag)
      h->sent_times[h->num_sent] = 
	timeval_diff(&h->last_send_time, &start_time);
#endif
    h->num_sent++; h->num_sent_i++;
    h->waiting++;
    num_pingsent++;
    last_send_time = h->last_send_time;
  }
  free(buffer);
}

#ifdef _NO_PROTO
int wait_for_reply()
#else
int wait_for_reply()
#endif
{
  int result;
  static char buffer[4096];
  struct sockaddr_in response_addr;
  struct ip *ip;
  int hlen;
  struct icmp *icp;
  int n, avg;
  HOST_ENTRY *h;
  PING_DATA *pdp;
  long this_reply;
  int this_count;
  struct timeval sent_time;

  result=recvfrom_wto(s,buffer,4096,
                     (struct sockaddr *)&response_addr,select_time);

  /* get time of receipt as close to the real time as possible */
  gettimeofday(&current_time,&tz);

  if (result<0) { return 0; } /* timeout */
  
#ifdef DEBUG
  if (randomly_lose_flag)
    if ((random() & 0x07) <= lose_factor)
      return 0;
#endif
  ip = (struct ip *) buffer;
#if defined(__alpha__) && defined(__osf1__) && __STDC__
  /* The alpha headers are decidedly broken.
   * Using an ANSI compiler, it provides ip_vhl instead of ip_hl and
   * ip_v.  So, to get ip_hl, we mask off the bottom four bits.
   */
  hlen = (ip->ip_vhl & 0x0F) << 2;
#else
  hlen = ip->ip_hl << 2;
#endif

  if (result < hlen+ICMP_MINLEN) { 
    return(1); /* too short */ 
  }

  icp = (struct icmp *)(buffer + hlen);
  if (icp->icmp_type != ICMP_ECHOREPLY) {
    /* handle some problem */
    if (handle_random_icmp(icp, result, &response_addr))
      num_othericmprcvd++;
    return 1;
  }

  if (icp->icmp_id   != ident)
       return 1; /* packet received, but not the one we are looking for! */

  num_pingreceived++;

  if (icp->icmp_seq  >= (n_short)num_hosts)
    return(1); /* packet received, don't worry about it anymore */

  n=icp->icmp_seq;
  h=table[n];

  /* received ping is cool, so process it */
  h->waiting = 0;
  h->timeout = timeout;
  h->num_recv++;  h->num_recv_i++;

  pdp = (PING_DATA *)icp->icmp_data;
  sent_time = pdp->ping_ts;
  this_count = pdp->ping_count;
  this_reply = timeval_diff(&current_time,&sent_time);
  if (this_reply > max_reply) max_reply=this_reply;
  if (this_reply < min_reply) min_reply=this_reply;
  if (this_reply > h->max_reply) h->max_reply=this_reply;
  if (this_reply < h->min_reply) h->min_reply=this_reply;
  if (this_reply > h->max_reply_i) h->max_reply_i=this_reply;
  if (this_reply < h->min_reply_i) h->min_reply_i=this_reply;
  sum_replies += this_reply;
  h->total_time += this_reply;
  h->total_time_i += this_reply;
  total_replies++;
  /* note reply time in array, probably */
  if (!loop_flag) {
    if ((this_count >= 0) && (this_count < trials)) {
      if (h->resp_times[this_count] == RESP_WAITING) {
	h->resp_times[this_count] = this_reply;
      }
    }
  }

  if (h->num_recv == 1) {
    num_alive++;
  }

  if (per_recv_flag) {
    avg = h->total_time / h->num_recv;
  }
  return num_jobs;
}

#ifdef _NO_PROTO
int handle_random_icmp(p, psize, addr)
     struct icmp *p;
     int psize;
     struct sockaddr_in *addr;
#else
int handle_random_icmp(struct icmp *p, int psize, struct sockaddr_in *addr)
#endif
{
  struct icmp *sent_icmp;
  u_char *c;
  HOST_ENTRY *h;

  c = (u_char *)p;
  switch (p->icmp_type) {
  case ICMP_UNREACH:
    sent_icmp = (struct icmp *) (c + 28);
    if ((sent_icmp->icmp_type == ICMP_ECHO) &&
	(sent_icmp->icmp_id == ident) &&
	(sent_icmp->icmp_seq < (n_short)num_hosts)) {
      /* this is a response to a ping we sent */
      h = table[sent_icmp->icmp_seq];
    }
    return 1;
  case ICMP_SOURCEQUENCH:
  case ICMP_REDIRECT:
  case ICMP_TIMXCEED:
  case ICMP_PARAMPROB:
    sent_icmp = (struct icmp *) (c + 28);
    if ((sent_icmp->icmp_type = ICMP_ECHO) &&
	(sent_icmp->icmp_id = ident) &&
	(sent_icmp->icmp_seq < (n_short)num_hosts)) {
      /* this is a response to a ping we sent */
      h = table[sent_icmp->icmp_seq];
    }
    return 2;
  /* no way to tell whether any of these are sent due to our ping */
  /* or not (shouldn't be, of course), so just discard            */
  case ICMP_TSTAMP:
  case ICMP_TSTAMPREPLY:
  case ICMP_IREQ:
  case ICMP_IREQREPLY:
  case ICMP_MASKREQ:
  case ICMP_MASKREPLY:
  default:
    return 0;
  }
}

/*
 * Checksum routine for Internet Protocol family headers (C Version)
 * From ping examples in W.Richard Stevens "UNIX NETWORK PROGRAMMING" book.
 */

#ifdef _NO_PROTO
int in_cksum(p,n)
u_short *p; int n;
#else
int in_cksum(u_short *p, int n)
#endif
{
  register u_short answer;
  register long sum = 0;
  u_short odd_byte = 0;

  while( n > 1 )  { sum += *p++; n -= 2; }

  /* mop up an odd byte, if necessary */
  if( n == 1 ) {
      *(u_char *)(&odd_byte) = *(u_char *)p;
      sum += odd_byte;
  }

  sum = (sum >> 16) + (sum & 0xffff);	/* add hi 16 to low 16 */
  sum += (sum >> 16);			/* add carry */
  answer = ~sum;			/* ones-complement, truncate*/
  return (answer);
}


/* process input name for addition to target list */
/*   name can turn into multiple targets via multiple interfaces (-m) */
/*   or via NIS groups */

#ifdef _NO_PROTO
int add_name(name)
char *name;
#else
int add_name(char *name)
#endif
{
  struct hostent *host_ent;
  u_int ipaddress;
  struct in_addr *ipa = (struct in_addr *)&ipaddress;
  struct in_addr *host_add;
  char *nm;
  int i = 0;

  if ((ipaddress = inet_addr(name)) != -1) {
    /* input name is an IP addr, go with it */
    if (name_flag) {
      if (addr_flag) {
	add_addr(name, na_cat(get_host_by_address(*ipa), *ipa), *ipa);
      } else {
	nm = cpystr(get_host_by_address(*ipa));
	add_addr(name, nm, *ipa);
      }
    } else {
      add_addr(name, name, *ipa);
    }
    return(1);
  }
  /* input name is not an IP addr, maybe it's a host name */
  host_ent = gethostbyname(name); 
  if (host_ent == NULL) { 
    if (h_errno == TRY_AGAIN) { 
      u_sleep(DNS_TIMEOUT) ; 
      host_ent = gethostbyname(name) ;
    }
    if (host_ent == NULL) {
#ifdef NIS_GROUPS
      /* maybe it's the name of a NIS netgroup */
      char *machine, *user_ignored, *domain_ignored;
      setnetgrent(name);
      if (getnetgrent(&machine, &user_ignored, &domain_ignored)==0){
	endnetgrent();
	if (!quiet_flag) return(0);
	num_noaddress++;
	return(1);
      } else {
	if ( ! add_name(cpystr(machine)) ) return(0);
      }
      while(getnetgrent(&machine, &user_ignored, &domain_ignored))
	add_name(cpystr(machine));
      endnetgrent();
      return(1);
#else
      if (!quiet_flag) return(0);
      num_noaddress++;
      return(1) ; 
#endif
    }
  }
  host_add = (struct in_addr *) *(host_ent->h_addr_list) ; 
  if (host_add == NULL) { 
    if (!quiet_flag) return(0);
    num_noaddress++;
    return(1) ; 
  } else {
    /* it is indeed a hostname with a real address */
    while (host_add) {
      if (name_flag && addr_flag) {
	add_addr(name, na_cat(name, *host_add), *host_add);
      } else if (addr_flag) {
	nm = cpystr(inet_ntoa(*host_add));
	add_addr(name, nm, *host_add);
      } else {
	add_addr(name, name, *host_add);
      }
      if (!multif_flag) break;
      host_add = (struct in_addr *) (host_ent->h_addr_list[++i]) ; 
    }
  }
  return(1);
}

#ifdef _NO_PROTO
char *na_cat(name, ipaddr)
char *name;
struct in_addr ipaddr;
#else
char *na_cat(char *name, struct in_addr ipaddr)
#endif
{
  char *nm, *as;

  as = inet_ntoa(ipaddr);
  nm = (char *) malloc(strlen(name) + strlen(as) + 4);
  if (!nm) crash_and_burn("can't allocate some space for a string");
  strcpy(nm, name);
  strcat(nm, " (");
  strcat(nm, as);
  strcat(nm, ")");
  return(nm);
}

/* add address to linked list of targets to be pinged */
/* assume memory for *name and *host is ours!!!       */

#ifdef _NO_PROTO
void add_addr(name, host, ipaddr)
char *name;
char *host;
struct in_addr ipaddr;
#else
void add_addr(char *name, char *host, struct in_addr ipaddr)
#endif
{
  HOST_ENTRY *p;
  int n, *i;

  p = (HOST_ENTRY *) malloc(sizeof(HOST_ENTRY));
  if (!p) crash_and_burn("can't allocate HOST_ENTRY");
  memset((char *) p, 0, sizeof(HOST_ENTRY));

  p->name = name;
  p->host = host;
  p->saddr.sin_family = AF_INET;
  p->saddr.sin_addr = ipaddr; 
  p->timeout = timeout;
  p->running = 1;
  p->min_reply = 10000000;

  if (strlen(p->host) > max_hostname_len)
    max_hostname_len = strlen(p->host);

  /* array for response time results */
  if (!loop_flag) {
    i = (int *) malloc(trials * sizeof(int));
    if (!i) crash_and_burn("can't allocate resp_times array");
    for (n = 1; n < trials; n++)
      i[n] = RESP_UNUSED;
    p->resp_times = i;
  }
#ifdef DEBUG
  /* likewise for sent times */
  if (sent_times_flag) {
    i = (int *) malloc(trials * sizeof(int));
    if (!i) crash_and_burn("can't allocate sent_times array");
    for (n = 1; n < trials; n++)
      i[n] = RESP_UNUSED;
    p->sent_times = i;
  }
#endif

  if (!rrlist) {
      rrlist = p;
      p->next = p;
      p->prev = p;
  } else {
      p->next = rrlist;
      p->prev = rrlist->prev;
      p->prev->next = p;
      p->next->prev = p;
  }
  num_hosts++;
}

#ifdef _NO_PROTO
void remove_job(h)
HOST_ENTRY *h;
#else
void remove_job(HOST_ENTRY *h)
#endif
{

  h->running = 0;
  h->waiting = 0;
  --num_jobs;

  if (num_jobs) {                    /* remove us from list of active jobs */
       h->prev->next = h->next;
       h->next->prev = h->prev;
       if (h==cursor) { cursor = h->next; }
  } else {     
       cursor=NULL;
       rrlist=NULL;
  }

}

#ifdef _NO_PROTO
char *get_host_by_address(in)
struct in_addr in;
#else
char *get_host_by_address(struct in_addr in)
#endif
{
  struct hostent *h;
   h=gethostbyaddr((char *) &in,sizeof(struct in_addr),AF_INET);
   if (h==NULL || h->h_name==NULL) return inet_ntoa(in);
   else return (char*)h->h_name;
}


#ifdef _NO_PROTO
char *cpystr(string)
char *string;
#else
char *cpystr(char *string)
#endif
{
  char *dst;

  if (string) {         
      dst = (char *) malloc (1+strlen (string));
      if (!dst) crash_and_burn("can't allocate some space for a string");
      strcpy (dst, string);
      return dst;
  }
  else 
      return NULL;
}
  
#ifdef _NO_PROTO
void crash_and_burn(message)
char *message;
#else
void crash_and_burn(char *message)
#endif
{
  exit(4);
}

#ifdef _NO_PROTO
void errno_crash_and_burn(message)
char *message;
#else
void errno_crash_and_burn(char *message)
#endif
{
  exit(4);
}

/* timeval_diff now returns result in hundredths of milliseconds */
/*   ie, tens of microseconds                                    */
#ifdef _NO_PROTO
long timeval_diff(a,b)
struct timeval *a,*b;
#else
long timeval_diff(struct timeval *a,struct timeval *b)
#endif
{
double temp;

temp = 
  (((a->tv_sec*1000000)+ a->tv_usec) - 
     ((b->tv_sec*1000000)+ b->tv_usec))/10;

return (long) temp;

}

/*
 * sprint_time: render time into a string with three digits of precision
 *              input is in tens of microseconds
 */

#ifdef _NO_PROTO
char * sprint_tm(t)
int t;
#else
char * sprint_tm(int t)
#endif
{
  static char buf[10];

  /* <= 0.99 ms */
  if (t < 100) {
    sprintf(buf, "0.%02d", t);
    return(buf);
  }
  /* 1.00 - 9.99 ms */
  if (t < 1000) {
    sprintf(buf, "%d.%02d", t/100, t%100);
    return(buf);
  }
  /* 10.0 - 99.9 ms */
  if (t < 10000) {
    sprintf(buf, "%d.%d", t/100, (t%100)/10);
    return(buf);
  }
  /* >= 100 ms */
  sprintf(buf, "%d", t/100);
  return(buf);
}

#ifdef _NO_PROTO
void u_sleep (u_sec)
int u_sec;
#else
void u_sleep (int u_sec)
#endif
{
  int nfound;
  struct timeval to;
  fd_set readset,writeset;

  to.tv_sec  = u_sec/1000000;
  to.tv_usec = u_sec - (to.tv_sec*1000000);

  FD_ZERO(&readset);
  FD_ZERO(&writeset);
  nfound = select(0, &readset, &writeset, NULL, &to);
  if (nfound<0) errno_crash_and_burn("select");
  return;
}

/*
 * recvfrom_wto: receive with timeout
 *      returns length of data read or -1 if timeout
 *      crash_and_burn on any other errrors
 *
 */

#ifdef _NO_PROTO
int recvfrom_wto (s,buf,len, saddr, timo)
int s; char *buf; int len; struct sockaddr *saddr; int timo;
#else
int recvfrom_wto (int s, char *buf, int len, struct sockaddr *saddr, int timo)
#endif
{
  int nfound,slen,n;
  struct timeval to;
  fd_set readset,writeset;

  to.tv_sec  = timo/100000;
  to.tv_usec = (timo - (to.tv_sec*100000))*10;

  FD_ZERO(&readset);
  FD_ZERO(&writeset);
  FD_SET(s,&readset);
  nfound = select(s+1,&readset,&writeset,NULL,&to);
  if (nfound<0) errno_crash_and_burn("select");
  if (nfound==0) return -1;  /* timeout */
  slen=sizeof(struct sockaddr);
  n=recvfrom(s,buf,len,0,saddr,&slen);
  if (n<0) errno_crash_and_burn("recvfrom");
  return n;
}
