int isRightTriangle(int ax, int ay, int bx, int by, int cx, int cy)
{
    int side1 = (bx-ax)*(bx-ax) + (by-ay)*(by-ay);
    int side2 = (cx-ax)*(cx-ax) + (cy-ay)*(cy-ay);
    int side3 = (cx-bx)*(cx-bx) + (cy-by)*(cy-by);
    if(side1 + side2 == side3 || side1 + side3 == side2 || side2 + side3 == side1)
    {
        printf("Trikampis status\n");
        return 1;
    }
    else
    {
        printf("Trikampis nestatus\n");
        return 0;
    }
}
