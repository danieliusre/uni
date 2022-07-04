# include <stdio.h>
# include <stdlib.h>
# include "deque.h"
#define VAR int

deque *dequeCreate()
{
    deque *d = (deque*)malloc(sizeof(deque));;
    d->head = NULL;
    d->tail = NULL;
    return d;
}
int dequeCheckEmpty(deque *d)
{
    if(d->head == NULL || d->tail == NULL)
        return 1;
    return 0;
}
int dequeCheckFull(deque *d)
{
    node *ptr = malloc(sizeof(node*)); // if more memory can not be allocated it is full
    if(ptr == NULL)
    {
        free(ptr);
        return 1;
    }
    free(ptr);
    return 0;
}
int dequeInsertFront(deque *d, VAR value)
{
    node *element = (node*)malloc(sizeof(node));
    element->value = value;
    element->rear = d->head;
    element->front = NULL;
    if(d->head == NULL || d->tail == NULL) {
        d->head = element; // if it is the only element, it is both the tail and head
        d->tail = element;
        return 1;
    }

    d->head->front = element;
    d->head = element; // make the created element the first one
    return 1;
}
int dequeInsertBack(deque *d, VAR value)
{
    node *element = (node*)malloc(sizeof(node));
    element->value = value;
    element->rear = NULL;
    element->front = d->tail;
    if(d->head == NULL || d->tail == NULL) {
        d->head = element; // if it is the only element, it is both the tail and head
        d->tail = element;
        return 1;
    }

    d->tail->rear = element;
    d->tail = element; // make the created element the last one
    return 1;
}
int dequePrintAll(deque *d)
{
    node *element = d->tail;
    if(element == NULL)
        return 0;
    while(element != NULL) // print all elements until we encounter a NULL element
    {
        printf("%d", element->value);
        element = element->front; // move on to the next one
    }
    printf("\n");
}
int dequeCountAll(deque *d)
{
    int count = 0;
    node *element = d->tail;
    while(element != NULL)
    {
        count++;
        element = element->front;// move on to the next one
    }
    return count;
}
int dequeDeleteFront(deque *d) // returns 1 if the element was deleted
{
    node *elem = d->head;
    if(elem == NULL)
        return 0;
    if(d->head != d->tail) //if there is more than one element
        d->head = d->head->rear;
    else
    {
        d->head = NULL;
        d->tail = NULL;
    }
    free(elem);
    return 1;
}
int dequeDeleteBack(deque *d) // returns 1 if the element was deleted
{
    node *elem = d->tail;
    if(elem == NULL)
        return 0;
    if(d->head != d->tail)
        d->tail = d->tail->front;
    else
    {
        d->head = NULL;
        d->tail = NULL;
    }
    free(elem);
    return 1;
}

int dequeGetFront(deque *d, VAR *val) // returns 1 if the element was returned
{
    if(d->head == NULL)
        return 0;
    *val = d->head->value;
    return 1;
}

int dequeGetBack(deque *d, VAR *val) // returns 1 if the element was returned
{
    if(d->tail == NULL)
        return 0;
    *val = d->tail->value;
    return 1;
}
int dequeDestroy(deque *d)
{
    node *element;
    element = d->tail;
    if(element == NULL)
        return 0;
    while(element != NULL)
    {
        element = element->front;
        free(d->tail);
        d->tail = element;
    }
    d->head = NULL;
    d->tail = NULL;
    return 1;
}
