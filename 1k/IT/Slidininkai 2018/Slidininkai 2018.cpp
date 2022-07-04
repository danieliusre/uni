#include<iostream>
#include<iomanip>
#include<fstream>
#include<string>
using namespace std;
struct startas{
    string pav;
    int VS;
    int MS;
    int SS;
    int Slaikas;
};
struct finisas{
    string pav;
    int VF;
    int MF;
    int SF;
    int Flaikas;
};
struct pabaiga{
    string pav;
    int sekundes;
};
void skait(startas A[], finisas B[], int &n, int &m);
void rik(pabaiga C[], int n);
void rez(pabaiga C[], int n);
int main()
{
    int n, m;
    startas A[30];
    finisas B[30];
    pabaiga C[30];
    skait(A, B, n, m);
    for(int i=0; i<n; i++)
    {
        for(int j=0; j<m; j++)
        {
            if(A[i].pav==B[j].pav)
            {
                C[i].pav=A[i].pav;
                C[i].sekundes=B[j].Flaikas-A[i].Slaikas;
            }
        }
    }
    rik(C, n);
    rez(C, n);

}
void skait(startas A[], finisas B[], int &n, int &m)
{
    char a[21];
    ifstream fd ("U2.txt");
    fd>>n;
    fd.ignore(80, '\n');
    for(int i=0; i<n; i++)
    {
        fd.get(a, 20);
        A[i].pav=a;
        fd>>A[i].VS>>A[i].MS>>A[i].SS;
        fd.ignore(80, '\n');
        A[i].Slaikas=A[i].VS*3600+A[i].MS*60+A[i].SS;
    }
    fd>>m;
    fd.ignore(80, '\n');
    for(int i=0; i<m; i++)
    {
        fd.get(a, 20);
        B[i].pav=a;
        fd>>B[i].VF>>B[i].MF>>B[i].SF;
            fd.ignore(80, '\n');
        B[i].Flaikas=B[i].VF*3600+B[i].MF*60+B[i].SF;
    }
}
void rik(pabaiga C[], int n)
{
    int temp;
    string ttemp;
    for(int i=0; i<n-1; i++)
    {
        for(int j=0; j<n-i-1; j++)
        {
            if(C[j].sekundes>C[j+1].sekundes)
            {
                temp=C[j].sekundes;
                C[j].sekundes=C[j+1].sekundes;
                C[j+1].sekundes=temp;
                ttemp=C[j].pav;
                C[j].pav=C[j+1].pav;
                C[j+1].pav=ttemp;

            }
            if(C[j].sekundes==C[j+1].sekundes&&C[j].pav>C[j+1].pav)
            {
                temp=C[j].sekundes;
                C[j].sekundes=C[j+1].sekundes;
                C[j+1].sekundes=temp;
                ttemp=C[j].pav;
                C[j].pav=C[j+1].pav;
                C[j+1].pav=ttemp;

            }
        }
    }
}
void rez(pabaiga C[], int n)
{
    ofstream fr ("U2rez.txt");
    for(int i=0; i<n; i++)
        if(C[i].pav!="")
        fr<<C[i].pav<<"  "<<C[i].sekundes/60<<" "<<C[i].sekundes%60<<endl;
}
