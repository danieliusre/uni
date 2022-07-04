#include<iostream>
#include<iomanip>
#include<fstream>
#include<string>
using namespace std;
struct pusr{
    string pav;
    int x;
};
int main()
{
    int n, nap, mok[100];
    string pav;
    pusr A[100];
    ifstream fd ("duom.txt");
    fd>>n;
    for(int i=0; i<n+1; i++)
    {
        getline(fd, A[i].pav);
    }
    fd>>nap;
    int q=0, w=0, nev=0, visomok=0;
    for(int i=0; i<100; i++)
        mok[i]=0;
    for(int i=0; i<nap; i++)
    {
        fd>>q;
        if(q!=0)
        for(int j=0; j<q; j++)
           {
               fd>>w;
               mok[w]+=1;
           }
        else
            nev+=1;
    }

    for(int i=1; i<n+1; i++)
    {
        A[i].x=mok[i];
    }
    int temp;
    string ttemp;
    for(int i=0; i<n-1; i++)
    {
        for(int j=1; j<n-i; j++)
        {
            if(A[j].x<A[j+1].x)
            {
                temp=A[j].x;
                A[j].x=A[j+1].x;
                A[j+1].x=temp;
                ttemp=A[j].pav;
                A[j].pav=A[j+1].pav;
                A[j+1].pav=ttemp;
            }
        }
    }
    ofstream fr ("rez.txt");
    for(int i=1; i<n+1; i++)
    {
        fr<<A[i].pav<<" "<<A[i].x<<endl;
    }
    fr<<"Pusryciu nevalgo "<< nev*100/nap<<"% mokiniu"<<endl;

}
