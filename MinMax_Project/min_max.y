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
		int fp2,fp4;
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
	struct datatype type;
}
%start S
%token <obj> min_object_dd
%token <obj> min_object_df
%token <obj> min_object_fd
%token <obj> min_object_ff
%token <integer> num
%token <flt> f
%type <type> S S1
%%
S : S1 {if($1.flag==1){
			printf("%d\n",$1.Number);
		}
		else{
			printf("%.*f\n",$1.float_point,$1.Float_number);
		}
	   }

	   
S1 : '!'S1','S1')' {
					if($2.flag==1 && $4.flag==1){
						$$.flag=1;
						if($2.Number<$4.Number){
							$$.Number=$2.Number;
						}
						else{
							$$.Number=$4.Number;
						}
					}
					else if($2.flag==0 && $4.flag==0){
						$$.flag=0;
						if($2.Float_number<$4.Float_number){
							$$.Float_number=$2.Float_number;
							$$.float_point=$2.float_point;
						}
						else{
							$$.Float_number=$4.Float_number;
							$$.float_point=$4.float_point;
						}
					}
					else if($2.flag==1 && $4.flag==0){
						if($2.Number<$4.Float_number){
							$$.Number=$2.Number;
							$$.flag=1;
						}
						else{
							$$.Float_number=$4.Float_number;
							$$.flag=0;
							$$.float_point=$4.float_point;
						}
					}
					else if($2.flag==0 && $4.flag==1){
						if($4.Number<$2.Float_number){
							$$.Number=$4.Number;
							$$.flag=1;
						}
						else{
							$$.Float_number=$2.Float_number;
							$$.flag=0;
							$$.float_point=$2.float_point;
						}
					}
				  }
  | min_object_dd {int min;if($1.num1<$1.num3){min=$1.num1;}else{min=$1.num3;}$$.Number=min;$$.flag=1;}
  | min_object_df {if($1.num1<$1.num2){$$.flag=1;$$.Number=$1.num1;}else{$$.flag=0;$$.Float_number=$1.num2;$$.float_point=$1.fp2;}}
  | min_object_fd {if($1.num2<$1.num1){$$.flag=0;$$.Float_number=$1.num2;$$.float_point=$1.fp2;}else{$$.flag=1;$$.Number=$1.num1;}}
  | min_object_ff {if($1.num2<$1.num4){$$.flag=0;$$.Float_number=$1.num2;$$.float_point=$1.fp2;}else{$$.flag=0;$$.Float_number=$1.num4;$$.float_point=$1.fp4;}}
  | num {$$.Number=$1;$$.flag=1;}
  | f {$$.Float_number=$1.num2;$$.flag=0;$$.float_point=$1.fp2;}
  ;

%%
void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}
