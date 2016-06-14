%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <stdarg.h>

  #include "node.h"
  #include "hash.h"
  #include "var.h"
  #include "command.h"

  Node *tmp;

  Node* operator(int name, int value, ...);
  Node* setIndex(int value);
  Node* setContent(int value);

  void freeNode(Node *p);
  int exeNode(Node *p, int sign);

  int yylexNode();
  void yyerror(char *s);
%}

%union {
  int id_value;
  int id_index;
  Node *table;
}

%token INT CHAR RETURN IF ELSE WHILE BREAK PRINT READ
%token ASSIGN NOT PLUS MINUS MULTIPLY DIVIDE
%token EQUAL NOT_EQUAL LESS GREATER LESS_EQUAL GREATER_EQUAL AND OR
%token O_BRACKET C_BRACKET O_PARENTHESIS C_PARENTHESIS O_BRACE 
       C_BRACE SEMICOLON COMMA

%token PARAM FUNC VAR CALL GLOBAL_VAR

%token <id_value> VAL CH
%token <id_index> IDENTIFIER

%token COMMENT

/*小心 MINUS可能是減法或是負號*/
%type <table> Program 
%type <table> DeclList DeclList_ Decl FunDecl
%type <table> VarDecl VarDecl_ VarDeclList
%type <table> ParamDeclList ParamDeclListTail ParamDeclListTail_ ParamDecl ParamDecl_
%type <table> StmtList StmtList_ Stmt
%type <table> Type Expr Expr_ Block ExprList ExprListTail ExprListTail_ ExprIdTail ExprArrayTail
%type <id_value> UnaryOp BinOp

%start Program

%%

Program
  : DeclList
    {
      exeNode($1, 0);
      //freeNode($1);
    }
  ;

DeclList
  : DeclList_ DeclList 
    {
      $$ = operator(SEMICOLON, 2, $1, $2);
    }
	| /*epsilon*/
    {
      $$ = NULL;
    }
  ;

DeclList_
  : Type IDENTIFIER Decl 
    {
      $$ = operator(SEMICOLON, 2, $1, $2);
      Node *tmp = setIndex($2);
    }
  ;

Decl
  : VarDecl
    {
      $$ = operator(GLOBAL_VAR, 1, $1);
    }
  | FunDecl
    {
      $$ = $1;
    }
  ;

VarDecl
  : Type IDENTIFIER VarDecl_
    {
      Node *tmp1;
      /* Insert new var declaration */
      tmp1 = setIndex($2);
      $$ = operator(VAR, 2, $1, tmp1);
    }
  ;

VarDecl_
  :  SEMICOLON
    {
    }
  | O_BRACKET VAL C_BRACKET SEMICOLON
    {
      Node *tmp2 = setContent($2);
      $$ = operator(VAR, 1, $2, tmp2);
    }
  ;

FunDecl
  : O_PARENTHESIS ParamDeclList C_PARENTHESIS Block
    {
      $$ = operator(FUNC, 2, $2, $4);
    }
  ;

VarDeclList
  : VarDecl VarDeclList
  | /*epsilon*/
    {
      $$ = NULL;
    }
  ;

ParamDeclList
  : ParamDeclListTail
    {
      $$ = $1;
    }
	| /*epsilon*/
    {
      $$ = NULL;
    }
  ;

ParamDeclListTail
  : ParamDecl ParamDeclListTail_
  ;

ParamDeclListTail_
  :	COMMA ParamDeclListTail 
    {
      $$ = operator(COMMA, 1, $2);
    }
  |	/*epsilon*/
    {
      $$ = NULL;
    }
  ;

ParamDecl
  : Type IDENTIFIER ParamDecl_
    {
      Node *tmp = setIndex($2);
      $$ = operator(PARAM, 2, $1, tmp);
    }
  ;

ParamDecl_
  : O_BRACKET C_BRACKET
    {
      Node *tmp;
      $$ = operator(PARAM, 3);
    }
	| /*epsilon*/
    {
      $$ = NULL;
    }
  ;

Block
  : O_BRACE VarDeclList StmtList C_BRACE
    {
      $$ = operator(O_BRACE, 2, $2, $3);
    }
  ;

Type
  : INT
    {
      $$ = setContent(INT);
    }
	| CHAR
    {
      $$ = setContent(CHAR);
    }
  ;

StmtList
  : Stmt StmtList_
    {
      $$ = operator(SEMICOLON, 2, $1, $2);
    }
  ;

StmtList_
  : StmtList
	| /*epsilon*/
    {
      $$ = NULL;
    }
  ;

