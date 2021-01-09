%{
#include <stdio.h>
#include <string.h>
void yyerror(const char *message);

typedef enum {cal, fin} choose;
struct data{
  choose opt;
  int val;
  char op;
  struct data *ptr1, *ptr2;
};

void print(struct data*);

%}
%union {
  int ival;
  struct data *buffer;
}
%token ADD SUB MUL DIV CR LB RB
%token <ival> INUMBER
%type <buffer> expr
%left ADD SUB
%left MUL DIV
%%
line    : expr{
            printf("the preorder expression is :");
            print( $1 );
            printf("\nthe result is : %d\n", count( $1 ));
          }
        ;
expr    : LB expr RB{ $$ = $2; }
        | expr MUL expr{ 
            struct data *buf = malloc( sizeof( struct data ) );
            buf->op   = '*';
            buf->opt  = cal;
            buf->ptr1 = $1;
            buf->ptr2 = $3;
            $$ = buf;
            //$$ = $1 + $3; 
          }
        | expr DIV expr{
            struct data *buf = malloc( sizeof( struct data ) );
            buf->op   = '/';
            buf->opt  = cal;
            buf->ptr1 = $1;
            buf->ptr2 = $3;
            $$ = buf;
          }
        | expr ADD expr{ 
            struct data *buf = malloc( sizeof( struct data ) );
            buf->op   = '+';
            buf->opt  = cal;
            buf->ptr1 = $1;
            buf->ptr2 = $3;
            $$ = buf;
          }
        | expr SUB expr{
            struct data *buf = malloc( sizeof( struct data ) );
            buf->op   = '-';
            buf->opt  = cal;
            buf->ptr1 = $1;
            buf->ptr2 = $3;
            $$ = buf;
          }
        | INUMBER{
            struct data* buf = malloc( sizeof( struct data ) );
            buf->val = $1;
            buf->opt = fin;
            $$ = buf;
          }
        ;

%%
struct data* endue(char op){
  struct data* buf = malloc( sizeof( struct data ) );
  


  return buf;
}
void yyerror (const char *message){
  fprintf (stderr, "%s\n",message);
}

int count(struct data* d ){
  if( d->opt==fin )
    return d->val;
  switch(d->op){
    case '+': return count(d->ptr1) + count(d->ptr2);
    case '-': return count(d->ptr1) - count(d->ptr2);
    case '*': return count(d->ptr1) * count(d->ptr2);
    case '/': return count(d->ptr1) / count(d->ptr2);
  }
}

void print(struct data* d){
  
  if( d->opt==fin ){
    printf(" %d", d->val);
  }else{
    printf(" %c", d->op);
    print( d->ptr1 );
    print( d->ptr2 );
  }

}

int main(int argc, char *argv[]) {
  yyparse();
  return(0);
}
