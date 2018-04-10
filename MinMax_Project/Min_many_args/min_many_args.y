%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<float.h>
extern int yylex();
void yyerror (char *s);
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
%union{
	char *string;
	struct s obj;
	struct s flt;
	int integer;
	char *str;
	struct datatype type;
}
%start S
%token <obj> min_object_dd
%token <obj> min_object_df
%token <obj> min_object_fd
%token <obj> min_object_ff
%token <integer> num
%token <str> args
%token <flt> f
%type <type> S S1
%%
S : S1 {printf("^^\n");if($1.flag==1){
			printf("##%d\n",$1.Number);
		}
		else{
			printf("##%.*f\n",$1.float_point,$1.Float_number);
		}
	   }

	   ;
S1 :S2 {printf("**\n");}		
	 |args {
			
			float fnum;
			int inum;
			
			struct k temp;
			temp.num1=2147483647;
			temp.num2=2147483647; 
			temp.fp2 = 0;
			
			int i=0,j=0,dot=0,l,count;
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
		          $$.flag=1;	
				  $$.Number=temp.num1;
			  }
			  else
			  {
				  $$.flag=0;
				  $$.Float_number=temp.num2;
				  $$.float_point=temp.fp2;
			  }
			  if($$.flag==1)printf("**%d",$$.Number);
			  else if($$.flag==0)printf("**%.*f\n",$$.float_point,$$.Float_number);
	}
	  
  ;
  
 S2 :  {printf("::");} 

%%
void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}
