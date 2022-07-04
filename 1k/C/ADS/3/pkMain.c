// Priemimo komisija (ADT: dekas, ilgas sveikas skaicius)

#include <stdio.h>
#include <stdlib.h>

#include "longint.c"
#include "deque.c"

void newClient (deque *Documents, deque *Waiting, LongInt *receptionTime, LongInt *singleTimeUnit, LongInt *currentTime, int worker1Busy,
                int worker2Busy, int* worker1, int* worker2, int Client, int Admission, int clientProbability, int* time)
{
    for(; lint_compare(receptionTime, currentTime) > 0; lint_add(&currentTime, &singleTimeUnit))
    {
        if(rand() % 100 > clientProbability)
            {
                if(worker1Busy > 0 || worker2Busy > 0)
                {
                    worker1Busy--;
                    worker2Busy--;
                }
            }
        else
        {
            Client++;
            if(!dequeCheckEmpty(Waiting))
            {
                dequeInsertBack(Waiting, Client);
                dequeGetFront(Waiting, &Client);
                dequeDeleteFront;
            }
            if(worker1Busy <= 0)
            {
                dequeInsertFront(Documents, Client);
                worker1Busy = Admission;
            }
            else if(worker2Busy <= 0)
            {
                dequeInsertBack(Documents, Client);
                worker2Busy = Admission;
            }
            else
                dequeInsertBack(Waiting, Client);

            if(worker1Busy > 0)
                *worker1 += 1;
            if(worker2Busy > 0)
                *worker2 += 1;

            worker1Busy--;
            worker2Busy--;
        }
        *time += 1;
    }
}
void DocumentArrangement(deque *Documents, int worker1Busy, int worker2Busy, int Arrangement1, int Arrangement2, int *totalTime)
{
    //  int tvarkau1 = 1, tvarkau2=1, sutvarkyta = 0;
    while(!dequeCheckEmpty(Documents))
    {
        if(worker1Busy <= 0)
        {
            worker1Busy = Arrangement1;

            //printf("1 teta tvarko %d \n", tvarkau1);
            //tvarkau1++;
        }
        if(worker2Busy <= 0)
        {
            worker2Busy = Arrangement2;

            //printf("2 teta tvarko %d \n", tvarkau2);
            //tvarkau2++;
        }

        *totalTime += 1;
        worker1Busy--;
        worker2Busy--;

        if(worker1Busy==0)
        {
            //sutvarkyta++;
            dequeDeleteFront(Documents);
        }
        if(worker2Busy==0 && !dequeCheckEmpty(Documents))
        {
            //sutvarkyta++;
            dequeDeleteBack(Documents);
        }

        //printf("Sutvarkyta: %d\n", sutvarkyta);
    }
}
int main()
{
    deque *Documents = dequeCreate();
    deque *Waiting = dequeCreate();

    int Admission, Arrangement1, Arrangement2, clientProbability;
    int Client;

    LongInt *receptionTime = NULL;
    LongInt *singleTimeUnit = NULL;
    LongInt *currentTime = NULL;

    lint_create(&currentTime, 0);
    lint_create(&singleTimeUnit, 1);

    printf("Darbuotoju produktyvumas - priemimo laikas:\n");
    scanf("%d", &Admission);
    printf("Darbuotoju produktyvumas - sutvarkymo laikas (1 teta):\n");
    scanf("%d", &Arrangement1);
    printf("Darbuotoju produktyvumas - sutvarkymo laikas (2 teta):\n");
    scanf("%d", &Arrangement2);
    printf("Kliento atvykimo tikimybe procentais (%%):\n");
    scanf("%d", &clientProbability);
    printf("Dokumentu priemimo laikas ");
    lint_read(&receptionTime);

    int worker1Busy = 0;
    int worker2Busy = 0;
    int worker1Working = 0;
    int worker2Working = 0;

    int timeOpen=0;

    newClient(Documents, Waiting, receptionTime, singleTimeUnit, currentTime, worker1Busy, worker2Busy, &worker1Working, &worker2Working, Client, Admission, clientProbability, &timeOpen);

    printf("\nDarbuotoju uzimtumas priimant dokumentus:\n1 Darbuotojo uzimtumas: %d%%\n2 Darbuotojo uzimtumas: %d%%\n", worker1Working*100/timeOpen, worker2Working*100/timeOpen);

    int timePassed = 0;

    DocumentArrangement(Documents, worker1Busy, worker2Busy, Arrangement1, Arrangement2, &timePassed);

    printf("\n\n Dokumentus tvarke: %d minuciu\n\n", timePassed);
    dequeDestroy(Waiting);
    dequeDestroy(Documents);

    return 0;
}
