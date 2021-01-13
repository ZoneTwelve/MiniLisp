%{
#include <stdio.h>
#include <string.h>
void yyerror(const char*);
char *_BOOL[2] = { "#f", "#t" };

int stack[0xffff];
int length = 0;

int tryCatch = 0;
%}
%union {
  int Int;
  int Bool;
}
%token ADD SUB MUL DIV CR LB RB
%token AND OR NOT MOD
%token GREA LESS EQUAL
%token print_num print_bool
%token <Int>IF
%token <Int> NUMBER
%token <Int>BOOLEAN
%type <Int>math <Int>math_bool
%type <Int>math_add <Int>proc_add    <Int>math_sub
%type <Int>math_mul <Int>proc_mul    <Int>math_div
%type <Int>math_and <Int>math_or <Int>math_not <Int>math_mod
%type <Int>proc_and <Int>proc_or
%type <Int>math_equal <Int>do_equal
%type <Int>GreaThen <Int>LessThen
%type <Int>print
%type <Int>if_bool <Int>if_numb
%type <Int>bool_ret <Int>math_ret
%%

program       : expr
              | program expr
              ;

expr          : print
              | bool_ret
              | math_ret
              ;

math_ret      : math_add
              | math_sub
              | math_mul
              | math_div
              | math_mod
              | NUMBER
              | if_numb
              ;

math          : math_ret
              | bool_ret {
                  if(tryCatch++==0)
                    printf("Type Error: Expect ‘number’ but got ‘boolean’.\n");
                }
              ;

bool_ret      : math_and
              | math_or
              | math_not
              | GreaThen
              | LessThen
              | math_equal
              | BOOLEAN
              | if_bool
              ;
math_bool     : bool_ret
              | math_ret{
                  if(tryCatch++==0)
                    printf("Type Error: Expect ‘boolean’ but got ‘number’.\n");
                }
              ;

math_add      : LB ADD proc_add RB {
                 $$ = $3;
                }
              ;

proc_add      : proc_add math { $$ = $1 + $2; }
              | math math { $$ = $1 + $2; }
              ;

math_sub      : LB SUB math math RB { 
                  $$ = $3 - $4;
                }
              ;
math_mul      : LB MUL proc_mul RB {
                  $$ = $3;
                }
              ;
proc_mul      : proc_mul math {
                  $$ = $1 * $2;
                }
              | math math {
                  $$ = $1 * $2;
                }
              ;
math_div      : LB DIV math math RB {
                  // TODO: try and catch division by zero
                  $$ = $3 / $4;
                }
              ;
math_mod      : LB MOD math math RB {
                  $$ = $3 % $4;
                }
              ;
GreaThen      : LB GREA math math RB {
                  $$ = ( $3 > $4 ) ? 1 : 0; 
                }
LessThen      : LB LESS math math RB {
                  $$ = ( $3 < $4 ) ? 1 : 0;
                }
              ;

math_and      : LB AND proc_and RB {
                  $$ = $3;
                }
              ;
proc_and      : proc_and math_bool  { $$ = $1 & $2; }
              | math_bool math_bool { $$ = $1 & $2; }
              ;

math_or       : LB OR proc_or RB {
                  $$ = $3;
                }
              ;
proc_or       : proc_or math_bool   { $$ = ($1 | $2) & 1; }
              | math_bool math_bool { $$ = ($1 | $2) & 1; }
              ;

math_equal    : LB do_equal RB { $$ = stack[--length]; } ;
do_equal      : EQUAL math math {
                  stack[length++] = $2==$3;
                  $$ = $3;
                }
              | do_equal math {
                  stack[length-1] = $1==$2 & stack[length-1] ;
                }
              | math
              ;

math_not      : LB NOT math_bool RB {
                  $$ = !$3;
                }
              ;

if_bool       : LB IF math_bool bool_ret math_bool RB {
                  $$ = $3==1 ? $4 : $5;
                }
              ;

if_numb       : LB IF math_bool math_ret math RB {
                  $$ = $3==1 ? $4 : $5;
                }
              ;

print         : LB print_num math RB {
                  if(!tryCatch)
                    printf("%d\n", $3);
                }
              | LB print_bool math_bool RB {
                  if(!tryCatch)
                    printf("%s\n", _BOOL[$3]);
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

