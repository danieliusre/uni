#include<iostream>
#include<iomanip>
#include<fstream>
#include<string>
using namespace std;
struct porc{
    string pav;
    int kaina;
};
struct uzsakymai{
    int x[10];
    int sum=0;
};
int main()
{
    int n, m, kaina, suma=0, viso=0;
    string pav;
    porc A[100];
    uzsakymai B[100];
    char a[25];
    ifstream fd ("duom.txt");
    fd>>n>>m;
    fd.ignore();
    for(int i=0; i<n; i++)
    {
        fd.get(a, 24);
        A[i].pav=a;
        fd>>A[i].kaina;
        fd.ignore();
    }
    for(int i=0; i<m; i++)
    {
        for(int j=0; j<n; j++)
        {
            fd>>B[i].x[j];
        }
    }
    for(int i=0; i<m; i++)
    {
        for(int j=0; j<n; j++)
        {
            B[i].sum+=B[i].x[j]*A[j].kaina;
        }
    }
    int q=0, ind;
    for(int i=0; i<m; i++)
    {
        if(q<B[i].sum)
        {
            q=B[i].sum;
            ind=i;
        }
    }
    ofstream fr ("rez.txt");
    for(int i=0; i<n; i++)
    {
        if(B[ind].x[i]!=0)
        fr<<A[i].pav<<" "<<A[i].kaina<<" x "<<B[ind].x[i]<<" = "<<A[i].kaina*B[ind].x[i]<<endl;
    }
    fr<<"Is viso........................."<<B[ind].sum;
}
