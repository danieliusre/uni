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
    int n, sk1, sk2, sk3;
    sk1=GetNum();
    sk2=GetNum();
    sk3=GetNum();
    n=sk1;
    while(sk2>n)
    {
        n=sk2;
    }
    while(sk3>n)
    {
        n=sk3;
    }
    printf("Didziausias skaicius - %d", n);
}
