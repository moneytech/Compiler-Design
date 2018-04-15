## Compilation: 
#### Using lex and yacc. Please use the following commands to run.
1. yacc -d if_while.y
2. lex if_while.l
3. gcc y.tab.c lex.yy.c -ll -lm
4. ./a.out
