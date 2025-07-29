%{
#include "y.tab.h"  // Token definitions from Yacc
#include <stdio.h>
#include <stdlib.h>
%}

%%

// Whitespace (ignored)
[ \t]+              ;  

// Newline
\n                  return '\n';  

// Integer numbers
[0-9]+              { yylval = atoi(yytext); return NUMBER; }

// Identifiers
[a-zA-Z_][a-zA-Z0-9_]* return ID;

// Operators and Symbols
"="                 return ASSIGN;
"+"                 return PLUS;
"-"                 return MINUS;
"*"                 return MUL;
"/"                 return DIV;
"("                 return LPAREN;
")"                 return RPAREN;
";"                 return SEMICOLON;

// Catch-all for any unknown characters
.                   return yytext[0];

%%

// Required for Lex
int yywrap() {
    return 1;
}
