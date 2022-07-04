#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(int argc, char *argv[])
{
    FILE *fdptr;
    if ((fdptr = fopen(argv[1],"r")) == NULL)
    {
       printf("Error! Nepavyko atidaryti failo arba failas neegzistuoja");
       exit(1);
    }

}
