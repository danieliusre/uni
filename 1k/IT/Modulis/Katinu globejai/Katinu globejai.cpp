#include<iostream>
#include<iomanip>
#include<fstream>
#include<string>
using namespace std;
struct ledai{
    string pav;
    int eur;
    int cent;
    int kiekis[10];
    double kaina[10];
    int liko;
    int mok=0;
    int d;
};
void skait(int &n, ledai A[]);
int vaik(int n, ledai A[]);
int main()
{
    string pav;
    int n, d, kp, eur, cent, kiekis, suma=0, nr;
    double kaina;
    ledai A[60];
    skait(n, A);
    for(int i=0; i<n; i++)
    {
        A[i].cent=A[i].cent+A[i].eur*100;
        A[i].liko=A[i].cent-A[i].mok;
        suma+=A[i].liko;
    }
    nr=vaik(n, A);
    ofstream fr ("rez.txt");
    for(int i=0; i<n; i++)
    {
        fr<<A[i].pav<<" "<<A[i].liko/100<<" "<<A[i].liko%100<<endl;
    }
    fr<<suma/100<<" "<<suma%100<<endl;
    fr<<A[nr].pav<<" "<<A[nr].liko/100<<" "<<A[nr].liko%100<<endl;

}
void skait(int &n, ledai A[])
{
    ifstream fd ("duom.txt");
    fd>>n;
    fd.ignore();
    char a[15];
    for(int i=0; i<n; i++)
    {
        fd.get(a, 15);
        A[i].pav=a;
        fd>>A[i].eur>>A[i].cent;
        fd>>A[i].d;
        for(int j=0; j<A[i].d; j++)
        {
            fd>>A[i].kiekis[j]>>A[i].kaina[j];
            A[i].mok+=A[i].kiekis[j]*A[i].kaina[j]*100;
        }
        fd.ignore();
    }
}
int vaik(int n, ledai A[])
{
    int x=0, y=0;
    for(int i=0; i<n; i++)
    {
        if(y<A[i].liko)
        {
            y=A[i].liko;
            x=i;
        }

    }
    return x;
}
