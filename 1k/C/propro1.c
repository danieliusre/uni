#include<stdio.h>
#include<stdlib.h>
int main()
{
    int a, b, n;
    int faktorialas=1;
    //scanf("%d %d", &a, &b);
    scanf("%d",&n);
    for(int i=1; i<=n; i++)
    {
        faktorialas=faktorialas*i;
    }
    printf("%d", faktorialas);

}




/*

    if(a<b)
    {
        for(int i=1; i<=b; i++)
        {
            faktorialas=faktorialas*i;
            if(faktorialas>a&&faktorialas<b)
                            printf("%d",faktorialas);
        }

    }

}
*/
