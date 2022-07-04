#include <stdio.h>
#include <stdlib.h>
int suma(int nr1, int nr2)
{
    return nr1 + nr2;
}
int main()
{
    int nr1, nr2;
    scanf("%d%d", &nr1, &nr2);
    int x;
    x=suma(nr1, nr2);
    printf("%d", x);
}
