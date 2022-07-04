#include<iostream>
#include<fstream>
#include<string>
using namespace std;
struct siunt{
    char a[11];
    string pav;
    int x;
    int y;
};
void skait(int &n, int &m, siunt A[]);
void atstumas(int n, int m, siunt A[], int &S, int &sk);
void rez(int sk, int S, siunt A[]);
int main()
{
    int n, m, x0=0, y0=0, sk, S;
    siunt A[100];
    skait(n, m, A);
    atstumas(n, m, A, S, sk);
    rez(sk, S, A);
}
void skait(int &n, int &m, siunt A[])
{
    ifstream fd ("U1.txt");
    fd>>n>>m;
    fd.ignore(80, '\n');
    for(int i=0; i<n; i++)
    {
        fd.get(A[i].a, 10);
        A[i].pav=A[i].a;
        fd>>A[i].x>>A[i].y;
        fd.ignore(80, '\n');
    }

}
void atstumas(int n, int m, siunt A[], int &S, int &sk)
{
    int kelias;
    int ats;
    S=0;
    sk=0;
    for(int i=0; i<n; i++)
    {
        ats=abs(A[i].x)+abs(A[i].y);
        kelias=2*ats;
        if(S+kelias<=m)
        {
            S+=kelias;
            sk++;
        }
    }
}
void rez(int sk, int S, siunt A[])
{
    ofstream fr ("U1rez.txt");
    fr<<sk<<" "<<S<<" "<<A[sk-1].pav;
}
