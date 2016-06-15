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

  int yylexNode(void);
  void yyerror(char *s);
%}

%union {
  int id_value;
  int id_index;
  Node *table;
};

%token <id_value> CONSTANT CH INT VOID CHAR
%token <id_index> IDENTIFIER

%token RETURN IF ELSE WHILE BREAK 
%token PRINT READ
%token ASSIGN NOT PLUS MINUS MULTIPLY DIVIDE
%token EQUAL NOT_EQUAL LESS GREATER LESS_EQUAL GREATER_EQUAL AND OR
%token FUNC PARAM CALL VAR GLOBAL_VAR

%nonassoc ELSE

%type <table> term var factor var_declaration local_declarations
%type <table> additive_expression simple_expression expression
%type <table> return_stmt iteration_stmt expression_stmt selection_stmt compound_stmt
%type <table> statement statement_list 
%type <table> param params_list params type_specifier
%type <table> fun_declaration declaration declaration_list
%type <table> call args arg_list

%type <id_value> relop mulop addop

%start program

%%

program
  : declaration_list 
    { 
      exeNode($1, 0); 
      //freeNode($1); 
    }
  ;

declaration_list
  : declaration_list declaration 
    { 
      $$ = operator(';', 2, $1, $2); 
    }
  | declaration 
    { 
      $$ = $1; 
    }
  ;

declaration
  : var_declaration 
    { 
      $$  = operator(GLOBAL_VAR, 1, $1);
    }
  | fun_declaration 
    { 
      $$ = $1; 
    }
  ;

var_declaration
  : type_specifier IDENTIFIER ';'
    {
      Node *tmp1;
      /* here to insert new var declaration */
      tmp1 = setIndex($2);
      $$ = operator(VAR, 2, $1, tmp1);
    }
  | type_specifier IDENTIFIER '[' CONSTANT ']' ';'
    {
      Node *tmp1, *tmp2;
      tmp1 = setIndex($2);
      tmp2 = setContent($4);
      $$ = operator(VAR, 3, $1, tmp1, tmp2);
    }
  ;

type_specifier
  : INT 
    { 
      $$ = setContent(INT); 
    }
  | VOID 
    { 
      $$ = setContent(VOID); 
    }
  | CHAR
    {
      $$ = setContent(CHAR);
    }
  ;

fun_declaration
  : type_specifier IDENTIFIER '(' params ')' 
    {
      Node *tmp1;
      tmp1 = setIndex($2);
      $$ = operator(FUNC, 3, $1, tmp1, $4);
    }

  | compound_stmt 
    { 
      $$ = operator(FUNC, 1, $1); 
    }
  ;

params
  : params_list 
    { 
      $$ = $1;
    }
  | 
    { 
      $$ = NULL; 
    }
  ;

params_list
  : params_list ',' param 
    { 
      $$ = operator(',', 2, $1, $3); 
    }
  | param 
    { 
      $$ = $1;
    }
  ;

param
  : type_specifier IDENTIFIER
    {
      Node *tmp1;
      /* here to insert new var declaration */
      tmp1 = setIndex($2);
      $$ = operator(PARAM, 2, $1, tmp1);
    }
  | type_specifier IDENTIFIER '[' ']'
    {
      Node *tmp1;
      /* here to insert new var declaration */
      tmp1 = setIndex($2);
      $$ = operator(PARAM, 3, $1, tmp1, NULL);
    }
  ;

compound_stmt
  : '{' local_declarations statement_list '}' 
    { 
      $$ = operator('{', 2, $2, $3); 
    }
  ;

local_declarations
  : local_declarations var_declaration 
    { 
      $$ = operator(';', 2, $1, $2); 
    }
  | /* empty */ 
    { 
      $$ = NULL; 
    }
  ;

statement_list
  : statement_list statement 
    { 
      $$ = operator(';', 2, $1, $2); 
    }
  | /* empty */ 
    { 
      $$ = NULL; 
    }
  ;

