%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "calc3.h"
/* prototypes */

#include <math.h>
#include <alloca.h>
#include <stddef.h>
#include <ctype.h>
#include <string.h>
nodeType *opr(int oper, int nops, ...);
nodeType *id(int i);
nodeType *con(int value);
void freeNode(nodeType *p);
int ex(nodeType *p);
int yylex(void);
void yyerror(char *s);
int sym[26]; /* symbol table */
int i=0,j=0;
%}
%code requires{
struct s{
 	    char string[100];
		int num1,num3;
		float num2,num4;
		int fp2,fp4,np1,np3,flag;
	} ;
struct k{
 	    char string[100];
		int num1;
		float num2;
		int fp2;
	} ;
struct datatype{
     int Number;
     float Float_number;
     int flag;
     int float_point;
	};
}
%union {
 int iValue; /* integer value */
 char sIndex; /* symbol table index */
 nodeType *nPtr; /* node pointer */
 char *string;
	struct s obj,flt;
	int integer;
	char *str;
	struct datatype type;

};
%token <iValue> INTEGER
%token <sIndex> VARIABLE
%token WHILE IF PRINT FACTORIAL 
%nonassoc IFX
%nonassoc ELSE
%left GE LE EQ NE '>' '<'
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS
%type <nPtr> stmt expr stmt_list S1 S2

%token <integer> num
%token <str> args args1

%%
program:
 function { exit(0); }
 ;
function:
 function stmt { ex($2); freeNode($2); }
 | /* NULL */
 ;
stmt:
 ';' { $$ = opr(';', 2, NULL, NULL); }
 | expr ';' { $$ = $1; }
 | PRINT expr ';' { $$ = opr(PRINT, 1, $2); } 

 | VARIABLE '=' expr ';' { $$ = opr('=', 2, id($1), $3); }
 | WHILE '(' expr ')' stmt { $$ = opr(WHILE, 2, $3, $5); }
 | IF '(' expr ')' stmt %prec IFX { $$ = opr(IF, 2, $3, $5); }
 | IF '(' expr ')' stmt ELSE stmt
 { $$ = opr(IF, 3, $3, $5, $7); }
 | '{' stmt_list '}' { $$ = $2; }
 ;
stmt_list:
 stmt { $$ = $1; }
 | stmt_list stmt { $$ = opr(';', 2, $1, $2); }
 ;
expr:
 INTEGER { $$ = con($1); }
 | VARIABLE { $$ = id($1); }
 | '-' expr %prec UMINUS { $$ = opr(UMINUS, 1, $2); }
 | expr '+' expr { $$ = opr('+', 2, $1, $3); }
 | expr '-' expr { $$ = opr('-', 2, $1, $3); }
 | expr '*' expr { $$ = opr('*', 2, $1, $3); }
 | expr '/' expr { $$ = opr('/', 2, $1, $3); }
 | expr '<' expr { $$ = opr('<', 2, $1, $3); }
 | expr '>' expr { $$ = opr('>', 2, $1, $3); }
 | expr GE expr { $$ = opr(GE, 2, $1, $3); }
 | expr LE expr { $$ = opr(LE, 2, $1, $3); }
 | expr NE expr { $$ = opr(NE, 2, $1, $3); }
 | expr EQ expr { $$ = opr(EQ, 2, $1, $3); }
 | '(' expr ')' { $$ = $2; }
 | FACTORIAL '(' expr ')' { $$ = opr(FACTORIAL, 1, $3); }
| S1 {  
 			$$->con.value=$1->con.value;
			//printf("%d\n",$1->con.value);
		}
	   
 | S2 {$$->con.value=$1->con.value;
 		//printf("%d",$1->con.value);
 		}
 ;

S1 :'!'S1','S1')' {     

						if($2->con.value<$4->con.value){
							$$->con.value=$2->con.value;
						}
						else{
							$$->con.value=$4->con.value;
						}
					}
					
					
					
						
	 |args {  
	             int i=0,j=0;
			char p[1000];
			strcpy(p,$1);
			strcpy($1,"");
			i=4;
			while(p[i]!='\0'){
				$1[j]=p[i];
				i=i+1;j=j+1;
				
			}
			$1[j]='\0';
			
			float fnum;
			int inum;
			
			struct k temp;
			temp.num1=2147483647;
			temp.num2=2147483647; 
			temp.fp2 = 0;
			
			int dot=0,l,count;
			i=0;j=0;
			l=strlen($1);
			while(i<l){
				dot=0;j=0;count=0;
				char op[1000];
				while(1)
				{
					if($1[i]!=',')
					{
					    if(dot==1)count++;
						if($1[i]=='.')
						{
							dot=1;
						}
						op[j]=$1[i];
						j++;i++;
					}
					if($1[i]==','||$1[i]==')'){

						op[j]='\0';i++;
						if(dot==0){
						 if(temp.num1>atoi(op)){

						  temp.num1=atoi(op);
						  }
						}
						else {
						  if(temp.num2>atof(op))
						   temp.num2=atof(op);
						   temp.fp2=count;
						}
						break;
					}	
				}
				
			}
			  if(temp.num1<temp.num2)
              {

				  $$->con.value=temp.num1;
				  $$->type=typeCon;
			  }
			 
			  
	}
	
	  
  ;
  
  
