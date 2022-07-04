#include<iostream>
#include<iomanip>
using namespace std;
#define INFINITY 9999
#define MAX 100
void read(int &n, int M[MAX][MAX], string cities[], string city1, string city2);
void newCity(int &n, string cities[], string city);
void add(int n, int M[MAX][MAX], string cities[], string city1, string city2, int distance);
int findDistance(int n, int M[MAX][MAX], string cities[], int start, int finish);
int main()
{
    string city1, city2, cities[MAX];
    int n = 0;
    int M[MAX][MAX];
    read(n, M, cities, city1, city2);
    int start, finish;
    string temp;
    cout<<"Iveskite miesta, is kurio keliausite:"<<endl;
    cin>>temp;
    for(int i=0; i<n; i++)
    {
        if(temp == cities[i])
            start = i;
    }
    cout<<"Iveskite miesta, i kuri keliausite:"<<endl;
    cin>>temp;
    for(int i=0; i<n; i++)
    {
        if(temp == cities[i])
            finish = i;
    }
    int finalDistance;
    finalDistance = findDistance(n, M, cities, start, finish);
    cout<<endl<<"TRUMPIAUSIAS ATSTUMAS TARP MIESTU = "<<finalDistance<<endl;
    return 0;
}
void read(int &n, int M[MAX][MAX], string cities[], string city1, string city2)
{
    cout<<"Iveskite atstumus tarp miestu (Pvz.: Vilnius Kaunas 100):"<<endl;
    cout<<"Iveskite 0, jei norite baigti"<<endl;
    int distance;
    string city;
    while(1)
    {
        cin>>city1;
        if(city1 == "0")
            break;
        city = city1;
        newCity(n, cities, city);
        cin>>city2;
        city = city2;
        newCity(n, cities, city);

        cin>>distance;
        add(n, M, cities, city1, city2, distance);

    }
    cout<<"Ivedimas baigtas, gauta kaiminystes matrica:"<<endl;
    for(int i=0; i<n; i++)
    {
        for(int j=0; j<n; j++)
        {
            cout<<M[i][j]<<" ";
        }
        cout<<endl;
    }
    return;
}
void newCity(int &n, string cities[], string city)
{
    int temp = 0;
    for(int i=0; i<n; i++)
    {
        if(cities[i] == city)
            temp = 1;
    }
    if(temp == 0)
    {
        cities[n] = city;
        n++;
    }
    return;
}
void add(int n, int M[MAX][MAX], string cities[], string city1, string city2, int distance)
{
    for(int i=0; i<n; i++)
    {
        for(int j=0; j<n; j++)
        {
            if(city1 == cities[i] && city2 == cities[j])
            {
                M[i][j] = distance;
                M[j][i] = distance;
            }
        }
    }
    return;
}
int findDistance(int n, int M[MAX][MAX], string cities[], int start, int finish)
{
    int cost[MAX][MAX], distance[MAX], pred[MAX];
    int visited[MAX], countNodes, mindistance, nextnode, i, j;

    for(i=0; i<n; i++)
    {
        for(j=0; j<n; j++)
        {
            if(M[i][j] == 0)
                cost[i][j] = INFINITY;
            else
                cost[i][j] = M[i][j];
        }
    }
    for(i=0; i<n; i++)
    {
		visited[i]=0;
        distance[i] = cost[start][i];
        pred[i]=start;
    }
    distance[start] = 0;
    visited[start] = 1;
    countNodes = 1;

    while(countNodes < n-1)
	{
		mindistance = INFINITY;
		for(i=0; i<n; i++)
			if(distance[i] < mindistance && !visited[i])
			{
				mindistance = distance[i];
				nextnode = i;
			}
        visited[nextnode] = 1;
        for(i=0; i<n; i++)
            if(!visited[i])
                if(mindistance + cost[nextnode][i] < distance[i])
                {
                    distance[i] = mindistance + cost[nextnode][i];
                    pred[i] = nextnode;
                }
		countNodes++;
	}
	int last;
	string path[MAX];
	int nodecount, nodes;
	path[0] = cities[finish];
	for(i=0; i<n; i++)
		if(i != start)
		{
		    nodecount = 1;
			j = i;
			do
			{
				j = pred[j];
				if(cities[i] == cities[finish])
                {
                    last = distance[i];
                    path[nodecount] = cities[j];
                    nodes = nodecount;
                    nodecount++;
                }
			}while(j != start);
        }
	path[nodes+1] = cities[start];
	cout<<endl<<"-------------------------------------------------"<<endl;
	cout<<"TRUMPIAUSIAS KELIAS: ";
	for(i=nodes; i>=0; i--)
    {
        cout<<path[i];
        if(i != 0)
            cout<<" -> ";
    }
    return last;
}
