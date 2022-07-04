#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define LENGTH 255
void isPalindrome();
int main(int argc, char *argv[])
{
    char *s;
    FILE *fdptr;
    FILE *frptr;
    s = malloc(LENGTH);
    if ((fdptr = fopen(argv[1],"r")) == NULL)
    {
       printf("Error! Nepavyko atidaryti failo arba failas neegzistuoja");
       exit(1);
    }
    frptr = fopen(argv[2], "w");
    if(frptr == NULL)
    {
        printf("Rezultatu failo negalima sukurti");
        exit(1);
    }
    while(!feof(fdptr))
    {
        fgets(s, LENGTH, fdptr);
        if(strlen(s)==LENGTH-1)
        fscanf(fdptr, "%*[^\n]%*c");
        isPalindrome(s, argv, frptr);
    }
    free(s);
    fclose(fdptr);
    fclose(frptr);
    fprintf(frptr, "\n");
}
// Ar zodis skaitomas is abieju pusiu?
void isPalindrome(char s[], char *argv[], FILE *frptr)
{
    frptr = fopen(argv[2], "a");
    char *zodis;
    zodis = malloc(LENGTH);
    char *revzodis;
    revzodis = malloc(LENGTH);
    char *ptr=s;
    while((sscanf(ptr, "%s", zodis)) == 1)
    {
    revzodis[0]='\0';
    int i=0, k=0;
    while(zodis[i]!='\0')
    {
        revzodis[i]=zodis[i];
        i++;
    }
    revzodis[i]='\0';
    strrev(revzodis);
    for(int j=0; j<i; j++)
    {
        if(zodis[j]!=revzodis[j])
        {
            k++;
        }
    }
    if(k==0)
    {
        fputs(zodis, frptr);
        fprintf(frptr, " ");
    }
    k=0;
    ptr = strstr(ptr, zodis);
    ptr += strlen(zodis);
    i=0;
    }
    free(zodis);
    free(revzodis);
}
