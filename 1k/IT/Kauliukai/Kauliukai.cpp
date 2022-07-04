#include<iostream>
#include<iomanip>
#include<fstream>
#include<string>
using namespace std;
struct kaul{
    int taskai[10];
    int viso;
    string pav;
    int lyg=0;
};
void vald(int n, int k, kaul A[]);
int main()
{
    int n, k, taskai, viso, lyg, suma;
    string pav;
    kaul A[50];
    char a[11];
    ifstream fd ("U2.txt");
    fd>>n>>k;
    fd.ignore(80, '\n');
    for(int i=0; i<n; i++)
    {
        fd.get(a, 10);
        A[i].pav=a;
        A[i].viso=0;
        for(int j=0; j<k; j++)
        {
            fd>>A[i].taskai[j];
        }
        A[i].viso=0;
        fd.ignore(80, '\n');
    }
    vald(n, k, A);
}
void vald(int n, int k, kaul A[])
{
    for(int i=0; i<n; i++)
    {
        for(int j=0; j<k; j++)
        {
            if(A[i].taskai[j]%2==0)
            {
                  A[i].viso=A[i].viso+A[i].taskai[j];
                  A[i].lyg++;
            }

            else
            {
                 A[i].viso=A[i].viso-A[i].taskai[j];
            }

        }
    }

    int temp;
    string ttemp;
    for(int i=0; i<n-1; i++)
    {
        for(int j=0; j<n-i-1; j++)
        {
            if(A[j].viso<A[j+1].viso)
            {
                temp=A[j].viso;
                A[j].viso=A[j+1].viso;
                A[j+1].viso=temp;
                ttemp=A[j].pav;
                A[j].pav=A[j+1].pav;
                A[j+1].pav=ttemp;
                temp=A[j].lyg;
                A[j].lyg=A[j+1].lyg;
                A[j+1].lyg=temp;
            }
        }
    }


    for(int i=0; i<n-1; i++)
    {
        for(int j=0; j<n-i-1; j++)
        {
            if(A[j].viso==A[j+1].viso&&A[j].lyg<A[j+1].lyg)
            {
                temp=A[j].viso;
                A[j].viso=A[j+1].viso;
                A[j+1].viso=temp;
                ttemp=A[j].pav;
                A[j].pav=A[j+1].pav;
                A[j+1].pav=ttemp;
                temp=A[j].lyg;
                A[j].lyg=A[j+1].lyg;
                A[j+1].lyg=temp;
            }
        }
    }
        for(int i=0; i<n; i++)
        cout<<A[i].pav<<" "<<A[i].viso<<" "<<A[i].lyg<<endl;

    ofstream fr ("U2rez.txt");
    for(int i=0; i<1; i++)
    {
        fr<<A[i].pav<<"  "<<A[i].viso<<endl;
    }


}
