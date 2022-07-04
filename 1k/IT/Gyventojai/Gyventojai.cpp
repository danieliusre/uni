#include<iostream>
#include<fstream>
#include<iomanip>
using namespace std;
void skait (int &n, int nr[], int gyv[]);
void gyvv (int gyv[], int &suma, int n);
void kd (int n, int gyv[], int nr[], int &k, int &d);
void kdnamai(int n, int gyv[], int nr[], int kn, int dn, double &kvid, double &dvid, int k, int d);
void rez(int n, int suma, int k, int d, double dvid, double kvid);
int main ()
{
    int nr[500];
    int gyv[500];
    int n, k, kn, dn, d, suma;
    double  kvid, dvid;
    skait(n, nr, gyv);
    gyvv(gyv, suma, n);
    kd(n, gyv, nr, k, d);
    kdnamai(n, gyv, nr, kn, dn, kvid, dvid, k, d);
    rez(n, suma, k, d, dvid, kvid);
}
void skait(int &n, int nr[], int gyv [])
{
    ifstream fd ("duom.txt");
    fd>>n;
    for(int i=0; i<n; i++)
    {
        fd>>nr[i]>>gyv[i];

    }
    fd.close();

}
void gyvv(int gyv[],int &suma, int n)
{
    suma=0;
    for(int i=0; i<n; i++)
    {
        suma=suma+gyv[i];
    }

}
void kd(int n, int gyv[], int nr[], int &k, int &d)
{
    k=0;
    d=0;
    for(int i=0; i<n; i++)
        if(nr[i]%2==0)
    {
        d=d+gyv[i];
    }
    else k=k+gyv[i];
}
void kdnamai(int n, int gyv[], int nr[], int kn, int dn, double &kvid, double &dvid, int k, int d)
{
    kn=0;
    dn=0;
    for(int i=0; i<n; i++)
       {
           if(nr[i]%2==0)
    {
        dn=dn+1;
    }

    else kn=kn+1;

       }
kvid=k/kn;
dvid=d/dn;

}
void rez(int n, int suma, int k, int d, double dvid, double kvid)
{
        ofstream fr ("rez.txt");
        fr<<suma<<endl;
        fr<<k<<endl;
        fr<<d<<endl;
        fr<<fixed<<setprecision(2)<<kvid<<endl;
        fr<<fixed<<setprecision(2)<<dvid<<endl;
        fr.close();
}

