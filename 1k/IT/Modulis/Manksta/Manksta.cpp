#include<iostream>
#include<fstream>
#include<string>
using namespace std;
struct prat{
    string pav;
    int k;
    int sum;
};
void rik(prat A[], int n);
int main()
{
    int n;
    char a[21];
    prat A[101];
    ifstream fd ("U2.txt");
    fd>>n;
    fd.ignore();
    for(int i=0; i<n; i++)
    {
        fd.get(a, 20);
        A[i].pav=a;
        fd>>A[i].k;
        fd.ignore(80, '\n');
    }
    for(int i=0; i<n; i++)
    {
        for(int j=i+1; j<n; j++)
        {
            if(A[i].pav==A[j].pav)
            {
                A[i].k+=A[j].k;
                A[j].pav="x";
                A[j].k=0;
            }
        }
    }
    rik(A, n);
    ofstream fr ("U2rez.txt");
    for(int i=0; i<n; i++)
    {
        if(A[i].pav!="x"||A[i].k!=0)
            fr<<A[i].pav<<"  "<<A[i].k<<endl;
    }
}
void rik(prat A[], int n)
{
    int temp;
    string ttemp;
    for(int i=0; i<n-1; i++)
    {
        for(int j=0; j<n-i-1; j++)
        {
            if(A[j].k<A[j+1].k)
            {
                temp=A[j].k;
                A[j].k=A[j+1].k;
                A[j+1].k=temp;
                ttemp=A[j].pav;
                A[j].pav=A[j+1].pav;
                A[j+1].pav=ttemp;
            }
        }
    }
}
