
%{
int yyerror(const char *s);
int yylex(void);
%}

%define parse.error verbose

%token TOK_IDENT 
%token TOK_PRINT
%token TOK_FLOAT
%token TOK_INT
%token TOK_TRUE
%token TOK_FALSE
%token TOK_FOR
%token TOK_IF
%token TOK_ELSE
%token TOK_AND
%token TOK_OR
%token TOK_EQUALS
%token TOK_Minor_LEFTEqual
%token TOK_Big_LEFTEqual
%token TOK_BIG_RIGHT
%token TOK_BIG_LEFT

%start program

%%

program : globals ;

globals : globals global {}
        | global {}

global : TOK_IDENT '=' expr ';' {}
       | TOK_PRINT TOK_IDENT ';' {}
       | repetition {}
       | decision {}

decision: TOK_IF '(' comparison')' '{' globals '}' {}
        | TOK_IF '(' comparison ')' '{' globals '}' TOK_ELSE '{' globals '}' {}

repetition:  TOK_FOR'(' TOK_IDENT ';' comparison ';' TOK_IDENT '=' expr')''{' globals '}' {}

comparison  : expr verification expr {}

verification : TOK_EQUALS {}
             | TOK_OR {}
             | TOK_AND {}
             | TOK_Big_LEFTEqual {}
             | TOK_Minor_LEFTEqual {}
             | TOK_BIG_LEFT {}
             | TOK_BIG_RIGHT {}
         
expr : expr '+' term {}
     | expr '-' term {}
     | term {}

term : term '*' factor {}
     | term '/' factor {}
     | factor {}
     | '(' expr ')' {}

factor : TOK_IDENT {}
       | TOK_INT {}
       | TOK_FLOAT {}
       | bool {}
       | unary {}

bool : TOK_TRUE {}
     | TOK_FALSE {}

unary : '-' factor{}

%%