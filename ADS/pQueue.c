#include <stdlib.h>
#include <stdio.h>
#include <limits.h>

#include "pQueue.h"

#define QUEUE_EMPTY INT_MIN

void createQueue(queue *q)
{
    q->head = NULL;
}

void deleteQueue(queue *q)
{
    node *temp;
    while(q->head != NULL)
    {
        temp = q->head;
        q->head = q->head->next; //padaro kad q head ziuri i kita ir atlaisvina esanti node;
        free(temp);
    }
    printf("\n*******Queue deleted*********\n");
}

int isEmpty(queue *q)
{
    if(q->head == NULL)
        return 1;
    else
        return 0;
}

int Insert(queue *q, MyType value, int priority)
{
    node *newnode = malloc(sizeof(node));
    if(newnode == NULL)
        return 0;
    newnode->value = value;
    newnode->next = NULL;
    newnode->priority = priority;
    if(q->head != NULL)
    {
        if(newnode->priority > q->head->priority) //jei priority didesnis uz pirmo, sitas tampa pirmu
        {
            newnode->next = q->head;
            q->head = newnode;
        }
        else
        {
            node *prevTmp = q->head;
            node *tmp = q->head->next;
            while(tmp != NULL && tmp->priority >= newnode->priority)  //kol newnode priority mazesnis uz tmp, tol eina toliau tmp = tmp->next;
            {
                prevTmp = tmp;
                tmp = tmp->next;
            }
            if(tmp == NULL) //jei nuejo iki galom tail = newnode
            {
                prevTmp->next = newnode;
            }
            else  //kai suranda kur, ikisa newnode i viduri tarp tmp ir prevTmp;
            {
                newnode->next = tmp;
                prevTmp->next = newnode;
            }
        }
    }
    else //jei queue tuscias, rodo i newnode
    {
        q->head = newnode;
    }
    return 1;
}

MyType Remove(queue *q)
{
    if(q->head == NULL)
        return QUEUE_EMPTY;
    else
    {
        node *temp = q->head;
        MyType result = temp->value;
        q->head = q->head->next;
        free(temp);
        return result;
    }
}

MyType getFirst(queue *q)
{
    MyType result;
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
            printf("Value = %d\tPriority: %d\n", temp->value, temp->priority); //kol nepasieke queue galo, atspausdina ir juda pirmyn
            temp = temp->next;
        }while(temp != NULL);
        free(temp);
        return;
    }
    return;
}
