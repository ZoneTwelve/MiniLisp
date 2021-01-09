%{
#include "main.tab.h"
%}
%%

\n    { return(0); }
\t    { /* do nothing */ }


"+"     return ADD;
"-"     return SUB;
"*"     return MUL;
"/"     return DIV;
"("     return LB;
")"     return RB;

.    { return(yytext[0]); }
%%


