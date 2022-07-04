#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <stdbool.h>

#define QUEUE_EMPTY INT_MIN

typedef struct node{
    int value;
    int priority;
    struct node *next;
} node;

typedef struct{
    node *head;
    node *tail;
} queue;

void createQueue(queue *q)
{
    q->head = NULL;
    q->tail = NULL;
}

void deleteQueue(queue *q)
{
    queue *temp;
    while(q->head != NULL)
    {
        temp = q;
        q->head = q->head->next;
        free(temp);
    }
}

bool isEmpty(queue *q)
{
    if(q->head == NULL)
        return true;
    else
        return false;
}

bool Insert(queue *q, int value, int priority)
{
    node *newnode = malloc(sizeof(node));
    if(newnode == NULL)
        return false;

    newnode->value = value;
    newnode->next = NULL;
    newnode->priority = priority;
    if(q->head != NULL)
    {
        if(newnode->priority > q->head->priority)
        {
            newnode->next = q->head;
            q->head = newnode;
        }
        else
        {
            node *prevTmp = q->head;
            node *tmp = q->head->next;
            while(tmp != NULL && tmp->priority >= newnode->priority)
            {
                prevTmp = tmp;
                tmp = tmp->next;
            }
            if(tmp == NULL)
            {
                prevTmp->next = newnode;
                q->tail = newnode;
            }
            else
            {
                newnode->next = tmp;
                prevTmp->next = newnode;
            }

        }
    }
    else
    {
        q->head = newnode;
        q->tail = newnode;
    }
    return true;
}

int Remove(queue *q)
{
    if(q->head == NULL)
        return QUEUE_EMPTY;
    else
    {
        node *temp = q->head;
        int result = temp->value;
        q->head = q->head->next;
        if(q->head == NULL)
            q->tail = NULL;
        free(temp);
        return result;
    }
}

int getFirst(queue *q)
{
    int result;
    result = q->head->value;
    return result;
}

void printQueue(queue *q)
{
    if(q->head != NULL)
    {
        node *temp = q->head;
        do
        {
            printf("Value = %d\tPriority: %d\n", temp->value, temp->priority);
            temp = temp->next;
        }while(temp != NULL);
        return;
    }
    return;
}

int main()
{
    queue q;


    createQueue(&q);

    Insert(&q, 1, 1);
    Insert(&q, 2, 1);
    Insert(&q, 3, 1);
    Insert(&q, 10, 1234);
    Insert(&q, 6, 10);


    printQueue(&q);
    Remove(&q);
    printQueue(&q);

    deleteQueue(&q);
    printQueue(&q);

    return 0;
}
