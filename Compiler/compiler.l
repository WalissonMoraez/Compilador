%{
#include <stdio.h>
#include "compiler.tab.h"

int yyerror(const char *s);

%}

%option yylineno

%%

[ \t\r\n] {/* ignora */}

"//".*\n { /* ignora */ }

"TRUE"  { return TOK_TRUE; }
"FALSE"  { return TOK_FALSE; }

"print" { return TOK_PRINT; }
"if" { return TOK_IF; }
"else" { return TOK_ELSE; }
"for" { return TOK_FOR; }

"||"  { return TOK_OR; }
"&&"  { return TOK_AND; }
"=="  { return TOK_EQUALS; }
"<="  { return TOK_Minor_LEFTEqual; }
">="  { return TOK_Big_LEFTEqual; }
">" { return TOK_BIG_LEFT; }
"<" { return TOK_BIG_RIGHT; }

"+"   { return '+'; }
"-"   { return '-'; }
"*"   { return '*'; }
"/"   { return '/'; }
"{"   { return '{'; }
"}"   { return '}'; }
"("   { return '('; }
")"   { return ')'; }
";"   { return ';'; }
"="   { return '='; }

[a-zA-Z_][a-zA-Z0-9_]* { 
  return TOK_IDENT;
}

[0-9]+\.[0-9]* { 
  return TOK_FLOAT;
}

[0-9]+ { 
  return TOK_INT;
}

. {
     printf("Símbolo não reconhecido %c\n", yytext[0]); 
  }




%%

int yywrap() {
  return 1;
}

int yyerror(const char *s){
  printf("Error de sintaxe na linha %d: %s\n", yylineno, s);
  return 1;
}

int main(int argc, char *argv[]){
    
    if(argc <= 1){
      printf("Sintaxe: %s nome_do_programa\n", argv[0]);
      return 1;
    }

    yyin = fopen(argv[1], "r");
    if(yyin == NULL){
      printf("Não foi possível abrir o arquivo %s.\n", argv[1]);
      return 1;
    }

    yyparse();

    if(yyin){
      fclose(yyin);
    }
    
    return 0;

}