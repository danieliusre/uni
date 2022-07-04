#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int GetNum()
{
    int skaicius;
    while(scanf("%d", &skaicius)==0||getchar()!='\n'||skaicius>999||skaicius<0)
        {
            scanf("%*[^\n]");
            printf("Ivestis netinka, iveskite sveika skaiciu nuo 0 iki 999:\n");
        }
    return skaicius;
}
int main()
{
    printf("Iveskite 10 sveiku skaiciu\n");
    int n=10, temp, k=0;
    int skaiciai[10];
    int daznis[10];
    for(int i=0; i<n; i++)
    {
        skaiciai[i]=0;
        daznis[i]=0;
    }
    for(int i=0; i<n; i++)
    {
        printf("Iveskite %d sekos nari:\n", i+1);
        temp=GetNum();

        for(int j=0; j<i; j++)
        {
            if(temp==skaiciai[j])
            {
                skaiciai[i]=0;
                daznis[j]++;
                k=1;
            }
        }
        if(k!=1)
        {
            skaiciai[i]=temp;
            daznis[i]++;
        }
        k=0;
    }
    for(int i=0; i<n; i++)
    {
        if(skaiciai[i]!=0)
        printf("Skaicius %d, daznis %d\n", skaiciai[i], daznis[i]);
    }

}
