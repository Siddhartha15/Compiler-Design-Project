# Semantic Analysis

## To run test
lex scanner.l 
yacc parser.y -d
gcc y.tab.c lex.yy.c -w
./a.out
