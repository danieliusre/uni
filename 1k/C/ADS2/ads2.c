#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int lengthTotal;
int values[10];
char letters[10];

void addLetters(char string[])
{
    int j, length = strlen(string);
    for(int i=0; i<length; i++)
    {
        for(j=lengthTotal-1; j>=0; j--)
        {
            if(letters[j] == string[i])
                break;
        }
        if(j == -1)
        {
            letters[lengthTotal] = string[i];
            lengthTotal++;
        }
    }
}

int equation(char word[])
{
    int temp;
    int k;
    int number = 0;
    int length = strlen(word);
    for(int i=0; i<length; i++)
    {
        k=0;
        while(word[i] != letters[k])
        {
            k++;
        }
        temp = values[k];
        for(int j=0; j<length-i-1; j++)     //  number += values[k] * pow (10, length-i-1)
            temp = temp * 10;
        number += temp;
    }
    return number;
}
int main()
{
    char word1[10];
    char word2[10];
    char word3[10];
    int number1, number2, number3;
    int used[100], usedindex=0;
    int skip, found = 0, valid;
    printf("Enter equation:\n");
    scanf("%s", &word1);
    printf("+\n");
    scanf("%s", &word2);
    printf("--------\n");
    scanf("%s", &word3);
    printf("\n");

    lengthTotal = 0;
    addLetters(word1);
    addLetters(word2);
    addLetters(word3);

    if(lengthTotal>10)
    {
        printf("Bad equation - more than 10 unique characters\n");
        return 0;
    }

    for(int i=0; i<lengthTotal; i++)
    {
        values[i]=0;
    }

    int first2, first3;

    for(int i=0; i<lengthTotal; i++)
    {
        if(word2[0] == letters[i])
            first2 = i;
        if(word3[0] == letters[i])
            first3 = i;
    }

    for(int i9=0; i9<10; i9++)
    {
        values[9]++;
        for(int i8=0; i8<10; i8++)
        {
            values[8]++;
            for(int i7=0; i7<10; i7++)
            {
                values[7]++;
                for(int i6=0; i6<10; i6++)
                {
                    values[6]++;
                    for(int i5=0; i5<10; i5++)
                    {
                        values[5]++;
                        for(int i6=0; i6<10; i6++)
                        {
                            values[4]++;
                            for(int i7=0; i7<10; i7++)
                            {
                                values[3]++;
                                for(int i8=0; i8<10; i8++)
                                {
                                    values[2]++;
                                    for(int i9=0; i9<10; i9++)
                                    {
                                        values[1]++;
                                        for(int i0=0; i0<10; i0++)
                                        {
                                            values[0]++;

                                            valid = 1;
                                            for(int i=0; i<lengthTotal; i++)
                                            {
                                                for(int j=i+1; j<lengthTotal; j++)
                                                {
                                                    if(values[i] == values[j])
                                                        valid = 0;
                                                }
                                            }

                                            for(int i=0; i<10; i++)
                                            {
                                                if(values[i] == 10)
                                                    values[i] = 0;
                                            }

                                            number1 = equation(word1);
                                            number2 = equation(word2);
                                            number3 = equation(word3);

                                            if(number1 + number2 == number3 && values[0] != 0 && values[first2] != 0 && values[first3] != 0 && valid == 1)
                                            {
                                                skip = 0;
                                                for(int i=0; i<10; i++)
                                                {
                                                    if(number3 == used[i])
                                                    {
                                                        skip = 1;
                                                    }
                                                }
                                                if(skip == 0)
                                                {
                                                    printf("SOLUTION FOUND:    %d   +   %d   =    %d  \n", number1, number2, number3);
                                                    for(int i=0; i<lengthTotal; i++)
                                                    {
                                                        printf("%c = %d \n", letters[i], values[i]);
                                                    }
                                                    used[usedindex] = number3;
                                                    usedindex++;
                                                    printf("\n");
                                                    found = 1;
                                                }
                                            }
                                            int end = 1;
                                            for(int i=0; i<lengthTotal+1; i++)
                                            {
                                                if(values[i] != 9)
                                                {
                                                    end = 0;
                                                }
                                            }
                                            if(lengthTotal>7 && found == 1)
                                                end = 1;


                                            if(end == 1)
                                            {
                                                if(found == 0)
                                                    printf("No solutions found\n");
                                                else
                                                    printf("No more solutions found\n");

                                                return 0;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return 0;
}
