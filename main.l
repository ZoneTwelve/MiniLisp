%{
#include "main.tab.h"
%}
%%
\n    { 
  return(0);
}
[ \t]+    { /* do nothing */ }

[0-9]+    { 
  yylval.ival = atoi(yytext); 
  return(INUMBER); 
}

"+"     return ADD;
"-"     return SUB;
"*"     return MUL;
"/"     return DIV;
"\n"    return CR;
"("     return LB;
")"     return RB;

"+"|"-"|"("|")"    { /* keep that here */
  return(yytext[0]); 
}
.    { return(yytext[0]); }
%%


