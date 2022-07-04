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
    int a, b, c;
    int n, temp;
    a=GetNum();
    b=GetNum();
    c=GetNum();
    a++;
    for(a; a<=b; a++)
    {
        if(a%c==1)
        {
            printf("%d\n", a);
        }
    }

}
