#include<iostream>
#include<fstream>
#include<string>
using namespace std;
struct miestai{
    string pav;
    string aps;
    int n;
};
struct apsk{
    string apskritis;
    int maz=100000;
    int sum=0;
};

int main()
{
    string xx[103];
    int x=0;
    miestai A[103];
    apsk B[103];
    int k;
    char a[21], b[14];
    ifstream fd ("U2.txt");
    fd>>k;
    fd.ignore(80, '\n');
    for(int i=0; i<k; i++)
    {
        fd.get(a, 21);
        A[i].pav=a;
        fd.get(b, 13);
        A[i].aps=b;
        fd>>A[i].n;
        fd.ignore(80, '\n');
    }
    int q=0;
    for(int i=0; i<k; i++)
    {
            if(B[0].apskritis!=A[i].aps&&B[1].apskritis!=A[i].aps&&B[2].apskritis!=A[i].aps&&B[3].apskritis!=A[i].aps&&B[4].apskritis!=A[i].aps&&B[5].apskritis!=A[i].aps&&B[6].apskritis!=A[i].aps&&B[7].apskritis!=A[i].aps&&B[8].apskritis!=A[i].aps&&B[9].apskritis!=A[i].aps&&B[10].apskritis!=A[i].aps)
                {
                B[q].apskritis=A[i].aps;
                q++;
                }
    }
    for(int i=0; i<k; i++)
        for(int j=0; j<q; j++)
    {
        if(A[i].aps==B[j].apskritis)
        {
            B[j].sum+=A[i].n;
            if(B[j].maz>A[i].n)
                B[j].maz=A[i].n;
        }
    }
    int temp;
    string ttemp;
    for(int i=0; i<q-1; i++)
    {
        for(int j=0; j<q-i-1; j++)
        {
            if(B[j].maz>B[j+1].maz)
            {
                temp=B[j].maz;
                B[j].maz=B[j+1].maz;
                B[j+1].maz=temp;
                ttemp=B[j].apskritis;
                B[j].apskritis=B[j+1].apskritis;
                B[j+1].apskritis=ttemp;
                temp=B[j].sum;
                B[j].sum=B[j+1].sum;
                B[j+1].sum=temp;
            }
        }
    }
     for(int i=0; i<q-1; i++)
    {
        for(int j=0; j<q-i-1; j++)
        {
            if(B[j].apskritis>B[j+1].apskritis&&B[j].maz==B[j+1].maz)
            {
                temp=B[j].maz;
                B[j].maz=B[j+1].maz;
                B[j+1].maz=temp;
                ttemp=B[j].apskritis;
                B[j].apskritis=B[j+1].apskritis;
                B[j+1].apskritis=ttemp;
                temp=B[j].sum;
                B[j].sum=B[j+1].sum;
                B[j+1].sum=temp;
            }
        }
    }
ofstream fr ("U2rez.txt");
fr<<q<<endl;
for(int i=0; i<q; i++)
{
    fr<<B[i].apskritis<<" "<<B[i].maz<<" "<<B[i].sum<<endl;
}
}
