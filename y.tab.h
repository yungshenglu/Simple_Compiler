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
    INT = 258,
    CHAR = 259,
    RETURN = 260,
    IF = 261,
    ELSE = 262,
    WHILE = 263,
    BREAK = 264,
    PRINT = 265,
    READ = 266,
    ASSIGN = 267,
    NOT = 268,
    PLUS = 269,
    MINUS = 270,
    MULTIPLY = 271,
    DIVIDE = 272,
    EQUAL = 273,
    NOT_EQUAL = 274,
    LESS = 275,
    GREATER = 276,
    LESS_EQUAL = 277,
    GREATER_EQUAL = 278,
    AND = 279,
    OR = 280,
    O_BRACKET = 281,
    C_BRACKET = 282,
    O_PARENTHESIS = 283,
    C_PARENTHESIS = 284,
    O_BRACE = 285,
    C_BRACE = 286,
    SEMICOLON = 287,
    COMMA = 288,
    PARAM = 289,
    FUNC = 290,
    VAR = 291,
    CALL = 292,
    GLOBAL_VAR = 293,
    VAL = 294,
    CH = 295,
    IDENTIFIER = 296,
    COMMENT = 297
  };
#endif
/* Tokens.  */
#define INT 258
#define CHAR 259
#define RETURN 260
#define IF 261
#define ELSE 262
#define WHILE 263
#define BREAK 264
#define PRINT 265
#define READ 266
#define ASSIGN 267
#define NOT 268
#define PLUS 269
#define MINUS 270
#define MULTIPLY 271
#define DIVIDE 272
#define EQUAL 273
#define NOT_EQUAL 274
#define LESS 275
#define GREATER 276
#define LESS_EQUAL 277
#define GREATER_EQUAL 278
#define AND 279
#define OR 280
#define O_BRACKET 281
#define C_BRACKET 282
#define O_PARENTHESIS 283
#define C_PARENTHESIS 284
#define O_BRACE 285
#define C_BRACE 286
#define SEMICOLON 287
#define COMMA 288
#define PARAM 289
#define FUNC 290
#define VAR 291
#define CALL 292
#define GLOBAL_VAR 293
#define VAL 294
#define CH 295
#define IDENTIFIER 296
#define COMMENT 297

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 24 "myyacc.y" /* yacc.c:1909  */

  int id_value;
  int id_index;
  Node *table;

#line 144 "y.tab.h" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
