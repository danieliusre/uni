#include<iostream>
#include<fstream>
#include<string>
using namespace std;
struct piesinys{
    int x0;
    int y0;
    int dx;
    int dy;
    int p;
    int a;
    int t;
};
void skait(int &n, piesinys A[]);
int main()
{
    int n;
    piesinys A[100];
    skait(n, A);
}
void skait(int &n, piesinys A[])
{
    ifstream fd ("U1.txt");
    fd>>n;
    for(int i=0; i<n; i++)
    {
        fd>>A[i].x0>>A[i].y0>>A[i].dx>>A[i].dy>>A[i].p>>A[i].a>>A[i].t;
    }
}
