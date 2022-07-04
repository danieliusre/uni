int suma(int nr1, int nr2)
{
    return nr1 + nr2;
}

void dalmuo_su_liekana(int nr1, int nr2, int *dalmuo, int *liekana)
{
    if(nr2==0)
    {
        *dalmuo=0;
        *liekana=0;
        return 0;
    }

    *dalmuo = nr1 / nr2;
    *liekana = nr1 % nr2;
}
