/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    CONSTANT = 258,
    CH = 259,
    INT = 260,
    VOID = 261,
    CHAR = 262,
    IDENTIFIER = 263,
    RETURN = 264,
    IF = 265,
    ELSE = 266,
    WHILE = 267,
    BREAK = 268,
    PRINT = 269,
    READ = 270,
    ASSIGN = 271,
    NOT = 272,
    PLUS = 273,
    MINUS = 274,
    MULTIPLY = 275,
    DIVIDE = 276,
    EQUAL = 277,
    NOT_EQUAL = 278,
    LESS = 279,
    GREATER = 280,
    LESS_EQUAL = 281,
    GREATER_EQUAL = 282,
    AND = 283,
    OR = 284,
    FUNC = 285,
    PARAM = 286,
    CALL = 287,
    VAR = 288,
    GLOBAL_VAR = 289
  };
#endif
/* Tokens.  */
#define CONSTANT 258
#define CH 259
#define INT 260
#define VOID 261
#define CHAR 262
#define IDENTIFIER 263
#define RETURN 264
#define IF 265
#define ELSE 266
#define WHILE 267
#define BREAK 268
#define PRINT 269
#define READ 270
#define ASSIGN 271
#define NOT 272
#define PLUS 273
#define MINUS 274
#define MULTIPLY 275
#define DIVIDE 276
#define EQUAL 277
#define NOT_EQUAL 278
#define LESS 279
#define GREATER 280
#define LESS_EQUAL 281
#define GREATER_EQUAL 282
#define AND 283
#define OR 284
#define FUNC 285
#define PARAM 286
#define CALL 287
#define VAR 288
#define GLOBAL_VAR 289

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 24 "myyacc.y" /* yacc.c:1909  */

  int id_value;
  int id_index;
  Node *table;

#line 128 "y.tab.h" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
