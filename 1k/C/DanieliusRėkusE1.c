/*********************************************************************************************
Funkcija hexToChar gauna skaièiø digit, kurio reikðmë turi bûti tarp 0 ir 15 imtinai, ir gràþina tà skaièiø
atitinkanèio ðeðioliktainës sistemos skaitmens simbolio ASCII kodà. Parametras type nurodo raidës dydá, tiems atvejams, kai digit > 9,
tokiu atveju, teigiama type reikðmë reiðkia didþiàjà, o neteigiama - maþàjà. Funkcija gràþina simbolio ASCII kodà; jei digit nepatenka á nurodytus rëþius,
funkcija gràþina 0. Pavyzdþiai: hexToChar(5,1) gràþina ’5’, hexToChar(10,1) gràþina ‘A’, hexToChar(0xF,-2) gràþina ‘f‘
*********************************************************************************************/
unsigned char hexToChar (int digit, char type){
    if(digit <0 || digit > 15)
        return 0;
    if(digit >= 10)
    {
        digit += 55;
        if(type < 0)
        {
            digit += 32;
        }
    }
    else
        digit += 48;
    return (char)digit;
}
