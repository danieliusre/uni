#include <stdlib.h>

// external global variables
extern void * ptr1;
extern void * ptr2;

// BLOCK_SIZE to be left unchanged; otherwise, provide your reasoning here ("changed, because ... ")
#define BLOCK_SIZE 4

/*********************************************************************************************
Funkcija imagine turi prieigà prie kitur apibrëþtø dviejø globaliø kintamøjø ptr1 ir ptr2 (þr. paveiksliukà),
 ir naudodamasi jais sukuria pavaizduotà konstrukcijà (trijø elementø dinaminá masyvà bei papildomà kintamàjá) dinaminëje atmintyje.
  Laikykite, kad kiekvienos "dëþutës" talpa yra lygiai 4 baitai. Uþpildykite visas pavaizduotas ðeðias "dëþutes" nurodytomis reikðmëmis:
  ákelkite á jø vidø paveiksliuke nurodytas (int) konstantas, arba atitinkamø "dëþuèiø" adresus (þr. nupieðtas rodykles). Funkcijai baigus darbà,
   paveiksliuke pavaizduota konstrukcija turi bûti paruoðta naudojimui. Jeigu konstrukcijos sukûrimas neámanomas, nustatykite ptr1 ir ptr2 reikðmes lygias NULL.
    Jeigu dël techniniø prieþasèiø negalite iðsaugoti adresø informacijos 4 baituose, LEIDÞIAMA pakeisti virðuje apibrëþtà makrosà BLOCK_SIZE á toká, su kuriuo galite dirbti,
    taèiau tokiu atveju privalu komentare ávardinti tokio pakeitimo prieþastá (þr. kodà aukðèau).

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
