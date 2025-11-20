/* Definition Section */
%{
#include <stdio.h>

int yylex(void);
int yyerror(const char *s);
extern FILE *yyin;
%}

%union {
    int num;
    float real;
    char* text;
}

/* Token */
%token EOL
%token <num> NUMBER
%token <text> CHARACTER
%token <real> FRACTION
%token PLUS
%type <num> exp
%type <real> exp2
%token MINUS
%token MULTIPLY
%left PLUS MINUS
%left MULTIPLY
%left DIVISION
%token LEFTPAREN
%token RIGHTPAREN
%type <num> fact
%type <real> fact2

%%

input:
     
    |input line
;

line:
    exp EOL {printf("%d \n",$1);}
|   exp {printf("%d \n",$1);}
|   exp2 {printf("%f \n",$1);}
|   EOL {}
;

exp:
    exp PLUS exp { $$ = $1 + $3; }
|   exp MINUS exp { $$ = $1 - $3; }
|   exp MULTIPLY exp { $$ = $1 * $3; }
|   exp DIVISION exp { $$ = $1 / $3; }
|   fact
;
exp2:
    exp2 PLUS exp2 { $$ = $1 + $3; }
|   exp2 MINUS exp2 { $$ = $1 - $3; }
|   exp2 MULTIPLY exp2 { $$ = $1 * $3; }
|   exp2 DIVISION exp2 { $$ = $1 / $3; }
|   exp PLUS exp2 { $$ = $1 + $3; }
|   exp MINUS exp2 { $$ = $1 - $3; }
|   exp MULTIPLY exp2 { $$ = $1 * $3; }
|   exp DIVISION exp2 { $$ = $1 / $3; }
|   exp2 PLUS exp  { $$ = $1 + $3; }
|   exp2 MINUS exp { $$ = $1 - $3; }
|   exp2 MULTIPLY exp { $$ = $1 * $3; }
|   exp2 DIVISION exp { $$ = $1 / $3; }
|   fact2;

fact:
    NUMBER { $$ = $1; }
|   LEFTPAREN exp RIGHTPAREN {$$ = $2;} 

fact2:
    FRACTION { $$ = $1; }
|   LEFTPAREN exp2 RIGHTPAREN {$$ = $2;}

%%
/* User Section */
int main(void) {
    yyin = fopen("input.txt", "r");
    int res=yyparse();
    fclose(yyin);
    return res;
}

int yyerror(const char *s) {
    printf("ERROR: %s \n", s);
    return 0;
}