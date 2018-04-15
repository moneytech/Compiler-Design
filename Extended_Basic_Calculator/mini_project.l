%{
#include <stdlib.h>
#include "calc3.h"
#include "y.tab.h"
void yyerror(char *);
%}
%%
[a-z] {
 yylval.sIndex = *yytext - 'a';
 return VARIABLE;
 }
[0-9]+ {
 yylval.iValue = atoi(yytext);
 return INTEGER;
 }
[-()<>=+*/;{}.] {
 return *yytext;
 }
">=" return GE;
"<=" return LE;
"==" return EQ;
"!=" return NE;
"while" return WHILE;
"if" return IF;
"else" return ELSE;
"print" return PRINT;
"factorial" return FACTORIAL;
"min()" {printf("Too few arguements\n");}
"max()" {printf("Too few arguements\n");}
"min(".*")" {
			
			
			yylval.str=strdup(yytext);
			return args;
		}
"max(".*")" {
			
			
			yylval.str=strdup(yytext);
			return args1;
		}		   
"min("	return '!';
"max("	return '@';	   
, {return yytext[0];}
[ \t\n]+ ; /* ignore whitespace */
. yyerror("Unknown character");
%%
int yywrap(void) {
 return 1;
} 
