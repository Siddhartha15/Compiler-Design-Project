%{
	#include <stdio.h>
	#include <string.h>
	
	int size=1002;

	struct Table
	{
		char name[100];
		char type[100];
		int length;
	}symTbl[1002],constTbl[1002];

	int hash(char *str);
	int searchSymTbl(char *str);
	int searchConstTbl(char *str);
	void insertSymTbl(char *str1, char *str2);
	void insertConstTbl(char *str1, char *str2);
	void printSymTbl();
	void printConstTbl();

%}

DE "define"
IN "include"

operator [[<][=]|[>][=]|[=][=]|[!][=]|[>]|[<]|[\|][\|]|[&][&]|[\!]|[=]|[\^]|[\+][=]|[\-][=]|[\*][=]|[\/][=]|[\%][=]|[\+][\+]|[\-][\-]|[\+]|[\-]|[\*]|[\/]|[\%]|[&]|[\|]|[~]|[<][<]|[>][>]]


%%
\n   {yylineno++;}
([#][" "]*({IN})[ ]*([<]?)([A-Za-z]+)[.]?([A-Za-z]*)([>]?))/["\n"|\/|" "|"\t"] {printf("%s \t-Pre Processor directive\n",yytext);}	//Matches #include<stdio.h>
([#][" "]*({DE})[" "]*([A-Za-z]+)(" ")*[0-9]+)/["\n"|\/|" "|"\t"] {printf("%s \t-Macro\n",yytext);} //Matches macro
\/\/(.*) {printf("%s \t- SINGLE LINE COMMENT\n", yytext);}				
\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+\/  {printf("%s \t- MULTI LINE COMMENT\n", yytext);}

[ \n\t] ;
; {printf("%s \t- SEMICOLON DELIMITER\n", yytext);}
, {printf("%s \t- COMMA DELIMITER\n", yytext);}
\{ {printf("%s \t- OPENING BRACES\n", yytext);}
\} {printf("%s \t- CLOSING BRACES\n", yytext);}
\( {printf("%s \t- OPENING BRACKETS\n", yytext);}
\) {printf("%s \t- CLOSING BRACKETS\n", yytext);}
\[ {printf("%s \t- SQUARE OPENING BRACKETS\n", yytext);}
\] {printf("%s \t- SQUARE CLOSING BRACKETS\n", yytext);}
\: {printf("%s \t- COLON DELIMITER\n", yytext);}
\\ {printf("%s \t- FSLASH\n", yytext);}
\. {printf("%s \t- DOT DELIMITER\n", yytext);}
auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while|main/[\(|" "|\{|;|:|"\n"|"\t"] {printf("%s \t- KEYWORD\n", yytext); insertSymTbl(yytext, "KEYWORD");}
\"[^\n]*\"/[;|,|\)] {printf("%s \t- STRING CONSTANT\n", yytext); insertConstTbl(yytext,"STRING CONSTANT");}
\'[A-Z|a-z]\'/[;|,|\)|:] {printf("%s \t- Character CONSTANT\n", yytext); insertConstTbl(yytext,"Character CONSTANT");}
[a-z|A-Z|_]([a-z|A-Z|_]|[0-9])*/\[[1-9][0-9]*\] {printf("%s \t- ARRAY IDENTIFIER\n", yytext); insertSymTbl(yytext, "IDENTIFIER");}

{operator}/[a-z]|[0-9]|;|" "|[A-Z]|\(|\"|\'|\)|\n|\t {printf("%s \t- OPERATOR\n", yytext);} 

[1-9][0-9]*|0/[;|,|" "|\)|<|>|=|\!|\||&|\+|\-|\*|\/|\%|~|\]|\}|:|\n|\t|\^] {printf("%s \t- NUMBER CONSTANT\n", yytext); insertConstTbl(yytext, "NUMBER CONSTANT");}
([0-9]*)\.([0-9]+)/[;|,|" "|\)|<|>|=|\!|\||&|\+|\-|\*|\/|\%|~|\n|\t|\^] {printf("%s \t- Floating CONSTANT\n", yytext); insertConstTbl(yytext, "Floating CONSTANT");}
[A-Za-z_][A-Za-z_0-9]*/[" "|;|,|\(|\)|<|>|=|\!|\||&|\+|\-|\*|\/|\%|~|\n|\.|\{|\^|\t] {printf("%s \t- IDENTIFIER\n", yytext); insertSymTbl(yytext, "IDENTIFIER");}


(.?) {
		if(yytext[0]=='#')
		{
       		printf("line No %d :Error in Pre-Processor directive\n",yylineno);
       	}
	    else if(yytext[0]=='/')
	    {
       		printf("line No %d :ERR_UNMATCHED_COMMENT\n",yylineno);
       	}
       	else if(yytext[0]=='"')
       	{
       		printf("line No %d :ERR_INCOMPLETE_STRING\n",yylineno);
       	}
       	else
       	{
       		printf("line No %d :ERROR\n",yylineno);
       	}
       	printf("%s\n", yytext);
       	return 0;
}

%%

int main(int argc , char **argv){


	int i;
	for (i=0;i<size;i++){
		symTbl[i].length=0;
		constTbl[i].length=0;
	}

	yyin = fopen("input.c","r");
	yylex();
	
	printf("\n\nSYMBOL TABLE\n\n");
	printSymTbl();
	printf("\n\nCONSTANT TABLE\n\n");
	printConstTbl();
}

int yywrap(){
    return 1;
}

int hash(char *str)
{
	int value = 0;
	for(int i = 0 ; i < strlen(str) ; i++)
	{
		value = 10*value + (str[i] - 'A');
		value = value % size;
		while(value < 0)
			value = value + size;
	}
	return value;
}

int searchSymTbl(char *str)
{
	int value = hash(str);
	if(symTbl[value].length == 0)
	{
		return 0;
	}
	else if(strcmp(symTbl[value].name,str)==0)
	{
		return 1;
	}
	else
	{
		for(int i = value + 1 ; i!=value ; i = (i+1)%size)
    	{
    		if(strcmp(symTbl[i].name,str)==0)
    		{
    			return 1;
    		}
    	}
    	return 0;
    }
}

int searchConstTbl(char *str)
{
	int value = hash(str);
	if(constTbl[value].length == 0)
		return 0;
	else if(strcmp(constTbl[value].name,str)==0)
		return 1;
	else
	{
		for(int i = value + 1 ; i!=value ; i = (i+1)%size)
		{
			if(strcmp(constTbl[i].name,str)==0)
			{
				return 1;
			}
		}
		return 0;
	}
}

void insertSymTbl(char *str1, char *str2)
{
	if(searchSymTbl(str1))
	{
	    return;
    }
	else
	{
		int value = hash(str1);
		if(symTbl[value].length == 0)
		{
			strcpy(symTbl[value].name,str1);
			strcpy(symTbl[value].type,str2);
			symTbl[value].length = strlen(str1);
			return;
		}

		int pos = 0;

		for (int i = value + 1 ; i!=value ; i = (i+1)%size)
		{
			if(symTbl[i].length == 0)
			{
				pos = i;
				break;
			}
		}

		strcpy(symTbl[pos].name,str1);
		strcpy(symTbl[pos].type,str2);
		symTbl[pos].length = strlen(str1);
	}
}

void insertConstTbl(char *str1, char *str2)
{
	if(searchConstTbl(str1))
		return;
	else
	{
		int value = hash(str1);
		if(constTbl[value].length == 0)
		{
			strcpy(constTbl[value].name,str1);
			strcpy(constTbl[value].type,str2);
			constTbl[value].length = strlen(str1);
			return;
		}

		int pos = 0;

		for (int i = value + 1 ; i!=value ; i = (i+1)%size)
		{
			if(constTbl[i].length == 0)
			{
				pos = i;
				break;
			}
		}

		strcpy(constTbl[pos].name,str1);
		strcpy(constTbl[pos].type,str2);
		constTbl[pos].length = strlen(str1);
	}
}

void printSymTbl()
{
	for(int i = 0 ; i < size ; i++)
	{
		if(symTbl[i].length == 0)
		{
			continue;
		}

		printf("%s\t%s\n",symTbl[i].name, symTbl[i].type);
	}
}

void printConstTbl()
{
	for(int i = 0 ; i < size ; i++)
	{
		if(constTbl[i].length == 0)
			continue;

		printf("%s\t%s\n",constTbl[i].name, constTbl[i].type);
	}
}