//for loop
//continue
//while loop
//do while loop
//operators

#include<stdio.h>

int main()
{
    int a=0;
    for (a = 0; a < 10; a++)
        continue;
    
    while(a>0) {
        a--;
    }

    do {
        a++;
    }while(a<10);

    int a=2,b,c,d,e,f,g,h;

    c=a+b;
    d=a*b;
    e=a/b;
    f=a%b;
    g=a&&b;
    h=a||b;
    h=a*(a+b);
    h=a*a+b*b;
    h=fun(b);
    
}

