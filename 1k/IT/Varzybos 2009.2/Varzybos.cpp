#include<iostream>
#include<iomanip>
#include<string>
#include<fstream>
using namespace std;
struct begikai{
    string pav;
    int m;
    int s;
};
void rez(begikai B[], int q);
int main()
{
    int n, k, q=0;
    begikai A[510], B[510];
    ifstream fd ("U2.txt");
    fd>>k;
    char a[21];
    for(int i=0; i<k; i++)
    {
        fd>>n;
        fd.ignore();
        {
            for(int j=0; j<n; j++)
            {
                fd.get(a, 20);
                A[j].pav=a;
                fd>>A[j].m>>A[j].s;
                A[j].s+=A[j].m*60;
                fd.ignore();
            }
            for(int j=0; j<n-1; j++)
            {
                for(int k=j+1; k<n; k++)
                {
                    if(A[j].s>A[k].s)
                    {
                        swap(A[j], A[k]);
                    }

                }

            }
            for(int j=0; j<n/2; j++)
            {
                B[q]=A[j];
                q++;
            }
        }
    }
    rez(B, q);
}
void rez(begikai B[], int q)
{
    ofstream fr ("U2rez.txt");
    for(int j=0; j<q-1; j++)
    {
        for(int k=j+1; k<q; k++)
        {
            if(B[j].s>B[k].s)
            {
                swap(B[j], B[k]);
            }
        }
    }
    for(int i=0; i<q; i++)
    {
        fr<<B[i].pav<<" "<<B[i].s/60<<" "<<B[i].s%60<<endl;
    }
}
