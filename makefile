#parser: lex.yy.o y.tab.c y.tab.h parser.c hash.h hash.c var.h command.h command.c node.h
#	gcc -o parser lex.yy.c y.tab.c parser.c hash.c command.c -ll
    
#lex.yy.o: lex.yy.c y.tab.h
#	gcc -c lex.yy.c

#y.tab.o: y.tab.c y.tab.h
#	gcc -c y.tab.c

#lex.yy.c: mylex.lex
#	flex mylex.lex

#y.tab.h: myyacc.y
#	yacc -d myyacc.y

#y.tab.c: myyacc.y
#	yacc -d myyacc.y

parser: lex.yy.c y.tab.c y.tab.h parser.c hash.h hash.c var.h command.h command.c
	gcc -o parser lex.yy.c y.tab.c parser.c hash.c command.c -ll

lex:
	lex mylex.lex

yacc:
	yacc -d myyacc.y
