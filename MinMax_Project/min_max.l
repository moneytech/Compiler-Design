%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "y.tab.h"
%}
ints -?[0-9]+
floats -?[0-9]+.[0-9]+
%%
{ints} {yylval.integer=atoi(yytext);return num;}
{floats} {yylval.flt.num2=atof(yytext);
			int i=0,dot=0,flag=0;
			while(yytext[i]!='\0'){
				if(dot==1){
					flag++;
				}
				if(yytext[i]=='.'){
					dot=1;
				}
				i++;
			}
			yylval.flt.fp2=flag;
			return f;	
		}
"min("{ints}","{ints}")" {int i=0,j=0;int op1,op2; char c[100];char d[100];
							while(1){
								if(yytext[i]=='('){
									i++;
									while(yytext[i]!=','){
										c[j]=yytext[i];
										i++;j++;							
									}
									c[j]='\0';
									break;
									
								}
								else{i++;}
							}
							j=0;
							if(yytext[i]==','){
							i++;
								while(yytext[i]!=')'){
									d[j]=yytext[i];
									i++;j++;
								}
								d[j]='\0';
								yylval.obj.num1=atoi(c);
								yylval.obj.num3=atoi(d);
								return min_object_dd;

							}
							
							
							

						}
"min("{ints}","{floats}")" {int i=0,j=0,f2=0,dot=0; int op1; float op2;char c[100];char d[100];
							while(1){
								if(yytext[i]=='('){
									i++;
									while(yytext[i]!=','){
										c[j]=yytext[i];
										i++;j++;							
									}
									c[j]='\0';
									break;
								}
								else{i++;}
							}
							j=0;
							if(yytext[i]==','){
							i++;
								while(yytext[i]!=')'){
									d[j]=yytext[i];
									if(dot==1){
										f2++;
									}
									if(yytext[i]=='.')
									{
										dot=1;
									}
									i++;j++;
								}
								d[j]='\0';
								yylval.obj.num1 = atoi(c);
								yylval.obj.num2 = atof(d);
								yylval.obj.fp2 = f2;
								return min_object_df;
							}
							
						}
						
"min("{floats}","{ints}")" {int i=0,j=0,f2=0,dot=0; int op1; float op2; char c[100];char d[100];
							while(1){
								if(yytext[i]=='('){
									i++;
									while(yytext[i]!=','){
										c[j]=yytext[i];
										if(dot==1){
											f2++;
										}
										if(yytext[i]=='.')
										{
											dot=1;
										}
										i++;j++;							
									}
									c[j]='\0';
									break;
								}
								else{i++;}
							}
							j=0;
							if(yytext[i]==','){
							i++;
								while(yytext[i]!=')'){
									d[j]=yytext[i];
									i++;j++;
								}
								d[j]='\0';
								yylval.obj.num2 = atof(c);
								yylval.obj.num1 = atoi(d);
								yylval.obj.fp2 = f2;
								return min_object_fd;
							}
	
						}
"min("{floats}","{floats}")" {int i=0,j=0,f2=0,f4=0,dot=0,dot2=0; float op1,op2; char c[100];char d[100];
							while(1){
								if(yytext[i]=='('){
									i++;
									while(yytext[i]!=','){
										c[j]=yytext[i];
										if(dot==1){
											f2++;
										}
										if(yytext[i]=='.')
										{
											dot=1;
										}
										i++;j++;							
									}
									c[j]='\0';
									break;
								}
								else{i++;}
							}
							j=0;
							if(yytext[i]==','){
							i++;
								while(yytext[i]!=')'){
									d[j]=yytext[i];
									if(dot2==1){
										f4++;
									}
									if(yytext[i]=='.')
									{
										dot2=1;
									}
									i++;j++;
								}
								d[j]='\0';
								yylval.obj.num2=atof(c);
								yylval.obj.num4=atof(d);
								yylval.obj.fp2 = f2;
								yylval.obj.fp4 = f4;
								return min_object_ff;

							}
						}
"min(" {return '!';}
, {return yytext[0];}	
\) {return yytext[0];}					
. {}
%%
int yywrap(void){return 1;}
