#include<iostream>
#include<fstream>
#include<string>
using namespace std;
struct sportas{
    string pav;
    int nr;
    int h1;
    int m1;
    int s1;
    int s;
};
struct fin{
    int nr2;
    int h2;
    int m2;
    int s2;
    int s;
    int suviai=0;
};
struct pab{
    string pav;
    int nr;
    int s;
    int finisas=0;
};
void skait(int &n, int &m, sportas A[], fin B[]);
void laikas(int n, int m, sportas A[], fin B[], pab C[]);
void rik(int n, pab C[]);
void rez(int n, pab C[]);
int main()
{
    sportas A[100];
    fin B[100];
    pab C[100];
    int n, m;
    skait(n, m, A, B);
    laikas(n, m, A, B, C);
    rik(n, C);
    rez(n, C);
}
void skait(int &n, int &m, sportas A[], fin B[])
{
    ifstream fd ("U2.txt");
    fd>>n;
    fd.ignore();
    char a[21];
    for(int i=0; i<n; i++)
    {
        fd.get(a, 21);
        A[i].pav=a;
        fd>>A[i].nr>>A[i].h1>>A[i].m1>>A[i].s1;
        fd.ignore();
    }
    fd>>m;
    int x;
    for(int i=0; i<m; i++)
    {
        fd>>B[i].nr2>>B[i].h2>>B[i].m2>>B[i].s2;
        if(B[i].nr2/100==1)
            for(int j=0; j<2; j++)
        {
            fd>>x;
            B[i].suviai+=x;
        }
        else
            for(int j=0; j<4; j++)
        {
            fd>>x;
            B[i].suviai+=x;
        }
    }
}
void laikas(int n, int m, sportas A[], fin B[], pab C[])
{
    for(int i=0; i<n; i++)
    {
        A[i].s=A[i].s1+A[i].m1*60+A[i].h1*3600;
    }
    for(int i=0; i<m; i++)
    {
        B[i].s=B[i].s2+B[i].m2*60+B[i].h2*3600;
    }
    for(int i=0; i<n; i++)
    {
        for(int j=0; j<n; j++)
        {
            if(A[i].nr==B[j].nr2)
            {
                C[i].nr=A[i].nr;
                C[i].pav=A[i].pav;
                C[i].finisas=1;
                if(A[i].nr/100==2)
                C[i].s=(B[j].s-A[i].s)+(20-B[j].suviai)*60;
                else
                C[i].s=(B[j].s-A[i].s)+(10-B[j].suviai)*60;

            }
        }
    }

}
void rik(int n, pab C[])
{
    int temp;
    string ttemp;
    for(int i=0; i<n-1; i++)
    {
        for(int j=0; j<n-i-1; j++)
        {
            if(C[j].s>C[j+1].s)
            {
                temp=C[j].s;
                C[j].s=C[j+1].s;
                C[j+1].s=temp;
                ttemp=C[j].pav;
                C[j].pav=C[j+1].pav;
                C[j+1].pav=ttemp;
                temp=C[j].nr;
                C[j].nr=C[j+1].nr;
                C[j+1].nr=temp;
                temp=C[j].finisas;
                C[j].finisas=C[j+1].finisas;
                C[j+1].finisas=temp;
            }
        }
    }
}
void rez(int n, pab C[])
{
    ofstream fr ("U2rez.txt");
    fr<<"Merginos"<<endl;
    for(int i=0; i<n; i++)
    {
        if(C[i].finisas==1&&C[i].nr/100==1)
        {

            fr<<C[i].nr<<" "<<C[i].pav<<" ";
            if(C[i].s>3600)
            {
                int x=C[i].s/3600;
                C[i].s=C[i].s-x*3600;
                fr<<x<<" "<<C[i].s/60<<" "<<C[i].s%60<<endl;
            }
            else fr<<"0 "<<C[i].s/60<<" "<<C[i].s%60<<endl;
        }
    }
    fr<<"Vaikinai"<<endl;
        for(int i=0; i<n; i++)
    {
        if(C[i].finisas==1&&C[i].nr/100==2)
        {

            fr<<C[i].nr<<" "<<C[i].pav<<" ";
            if(C[i].s>3600)
            {
                int x=C[i].s/3600;
                C[i].s=C[i].s-x*3600;
                fr<<x<<" "<<C[i].s/60<<" "<<C[i].s%60<<endl;
            }
            else fr<<"0 "<<C[i].s/60<<" "<<C[i].s%60<<endl;
        }
    }
}
