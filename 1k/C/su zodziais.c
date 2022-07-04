#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int main()
{
    char A[999];
    int n=0, m=0, i=0;
    label:
    scanf("%s", A);
    if(A[n]!='\n')
    {
        n++;
        i++;
        goto label;
    }
    else if (scanf(A[n])!='\n')
        goto label;
    else (printf("Paspaudus dar viena enter, baigsis programa\n"));


}
