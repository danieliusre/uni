#include<iostream>
#include<fstream>
using namespace std;
void skait(int &n, int &m, int varztai[], int verzles[], int a[], int b[]);
void rez(int n, int varztai[], int verzles[]);
int main()
{
    int n, m, varztai[500], verzles[500], a[500], b[500];
    skait(n, m, varztai, verzles, a, b);
    rez(n, varztai, verzles);
}
void skait(int &n, int &m, int varztai[], int verzles[], int a[], int b[])
{
    fstream fd ("duom.txt");
    fd>>n;
    for(int i=1; i<=20; i++)
    {
        varztai[i]=0;
    }
    for(int i=1; i<=n; i++)
    {
        fd>>a[i];
    }
    fd>>m;
    for(int i=1; i<=20; i++)
    {
        verzles[i]=0;
    }
    for(int i=1; i<=m; i++)
    {
        fd>>b[i];
    }
    int k=1;
    for(int j=1; j<=20; j++)
    {
        for(int i=1; i<=n; i++)
        {
        if(a[i]==k)
            varztai[k]=varztai[k]+1;
        }
        k++;
    }
    int q=1;
        for(int j=1; j<=20; j++)
    {
        for(int i=1; i<=m; i++)
        {
        if(b[i]==q)
            verzles[q]=verzles[q]+1;
        }
        q++;
    }
}
void rez(int n, int varztai[], int verzles[])
{
    ofstream fr ("rez.txt");
    for(int i=1; i<=20; i++)
       {
          // fr<<varztai[i]<<endl;;
          // fr<<verzles[i];
       }
}
