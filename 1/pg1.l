%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SYMBOLS 100

// Symbol table
char *symbolTable[MAX_SYMBOLS];
int symbolCount = 0;

// Function to add to symbol table
void addToSymbolTable(const char *name) {
    for (int i = 0; i < symbolCount; i++) {
        if (strcmp(symbolTable[i], name) == 0)
            return;  // Already exists
    }
    symbolTable[symbolCount++] = strdup(name);
}
%}

%option noyywrap

%%
    // Identifier: starts with letter or _, followed by alphanumeric or _
[a-zA-Z_][a-zA-Z0-9_]* {
    printf("Identifier: %s\n", yytext);
    addToSymbolTable(yytext);
}

    // Numeric constants
[0-9]+ {
    printf("Number: %s\n", yytext);
}

    // Operators
[\+\-\*/=<>!&|]+ {
    printf("Operator: %s\n", yytext);
}

    // Single-line comment
\/\/[^\n]* {
    printf("Single-line Comment\n");
}

    // Multi-line comment
\/\*([^*]|\*+[^*/])*\*+\/ {
    printf("Multi-line Comment\n");
}

    // Whitespace (ignored)
[ \t\n]+    { /* Skip whitespace */ }

    // Any other single character
. {
    printf("Other: %s\n", yytext);
}
%%

// Main function
int main() {
    printf("Start Lexical Analysis:\n\n");
    yylex();

    printf("\n--- Symbol Table ---\n");
    for (int i = 0; i < symbolCount; i++) {
        printf("%s\n", symbolTable[i]);
    }

    return 0;
}
