%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
extern int yylex();
void yyerror (char *s);
int i=0,j=0,flag=0;
%}

%union {char string[100];
		int num;
		int b;}
%start sym
%token <string> s_op
%token <num> n_op
%token exit_command
%type <string> S S1 S2 Str sym S_r
%type <num> S3 Num N_r
%type <b> S4
%left '=' '!'
%left '#'
%left '@'
%left '~'
%left '&'
%left '%'
%left '*'
%right '^'
%right '?'

%%
sym : S ';' {printf("%s\n",$1);}
	|sym S ';' {printf("%s\n",$2);}
	;
//S4 {sprintf($$,"%d",$1);}	
	
S : S1  {strcpy($$,$1);}
	|S2 {strcpy($$,$1);}
	|S3 {if($1==1){strcpy($$,"True");}else{strcpy($$,"FALSE");}}
	|S4 {if($1==1){strcpy($$,"True");}else{strcpy($$,"FALSE");}}
	|Str {strcpy($$,$1);}
	|Num {sprintf($$,"%d",$1);}
	|'('Str')' {strcpy($$,$2);}
	| exit_command	{ exit(EXIT_SUCCESS); }
	;
	
Str : '('S_r')' {strcpy($$,$2);}
		|S_r{strcpy($$,$1);}
		;
		
S1 : S_r'*'S_r {strcat($1,$3);strcpy($$,$1);} 
	|'('S1')'    {strcpy($$,$2);}
	;
	
S_r : S1 {strcpy($$,$1);}
	 |s_op{strcpy($$,$1);}
	 |S2{strcpy($$,$1);}
	 ;
	 
Num : '('N_r')' {$$=$2;}
		|N_r {$$=$1;}
		;
		
N_r : '('n_op')' {$$=$2;}
	|n_op {$$=$1;}
	|S3 {$$=$1;} 	 
	|S4 {$$=$1;}
	;
	
S2 : S_r'^'N_r {strcpy($$,"");
				  if($3!=0){
				  	for(i=0;i<$3;i++){
				  	  strcat($$,$1);
				  	}
				  }}
	|'('S2')' {strcpy($$,$2);}
				  
	|S_r'%'N_r {if($3==0){strcpy($$,"Empty");}
				  else{for(i=0;i<$3;i++){$$[i]=$1[i];}$$[i]='\0';}}
				  
	|S_r'&'N_r {if($3==0){strcpy($$,"Empty");}
				  else{j=0;
				  	for(i=strlen($1)-$3;i<=strlen($1)-1;i++){
				  		$$[j]=$1[i];
				  		j++;
				  	}
				  	$$[j]='\0';}
				 }
	;
	
	
S3 : '('N_r')' {$$=$2;}
	|'?'S_r {$$=strlen($2);}
	;
	
	
S4 : '('S4')' {$$=$2;}
	|S_r'~'S_r {if(strncmp($1, $3, strlen($1))==0){$$=1;}
				  else{$$=0;}}
			
	|S_r'@'S_r {	for(i=strlen($3)-strlen($1);i<=strlen($3)-1;i--){
						if($3[i]==$1[j]){j++;}
						else{flag=1;break;}
				  	}
				  	if(flag==0){$$=1;}
				  	else{$$=0;}
				  }
				     
	|S_r'#'S_r {for(i=0;i<strlen($3)||j==strlen($1);i++){
					if($3[i]==$1[j]){j++;}
					else{j=0;}
				  }
				  if(j==strlen($1)){$$=1;}
				  else{$$=0;}}
				  
	|S_r'='S_r {if(strcmp($1,$3)==0){$$=1;}
				  else{$$=0;}}
				  
	|S_r'!'S_r {if(strcmp($1,$3)!=0){$$=1;}
				  else{$$=0;}}//
	;
	
	


%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}
int main(void) {
    yyparse();
    return 0;
}
		
// #,<>,nested(),
