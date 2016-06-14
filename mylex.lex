%{
	#include <stdio.h>
	#include <string.h>
	
	#include "node.h"
	#include "hash.h"
	#include "y.tab.h"

	/*
	lex will return tokens(6 types):
	    keywords: int, char, return, if, else, while, break, print, read
	    arithmetic op: =, !, +, -, *, /
	    comparision op: ==, !=, <, >, <=, >=, &&, ||
	    special symbols: [, ], (, ), {, }, ;, , 
	    id: beginning by "id"Uppercase_string
	    number: 0~9 string
	        
	    just id and number these two token need a value, so need a type
	    id is a string, and number is a int.(yacc can define by union)
	*/

	void lex_failed(char *s);
	void comment();
	void count();
	int checkType();
%}

%%

\n              { 	//printf("\n"); 
				}

 /* Keyword */
int             { 	//printf("INT "); 
					count();			
					return INT; }
char            { 	//printf("CHAR "); 			
					count();
					return CHAR; }
return          { 	//printf("RETURN "); 		
					count();
					return RETURN; }
if              { 	//printf("IF "); 			
					count();
					return IF; }
else            { 	//printf("ELSE "); 			
					count();
					return ELSE; }
while           { 	//printf("WHILE "); 		
					count();
					return WHILE; }
break           { 	//printf("BREAK "); 		
					count();
					return BREAK; }
print           { 	//printf("PRINT "); 		
					count();
					return PRINT; }
read            { 	//printf("READ "); 			
					count();
					return READ; }

 /* Arithmrtic op */
=               { 	//printf("ASSIGN "); 		
					count();
					return ASSIGN; }
!               { 	//printf("NOT "); 			
					count();
					return NOT; }
\+              { 	//printf("PLUS "); 			
					count();
					return PLUS; }
-               { 	//printf("MINUS "); 		
					count();
					return MINUS; }
\*              { 	//printf("MULTIPLY "); 		
					count();
					return MULTIPLY; }
\/              { 	//printf("DIVIDE "); 		
					count();
					return DIVIDE; }

 /* Comparison op */
==              { 	//printf("EQUAL ");			
					count();
					return EQUAL; }
!=              { 	//printf("NOT_EQUAL ");		
					count();
					return NOT_EQUAL; }
\<              { 	//printf("LESS ");			
					count();
					return LESS; }
>               { 	//printf("GREATER ");		
					count();
					return GREATER; }
\<=             { 	//printf("LESS_EQUAL ");	
					count();
					return LESS_EQUAL; }
>=              { 	//printf("GREATER_EQUAL ");	
					count();
					return GREATER_EQUAL; }
&&              {	//printf("AND ");			
					count();
					return AND; }
"||"            { 	//printf("OR "); 			
					count();
					return OR; }

 /* Special symbols */
"["             { 	//printf("["); 				
					count();
					return O_BRACKET; }
"]"             { 	//printf("]"); 				
					count();
					return C_BRACKET; }
"("             { 	//printf("("); 				
					count();
					return O_PARENTHESIS; }
")"             { 	//printf(")"); 				
					count();
					return C_PARENTHESIS; }
"{"             { 	//printf("{"); 				
					count();
					return O_BRACE; }
"}"             { 	//printf("}"); 				
					count();
					return C_BRACE; }
;               { 	//printf(";"); 				
					count();
					return SEMICOLON; }
,               { 	//printf(","); 				
					count();
					return COMMA; }
 
 /* Identifier (incorrect) */
id[A-Z][a-z]*   { 	//printf("%s ", yytext); 		
					//yylval.table = hash_lookup(yytext);
					count();
					return checkType(); }
 
 /* Variables */
[0-9]+          { 	//printf("%s ", yytext); 
					count();
					yylval.id_value = atoi(yytext);
					return VAL; }

 /* Character */
\".\"           { 	//printf("%s ", yytext); 	
					return CH; }

 /* Single line comment (but return comment is useless) */
"/*"			{ 	comment(); }
"//"[^\n]*      { 	/* consume //-comment */ }

 /* other */
[\t ]+          ;  	// ignore any space or tab.
.               { 	//printf("WTF? "); 		
					lex_failed(yytext); }

%%

void lex_failed(char *s) {
    // exit(1);
}

void comment() {
	char c, prev = 0;
  
	while ((c = input()) != 0) {
		if (c == '/' && prev == '*')
			return;

		prev = c;
	}

	error("Unterminated comment");
}

int column = 0;

void count() {
	int i;

	for (i = 0; yytext[i] != '\0'; ++i) {
		if (yytext[i] == '\n')
			column = 0;
		else if (yytext[i] == '\t')
			column += (8 - (column % 8));
		else
			column += 1;
	}
}

int checkType() {
	yylval.id_index = ELFHash(yytext, strlen(yytext));
	return IDENTIFIER;
}