#include <stdio.h>
#include <stdlib.h>
int main(void)
{
    int sk=1, sum=0, rc;
    printf("Iveskite sveiku skaiciu seka (pabaiga zymima 0):\n");
    int i=0;
    while(sk!=0)
    {
        scanf("%d", &sk);
        if(rc=scanf("%d", &sk)==0)
        {
            scanf("%*[^\n]");
            printf("Ivestis netinka, iveskite sveika skaiciu:\n");
        }
        i++;
        if(i%2==0)
        {
            sum+=sk;
        }
    }
    printf("Lyginiu nariu suma yra %d", sum);
}