Stmt
  : SEMICOLON
    {
      $$ = NULL;
    }
	| Expr SEMICOLON
    {
      $$ = $1;
    }
	| RETURN Expr SEMICOLON
    {
      $$ = operator(RETURN, 1, $2);
    }
	| BREAK SEMICOLON
    {
      $$ = operator(BREAK, 0);
    }
	| IF O_PARENTHESIS Expr C_PARENTHESIS Stmt ELSE Stmt
    {
      $$ = operator(IF, 2, $3, $5);
    }
	| WHILE O_PARENTHESIS Expr C_PARENTHESIS Stmt
    {
      $$ = operator(WHILE, 2, $3, $5);
    }
	| Block 
    {
      $$ = $1;
    }
	| PRINT IDENTIFIER SEMICOLON 
    {
      $$ = operator(PRINT, 1, $2);
    }
	| READ IDENTIFIER SEMICOLON
    {
      $$ = operator(READ, 1, $2);
    }
  ;

Expr
  : UnaryOp Expr
    {
      $$ = operator($1, 1, $2);
    }
	| VAL Expr_
    {
      $$ = $2;
    }
	| O_PARENTHESIS Expr C_PARENTHESIS Expr_
    {
      $$ = $2;
    }
	| IDENTIFIER ExprIdTail
    {
      Node *tmp = setIndex($1);
    }
  ;

ExprIdTail
  :	Expr_
    {
      $$ = $1;
    }
	| O_PARENTHESIS ExprList C_PARENTHESIS Expr_
    {
      $$ = $2;
    }
	| O_BRACKET Expr C_BRACKET ExprArrayTail
    {
      $$ = operator(O_BRACKET, 2, tmp, $2);
    }
	| ASSIGN Expr
    {
      $$ = operator(ASSIGN, 1, $2);
    }
  ;

ExprArrayTail
  : Expr_
    {
      $$ = $1;
    }
	| ASSIGN Expr
    {
      $$ = operator(ASSIGN, 1, $2);
    }
  ;

Expr_
  : BinOp Expr
    {
      $$ = operator($1, 1, $2);
    }
	| /*epsilon*/
    {
      $$ = NULL;
    }
  ;

ExprList
  : ExprListTail
	| /*epsilon*/
    {
      $$ = NULL;
    }
  ;

ExprListTail
  : Expr ExprListTail_
  ;

ExprListTail_
  : COMMA ExprListTail
    {
      $$ = operator(COMMA, 1, $2);
    }
	| /*epsilon*/
    {
      $$ = NULL;
    }
  ;

UnaryOp
  : MINUS
    {
      $$ = MINUS;
    }
  | NOT
    {
      $$ = NOT;
    }
  ;

BinOp
  : PLUS 
    { 
      $$ = '+'; 
    }
  | MINUS
    { 
      $$ = '-'; 
    }
  | MULTIPLY
    { 
      $$ = '*'; 
    }
  | DIVIDE
    { 
      $$ = '/'; 
    }
  | EQUAL
    { 
      $$ = EQUAL; 
    }
  | NOT_EQUAL
    { 
      $$ = NOT_EQUAL; 
    }
  | LESS
    { 
      $$ = '<'; 
    }
  | LESS_EQUAL
    { 
      $$ = LESS_EQUAL; 
    }
  | GREATER
    { 
      $$ = '>'; 
    }
  | GREATER_EQUAL
    { 
      $$ = GREATER_EQUAL; 
    }
  | AND
    { 
      $$ = AND; 
    }
  | OR
    { 
      $$ = OR; 
    }
  ;

%%

#define SIZE_NODE ((char*)&p->content - (char*)p)

extern FILE *yyin;

Node* setContent(int value) {
  Node *p;
  size_t sizeNode = SIZE_NODE + sizeof(int);

  if ((p = malloc(sizeNode)) == NULL)
    yyerror("Out of memory.");

  p->type = TYPE_CONTENT;
  p->content = value;

  return p;
}

Node* setIndex(int value) {
  Node *p;
  size_t sizeNode = SIZE_NODE + sizeof(int);

  if ((p = malloc(sizeNode)) == NULL)
    yyerror("Out of memory"); 
  
  p->type = TYPE_INDEX;
  p->index = value;

  return p;
}

Node* operator(int name, int operand, ...) {
  va_list valist;
  Node *p;

  int i;
  size_t sizeNode = SIZE_NODE + sizeof(OpNode) + (operand - 1) * sizeof(Node*);
 
  if ((p = malloc(sizeNode)) == NULL)
    yyerror("Out of memory"); 
    
  p->type = TYPE_OP;
  p->op.op_name = name;
  p->op.operand = operand;

  va_start(valist, operand);
 
  for (i = 0; i < operand; ++i)
    p->op.node[i] = va_arg(valist, Node*);
    
  va_end(valist);

  return p;
}

void freeNode(Node *p) {
  int i;

  if (!p) 
    return;

  if (p->type == TYPE_OP) {
    for (i = 0; i < p->op.operand; ++i)
      freeNode(p->op.node[i]);
  }

  free (p);
}

/* Error message */
void yyerror(char *s) {
  fprintf(stderr, "ERROR: %s.\n", s);
}

main() {
  hash_init(var_local, HASHSIZE);
  hash_init(var_local_SorA, HASHSIZE);
  hash_init(var_local_GorP, HASHSIZE);

  yyparse();
  return 0;
}