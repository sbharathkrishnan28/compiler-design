%{
#include <stdio.h>
#include <stdlib.h>

// Function declarations
void yyerror(const char *s);
int yylex(void);
%}

/* Token Definitions */
%token ID NUMBER
%token PLUS MINUS MUL DIV ASSIGN SEMICOLON
%token LPAREN RPAREN

/* Operator Precedence */
%left PLUS MINUS
%left MUL DIV

%%

/* Grammar Rules Section */

program:
      /* empty */
    | program statement
    ;

statement:
      declaration
    | assignment SEMICOLON
    ;

declaration:
      ID SEMICOLON
    ;

assignment:
      ID ASSIGN expr
    ;

expr:
      expr PLUS expr
    | expr MINUS expr
    | expr MUL expr
    | expr DIV expr
    | NUMBER
    | ID
    | LPAREN expr RPAREN
    ;

%%

/* Error Handler */
void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error: %s\n", s);
}

/* Entry Point */
int main(void) {
    printf("Enter statements (end with Ctrl+D):\n");
    return yyparse();
}
