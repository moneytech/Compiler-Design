%{
#include<stdio.h>
#include<stdlib.h>
#include "y.tab.h"


%}

%%
"exit"    {return exit_command;}
[a-zA-Z]+ {strcpy(yylval.string,yytext);return s_op;}
[0-9]+ {yylval.num=atoi(yytext);return n_op;}
[-+*/#@%;^&\*=~?] {return yytext[0];}
"<>" {return '!';}
")" {return *yytext;}
"(" {return *yytext;}
[ \t\r] ;
.      {ECHO;yyerror("unexpected character");}

%%
int yywrap(void){return 1;}
