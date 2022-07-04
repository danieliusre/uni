#include<iostream>
#include<iomanip>
#include<fstream>
#include<string>
using namespace std;
struct avys{
    string pav;
    char dnr[20];
    int tinka=0;
};
void skait(int &n, int &m, int &nr, avys A[]);
void sut(int n, int m, int nr, avys A[]);
void rik(int n, avys A[]);
void rez(int n, int nr, avys A[]);
int main()
{
    int n, m, nr;
    avys A[100];
    skait(n, m, nr, A);
    sut(n, m, nr, A);
    rik(n, A);
    rez(n, nr, A);
}
void skait(int &n, int &m, int &nr, avys A[])
{
    char b[11];
    ifstream fd ("U2.txt");
    fd>>n>>m;
    fd>>nr;
    fd.ignore(80, '\n');
    for(int i=0; i<n; i++)
    {
        fd.get(b, 11);
        A[i].pav=b;
        for(int j=0; j<m; j++)
            {
                fd>>A[i].dnr[j];
            }
        fd.ignore(80, '\n');
    }
}
void sut(int n, int m, int nr, avys A[])
{
    for(int i=0; i<n; i++)
    {
        for(int j=0; j<m; j++)
        {
            if(A[nr-1].dnr[j]==A[i].dnr[j])
            {
                A[i].tinka++;
            }
        }
    }
}
void rik(int n, avys A[])
{
    int temp;
    string ttemp;
    for(int i=0; i<n-1; i++)
    {
        for(int j=i+1; j<n; j++)
        {
            if(A[i].tinka<A[j].tinka)
            {
                swap(A[i].tinka, A[j].tinka);
                swap(A[i].pav, A[j].pav);
            }
            if(A[i].tinka==A[j].tinka&&A[i].pav>A[j].pav)
            {
                swap(A[i].tinka, A[j].tinka);
                swap(A[i].pav, A[j].pav);
            }
        }
    }
}
void rez(int n, int nr, avys A[])
{
    ofstream fd ("U2rez.txt");
    fd<<A[0].pav<<endl;
    for(int i=1; i<n; i++)
    {
            fd<<A[i].pav<<" "<<A[i].tinka<<endl;
    }
}
