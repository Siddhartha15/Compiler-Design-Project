#include<stdio.h>

int add(int a , int b){
	return a+b;
}

int main()
{
	int a = 5, b =10, i = 0;
	a = a+b;
	for(i=0;i<b;i++)
	{
		b++;
		add(a,b);

	}
	a++;


	
	while(a>0)
	{
		printf("Hello world");
		a--;
	}

	a=4;
	while(a>0)
	{
		printf("%d",a);
		a--;
		int b;
		b= 4;
		while(b>0)
		{
			printf("%d", b);
			b--;
		}
	}
}
