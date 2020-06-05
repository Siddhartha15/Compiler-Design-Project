#include<stdio.h>  

int facto(int n){
	int i, fact=1;
	for(i=1;i<=n;i++){    
      	fact=fact*i;    
  	}   
  	return fact;
}
int main()    
{    
 int i,number;    
 printf("Enter a number: ");    
  scanf("%d",&number);    
 char answer[10] =""
 answer = facto(number) 
  printf("Factorial of %d is: %d",number,answer);    
return 0;  
}   