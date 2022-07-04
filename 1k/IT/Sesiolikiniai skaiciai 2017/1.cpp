#include<iostream>
#include<iomanip>
#include<fstream>
#include<string>
using namespace std;
struct sk{
    int skaicius[5];
    char ch[5];
};
string funkc(sk A[], int q);
int main()
{
    int a, b, q=0;
    sk A[50000];
    ifstream fd ("U1.txt");
    ofstream fr ("U1rez.txt");
    fd>>a>>b;
    string kodas="x";
    for(int j=0; j<a; j++)
        {
            for(int i=0; i<b; i++)
                {
                    fd>>A[q].skaicius[0]>>A[q].skaicius[2]>>A[q].skaicius[4];
                    kodas=funkc(A, q);
                    q++;
                    kodas.resize(6);
                    if(i+1==b)
                    fr<<kodas;
                    else fr<<kodas<<";";
                }
                fr<<endl;
        }

}
string funkc(sk A[], int q)
{
    for(int i=0; i<6; i++)
    {
        if((A[q].skaicius[i]/16)<=10)
        {
            int zz=A[q].skaicius[i]/16;
            char a='0'+zz;
            A[q].ch[i]=a;
        }
        if((A[q].skaicius[i]/16)==10)
        {
            A[q].ch[i]='A';
        }
        if((A[q].skaicius[i]/16)==11)
        {
            A[q].ch[i]='B';
        }
        if((A[q].skaicius[i]/16)==12)
        {
            A[q].ch[i]='C';
        }
        if((A[q].skaicius[i]/16)==13)
        {
            A[q].ch[i]='D';
        }
        if((A[q].skaicius[i]/16)==14)
        {
            A[q].ch[i]='E';
        }
        if((A[q].skaicius[i]/16)==15)
        {
            A[q].ch[i]='F';
        }
        i++;
        if((A[q].skaicius[i-1]%16)<10)
        {
            int zz=A[q].skaicius[i-1]%16;
            char a='0'+zz;
            A[q].ch[i]=a;
        }
        if((A[q].skaicius[i-1]%16)==10)
        {
            A[q].ch[i]='A';
        }
        if((A[q].skaicius[i-1]%16)==11)
        {
            A[q].ch[i]='B';
        }
        if((A[q].skaicius[i-1]%16)==12)
        {
            A[q].ch[i]='C';
        }
        if((A[q].skaicius[i-1]%16)==13)
        {
            A[q].ch[i]='D';
        }
        if((A[q].skaicius[i-1]%16)==14)
        {
            A[q].ch[i]='E';
        }
        if((A[q].skaicius[i-1]%16)==15)
        {
            A[q].ch[i]='F';
        }
    }
    string x;
    x=A[q].ch;
    return x;
}
