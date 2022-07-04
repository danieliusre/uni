#include <stdlib.h>

// external global variables
extern void * ptr1;
extern void * ptr2;

// BLOCK_SIZE to be left unchanged; otherwise, provide your reasoning here ("changed, because ... ")
#define BLOCK_SIZE 4

/*********************************************************************************************
Funkcija imagine turi prieig� prie kitur apibr��t� dviej� globali� kintam�j� ptr1 ir ptr2 (�r. paveiksliuk�),
 ir naudodamasi jais sukuria pavaizduot� konstrukcij� (trij� element� dinamin� masyv� bei papildom� kintam�j�) dinamin�je atmintyje.
  Laikykite, kad kiekvienos "d��ut�s" talpa yra lygiai 4 baitai. U�pildykite visas pavaizduotas �e�ias "d��utes" nurodytomis reik�m�mis:
  �kelkite � j� vid� paveiksliuke nurodytas (int) konstantas, arba atitinkam� "d��u�i�" adresus (�r. nupie�tas rodykles). Funkcijai baigus darb�,
   paveiksliuke pavaizduota konstrukcija turi b�ti paruo�ta naudojimui. Jeigu konstrukcijos suk�rimas ne�manomas, nustatykite ptr1 ir ptr2 reik�mes lygias NULL.
    Jeigu d�l technini� prie�as�i� negalite i�saugoti adres� informacijos 4 baituose, LEID�IAMA pakeisti vir�uje apibr��t� makros� BLOCK_SIZE � tok�, su kuriuo galite dirbti,
    ta�iau tokiu atveju privalu komentare �vardinti tokio pakeitimo prie�ast� (�r. kod� auk��au).

*********************************************************************************************/
void imagine () {
    int * ptr = (int *) malloc(BLOCK_SIZE);
    int * block = (int *) malloc(BLOCK_SIZE*3);
    block[0] = 4831;
    block[1] = -568;
    block[2] = (int) &ptr;
    ptr1 = &ptr;
    ptr2 = block+2;
    ptr = block;
}
