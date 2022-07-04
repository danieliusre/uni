//Nr. 2016028 Danielius Rekus danielius.rekus@mif.stud.vu.lt, 4

#include <stdio.h>
#include <stdlib.h>
int Validacija()
{
    int skaicius;
    while(scanf("%d", &skaicius)==0||getchar()!='\n')
        {
            scanf("%*[^\n]");
            printf("Ivestis netinka, iveskite sveika skaiciu:\n");
        }
    return skaicius;
}
void getNumber(int n, int skaiciai[])
{
    for(int i=0; i<n; i++)
    {
        skaiciai[i] = Validacija();
    }
}
void getAvg(int n, int skaiciai[], float* vid)
{
    int suma=0;
    for(int i=0; i<n; i++)
    {
        suma+=skaiciai[i];
    }
    *vid=suma/(float)n;
}
void printRez(int n, int skaiciai[], float vidurkis)
{

    int temp, mazesnis, didesnis;
    for(int i=0; i<n-1; i++)
    {
        for(int j=0; j<n-i-1; j++)
        {
            if(skaiciai[j]>skaiciai[j+1])
            {
                temp=skaiciai[j];
                skaiciai[j]=skaiciai[j+1];
                skaiciai[j+1]=temp;
            }
        }
    }
    int maz=mazesnis;
    int did=didesnis;
    for(int i=0; i<n; i++)
    {
        if((float)skaiciai[i]<vidurkis)
        {
            mazesnis=skaiciai[i];
        }
        else if((float)skaiciai[i]>vidurkis)
        {
            didesnis=skaiciai[i];
            break;
        }
    }
    if(mazesnis==maz)
        printf("Mazesnio uz vidurki nera, ");
    else
        printf("Mazesnis uz vidurki - %d, ", mazesnis);
    if(didesnis==did)
        printf("didesnio uz vidurki nera.\n");
    else
        printf("didesnis uz vidurki - %d.\n", didesnis);
}
int main()
{
    int n;
    printf("Iveskite sveika skaiciu n:\n");
    n = Validacija();
    while(n<2)
    {
        printf("n negali buti mazesnis nei 2, iveskite nauja sveika skaiciu:\n");
        n = Validacija();
    }
    int skaiciai[n];
    printf("Iveskite n sveiku skaiciu:\n");
    getNumber(n, skaiciai);
    float vidurkis;
    getAvg(n, skaiciai, &vidurkis);
    printRez(n, skaiciai, vidurkis);
    return 0;
}
