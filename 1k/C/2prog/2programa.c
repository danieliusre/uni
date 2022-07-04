//Nr. 2016028 Danielius Rekus danielius.rekus@mif.stud.vu.lt, 4

#include <stdio.h>
#include <stdlib.h>
int GetNumber(int skaicius)
{
    while(scanf("%d", &skaicius)==0||getchar()!='\n')
        {
            scanf("%*[^\n]");
            printf("Ivestis netinka, iveskite sveika skaiciu:\n");
        }
    return skaicius;
}
int main()
{
    int skaicius, skaiciai[500], n, suma=0, mazesnis, didesnis;
    float vidurkis, suma2;
    printf("Iveskite sveika skaiciu n:\n");
    n = GetNumber(skaicius);
    printf("Iveskite n sveiku skaiciu:\n");
    for(int i=0; i<n; i++)
    {
        skaiciai[i] = GetNumber(skaicius);
        suma+=skaiciai[i];
    }
    vidurkis =(float)suma/n;
    for(int i=0; i<n; i++)
    {
        if((float)skaiciai[i]<vidurkis)
        {
            mazesnis=skaiciai[i];
        }
        else
        {
            didesnis=skaiciai[i];
            break;
        }
    }
    printf("%d %d\n", mazesnis, didesnis);
}
