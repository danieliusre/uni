#ifndef PQUEUE_H_INCLUDED
#define PQUEUE_H_INCLUDED

typedef int MyType;

typedef struct node{
    MyType value;
    int priority;
    struct node *next;
} node;

typedef struct{
    node *head;
} queue;
//create a queue
void createQueue(queue *q);
//delete a queue
void deleteQueue(queue *q);
//check if queue is empty
int isEmpty(queue *q);
//insert new node into the queue
int Insert(queue *q, MyType value, int priority);
//remove a node from the top of the queue
MyType Remove(queue *q);
//get value of first node without removing it
MyType getFirst(queue *q);
//print the queue (change % to print the right type)
void printQueue(queue *q);

#endif