statement
  : expression_stmt 
    { 
      $$ = $1; 
    }
  | compound_stmt 
    { 
      $$ = $1; 
    }
  | selection_stmt 
    { 
      $$ = $1; 
    }
  | iteration_stmt 
    { 
      $$ = $1; 
    }
  | return_stmt 
    { 
      $$ = $1; 
    }
  ;

expression_stmt
  : expression ';' 
    { 
      $$ = $1; 
    }
  | ';' 
    { 
      $$ = NULL; 
    }
  ;

selection_stmt
  : IF '(' expression ')' statement 
    { 
      $$ = operator(IF, 2, $3, $5); 
    }
  | IF '(' expression ')' statement ELSE statement
    { 
      $$ = operator(IF, 3, $3, $5, $7); 
    }
  ;

iteration_stmt
  : WHILE '(' expression ')' statement 
    { 
      $$ = operator(WHILE, 2, $3, $5); 
    }
  ;

return_stmt
  : RETURN ';' 
    { 
      $$ = operator(RETURN, 0); 
    }
  | RETURN expression ';' 
    { 
      $$ = operator(RETURN, 1, $2); 
    }
  ;

expression
  : var '=' expression
    {
      $$ = operator('=', 2, $1, $3);
    }
  | simple_expression 
    { 
      $$ = $1; 
    }
  ;

var
  : IDENTIFIER 
    {
      $$ = setIndex($1); 
    }
  | IDENTIFIER '[' expression ']' 
    {
      Node *tmp1;
      tmp1 = setIndex($1);
      $$ = operator('[', 2, tmp1, $3); 
    }
  ;

simple_expression
  : additive_expression relop additive_expression
    {
      $$ = operator($2, 2, $1, $3); 
    }
  | additive_expression 
    { 
      $$ = $1; 
    }
  ;

relop
  : LESS_EQUAL 
    { 
      $$ = LESS_EQUAL; 
    }
  | '<' 
    {
      $$ = '<'; 
    }
  | '>' 
    { 
      $$ = '>'; 
    }
  | GREATER_EQUAL 
    { 
      $$ = GREATER_EQUAL; 
    }
  | EQUAL 
    { 
      $$ = EQUAL; 
    }
  | NOT_EQUAL 
    { 
      $$ = NOT_EQUAL; 
    }
  ;

additive_expression
  : additive_expression addop term
    {
      $$ = operator($2, 2, $1, $3);
    }
  | term
    { 
      $$ = $1;
    }
  ;

addop
  : '+' 
    { 
      $$ = '+'; 
    }
  | '-' 
    { 
      $$ = '-'; 
    }
  ;

term
  : term mulop factor
    {
      $$ = operator($2, 2, $1, $3);
    }
  | factor 
    { 
      $$ = $1; 
    }
  ;

mulop
  : '*' 
    { 
      $$ = '*'; 
    }
  | '/' 
    { 
      $$ = '/'; 
    }
  ;

factor
  : '(' expression ')' 
    { 
      $$ = $2; 
    }
  | var 
    { 
      $$ = $1; 
    }
  | call 
    { 
      $$ = $1; 
    }
  | CONSTANT 
    { 
      $$ = setContent($1); 
    }
  ;

call
  : IDENTIFIER '(' args ')'
    { 
        Node *tmp1;
        tmp1 = setIndex($1);
        $$ = operator(CALL, 2, tmp1, $3);
    }
  ;

args
  : arg_list
    { 
      $$ = $1; 
    }
  | /* empty */ 
    { 
      $$ = NULL; 
    }
  ;

arg_list
  : arg_list ',' expression 
    { 
      $$ = operator(',', 2, $1, $3); 
    }
  | expression 
    { 
      $$ = $1; 
    }
  ;

%%

#define SIZE_NODE ((char*)&p->content - (char*)p)

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
  printf("ERROR: %s\n", s);
}

int main(void) {
  hash_init(var_local, HASHSIZE);
  hash_init(var_local_SorA, HASHSIZE);
  hash_init(var_local_GorP, HASHSIZE);
  
  yyparse();

  return 0;
}