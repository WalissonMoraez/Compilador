# Compilador

Projeto desenvolvido para a disciplina de Compiladores no 7º período do curso de Ciência da Computação, semestre 24.1, na Universidade Federal de Jataí (UFJ).

## Descrição

Este projeto consiste na implementação de um compilador para uma nova linguagem de programação, criado como parte das atividades da disciplina de Compiladores. O objetivo é aplicar os conceitos aprendidos em sala de aula, como análise léxica, análise sintática, análise semântica e geração de código.

## Estrutura do Projeto

A estrutura do projeto é a seguinte:

- **Compiler/**: Diretório contendo o código-fonte do compilador.
- **README.md**: Arquivo com informações sobre o projeto.

## Tecnologias Utilizadas

As principais linguagens e ferramentas utilizadas no desenvolvimento deste compilador são:

- **C**: Linguagem principal utilizada no desenvolvimento.
- **C++**: Utilizada em partes específicas do projeto.
- **Yacc**: Ferramenta para geração de analisadores sintáticos.
- **Lex**: Ferramenta para geração de analisadores léxicos.

## Como Executar

Para compilar e executar o projeto, siga os seguintes passos:

1. Clone o repositório:

   ```bash
   git clone https://github.com/WalissonMoraez/Compilador.git
   ```

2. Navegue até o diretório do projeto:

   ```bash
   cd Compilador/Compiler
   ```

3. Compile o código:

   ```bash
   make
   ```

4. Execute o compilador:

   ```bash
   ./compilador [arquivo_fonte]
   ```

   Substitua `[arquivo_fonte]` pelo caminho do arquivo da nova linguagem a ser compilado.
