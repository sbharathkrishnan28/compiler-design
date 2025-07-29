%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX 100
char *symbolTable[MAX];
int symbolCount = 0;

// Add identifier to symbol table if not already present
void addToSymbolTable(const char *name) {
    for (int i = 0; i < symbolCount; i++) {
        if (strcmp(symbolTable[i], name) == 0)
            return;
    }
    symbolTable[symbolCount++] = strdup(name);
}
%}

%option noyywrap

%%

// Identifiers
[a-zA-Z_][a-zA-Z0-9_]* {
    printf("Identifier: %s\n", yytext);
    addToSymbolTable(yytext);
}

// Floating-point and integer numbers
[0-9]+\.[0-9]+ {
    printf("Float Number: %s\n", yytext);
}

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

// Character constants
'\''[a-zA-Z0-9]'\'' {
    printf("Character Constant: %s\n", yytext);
}

// Whitespace
[ \t\n]+ {
    /* skip whitespace */
}

// Any other character
. {
    printf("Other: %s\n", yytext);
}
%%

// Main function
int main() {
    printf("Starting lexical analysis...\n\n");
    yylex();

    printf("\n--- Symbol Table ---\n");
    for (int i = 0; i < symbolCount; i++) {
        printf("%s\n", symbolTable[i]);
    }
    return 0;
}
