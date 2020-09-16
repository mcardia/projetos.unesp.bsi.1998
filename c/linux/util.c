#include <libpadrao.h>

void input(char *valor, char *variavel, int size)
{
    if ( size < strlen(valor) )
    {
        fprintf(stderr, "Impossível armazernar a string\n");
        exit (-1);
    }
    memset( variavel, 0, size );
    strncpy(variavel, valor, strlen(valor));
}

char *trim (register const char *string)
{
   int	size = 0,
	idx = 0;
   char *rtrn;

   size = strlen (string) + 1;
   rtrn = (char *) malloc (size);
   memset (rtrn, 0, size);
   while (*string)
   {
	if ( *string == ' ' || *string == '\t' || *string == '\r' ||
		*string == '\n' )
	   string++;
	else
	   break;
   }
   while (*string)
	rtrn[idx++] = *string++;
   rtrn[idx--] = '\0';
   while (idx)
   {
	if ( rtrn[idx] == ' ' || rtrn[idx] == '\t' || rtrn[idx] == '\r' ||
		rtrn[idx] == '\n' )
	   rtrn[idx] = '\0';
	else
	   break;
	size = idx--;
   }
   (void) realloc (rtrn, size);
   return ((char *)rtrn);
}

void str_clear (char *string, char *ret)
{
   int	size = 0,
	    idx = 0;
   char *rtrn;

   size = strlen(string) + 1;
   rtrn = (char *) malloc (size);

   memset (rtrn, 0, size);

   while (*string)
   {
	if ( *string == ' ' || *string == '\t' || *string == '\r' ||
		*string == '\n' )
	   string++;
	else
	   break;
   }

	while (*string)
	{
		rtrn[idx++] = *string;
		if ( *string == ' ' )
		{
			while ( *string == ' ')
			{
				string++;
			}
			string--;
		}
		string++;
	}
   
   
   rtrn[idx--] = '\0';
   
   while (idx)
   {
	if ( rtrn[idx] == ' ' || rtrn[idx] == '\t' || rtrn[idx] == '\r' ||
		rtrn[idx] == '\n' )
	   rtrn[idx] = '\0';
	else
	   break;
	size = idx--;
   }
   strcpy( ret, rtrn);
   free(rtrn);
}

char *ap_trim (char *string)
{
   int	size = 0,
	idx = 0;
   char *rtrn;

   size = strlen (string) + 1;
   rtrn = (char *) malloc (size);
   memset (rtrn, 0, size);
   while (*string)
   {
	if (*string == ' ' || *string == '\t' || *string == '\r' ||
		*string == '\n' || *string == '"' )
	   string++;
	else
	   break;
   }
   while (*string)
	rtrn[idx++] = *string++;
   rtrn[idx--] = '\0';
   while (idx)
   {
	if (rtrn[idx] == ' ' || rtrn[idx] == '\t' || rtrn[idx] == '\r' ||
		rtrn[idx] == '\n' || rtrn[idx] == '"' )
	   rtrn[idx] = '\0';
	else
	   break;
	size = idx--;
   }
   (void) realloc (rtrn, size);
   return ((char *)rtrn);
}

char *strtolower( char *str )
{
	char *rt;
	int idx = 0;
	
	rt = (char *) malloc ( strlen(str) );
	memset(rt, 0, strlen(str));
	
	while ( *str )
	{
		rt[idx++] = tolower(*str++);
	}
	
	return( (char *) rt );
}
