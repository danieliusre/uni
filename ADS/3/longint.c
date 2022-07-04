#include <stdio.h>
#include <stdlib.h>

#include "longint.h"
int lint_length(LongInt* head);
int lint_compare_unsigned(LongInt* head, LongInt* head2);
void lint_prepend(LongInt** head, int value);
void lint_behead(LongInt** head);
void lint_cutoff(LongInt** head);
void lint_cleanSymbols(LongInt** head);

void lint_read(LongInt** head)
{
    lint_clear(head);
    int value;
    printf(" (iveskite skaiciu nuo 1 iki +2147483647):\n");
    scanf("%d",&value);
    while(value/10!=0)
    {
        lint_prepend(head,value%10);
        value=value/10;
    }
    lint_prepend(head,value%10);
}
//===============================================================
void lint_create(LongInt** head, int value)
{
    lint_clear(head);
    while(value/10!=0)
    {
        lint_prepend(head,value%10);
        value=value/10;
    }
    lint_prepend(head,value%10);
}
//===============================================================
void lint_copy(LongInt** head, LongInt** head2)
{
    LongInt* temp=(*head);
    lint_clear(head2);
    while(temp->next!=NULL)
        temp=temp->next;
    while(temp->prev!=NULL)
    {
        lint_prepend(head2,temp->value);
        temp=temp->prev;
    }
    lint_prepend(head2,temp->value);
    (*head2)->sign=(*head)->sign;
}
//===============================================================
int lint_length(LongInt* head)
{
    LongInt* temp=head;
    int length=0;
    while(temp->next!=NULL)
    {
        temp=temp->next;
        length++;
    }
    length++;
    return length;
}
//===============================================================
int lint_compare(LongInt* head, LongInt* head2)
{
    LongInt* temp=head;
    LongInt* temp2=head2;
    if(head->sign>head2->sign)
        return 1;
    else if(head->sign<head2->sign)
        return -1;
    if(lint_length(head)>lint_length(head2) && head->sign==1 || lint_length(head)<lint_length(head2) && head->sign==-1)
        return 1;
    else if(lint_length(head)<lint_length(head2) && head->sign==1 || lint_length(head)>lint_length(head2) && head->sign==-1)
        return -1;
    else
    {
        /*while(temp->next!=NULL)
        {
            if(temp->value>temp2->value)
                return 1;
            else if(temp->value<temp2->value)
                return -1;
            temp=temp->next;
            temp2=temp2->next;
        }*/
        if(lint_compare_unsigned(head,head2)==1 && head->sign==1 || lint_compare_unsigned(head,head2)==-1 && head->sign==-1)
            return 1;
        else if(lint_compare_unsigned(head,head2) && head->sign==1 || lint_compare_unsigned(head,head2)==1 && head->sign==-1)
            return -1;
        else
            return 0;
    }
}
//===============================================================
int lint_compare_unsigned(LongInt* head, LongInt* head2)
{
    LongInt* temp=head;
    LongInt* temp2=head2;

    if(lint_length(head)>lint_length(head2))
        return 1;
    else if(lint_length(head)<lint_length(head2))
        return -1;
    else
    {
        temp=head;
        temp2=head2;
        while(temp->next!=NULL)
        {
            if(temp->value>temp2->value)
                return 1;
            else if(temp->value<temp2->value)
                return -1;
            temp=temp->next;
            temp2=temp2->next;
        }
        if(temp->value>temp2->value)
            return 1;
        else if(temp->value<temp2->value)
            return -1;
        else
            return 0;
    }
}
//===============================================================
void lint_add(LongInt** head, LongInt** head2)
{
    LongInt* temp=*head;
    LongInt* temp2=*head2;
    int plusOne=0,minusOne=0;
    while(temp->next!=NULL)
    {
        temp=temp->next;
    }
    while(temp2->next!=NULL)
    {
        temp2=temp2->next;
    }


    if((*head)->sign==(*head2)->sign)
    {
        while(temp2->prev!=NULL)
        {
            if(plusOne==1)
            {
                temp->value++;
                plusOne=0;
            }
            temp->value+=temp2->value;
            if(temp->value/10!=0)
            {
                plusOne=1;
                temp->value%=10;
            }
            if(temp->prev==NULL)
                lint_prepend(head,0);
            temp=temp->prev;
            temp2=temp2->prev;
        }
        if(plusOne==1)
        {
            temp->value++;
            plusOne=0;
        }
        temp->value+=temp2->value;
        if(temp->value/10!=0)
        {
            plusOne=1;
            temp->value%=10;
        }
        if(temp->prev==NULL && plusOne==1)
        {
            lint_prepend(head,1);
            (*head)->sign=(*head)->next->sign;
            plusOne=0;
        }
        else if(temp->prev!=NULL && plusOne==1)
        {
            temp->prev->value++;
            plusOne=0;
        }

        while(temp->prev!=NULL)
        {
            if(plusOne==1)
            {
                temp->value++;
                plusOne=0;
            }
            if (temp->value>9)
            {
                plusOne=1;
                temp->value%=10;
            }
                temp=temp->prev;
        }
        if(plusOne==1)
        {
            temp->value++;
            plusOne=0;
        }
        if (temp->value>9)
        {
            plusOne=1;
            temp->value%=10;
        }
        if(plusOne==1)
        {
            lint_prepend(head,1);
            (*head)->sign=(*head)->next->sign;
            plusOne=0;
        }

    }
    else if(lint_compare_unsigned(*head,*head2)>=0)
    {
        while(temp2->prev!=NULL)
        {
            if(minusOne==1)
            {
                temp->value--;
                minusOne=0;
            }
            temp->value-=temp2->value;
            if(temp->value<0)
            {
                minusOne=1;
                temp->value+=10;
            }
            temp=temp->prev;
            temp2=temp2->prev;
        }
        if(minusOne==1)
        {
            temp->value--;
            minusOne=0;
        }
        temp->value-=temp2->value;
        if(temp->value<0)
        {
            minusOne=1;
            temp->value+=10;
        }
        if(minusOne==1)
        {
            temp->prev->value--;
            minusOne=0;
        }


        while(temp->next!=NULL)
        {
            temp=temp->next;
        }
        while(temp->prev!=NULL)
        {
            if(minusOne==1)
            {
                temp->value--;
                minusOne=0;
            }
            if (temp->value<0)
            {
                minusOne=1;
                temp->value+=10;
            }
                temp=temp->prev;
        }
        if(minusOne==1)
        {
            temp->value--;
            minusOne=0;
        }
        if (temp->value<0)
        {
            minusOne=1;
            temp->value+=10;
        }
        if(minusOne==1)
        {
            lint_prepend(head,1);
            (*head)->sign=(*head)->next->sign;
            minusOne=0;
        }
    }
    else
    {
        while(temp2->prev!=NULL)
        {
            if(minusOne==1)
                temp->value++;
            temp->value=temp2->value-temp->value;
            if(temp->value<0)
            {
                minusOne=1;
                temp->value+=10;
            }
            if(temp->prev==NULL)
                lint_prepend(head,0);
            temp=temp->prev;
            temp2=temp2->prev;
        }
        if(minusOne==1)
            temp->value++;
        temp->value=temp2->value-temp->value;
        if(temp->value/10!=0)
        {
            minusOne=1;
            temp->value+=10;
        }
        if(temp->prev==NULL)
            lint_prepend(head,0);
        if(minusOne==1)
            temp->prev->value++;

        (*head)->sign=(*head2)->sign;
    }
    while((*head)->next!=NULL && (*head)->value==0)
        lint_behead(head);
    if ((*head)->value==0)
        (*head)->sign=1;
}
//===============================================================
void lint_subtract(LongInt** head, LongInt** head2)
{
    (*head2)->sign*=-1;
    lint_add(head, head2);
    (*head2)->sign*=-1;
    if ((*head)->value==0)
        (*head)->sign=1;
}
//===============================================================
void lint_multiply(LongInt** head, LongInt** head2)
{
    int i=0,plus=0;
    LongInt* temp=(*head);
    LongInt* temp2=(*head2);
    LongInt* head3=NULL;
    LongInt* temp3;
    LongInt* tempMult=NULL;
    LongInt* temp2Mult=NULL;
    lint_copy(head,&head3);
    temp3=head3;
    while(temp->next!=NULL)
    {
        temp->value=0;
        temp=temp->next;
    }
    temp->value=0;
    while(temp2->next!=NULL)
        temp2=temp2->next;
    while(temp3->next!=NULL)
    {
        temp3=temp3->next;
    }
    temp2Mult=temp2;


    while(temp3->prev!=NULL)
    {
        tempMult=temp;
        while(temp2->prev!=NULL)
        {
            if(plus!=0)
            {
                tempMult->value+=plus;
                plus=0;
            }
            tempMult->value=temp3->value*temp2->value+tempMult->value;
            if(tempMult->value/10!=0)
            {
                plus=tempMult->value/10;
                tempMult->value%=10;
            }
            if(tempMult->prev==NULL)
                lint_prepend(head,0);

            tempMult=tempMult->prev;
            temp2=temp2->prev;
        }
        if(plus!=0)
        {
            tempMult->value+=plus;
            plus=0;
        }
        tempMult->value=temp3->value*temp2->value+tempMult->value;
        if(tempMult->value/10!=0)
        {
            plus=tempMult->value/10;
            tempMult->value%=10;
        }
        if(tempMult->prev==NULL)
            lint_prepend(head,0);
        tempMult=tempMult->prev;
        if(plus!=0)
        {
            tempMult->value+=plus;
            plus=0;
        }

        temp3=temp3->prev;
        temp=temp->prev;
        temp2=temp2Mult;
    }
    tempMult=temp;
    while(temp2->prev!=NULL)
    {
        if(plus!=0)
        {
            tempMult->value+=plus;
            plus=0;
        }
        tempMult->value=temp3->value*temp2->value+tempMult->value;
        if(tempMult->value/10!=0)
        {

            plus=tempMult->value/10;
            tempMult->value%=10;
        }
        if(tempMult->prev==NULL)
            lint_prepend(head,0);

        tempMult=tempMult->prev;
        temp2=temp2->prev;
    }
    if(plus!=0)
    {
        tempMult->value+=plus;
        plus=0;
    }
    tempMult->value=temp3->value*temp2->value+tempMult->value;
    if(tempMult->value/10!=0)
    {

        plus=tempMult->value/10;
        tempMult->value%=10;
    }
    if(tempMult->prev==NULL)
        lint_prepend(head,0);
    tempMult=tempMult->prev;
    if(plus!=0)
    {
        tempMult->value+=plus;
        plus=0;
    }


    while((*head)->next!=NULL && (*head)->value==0)
        lint_behead(head);
    (*head)->sign=head3->sign*(*head2)->sign;
    lint_clear(&head3);
}
//===============================================================
void lint_division(LongInt** head, LongInt** head2)
{
    if ((*head2)->value==0)
    {
        printf("Negalima dalint is 0\n");
        exit(1);
    }
    else
    {
        int sign=1, sign2=1, sign3=1, desimtys=0;
        LongInt* temp=(*head);
        LongInt* temp2=(*head2);
        LongInt* head3=NULL;
        LongInt* head4=NULL;
        LongInt* head5=NULL;
        if ((*head)->sign!=(*head2)->sign)
            sign3=-1;
        while(temp->next!=NULL)
            temp=temp->next;
        while(temp->prev!=NULL)
        {
            lint_prepend(&head3,temp->value);
            temp=temp->prev;
        }
        lint_prepend(&head3,temp->value);
        head3->sign=(*head)->sign;
        while(temp->next!=NULL)
        {
            temp->value=0;
            temp=temp->next;
        }
        temp->value=0;
        lint_create(&head4,1);
        lint_create(&head5,10);
        while(lint_compare_unsigned(head3,(*head2))>=0)
        {
            lint_multiply(head2,&head5);
            lint_multiply(&head4,&head5);
            desimtys++;
        }
        while(desimtys>0)
        {
            lint_cutoff(head2);
            lint_cutoff(&head4);
            while(lint_compare_unsigned(head3,(*head2))>=0)
            {
                if (head3->sign!=(*head2)->sign)
                    sign=-1;
                if ((*head2)->sign==-1)
                    sign2=-1;
                (*head2)->sign=1;
                (*head)->sign=1;
                head3->sign=1;
                lint_subtract(&head3,head2);
                lint_add(head,&head4);
            }
            desimtys--;
        }
        temp=(*head);
        while(temp->value==0 && temp->next!=NULL)
        {
            temp=temp->next;
            lint_behead(head);
        }
        if (sign3==-1)
            (*head)->sign=-1;
        if ((*head)->value==0)
        {
            (*head)->sign=1;
        }
        if (sign2==-1)
            (*head2)->sign=-1;


        lint_clear(&head3);
        lint_clear(&head4);
    }
}
//===============================================================
void lint_remainder(LongInt** head, LongInt** head2)
{
    if ((*head2)->value==0)
    {
        printf("Negalima dalint is 0\n");
        exit(1);
    }
    else
    {
        int sign=1;
        LongInt* temp=(*head);
        LongInt* temp2=(*head2);
        LongInt* head3=NULL;
        while(temp->next!=NULL)
            temp=temp->next;
        while(temp->prev!=NULL)
        {
            lint_prepend(&head3,temp->value);
            temp=temp->prev;
        }
        lint_prepend(&head3,temp->value);
        head3->sign=(*head)->sign;
        if((*head)->sign==(*head2)->sign)
            sign=1;
        else
            sign=-1;
        lint_division(&head3,head2);
        lint_multiply(&head3,head2);
        lint_subtract(head,&head3);
        (*head)->sign=1;
        lint_clear(&head3);
    }

}
//===============================================================
void lint_prepend(LongInt** head, int value)
{
    LongInt* newHead=(LongInt*)malloc(sizeof(LongInt));
    newHead->value=value;
    newHead->next=NULL;
    newHead->prev=NULL;
    if (*head==NULL)
        *head=newHead;
    else
    {
        newHead->next=*head;
        (*head)->prev=newHead;
        *head=newHead;
    }
    if(value>=0)
        (*head)->sign=1;
    else
        (*head)->sign=-1;
    lint_cleanSymbols(head);
}
//===============================================================
void lint_behead(LongInt** head)
{

    if ((*head)->next==NULL)
    {
        LongInt* next=(*head)->next;
        free(*head);
        *head=next;
    }
    else
    {
        LongInt* next=(*head)->next;
        next->sign=(*head)->sign;
        free(*head);
        *head=next;
        (*head)->prev=NULL;
    }
}
//===============================================================
void lint_cutoff(LongInt** head)
{
    LongInt* temp=(*head);
    while (temp->next!=NULL)
        temp=temp->next;
    if (temp->prev==NULL)
    {
        free(temp);
    }
    else
    {
        LongInt* prev=temp->prev;
        free(temp);
        temp=prev;
        temp->next=NULL;
    }
}
//===============================================================
void lint_cleanSymbols(LongInt** head)
{
    LongInt* temp=(*head);
    if((*head)->value>=0)
        (*head)->sign=1;
    else
        (*head)->sign=-1;
    while(temp->next!=NULL)
    {
        if (temp->value<0)
            temp->value*=-1;
        temp=temp->next;
    }
    if (temp->value<0)
        temp->value*=-1;
}
//===============================================================
void lint_print(LongInt* head)
{
    if(head==NULL)
        printf("NULL\n");
    else
    {
        if (head->sign==-1)
            printf("-");
        //printf("sign:%d\n",head->sign);
        while(head!=NULL)
        {
            printf("%d",head->value);
            //printf("prev:%d, current:%d, value:%d, next:%d\n",head->prev, head, head->value, head->next);
            head=head->next;
        }
        printf("\n\n");
    }
}
//===============================================================
void lint_clear(LongInt** head)
{
    while(*head!=NULL)
        lint_behead(head);
}
