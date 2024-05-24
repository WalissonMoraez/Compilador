all:
	flex compiler.l
	bison -d compiler.y -Wcounterexamples
	gcc *.c -o compiler