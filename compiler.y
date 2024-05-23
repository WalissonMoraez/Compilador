
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
globals : global {}

global : TOK_IDENT '=' expr ';' {}
global : TOK_IDENT '=' bool ';' {}
global : TOK_PRINT TOK_IDENT ';' {}
global : repetition {}
global : decision {}

decision: TOK_IF '(' comparison ')' '{' globals '}' {}
decision: TOK_IF '(' comparison ')' '{' globals '}' TOK_ELSE '{' globals '}' {}

repetition:  TOK_FOR'(' TOK_IDENT ';' comparison ';' TOK_IDENT '=' expr')''{' globals '}' {}

comparison  : expr verification expr {}
comparison  : TOK_IDENT TOK_EQUALS bool {}

verification : TOK_EQUALS {}
verification : TOK_OR {}
verification : TOK_AND {}
verification : TOK_Big_LEFTEqual {}
verification : TOK_Minor_LEFTEqual {}
verification : TOK_BIG_LEFT {}
verification : TOK_BIG_RIGHT {}
         
bool: TOK_TRUE {}
bool: TOK_FALSE {}

expr : expr '+' term {}
expr : expr '-' term {}
expr : term {}

term : term '*' factor{}
term : term '/' factor {}
term : factor{}
term : '(' expr ')'{}

factor : TOK_IDENT{}
factor : TOK_INT{}
factor : TOK_FLOAT{}
factor : unary{}

unary : '-' factor{}

%%