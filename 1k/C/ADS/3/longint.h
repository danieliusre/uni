#ifndef __LINT_H
#define __LINT_H

typedef struct LongInt
{
    int value;
    int sign;
    struct LongInt* next;
    struct LongInt* prev;
}LongInt;


void lint_read(LongInt** head);
void lint_create(LongInt** head, int value);
void lint_copy(LongInt** head, LongInt** head2);
int lint_compare(LongInt* head, LongInt* head2);
void lint_add(LongInt** head, LongInt** head2);
void lint_subtract(LongInt** head, LongInt** head2);
void lint_multiply(LongInt** head, LongInt** head2);
void lint_division(LongInt** head, LongInt** head2);
void lint_remainder(LongInt** head, LongInt** head2);
void lint_print(LongInt* head);
void lint_clear(LongInt** head);

#endif
