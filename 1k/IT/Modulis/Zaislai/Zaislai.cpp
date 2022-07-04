#include<iostream>
#include<fstream>
#include<string>
using namespace std;
struct zaisl{
    string pav;
    int x[10];
    int d;
    int suma=0;
};
int main()
{
    int x, n, m, d, viso=0, sumd[500];
    string pav;
    char a[21];
    zaisl A[50];
    ifstream fd ("duom.txt");
    fd>>n>>m;
    fd.ignore();
    for(int i=0; i<m; i++)
    {
        fd.get(a, 20);
        A[i].pav=a;
        fd.ignore();
    }
    for(int i=0; i<n; i++)
    {
        fd>>A[i].d;
        for(int j=0; j<m; j++)
        {
            fd>>A[j].x[i];
            sumd[A[i].d]+=A[j].x[i];
        }

    }
    for(int i=0; i<n; i++)
    {
        for(int j=0; j<m; j++)
        {
            A[j].suma+=A[j].x[i];
        }
    }
    for(int i=0; i<m; i++)
    {
        viso+=A[i].suma;
    }
    ofstream fr ("rez.txt");
    for(int i=0; i<m; i++)
    {
        fr<<A[i].pav<<" "<<A[i].suma<<endl;
    }
    fr<<"Is viso pagamino "<<viso<<" zaislu"<<endl;
    int temp, nr;
    for(int i=0; i<n-1; i++)
    {
        for(int j=0; j<n-i-1; j++)
        {
            if(sumd[j]<sumd[j+1])
            {
                temp=sumd[j];
                sumd[j]=sumd[j+1];
                sumd[j+1]=temp;
                nr=j;
            }
        }
    }
    fr<<"Daugiausia pagamino "<<nr<<"-iadieni"<<endl;
    string ttemp;
    for(int i=0; i<m-1; i++)
    {
        for(int j=0; j<m-i-1; j++)
        {
            if(A[j].suma<A[j+1].suma)
            {
                temp=A[j].suma;
                A[j].suma=A[j+1].suma;
                A[j+1].suma=temp;
                ttemp=A[j].pav;
                A[j].pav=A[j+1].pav;
                A[j+1].pav=ttemp;
            }
        }
    }
    fr<<"Daugiausia pagamino "<<A[0].pav;




}
