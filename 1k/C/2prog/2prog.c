//Nr. 2016028 Danielius Rekus danielius.rekus@mif.stud.vu.lt, 4

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int Validacija(int skaicius)
{
    while(scanf("%d", &skaicius)==0||getchar()!='\n')
        {
            scanf("%*[^\n]");
            printf("Ivestis netinka, iveskite sveika skaiciu:\n");
        }
    return skaicius;
}
int GetNumber(int n, int *skaiciai[], int skaicius)
{
    for(int i=0; i<n; i++)
    {
        skaiciai[i] = Validacija(skaicius);
    }
}
int main()
{
    int skaicius, n, suma=0;
    int skaiciai[n];
    printf("Iveskite sveika skaiciu n:\n");
    n = Validacija(skaicius);
    printf("Iveskite n sveiku skaiciu:\n");
    GetNumber(n, skaiciai, skaicius);
    for(int i=0; i<n; i++)
    {
        suma+=skaiciai[i];
    }
        float vidurkis;
    int mazesnis, didesnis;
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
    return 0;
}
