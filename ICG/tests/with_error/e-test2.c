#include<stdio.h>
int cube(int a)
{
	return a*a*a;
}

int main()
{
	int num = 2;
	if(num < 0){
		num = cube(num)
	}
	else{
		num = square(num)
	}
}