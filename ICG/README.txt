yacc -d parser.y
flex scanner.l
gcc -o compiler lex.yy.c y.tab.h y.tab.c -ll -ly
./compiler test.c