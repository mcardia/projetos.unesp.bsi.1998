#include <libpadrao.h>

int count_line(char *file_name)
{
    FILE *file;
    int linha = 1;
    char ch;

    file = fopen(file_name, "r");
    if ( !file )
    {
        return(0);
    }

    while ( !feof(file) )
    {
        ch = fgetc(file);

        if ( ch == '\n' ) linha++;
    }

    fclose(file);

    return(linha);
}

int insert_line(int linha, char *buffer, char *file_name)
{
    FILE *file, *temp;
    int
        cont_linha = 1,
        total_linha = count_line(file_name);
    char
        temp_file_name[255],
        ch;

    if ( (linha > total_linha) || total_linha == 0 )
    {
        return(-1);
    }
    if ( linha == 0 ) linha = total_linha;

    memset(temp_file_name, 0, 255);
    sprintf(temp_file_name, "/tmp/%s.tmp", file_name);

    file = fopen(file_name, "r");
    temp = fopen(temp_file_name, "w");
    if ( !file || !temp )
    {
        return(-1);
    }
    while ( !feof(file) && cont_linha < linha )
    {
        ch = fgetc(file);
        fprintf(temp, "%c", ch);
        if ( ch == '\n' ) cont_linha++;
    }
    fprintf(temp, "%s\n", buffer);
    while ( 1 )
    {
        ch = fgetc(file);

        if ( feof(file) ) break;

        fprintf(temp, "%c", ch);
    }
    fclose(file);
    fclose(temp);


    file = fopen(file_name, "w");
    temp = fopen(temp_file_name, "r");
    if ( !file || !temp )
    {
        return(-1);
    }
    while ( 1 )
    {
        ch = fgetc(temp);

        if ( feof(temp) ) break;

        fprintf(file, "%c", ch);
    }
    fclose(file);
    fclose(temp);
    unlink(temp_file_name);

    return(0);
}

int is_dir(char *dir)
{
	struct stat file_info;
	
	if ( stat(dir, &file_info) != 0 )
	{
		return(-1);
	} else
	{
		if ( S_ISDIR(file_info.st_mode) )
		{
			return(0);
		} else
		{
			return(1);
		}
	}	
}

int is_reg(char *path)
{
	struct stat file_info;
	
	if ( stat(path, &file_info) != 0 )
	{
		return(-1);
	} else
	{
		if ( S_ISREG(file_info.st_mode) )
		{
			return(0);
		} else
		{
			return(1);
		}
	}	
}
