#include<stdlib.h>
#include<stdio.h>
int main()
{
    char A[500];
    int i=0, n;
    while(getchar()!='\n')
    {
        scanf("%c", &A[i]);
        i++;
        printf("%c   ", A[i]);
    }
    n=i;
    for(int i=0; i<5; i++)
        printf("%c   ", A[i]);
}
