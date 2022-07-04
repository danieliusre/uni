//Nr. 2016028 Danielius Rekus danielius.rekus@mif.stud.vu.lt, 9

#include <stdio.h>
#include <stdlib.h>
int main()
{
    int skaicius, lyginiai=0, ivestis=1;
    printf("Iveskite sveiku skaiciu seka (pabaiga zymima 0):\n");
    int i=0;
    while(ivestis!=0)
    {
        ivestis=GaukSkaiciu(skaicius);
        i++;
        if(i%2==0&&ivestis>0)
        {
            lyginiai++;
        }
    }
    printf("Lyginiu nariu skaicius yra %d\n", lyginiai);
}
int GaukSkaiciu(int skaicius)
{
    while(scanf("%d", &skaicius)==0||getchar()!='\n')
        {
            scanf("%*[^\n]");
            printf("Ivestis netinka, iveskite sveika skaiciu:\n");
        }
    return skaicius;
}
