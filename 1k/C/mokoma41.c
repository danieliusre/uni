#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int GetNum()
{
    int skaicius;
    while(scanf("%d", &skaicius)==0||getchar()!='\n')
        {
            scanf("%*[^\n]");
            printf("Ivestis netinka, iveskite sveika skaiciu nuo 0 iki 999:\n");
        }
    return skaicius;
}
int GetNum()
{
    int skaicius;
    while(scanf("%d", &skaicius)==0||getchar()!='\n')
        {
            scanf("%*[^\n]");
            printf("Ivestis netinka, iveskite sveika skaiciu nuo 0 iki 999:\n");
        }
    return skaicius;
}
int main()
{
    int a, b, c;
    int D;
    double x1, x2;
    a=GetNum();
    b=GetNum();
    c=GetNum();
    b=(double)b;
    printf("b = %d\n", b);
    D=(b*b)-(4*a*c);
    printf("D = %d\n", D);
    double d=sqrt((double)D);
    printf("d = %f\n", d);
    if(D<0)
        printf("Sprendiniu nera\n");
    else if(D==0)
    {
        x1=(-b)/2;
        printf("Sprendinys vienas = %d", x1);
    }
    else if(D>0)
    {
        x1=((-b)+(sqrt(D)))/2;
        x2=((-b)-(sqrt(D)))/2;
        printf("Sprendiniai du, x1 = %f, x2 = %f", x1, x2);
    }
}
