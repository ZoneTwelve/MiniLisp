%{
#include <stdio.h>
#include <string.h>
void yyerror(const char*);

%}
%union {
  int Int;
  struct data *buffer;
}
%token ADD SUB MUL DIV CR LB RB
%token <Int> NUMBER
%%
program : expr { }
        ;
expr    : LB expr RB{ }
        | NUMBER{
          }
        ;

%%

int main(int argc, char *argv[]) {
  yyparse();
  return(0);
}

void yyerror (const char *message){
  fprintf (stderr, "%s\n",message);
}

