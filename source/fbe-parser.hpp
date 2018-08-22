/* A Bison parser, made by GNU Bison 2.7.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
   
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

#ifndef YY_YY_Z_PROJECTS_CPPPROJECTS_FASTBINARYENCODING_SOURCE_FBE_PARSER_HPP_INCLUDED
# define YY_YY_Z_PROJECTS_CPPPROJECTS_FASTBINARYENCODING_SOURCE_FBE_PARSER_HPP_INCLUDED
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     PACKAGE = 258,
     OFFSET = 259,
     IMPORT = 260,
     ENUM = 261,
     FLAGS = 262,
     STRUCT = 263,
     KEY = 264,
     BOOL = 265,
     BYTE = 266,
     BYTES = 267,
     CHAR = 268,
     WCHAR = 269,
     INT8 = 270,
     UINT8 = 271,
     INT16 = 272,
     UINT16 = 273,
     INT32 = 274,
     UINT32 = 275,
     INT64 = 276,
     UINT64 = 277,
     FLOAT = 278,
     DOUBLE = 279,
     DECIMAL = 280,
     STRING = 281,
     USTRING = 282,
     TIMESTAMP = 283,
     UUID = 284,
     CONST_TRUE = 285,
     CONST_FALSE = 286,
     CONST_NULL = 287,
     CONST_UTC = 288,
     CONST_UUID1 = 289,
     CONST_UUID4 = 290,
     CONST_CHAR = 291,
     CONST_INT = 292,
     CONST_FLOAT = 293,
     CONST_STRING = 294,
     IDENTIFIER = 295
   };
#endif


#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{
/* Line 2058 of yacc.c  */
#line 16 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"

    int token;
    std::string* string;
    FBE::Package* package;
    FBE::Import* import;
    FBE::Statements* statements;
    FBE::Statement* statement;
    FBE::EnumType* enum_type;
    FBE::EnumBody* enum_body;
    FBE::EnumValue* enum_value;
    FBE::EnumConst* enum_const;
    FBE::FlagsType* flags_type;
    FBE::FlagsBody* flags_body;
    FBE::FlagsValue* flags_value;
    FBE::FlagsConst* flags_const;
    FBE::StructType* struct_type;
    FBE::StructBody* struct_body;
    FBE::StructField* struct_field;


/* Line 2058 of yacc.c  */
#line 118 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe-parser.hpp"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
} YYLTYPE;
# define yyltype YYLTYPE /* obsolescent; will be withdrawn */
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;
extern YYLTYPE yylloc;
#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_YY_Z_PROJECTS_CPPPROJECTS_FASTBINARYENCODING_SOURCE_FBE_PARSER_HPP_INCLUDED  */
