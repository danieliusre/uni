#include<iostream>
#include<fstream>
#include<string>
using namespace std;
struct prod{
    string pav;
    int a[500];
    int kainac;
};
void centai(int &viso, int N, int P, prod A[], int kaina[]);
int main()
{
    int viso=0, N, P, kaina[500];
    char x[15];
    prod A[500];
    ifstream fd ("U2.txt");
    fd>>N>>P;

    for(int i=0; i<N; i++)
    {
        fd>>kaina[i];
    }
    fd.ignore(80, '\n');
    for(int i=0; i<P; i++)
    {
        fd.get(x, 15);
        A[i].pav=x;

        for(int j=0; j<N; j++)
        {
                fd>>A[i].a[j];

        }    fd.ignore(80, '\n');
    }
    centai(viso, N, P, A, kaina);
    ofstream fr ("U2rez.txt");
    for(int i=0; i<P; i++)
    {
        fr<<A[i].pav<<"  "<<A[i].kainac<<endl;
    }
    fr<<viso/100<<" "<<viso%100;
}
void centai(int &viso, int N, int P, prod A[], int kaina[])
{

    for(int j=0; j<P; j++)
    {   A[j].kainac=0;
        for(int i=0; i<N; i++)
            {
                A[j].kainac=A[j].kainac+kaina[i]*A[j].a[i];
            }
            viso=viso+A[j].kainac;
    }


}

