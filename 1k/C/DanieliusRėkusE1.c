/*********************************************************************************************
Funkcija hexToChar gauna skai�i� digit, kurio reik�m� turi b�ti tarp 0 ir 15 imtinai, ir gr��ina t� skai�i�
atitinkan�io �e�ioliktain�s sistemos skaitmens simbolio ASCII kod�. Parametras type nurodo raid�s dyd�, tiems atvejams, kai digit > 9,
tokiu atveju, teigiama type reik�m� rei�kia did�i�j�, o neteigiama - ma��j�. Funkcija gr��ina simbolio ASCII kod�; jei digit nepatenka � nurodytus r��ius,
funkcija gr��ina 0. Pavyzd�iai: hexToChar(5,1) gr��ina �5�, hexToChar(10,1) gr��ina �A�, hexToChar(0xF,-2) gr��ina �f�
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
