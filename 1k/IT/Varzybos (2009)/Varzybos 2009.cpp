#include<iostream>
#include<fstream>
#include<string>
using namespace std;
struct grup{
    string vard;
    int m;
    int s;
};
int main()
{
    int m, q=0, s, n, k, x1=1000, x2;
    string vard;
    char a[21];
    grup A[100], ger[100], gg[100];
    ifstream fd ("U2.txt");
    ofstream fr ("U2rez.txt");
    fd>>k;
    for(int i=0; i<k; i++)
    {
        fd>>n;
        fd.ignore();
        for(int j=0; j<n; j++)
        {
            fd.get(a, 21);
            A[j].vard=a;
            fd>>A[j].m>>A[j].s;
            fd.ignore();
            A[j].s=A[j].m*60+A[j].s;
        }
    int mini, b;
    string bb;
    for(int i=0; i<n-1; i++)
    {
        mini=i;
        for(int j=i+1; j<n; j++)
        {
            if(A[j].s<A[mini].s)
            {
                mini=j;
                b=A[i].s;
                A[i].s=A[mini].s;
                A[mini].s=b;
                bb=A[i].vard;
                A[i].vard=A[mini].vard;
                A[mini].vard=bb;

            }
        }
    }

    for(int l=0; l<n/2; l++)
    {
        ger[q].s=A[l].s;
        ger[q].vard=A[l].vard;
        q++;
    }

}
int mini, b;
string bb;
for(int i=0; i<q-1; i++)
    {
        for(int j=i+1; j<q; j++)
        {
            if(ger[j].s<ger[i].s)
            {
                mini=ger[i].s;
                ger[i].s=ger[j].s;
                ger[j].s=mini;
                bb=ger[i].vard;
                ger[i].vard=ger[j].vard;
                ger[j].vard=bb;
            }
        }
    }
for(int i=0; i<q; i++)
    {
        fr<<ger[i].vard<<ger[i].s/60<<" "<<ger[i].s%60<<endl;
    }
}

