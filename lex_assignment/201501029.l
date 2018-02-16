%{
#include<stdio.h>
#include<string.h>
#include<math.h>
%}



%%
[\n]+ {fprintf(yyout,"\n");}
((\/)(\/).*"\n") {}
\/\*([^*"]*|".*"|\*+[^/])*\*\/ {}
([pP][rR][Ii][Nn][Tt][Ff][(].*((\/)(\/)).*) {ECHO;}
([pP][rR][Ii][Nn][Tt][Ff][(].*((\/)(\*)).*((\*)(\/))) {ECHO;}

%%

int main()
{
   yyin=fopen("p.c","r");
   yyout=fopen("out_file.c","w");
   yylex();
   fclose(yyin);
   fclose(yyout);
   system("indent -kr out_file.c -o out_file.c");
   return 0;
}
int yywrap(){
	return 1;
}
