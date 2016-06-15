%{
	#include <stdio.h>
	#include <string.h>

	#include "node.h"
	#include "y.tab.h"
	#include "hash.h"

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

	void count(void);
%}

%%
 /* Comment */
"/*"			{ 	comment(); }
"//"[^\n]*      { 	/* consume //-comment */ }

 /* Keyword */
"int"           { 	//printf("INT "); 
					count();			
					return INT; }
"char"          { 	//printf("CHAR "); 			
					count();
					return CHAR; }
"return"        { 	//printf("RETURN "); 		
					count();
					return RETURN; }
"if"            { 	//printf("IF "); 			
					count();
					return IF; }
"else"          { 	//printf("ELSE "); 			
					count();
					return ELSE; }
"while"         { 	//printf("WHILE "); 		
					count();
					return WHILE; }
"break"         { 	//printf("BREAK "); 		
					count();
					return BREAK; }
"print"         { 	//printf("PRINT "); 		
					count();
					return PRINT; }
"read"          { 	//printf("READ "); 			
					count();
					return READ; }

 /* Arithmrtic operator */
"="             { 	//printf("ASSIGN "); 	
					count();
					return '='; }
"!"             { //printf("NOT "); 			
					count();
					return '!'; }
"+"             { 	//printf("PLUS "); 			
					count();
					return '+'; }
"-"             { 	//printf("MINUS "); 		
					count();
					return '-'; }
"*"             { 	//printf("MULTIPLY "); 		
					count();
					return '*'; }
"/"             { 	//printf("DIVIDE "); 		
					count();
					return '/'; }

 /* Comparison op */
"=="            { 	//printf("EQUAL ");			
					count();
					return EQUAL; }
"!="            { 	//printf("NOT_EQUAL ");		
					count();
					return NOT_EQUAL; }
"<"             { 	//printf("LESS ");			
					count();
					return '<'; }
">"             { 	//printf("GREATER ");		
					count();
					return '>'; }
"<="            { 	//printf("LESS_EQUAL ");	
					count();
					return LESS_EQUAL; }
">="            { 	//printf("GREATER_EQUAL ");	
					count();
					return GREATER_EQUAL; }
"&&"            {	//printf("AND ");			
					count();
					return AND; }
"||"            { 	//printf("OR "); 			
					count();
					return OR; }

 /* Special symbols */
"["             { 	//printf("["); 				
					count();
					return '['; }
"]"             { 	//printf("]"); 				
					count();
					return ']'; }
"("             { 	//printf("("); 				
					count();
					return '('; }
")"             { 	//printf(")"); 				
					count();
					return ')'; }
"{"             { 	//printf("{"); 				
					count();
					return '{'; }
"}"             { 	//printf("}"); 				
					count();
					return '}'; }
";"             { 	//printf(";"); 				
					count();
					return ';'; }
","             { 	//printf(","); 				
					count();
					return ','; }
 
 /* Identifier (incorrect) */
"id"[A-Z][a-zA_Z_]* { 	//printf("%s ", yytext); 		
					//yylval.table = hash_lookup(yytext);
					count();
					return checkType(); }
 
 /* Variables */
[0-9]+          { 	//printf("%s ", yytext); 
					count();
					yylval.id_value = atoi(yytext);
					return CONSTANT; }

 /* Character */
"\'.\'"         { 	//printf("%c ", yytext[1]); 	
					return CH; }

 /* Others */
[ \t\n]         {	//count();
					;           }
.               {	;			}

%%

int yywrap(void) {
	return 1;
}

void comment(void) {
	char c, prev = 0;
  
	while ((c = input()) != 0) {
		if (c == '/' && prev == '*')
			return;

		prev = c;
	}

	error("Unterminated comment");
}

int column = 0;

void count(void) {
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

int checkType(void) {
	yylval.id_index = ELFHash(yytext, strlen(yytext));
	return IDENTIFIER;
}