/*
3. Pri�mimo komisija (ADT: dekas, ilgas sveikas skai�ius).

Procesas: pri�mimo komisijoje dirba 2 darbuotojos, kuri� produktyvumas skirtingas, jos priima stojan�i�j� pra�ymus ir stato � lentyn�,
kiekviena i� savo pus�s, kai n�ra stojan�i�j� ir pasibaigus tos dienos pri�mimui, jos ima stojan�i�j� pra�ymus ir juos sutvarko.

Tikslas: patyrin�ti, kiek laiko reikia skirti pra�ym� tvarkymui, pasibaigus j� pri�mimui.

Pradiniai duomenys: darbuotoj� produktyvumas (abi darbuotojos pra�ymo pri�mimui sugai�ta vienodai laiko, bet pra�ymo sutvarkymui skirtingai laiko),
stojan�iojo at�jimo tikimyb� (galima realizacija: generuojamas atsitiktinis skai�ius ir tikrinama, ar jis tenkina tam tikr� s�lyg�), dokument� pri�mimo laikas.

Rezultatai: papildomas darbo laikas, kuris turi b�ti skiriamas pra�ym� tvarkymui, darbuotoj� u�imtumas (procentais), nes galima situacija,
kad pagal pateiktus pradinius duomenis stojan�i�j� intensyvumas toks nedidelis, kad dal� laiko darbuotojos poilsiauja.
*/
#include <stdio.h>
#include <stdlib.h>

#include "longint.c"
#include "deque.c"
void newClient (deque *Documents, deque *Waiting, LongInt* receptionTime, LongInt* singleTimeUnit, LongInt* currentTime,
                int worker1Busy, int worker2Busy, int worker1Working, int worker2Working, int Client, int Admission, int clientProbability, int timeOpen);

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
    printf("Dokumentu priemimo laikas -");
    lint_read(&receptionTime);

    int worker1Busy = 0;
    int worker2Busy = 0;
    int worker1Working = 0;
    int worker2Working = 0;

    int timeOpen = 0;

    for(; lint_compare(receptionTime, currentTime) > 0; lint_add(&currentTime, &singleTimeUnit))
    {
        if(rand() % 100 + 1 > clientProbability)
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
                printf("1 teta pridejo\n");
                worker1Busy = Admission;
            }
            else if(worker2Busy <= 0)
            {
                dequeInsertBack(Documents, Client);
                printf("2 teta pridejo\n");
                worker2Busy = Admission;
            }
            if(worker1Busy > 0)
                worker1Working++;
            if(worker2Busy > 0)
                worker2Working++;
            else
                dequeInsertBack(Waiting, Client);

            worker1Busy--;
            worker2Busy--;
        }
        timeOpen++;
        printf("Laikas Open: %d\n\n", timeOpen);
    }
    printf("\nDarbuotoju uzimtumas priimant dokumentus:\n1 Darbuotojo uzimtumas: %d%%\n2 Darbuotojo uzimtumas: %d%%\n", worker1Working*100/timeOpen, worker2Working*100/timeOpen);
    worker1Busy = 0;
    worker2Busy = 0;
    worker1Working = 0;
    worker2Working = 0;
    int TimePassed = 0;

    int tvarkau1 = 1, tvarkau2=1, sutvarkyta = 0;

    while(!dequeCheckEmpty(Documents))
    {
        if(worker1Busy <= 0)
        {
            worker1Busy = Arrangement1;

            printf("1 teta tvarko %d \n", tvarkau1);
            tvarkau1++;
        }
        if(worker1Busy > 0)
            worker1Working++;
        if(worker2Busy <= 0)
        {
            worker2Busy = Arrangement2;

            printf("2 teta tvarko %d \n", tvarkau2);
            tvarkau2++;
        }
        if(worker2Busy > 0)
            worker2Working++;

        TimePassed++;
        worker1Busy--;
        worker2Busy--;

        if(worker1Busy==0)
        {
            sutvarkyta++;
            dequeDeleteFront(Documents);
        }
        if(worker2Busy==0 && !dequeCheckEmpty(Documents))
        {
            sutvarkyta++;
            dequeDeleteBack(Documents);
        }

        printf("Sutvarkyta: %d\n", sutvarkyta);
    }
    printf("\n\n Dokumentus tvarke: %d minuciu\n\n", TimePassed);
    dequeDestroy(Waiting);
    dequeDestroy(Documents);
}
