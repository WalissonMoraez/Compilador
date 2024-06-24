
%{
#include "nodes.h"

int yyerror(const char *s);
int yylex(void);

int error_count=0;
extern bool force_print_tree;
%}

%define parse.error verbose

//o %union vira o yylval para conseguir conversar com o .y e .l 
%union {
    char *str;
    int itg;
    double flt;
    Node *node;
}

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

%type<str> TOK_IDENT
%type<itg> TOK_INT
%type<flt> TOK_FLOAT
%type<node> globals global decision else repetition comparison_1 comparison_2 comparison_3 verification expr term factor bool unary

%start program

%%

program : globals {
    Node *program = new Program();
    program-> append($globals);

    // aqui vai a analise semantica

    CheckVarDecl cvd;
    cvd.check(program);

    if(error_count>0) //caso ter erros nao printa a arvore
        cout << error_count << " error(s) found." << endl;
    if (error_count == 0 || force_print_tree) 
        printf_tree(program);
} ;

globals : globals[gg] global {
               $gg->append($global);
               $$ = $gg;
          }
        | global {
               Node *n = new Node();
               n->append($global);
               $$ = n;
          }

global : TOK_IDENT '=' expr ';' { $$ = new Variable($TOK_IDENT, $expr); }
       | TOK_PRINT TOK_IDENT ';' {
          Ident *id = new Ident($TOK_IDENT);
          $$ = new Print(id);
       }
       | repetition {}
       | decision {}
       | error ';' { $$ = new Node(); }

decision  : TOK_IF '('comparison_1')' '{' globals '}' {}
          | TOK_IF '('comparison_1')' '{' globals '}' else {}
          
else : TOK_ELSE '{' globals '}' {}
     | TOK_ELSE decision{}

repetition:  TOK_FOR'(' comparison_1 ';' TOK_IDENT '=' expr')''{' globals '}' {}

comparison_1 : comparison_1 TOK_OR comparison_2 {}
		   | comparison_2 {}						
		  
comparison_2 : comparison_2 TOK_AND comparison_3 {}
		   | comparison_3 {}				

comparison_3  : expr verification expr {}
              | '(' comparison_1 ')' {}

verification : TOK_EQUALS {}
             | TOK_OR {}
             | TOK_AND {}
             | TOK_Big_LEFTEqual {}
             | TOK_Minor_LEFTEqual {}
             | TOK_BIG_LEFT {}
             | TOK_BIG_RIGHT {}
         
expr : expr[ee] '+' term { $$ = new BinaryOp($ee, $term, '+'); }
     | expr[ee] '-' term { $$ = new BinaryOp($ee, $term, '-'); }
     | term { $$ = $term; }

term : term[tt] '*' factor { $$ = new BinaryOp($tt, $factor, '*'); }
     | term[tt] '/' factor { $$ = new BinaryOp($tt, $factor, '/'); }
     | factor { $$ = $factor; }
     | '(' expr ')' { $$ = $expr; }

factor : TOK_IDENT {$$ = new Ident($TOK_IDENT); }
       | TOK_INT { $$ = new Integer($TOK_INT); }
       | TOK_FLOAT { $$ = new Float($TOK_FLOAT); }
       | bool {}
       | unary { $$ = $unary; }

bool : TOK_TRUE {}
     | TOK_FALSE {}

unary : '-' factor{
     $$ = new Unary($factor, '-');
}

%%