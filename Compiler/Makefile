all:
	flex lex.l
	bison -d lex.y -Wcounterexamples
	gcc *.c -o lex