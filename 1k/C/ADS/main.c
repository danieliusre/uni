#include <stdlib.h>
#include "pQueue.c"
#include <string.h>
int main()
{
    queue q;

    createQueue(&q); //create

    Insert(&q, 1, 1); //add 5
    Insert(&q, 2, 1);
    Insert(&q, 3, 1);
    Insert(&q, 142, 1234);
    Insert(&q, 25, 10);

    printf("Is the queue empty? %s\n\n", isEmpty(&q)? "Yes" : "No");

    printQueue(&q); //print
    printf("\n");

    printf("Value of first member = %d\n\n", getFirst(&q));

    Remove(&q); //remove 2
    Remove(&q);

    printQueue(&q); //print
    printf("\n");

    printf("Value of first member = %d\n\n", getFirst(&q));

    Remove(&q); //remove 3
    Remove(&q);
    Remove(&q);

    printQueue(&q); //print

    printf("Is the queue empty? %s\n", isEmpty(&q)? "Yes" : "No");

    deleteQueue(&q); //delete

    printQueue(&q); //print

    return 0;
}
