#ifndef DECK_H_INCLUDED
#define DECK_H_INCLUDED

/// to compile the program write "gcc dequeExample.c deque.c -o dequeExample" and to run it then "./dequeExample"

/// to change what type of variables will be stored change this define and define in deque.c
#define VAR int

/// When creating the deque write: "deque *d = dequeCreate();"
/// It is important to put the * near the d, because the function returns a pointer to the deque!

typedef struct node
{
    VAR value;
    struct node *front, *rear;

} node;

typedef struct deque
{
    node *head; // pointer to the first element of deque
    node *tail; // pointer to the last element of deque

} deque;

/**
*   Creates a deque data structure
*   Returns a pointer to a deque data structure
**/
deque *dequeCreate();

/**
*   Checks whether deck is empty
*   Returns 1 if empty, 0 otherwise
**/
int dequeCheckEmpty(deque *d);

/**
*   Checks whether deck is full
*   Returns 1 if full, 0 otherwise
**/
int dequeCheckFull(deque *d);

/**
*   Inserts an element to the deque's front
*   @d is the Pointer to the deque
*   @value is the element to be inserted
**/
int dequeInsertFront(deque *d, VAR value);

/**
*   Inserts an element to the deque's back
*   @d is the Pointer to the deque
*   @value is the element to be inserted
**/
int dequeInsertBack(deque *d, VAR value);

/**
*   Prints all elements of deque from first forward
*   Returns 0 if there were no elements to print
*   @d is the Pointer to the deque
**/
int dequePrintAll(deque *d);

/**
*   Counts all the elements in the deque
*   Returns the count of elements
*   @d is the Pointer to the deque
**/
int dequeCountAll(deque *d);

/**
*   Deletes the first element in the deque
*   Returns 1 if the delete was succesful, 0 if there were no elements
*   @d is the Pointer to the deque
**/
int dequeDeleteFront(deque *d);

/**
*   Deletes the last element in the deque
*   Returns 1 if the delete was succesful, 0 if there were no elements
*   @d is the Pointer to the deque
**/
int dequeDeleteBack(deque *d);

/**
*   Returns the first element of the deque
*   Returns 0 if there were no elements
*   @d is the pointer to the deque
*   @val is the pointer to the value to be returned
**/
int dequeGetFront(deque *d, VAR *val);

/**
*   Returns the last element of the deque
*   Returns 0 if there were no elements
*   @d is the pointer to the deque
*   @val is the pointer to the value to be returned
**/
int dequeGetBack(deque *d, VAR *val);

/**
*   Destroys the created deque
*   Returns 0 if there were no elements in the deque, 1 if it was destroyed succesfully
*   @d is the Pointer to the deque
**/
int dequeDestroy(deque *d);


#endif // DECK_H_INCLUDED
