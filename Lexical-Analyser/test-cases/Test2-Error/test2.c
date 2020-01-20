// a linked list 
#include <stdio.h> 
#include <stdlib.h> 

#define size 10
struct pair{
    int a;
    int b;
};

int fun(int x){
    return x*x;
}

int main(){
    int a=2,b,c,d,e,f,g,h;

  
    char s[10]="Welcome!!";
    char s[]="Welcome!!";
    int a[2] = {1, 2};
    char S[20];

    int p;
    if(s[0]=='W'){
        if(s[1]=='e'){
            if(s[2]=='l'){
                printf("Welcome!!");
            }

            else printf("Bug1\n");
        }
        else printf("Bug2\n");
    }

    else printf("Bug3\n");
    
    int i=size;

    while(i--)
    {
        printf("hello world\n");
    }

}