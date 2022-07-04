#include<iostream>
#include<fstream>
#include<string>
using namespace std;
struct rez{
    int nr;
    int taskai;
};
struct namekai{
    string pav;
    string vard;
    int nr;
    string kom;
    int komtaskai=0;
};
struct start{
    string pav;
    string vard;
    int nr;
    string kom;
    int taskai;
    int minutes=0;
    int sek=0;
};
void skait(int &n, rez A[], namekai B[]);
void laik(int n, rez A[], namekai B[], start C[]);
void ger(int n, rez A[], namekai B[], string &geriausia, int &gertaskai);
void rezultatai(int n, rez A[], namekai B[], start C[], string geriausia, int gertaskai);
int main()
{
    string geriausia;
    rez A[100];
    namekai B[100];
    start C[100];
    int n, gertaskai;
    skait(n, A, B);
    laik(n, A, B, C);
    ger(n, A, B, geriausia, gertaskai);
    rezultatai(n, A, B, C, geriausia, gertaskai);
}
void skait(int &n, rez A[], namekai B[])
{
    ifstream fd1 ("rezultatai.txt");
    ifstream fd2 ("namekai.txt");
    fd1>>n;
    for(int i=0; i<n; i++)
    {
        fd1>>A[i].nr>>A[i].taskai;
    }
    for(int i=0; i<n; i++)
    {
        fd2>>B[i].pav>>B[i].vard>>B[i].nr>>B[i].kom;
    }
    int temp;
    string ttemp;
    for(int i=0; i<n-1; i++)
    {
        for(int j=0; j<n-i-1; j++)
        {
            if(B[j].nr>B[j+1].nr)
            {
                temp=B[j].nr;
                B[j].nr=B[j+1].nr;
                B[j+1].nr=temp;
                ttemp=B[j].pav;
                B[j].pav=B[j+1].pav;
                B[j+1].pav=ttemp;
                ttemp=B[j].kom;
                B[j].kom=B[j+1].kom;
                B[j+1].kom=ttemp;
            }
        }
    }
}
void laik(int n, rez A[], namekai B[], start C[])
{
    for(int i=1; i<n; i++)
    {
        C[i].sek=A[0].taskai-A[i].taskai;
        if(C[i].sek>60)
        {
            C[i].minutes=C[i].sek/60;
            C[i].sek=C[i].sek%60;
        }
    }
}
void ger(int n, rez A[], namekai B[], string &geriausia, int &gertaskai)
{
    int zal=0, raud=0, gelt=0;
    for(int i=0; i<n; i++)
    {
                if(B[i].kom=="Zalieji")
                    zal+=A[i].taskai;
                if(B[i].kom=="Raudonieji")
                    raud+=A[i].taskai;
                if(B[i].kom=="Geltonieji")
                    gelt+=A[i].taskai;
    }
    if(zal>raud&&zal>gelt)
    {
        geriausia="Zalieji";
        gertaskai=zal;
    }
    if(raud>zal&&raud>gelt)
    {
        geriausia="Raudonieji";
        gertaskai=raud;
    }
    if(gelt>raud&&gelt>zal)
    {
        geriausia="Geltonieji";
        gertaskai=gelt;
    }
}
void rezultatai(int n, rez A[], namekai B[], start C[], string geriausia, int gertaskai)
{
    ofstream fr ("StartoSarasas.txt");
    for(int i=0; i<n; i++)
    {
        if(C[i].sek/10==0&&C[i].minutes/10==0)
        fr<<B[i].pav<<" "<<B[i].vard<<" "<<B[i].nr<<" "<<B[i].kom<<" "<<A[i].taskai<<" 0"<<C[i].minutes<<":0"<<C[i].sek<<endl;
        if(C[i].sek/10!=0&&C[i].minutes/10==0)
        fr<<B[i].pav<<" "<<B[i].vard<<" "<<B[i].nr<<" "<<B[i].kom<<" "<<A[i].taskai<<" 0"<<C[i].minutes<<":"<<C[i].sek<<endl;
        if(C[i].sek/10==0&&C[i].minutes/10!=0)
        fr<<B[i].pav<<" "<<B[i].vard<<" "<<B[i].nr<<" "<<B[i].kom<<" "<<A[i].taskai<<" "<<C[i].minutes<<":0"<<C[i].sek<<endl;
        if(C[i].sek/10!=0&&C[i].minutes/10!=0)
        fr<<B[i].pav<<" "<<B[i].vard<<" "<<B[i].nr<<" "<<B[i].kom<<" "<<A[i].taskai<<" "<<C[i].minutes<<":"<<C[i].sek<<endl;
    }
    fr<<geriausia<<" "<<gertaskai<<endl;
}










