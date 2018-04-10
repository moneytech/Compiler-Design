%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "y.tab.h"
%}
ints -?[0-9]+
floats -?[0-9]+.[0-9]+
nums -?[0-9]+(.[0-9]+)?
%%

		
"min("({nums}(,)?)+")" {
			
			int i=0,j=0;
			char *p = yytext;
			i=4;
			while(p[i]!='\0'){
				yytext[j]=p[i];
				i=i+1;j=j+1;
				
			}
			yytext[j]='\0';
			yylval.str=strdup(yytext);
			return args;
		}
		   
		   
, {return yytext[0];}	

"min()" {printf("Too few arguements\n");}
					
%%
int yywrap(void){return 1;}
