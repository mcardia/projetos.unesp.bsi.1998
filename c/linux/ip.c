#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <ifaddrs.h>
#include <netinet/in.h>

int main (int argc, char **argv) 
{
    struct ifaddrs *ifap;
	struct sockaddr_in *s;

    if ( getifaddrs(&ifap) != 0 )
    {
        fprintf(stderr, "Nao foi possivel obter as informacoes.\n");
        return(-1);
    }        
    
    while ( ifap ) {
        if ( ifap->ifa_addr != NULL && ifap->ifa_addr->sa_family == AF_INET)
        {
            s = (struct sockaddr_in *)ifap->ifa_addr;
            fprintf(stdout, "%s: %s ", ifap->ifa_name, inet_ntoa(s->sin_addr));
            s = (struct sockaddr_in *)ifap->ifa_netmask;
            fprintf(stdout, "%s\n", inet_ntoa(s->sin_addr));
        }
        ifap = ifap->ifa_next;
    }

    freeifaddrs(ifap);
    return(0);
}