S2 : '@'S2','S2')' {     printf("yes");
					

						if($2->con.value<$4->con.value){
							$$->con.value=$2->con.value;
						}
						else{
							$$->con.value=$4->con.value;
						}
					}
					
					
						
	 |args1 {  
	             int i=0,j=0;
			char p[1000];
			strcpy(p,$1);
			strcpy($1,"");
			i=4;
			while(p[i]!='\0'){
				$1[j]=p[i];
				i=i+1;j=j+1;
				
			}
			$1[j]='\0';
			
			float fnum;
			int inum;
			
			struct k temp;
			temp.num1=-2147483647;
			temp.num2=-2147483647; 
			temp.fp2 = 0;
			
			int dot=0,l,count;
			i=0;j=0;
			l=strlen($1);
			while(i<l){
				dot=0;j=0;count=0;
				char op[1000];
				while(1)
				{
					if($1[i]!=',')
					{
					    if(dot==1)count++;
						if($1[i]=='.')
						{
							dot=1;
						}
						op[j]=$1[i];
						j++;i++;
					}
					if($1[i]==','||$1[i]==')'){

						op[j]='\0';i++;
						if(dot==0){
						 if(temp.num1<atoi(op)){

						  temp.num1=atoi(op);
						  }
						}
						else {
						  if(temp.num2<atof(op))
						   temp.num2=atof(op);
						   temp.fp2=count;
						}
						break;
					}	
				}
				
			}
			  if(temp.num1>temp.num2)
              {
		          $$->type=typeCon;	
				  $$->con.value=temp.num1;
			  }
			 
			  //if($$.flag==1)printf("**%d",$$.Number);
			  //else if($$.flag==0)printf("**%.*f\n",$$.float_point,$$.Float_number);
	}
	  
  ;  



 

%%
#define SIZEOF_NODETYPE ((char *)&p->con - (char *)p)
nodeType *con(int value) {
 nodeType *p;
 size_t nodeSize;
 /* allocate node */
 nodeSize = SIZEOF_NODETYPE + sizeof(conNodeType);
 if ((p = malloc(nodeSize)) == NULL)
 yyerror("out of memory");
 /* copy information */
 p->type = typeCon;
 p->con.value = value;
 return p;
}
nodeType *id(int i) {
 nodeType *p;
 size_t nodeSize;
 /* allocate node */
 nodeSize = SIZEOF_NODETYPE + sizeof(idNodeType); 
 if ((p = malloc(nodeSize)) == NULL)
 yyerror("out of memory");
 /* copy information */
 p->type = typeId;
 p->id.i = i;
 return p;
}
nodeType *opr(int oper, int nops, ...) {
 va_list ap;
 nodeType *p;
 size_t nodeSize;
 int i;
 /* allocate node */
 nodeSize = SIZEOF_NODETYPE + sizeof(oprNodeType) +
 (nops - 1) * sizeof(nodeType*);
 if ((p = malloc(nodeSize)) == NULL)
 yyerror("out of memory");
 /* copy information */
 p->type = typeOpr;
 p->opr.oper = oper;
 p->opr.nops = nops;
 va_start(ap, nops);
 for (i = 0; i < nops; i++)
 p->opr.op[i] = va_arg(ap, nodeType*);
 va_end(ap);
 return p;
}
int ex(nodeType *p) {
int factorial(int n)
{
  int c;
  int result = 1;
 
  for (c = 1; c <= n; c++)
    result = result * c;
 
  return result;
}
 if (!p) return 0;
 switch(p->type) {
 case typeCon: return p->con.value;
 case typeId: return sym[p->id.i];
 case typeOpr:
 switch(p->opr.oper) {
 case WHILE: while(ex(p->opr.op[0]))
 ex(p->opr.op[1]); return 0;
 case IF: if (ex(p->opr.op[0]))
 ex(p->opr.op[1]);
 else if (p->opr.nops > 2)
 ex(p->opr.op[2]);
 return 0;
 case PRINT: printf("%d\n", ex(p->opr.op[0]));
 return 0;
 case ';': ex(p->opr.op[0]);
 return ex(p->opr.op[1]);
 case '=': return sym[p->opr.op[0]->id.i] =
 ex(p->opr.op[1]);
 case UMINUS: return -ex(p->opr.op[0]);
 case '+': return ex(p->opr.op[0]) + ex(p->opr.op[1]);
 case '-': return ex(p->opr.op[0]) - ex(p->opr.op[1]);
 case '*': return ex(p->opr.op[0]) * ex(p->opr.op[1]);
 case '/': return ex(p->opr.op[0]) / ex(p->opr.op[1]);
 case '<': return ex(p->opr.op[0]) < ex(p->opr.op[1]);
 case '>': return ex(p->opr.op[0]) > ex(p->opr.op[1]);
 case GE: return ex(p->opr.op[0]) >= ex(p->opr.op[1]);
 case LE: return ex(p->opr.op[0]) <= ex(p->opr.op[1]);
 case NE: return ex(p->opr.op[0]) != ex(p->opr.op[1]);
 case EQ: return ex(p->opr.op[0]) == ex(p->opr.op[1]);
 case FACTORIAL: return factorial(ex(p->opr.op[0]));
 }
 }
 return 0;
} 
void freeNode(nodeType *p) {
 int i;
 if (!p) return;
 if (p->type == typeOpr) {
 for (i = 0; i < p->opr.nops; i++)
 freeNode(p->opr.op[i]);
 }
 free (p);
}
void yyerror(char *s) {
 fprintf(stdout, "%s\n", s);
}
int main(void) {
 yyparse();
 return 0;
} 
