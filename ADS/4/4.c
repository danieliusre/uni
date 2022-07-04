//  3.Duotas keliø sàraðas: miestas, miestas, atstumas. Rasti trumpiausià kelionës ið vieno duoto miesto á kità duotà miestà marðrutà ir jo ilgá.
//  Numatyti atvejá, kad toks marðrutas neegzistuoja. (grafo realizacija paremta kaimynystës matrica)
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define MAX_CITY_NAME_SIZE 30
#define MAX_NUMBER_OF_CITIES 100
void newCity();



int main()
{
    printf("Iveskite miestu pavadinimus (ENTER, kad baigti) :\n");
    int n = 0;
    char cities[MAX_NUMBER_OF_CITIES][MAX_CITY_NAME_SIZE];
    while(scanf("%s", &cities[n]))
    {
        if(strlen(cities[n]) == 1)
            break;
        //printf("----%s\n", cities[n]);
        n++;
    }
    for(int i=0; i<n; i++)
        printf("%s", cities[n][MAX_CITY_NAME_SIZE]);
    int M[n][n];
    for(int i=0; i<n; i++)
    {
        for(int j=0; j<n; j++)
        {
            M[i][j] = 0;
        }
    }
    char city1[MAX_CITY_NAME_SIZE], city2[MAX_CITY_NAME_SIZE];
    int distance;
    printf("Iveskite atstumus tarp miestu (Pvz.: Vilnius Kaunas 100\\n), arba 0 0 kad uzbaigti sarasa:\n");
    while(scanf("%s%s%d", &city1, &city2, &distance))
    {
        if(strlen(city1) == 1 && strlen(city2) == 1)
            break;
        for(int i=0; i<n; i++)
        {
            for(int j=0; j<n; j++)
            {
                if(city1 == cities[i] && city2 == cities[j])
                {
                    M[i][j] = distance;
                }
            }
        }
    }
    printf("VSIO SIOVSIOVISOIVSO\n");
    for(int i=0; i<n; i++)
    {
        for(int j=0; j<n; j++)
        {
            printf("%d ", M[i][j]);
        }
        printf("\n");
    }



}
