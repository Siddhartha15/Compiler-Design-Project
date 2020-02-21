# Parser

## To run test.c
- Make sure test.c is in 'Parser' directory
- yacc -d parser.y
- lex scanner.l
- gcc lex.yy.c y.tab.c -w
- ./a.out test.c 
