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
    int a, b;
    int temp;
    int faktorialas=1;
    a=GetNum();
    b=GetNum();
    int i=1;
    while(faktorialas<=b)
    {
        faktorialas=faktorialas*i;
        {
            if(faktorialas>=a && faktorialas <=b)
            {
                printf("Faktorialas - %d = %d!\n", faktorialas, i);
            }
        }
        i++;
    }

}
