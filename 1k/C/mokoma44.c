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
int main()
{
    int a, b, c, didziausias;
    int n=0, temp;
    a=GetNum();
    didziausias=a;
    b=GetNum();
    if(b>didziausias)
    didziausias=b;
    c=GetNum();
    if(c>didziausias)
    didziausias=c;
    int daliklis, kartotinis;
    daliklis=didziausias;
    kartotinis=didziausias;
    int DBD, MBK;
    while(n==0)
    {
        if(a%daliklis==0 && b%daliklis==0 && c%daliklis==0)
        {
            DBD=daliklis;
            n=1;
        }
        daliklis=daliklis-1;
    }
    n=0;
    printf("DBD = %d\n", DBD);
    while(n==0)
    {
        if(kartotinis%a==0 && kartotinis%b==0 && kartotinis%c==0)
        {
            MBK=kartotinis;
            n=1;
        }
        kartotinis++;
    }
        printf("MBK = %d\n", MBK);


}

