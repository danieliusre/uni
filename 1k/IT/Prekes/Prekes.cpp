#include<iostream>
#include<fstream>
#include<iomanip>
using namespace std;
void skait(int &p, int &sk, int &n, int pr[]);
void rez(int p, int sk);
int main()
{
    int p, n, pr[500], sk=0;
    skait(p, sk, n, pr);
    rez(p, sk);
}
void skait(int &p, int &sk, int &n, int pr[])
{
    int m, x=0, y=0;
    ifstream fd("duom.txt");
    fd>>p>>n;
    for(int i=0; i<n; i++)
    {
        x=0;
        fd>>m;
        cout<<"m="<<m<<endl;
        for(int j=0; j<m; j++)
        {
            fd>>pr[j]; cout<<"prrr="<<pr[j]<<endl;
            if(pr[j]>x&&pr[j]<p)
               {

                x=pr[j];
                cout<<"x="<<x<<endl;}
        }
        if(x<p)
        {
            p=p-x;
            cout<<"p="<<p<<endl;
            sk=sk+1;
        }


}
fd.close();
}
void rez(int p, int sk)
{
    ofstream fr("rez.txt");
    fr<<sk<<endl<<p;
    fr.close();

}
