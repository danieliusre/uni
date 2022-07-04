#include <stdio.h>
#include <stdlib.h>
int main()
{
    int n, skaicius[500];
    scanf("%d", &n);
    for(int i=0; i<n; i++)
    {
        scanf("%d", &skaicius[i]);
        for(int j=0; j<i; j++)
        {
            if(skaicius[i]==skaicius[j])
            {
                skaicius[i]==0;
                i=i-1;
                n=n-1;
            }
        }
    }
    printf("\n");
    for(int i=0; i<n; i++)
    {
        printf("%d ", skaicius[i]);
    }
}
