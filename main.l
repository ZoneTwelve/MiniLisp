%{
#include "main.tab.h"
%}
%%

\n    {  }
\t    { /* do nothing */ }
\r    {}
" "   {}
"-"?[0-9]+  { yylval.Int = atoi(yytext);return(NUMBER); }
"#t"        { yylval.Int= 1; return BOOLEAN; }
"#f"        { yylval.Int= 0; return BOOLEAN; }

"define"|"fun"
"if"        { return IF; }

"print-num"  { return print_num; }
"print-bool" { return print_bool; }

"+"     return ADD;
"-"     return SUB;
"*"     return MUL;
"/"     return DIV;
"("     return LB;
")"     return RB;
"mod"   return MOD;

"and"   return AND;
"or"    return OR;
"not"   return NOT;

">"     return GREA;
"<"     return LESS;
"="     return EQUAL;
.    {}
%%


