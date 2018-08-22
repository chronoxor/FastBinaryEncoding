/* A Bison parser, made by GNU Bison 2.7.  */

/* Bison implementation for Yacc-like parsers in C
   
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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.7"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
/* Line 371 of yacc.c  */
#line 1 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"


#include "fbe.h"

int yylex(void);
int yyerror(const char* msg);
int yyerror(const std::string& msg);


/* Line 371 of yacc.c  */
#line 78 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe-parser.cpp"

# ifndef YY_NULL
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULL nullptr
#  else
#   define YY_NULL 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "fbe-parser.hpp".  */
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
/* Line 387 of yacc.c  */
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


/* Line 387 of yacc.c  */
#line 182 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe-parser.cpp"
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

/* Copy the second part of user declarations.  */

/* Line 390 of yacc.c  */
#line 223 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe-parser.cpp"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(N) (N)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int yyi)
#else
static int
YYID (yyi)
    int yyi;
#endif
{
  return yyi;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL \
	     && defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
  YYLTYPE yyls_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE) + sizeof (YYLTYPE)) \
      + 2 * YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)				\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack_alloc, Stack, yysize);			\
	Stack = &yyptr->Stack_alloc;					\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (YYID (0))
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  6
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   398

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  56
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  31
/* YYNRULES -- Number of rules.  */
#define YYNRULES  116
/* YYNRULES -- Number of states.  */
#define YYNSTATES  198

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   295

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    52,     2,     2,     2,     2,     2,     2,
      50,    51,     2,     2,     2,     2,    55,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    43,    44,
      53,    45,    54,    49,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    47,     2,    48,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    41,    46,    42,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     6,    10,    13,    18,    21,    25,    27,
      29,    32,    34,    36,    38,    44,    52,    54,    56,    58,
      60,    62,    64,    66,    68,    70,    72,    74,    76,    79,
      82,    87,    89,    91,    93,    99,   107,   109,   111,   113,
     115,   117,   119,   121,   123,   125,   127,   130,   135,   137,
     139,   143,   149,   157,   165,   175,   184,   195,   197,   200,
     204,   210,   217,   226,   228,   230,   232,   234,   236,   238,
     240,   242,   244,   246,   248,   250,   252,   254,   256,   258,
     260,   262,   264,   266,   268,   270,   272,   274,   276,   278,
     280,   282,   285,   290,   295,   299,   303,   307,   311,   314,
     319,   324,   329,   334,   336,   338,   340,   342,   344,   346,
     348,   350,   352,   354,   356,   360,   362
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      57,     0,    -1,    58,    61,    -1,    58,    59,    61,    -1,
       3,    60,    -1,     3,    60,     4,    37,    -1,     5,    60,
      -1,    59,     5,    60,    -1,    40,    -1,    62,    -1,    61,
      62,    -1,    63,    -1,    68,    -1,    73,    -1,     6,    40,
      41,    65,    42,    -1,     6,    40,    43,    64,    41,    65,
      42,    -1,    11,    -1,    13,    -1,    14,    -1,    15,    -1,
      16,    -1,    17,    -1,    18,    -1,    19,    -1,    20,    -1,
      21,    -1,    22,    -1,    66,    -1,    65,    66,    -1,    40,
      44,    -1,    40,    45,    67,    44,    -1,    36,    -1,    37,
      -1,    40,    -1,     7,    40,    41,    70,    42,    -1,     7,
      40,    43,    69,    41,    70,    42,    -1,    11,    -1,    15,
      -1,    16,    -1,    17,    -1,    18,    -1,    19,    -1,    20,
      -1,    21,    -1,    22,    -1,    71,    -1,    70,    71,    -1,
      40,    45,    72,    44,    -1,    37,    -1,    40,    -1,    40,
      46,    72,    -1,     8,    40,    41,    74,    42,    -1,     8,
      40,    43,    86,    41,    74,    42,    -1,     8,    40,    45,
      37,    41,    74,    42,    -1,     8,    40,    45,    37,    43,
      86,    41,    74,    42,    -1,     8,    40,    45,    45,    37,
      41,    74,    42,    -1,     8,    40,    45,    45,    37,    43,
      86,    41,    74,    42,    -1,    75,    -1,    74,    75,    -1,
      76,    86,    44,    -1,    76,    86,    45,    85,    44,    -1,
      47,     9,    48,    76,    86,    44,    -1,    47,     9,    48,
      76,    86,    45,    85,    44,    -1,    77,    -1,    78,    -1,
      79,    -1,    80,    -1,    81,    -1,    82,    -1,    83,    -1,
      84,    -1,    10,    -1,    11,    -1,    12,    -1,    13,    -1,
      14,    -1,    15,    -1,    16,    -1,    17,    -1,    18,    -1,
      19,    -1,    20,    -1,    21,    -1,    22,    -1,    23,    -1,
      24,    -1,    25,    -1,    26,    -1,    28,    -1,    29,    -1,
      86,    -1,    77,    49,    -1,    77,    47,    37,    48,    -1,
      78,    47,    37,    48,    -1,    77,    47,    48,    -1,    78,
      47,    48,    -1,    77,    50,    51,    -1,    78,    50,    51,
      -1,    77,    52,    -1,    77,    53,    77,    54,    -1,    78,
      53,    77,    54,    -1,    77,    41,    77,    42,    -1,    78,
      41,    77,    42,    -1,    30,    -1,    31,    -1,    32,    -1,
      33,    -1,    34,    -1,    35,    -1,    36,    -1,    37,    -1,
      38,    -1,    39,    -1,    86,    -1,    85,    46,    86,    -1,
      40,    -1,    86,    55,    40,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    77,    77,    78,    82,    83,    87,    88,    92,    96,
      97,   101,   102,   103,   107,   108,   112,   113,   114,   115,
     116,   117,   118,   119,   120,   121,   122,   126,   127,   130,
     131,   135,   136,   137,   141,   142,   146,   147,   148,   149,
     150,   151,   152,   153,   154,   158,   159,   163,   167,   168,
     169,   173,   174,   175,   176,   177,   178,   182,   183,   187,
     188,   189,   190,   194,   195,   196,   197,   198,   199,   200,
     201,   205,   206,   207,   208,   209,   210,   211,   212,   213,
     214,   215,   216,   217,   218,   219,   220,   221,   222,   223,
     224,   228,   232,   233,   237,   238,   242,   243,   247,   251,
     252,   256,   257,   261,   262,   263,   264,   265,   266,   267,
     268,   269,   270,   271,   272,   276,   277
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "PACKAGE", "OFFSET", "IMPORT", "ENUM",
  "FLAGS", "STRUCT", "KEY", "BOOL", "BYTE", "BYTES", "CHAR", "WCHAR",
  "INT8", "UINT8", "INT16", "UINT16", "INT32", "UINT32", "INT64", "UINT64",
  "FLOAT", "DOUBLE", "DECIMAL", "STRING", "USTRING", "TIMESTAMP", "UUID",
  "CONST_TRUE", "CONST_FALSE", "CONST_NULL", "CONST_UTC", "CONST_UUID1",
  "CONST_UUID4", "CONST_CHAR", "CONST_INT", "CONST_FLOAT", "CONST_STRING",
  "IDENTIFIER", "'{'", "'}'", "':'", "';'", "'='", "'|'", "'['", "']'",
  "'?'", "'('", "')'", "'!'", "'<'", "'>'", "'.'", "$accept", "fbe",
  "package", "import", "package_name", "statements", "statement", "enum",
  "enum_type", "enum_body", "enum_value", "enum_const", "flags",
  "flags_type", "flags_body", "flags_value", "flags_const", "struct",
  "struct_body", "struct_field", "struct_field_type", "struct_field_base",
  "struct_field_optional", "struct_field_array", "struct_field_vector",
  "struct_field_list", "struct_field_set", "struct_field_map",
  "struct_field_hash", "struct_field_value", "type_name", YY_NULL
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   123,   125,    58,    59,    61,   124,    91,    93,    63,
      40,    41,    33,    60,    62,    46
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    56,    57,    57,    58,    58,    59,    59,    60,    61,
      61,    62,    62,    62,    63,    63,    64,    64,    64,    64,
      64,    64,    64,    64,    64,    64,    64,    65,    65,    66,
      66,    67,    67,    67,    68,    68,    69,    69,    69,    69,
      69,    69,    69,    69,    69,    70,    70,    71,    72,    72,
      72,    73,    73,    73,    73,    73,    73,    74,    74,    75,
      75,    75,    75,    76,    76,    76,    76,    76,    76,    76,
      76,    77,    77,    77,    77,    77,    77,    77,    77,    77,
      77,    77,    77,    77,    77,    77,    77,    77,    77,    77,
      77,    78,    79,    79,    80,    80,    81,    81,    82,    83,
      83,    84,    84,    85,    85,    85,    85,    85,    85,    85,
      85,    85,    85,    85,    85,    86,    86
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     2,     3,     2,     4,     2,     3,     1,     1,
       2,     1,     1,     1,     5,     7,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     2,     2,
       4,     1,     1,     1,     5,     7,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     2,     4,     1,     1,
       3,     5,     7,     7,     9,     8,    10,     1,     2,     3,
       5,     6,     8,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     2,     4,     4,     3,     3,     3,     3,     2,     4,
       4,     4,     4,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     3,     1,     3
};

/* YYDEFACT[STATE-NAME] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,     8,     4,     1,     0,     0,     0,
       0,     0,     2,     9,    11,    12,    13,     0,     6,     0,
       0,     0,     0,     3,    10,     5,     0,     0,     0,     0,
       0,     0,     0,     7,     0,     0,    27,    16,    17,    18,
      19,    20,    21,    22,    23,    24,    25,    26,     0,     0,
       0,    45,    36,    37,    38,    39,    40,    41,    42,    43,
      44,     0,    71,    72,    73,    74,    75,    76,    77,    78,
      79,    80,    81,    82,    83,    84,    85,    86,    87,    88,
      89,   115,     0,     0,    57,     0,    63,    64,    65,    66,
      67,    68,    69,    70,    90,     0,     0,     0,    29,     0,
      14,    28,     0,     0,    34,    46,     0,     0,    51,    58,
       0,     0,     0,    91,     0,    98,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    31,    32,    33,     0,
       0,    48,    49,     0,     0,     0,    59,     0,     0,     0,
      94,    96,     0,     0,     0,    95,    97,     0,   116,     0,
       0,     0,     0,     0,    30,    15,     0,    47,    35,     0,
     103,   104,   105,   106,   107,   108,   109,   110,   111,   112,
       0,   113,   101,    92,    99,   102,    93,   100,    52,    53,
       0,     0,     0,    50,     0,    60,     0,     0,    55,     0,
      61,     0,   114,    54,     0,     0,    56,    62
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     2,     3,    11,     5,    12,    13,    14,    48,    35,
      36,   129,    15,    61,    50,    51,   133,    16,    83,    84,
      85,    86,    87,    88,    89,    90,    91,    92,    93,   170,
      94
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -119
static const yytype_int16 yypact[] =
{
      29,    21,    82,   118,  -119,    96,  -119,    21,    48,    64,
      70,   144,    84,  -119,  -119,  -119,  -119,    90,  -119,    22,
      55,   -12,    21,    84,  -119,  -119,    81,    59,   106,    98,
     309,   151,   -10,  -119,   113,    61,  -119,  -119,  -119,  -119,
    -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,   112,   139,
     114,  -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,
    -119,   159,  -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,
    -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,
    -119,  -119,   183,    -4,  -119,   151,    -2,    -1,  -119,  -119,
    -119,  -119,  -119,  -119,   143,   -18,   121,   164,  -119,    49,
    -119,  -119,    81,    20,  -119,  -119,   106,   154,  -119,  -119,
      11,   347,    16,  -119,   152,  -119,   347,   347,    46,   171,
     347,   185,   309,   309,   151,   122,  -119,  -119,  -119,   182,
     147,  -119,   181,   184,   148,   347,  -119,   358,   187,   186,
    -119,  -119,   176,   189,   188,  -119,  -119,   178,  -119,   119,
     157,   -13,   309,   151,  -119,  -119,    20,  -119,  -119,   151,
    -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,
     149,   143,  -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,
     309,   195,   -11,  -119,    14,  -119,   151,   233,  -119,   309,
    -119,   358,   143,  -119,   271,   150,  -119,  -119
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -119,  -119,  -119,  -119,    19,   222,    72,  -119,  -119,   136,
     -33,  -119,  -119,  -119,   133,   -47,    85,  -119,  -118,   -82,
     105,    -9,  -119,  -119,  -119,  -119,  -119,  -119,  -119,    69,
     -31
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const yytype_uint8 yytable[] =
{
      95,   109,   101,   105,   149,   150,    62,    63,    64,    65,
      66,    67,    68,    69,    70,    71,    72,    73,    74,    75,
      76,    77,    78,   122,    79,    80,    18,    96,   180,    30,
     189,    31,     1,    32,   181,    97,    81,   121,   108,   111,
     117,    33,   121,    82,   121,   112,   118,   113,   114,   119,
     115,   116,   120,   139,   110,   136,   137,   131,   190,   191,
     132,     4,   187,    26,   140,    27,   121,   109,   109,   121,
      37,   194,    38,    39,    40,    41,    42,    43,    44,    45,
      46,    47,     6,   144,    24,   126,   127,   105,    19,   128,
       8,     9,    10,   151,   145,    24,    28,   101,    29,   109,
      17,    34,   138,   100,    20,   109,   171,   142,   143,    52,
      21,   147,   109,    53,    54,    55,    56,    57,    58,    59,
      60,    34,   182,     7,     8,     9,    10,    25,   184,    62,
      63,    64,    65,    66,    67,    68,    69,    70,    71,    72,
      73,    74,    75,    76,    77,    78,    49,    79,    80,    22,
       8,     9,    10,   102,    49,   192,   104,    98,    99,    81,
     171,   178,   123,   152,   124,   153,    82,    62,    63,    64,
      65,    66,    67,    68,    69,    70,    71,    72,    73,    74,
      75,    76,    77,    78,   103,    79,    80,    34,    49,   155,
     158,    81,   107,   185,   197,   186,   186,    81,   121,   179,
     106,   125,   135,   141,    82,    62,    63,    64,    65,    66,
      67,    68,    69,    70,    71,    72,    73,    74,    75,    76,
      77,    78,   146,    79,    80,   148,   154,   156,   157,   172,
     174,   175,   177,    23,   173,    81,   176,   188,   130,   134,
     159,   183,    82,    62,    63,    64,    65,    66,    67,    68,
      69,    70,    71,    72,    73,    74,    75,    76,    77,    78,
     195,    79,    80,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,    81,     0,   193,     0,     0,     0,     0,
      82,    62,    63,    64,    65,    66,    67,    68,    69,    70,
      71,    72,    73,    74,    75,    76,    77,    78,     0,    79,
      80,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,    81,     0,   196,     0,     0,     0,     0,    82,    62,
      63,    64,    65,    66,    67,    68,    69,    70,    71,    72,
      73,    74,    75,    76,    77,    78,     0,    79,    80,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,    81,
       0,     0,     0,     0,     0,     0,    82,    62,    63,    64,
      65,    66,    67,    68,    69,    70,    71,    72,    73,    74,
      75,    76,    77,    78,     0,    79,    80,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,    81,   160,   161,
     162,   163,   164,   165,   166,   167,   168,   169,    81
};

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-119)))

#define yytable_value_is_error(Yytable_value) \
  YYID (0)

static const yytype_int16 yycheck[] =
{
      31,    83,    35,    50,   122,   123,    10,    11,    12,    13,
      14,    15,    16,    17,    18,    19,    20,    21,    22,    23,
      24,    25,    26,    41,    28,    29,     7,    37,    41,    41,
      41,    43,     3,    45,   152,    45,    40,    55,    42,    41,
      41,    22,    55,    47,    55,    47,    47,    49,    50,    50,
      52,    53,    53,    37,    85,    44,    45,    37,    44,    45,
      40,    40,   180,    41,    48,    43,    55,   149,   150,    55,
      11,   189,    13,    14,    15,    16,    17,    18,    19,    20,
      21,    22,     0,    37,    12,    36,    37,   134,    40,    40,
       6,     7,     8,   124,    48,    23,    41,   130,    43,   181,
       4,    40,   111,    42,    40,   187,   137,   116,   117,    11,
      40,   120,   194,    15,    16,    17,    18,    19,    20,    21,
      22,    40,   153,     5,     6,     7,     8,    37,   159,    10,
      11,    12,    13,    14,    15,    16,    17,    18,    19,    20,
      21,    22,    23,    24,    25,    26,    40,    28,    29,     5,
       6,     7,     8,    41,    40,   186,    42,    44,    45,    40,
     191,    42,    41,    41,    43,    43,    47,    10,    11,    12,
      13,    14,    15,    16,    17,    18,    19,    20,    21,    22,
      23,    24,    25,    26,    45,    28,    29,    40,    40,    42,
      42,    40,     9,    44,    44,    46,    46,    40,    55,    42,
      41,    37,    48,    51,    47,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    51,    28,    29,    40,    44,    46,    44,    42,
      54,    42,    54,    11,    48,    40,    48,    42,   102,   106,
     135,   156,    47,    10,    11,    12,    13,    14,    15,    16,
      17,    18,    19,    20,    21,    22,    23,    24,    25,    26,
     191,    28,    29,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    40,    -1,    42,    -1,    -1,    -1,    -1,
      47,    10,    11,    12,    13,    14,    15,    16,    17,    18,
      19,    20,    21,    22,    23,    24,    25,    26,    -1,    28,
      29,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    40,    -1,    42,    -1,    -1,    -1,    -1,    47,    10,
      11,    12,    13,    14,    15,    16,    17,    18,    19,    20,
      21,    22,    23,    24,    25,    26,    -1,    28,    29,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    40,
      -1,    -1,    -1,    -1,    -1,    -1,    47,    10,    11,    12,
      13,    14,    15,    16,    17,    18,    19,    20,    21,    22,
      23,    24,    25,    26,    -1,    28,    29,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    40,    30,    31,
      32,    33,    34,    35,    36,    37,    38,    39,    40
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,    57,    58,    40,    60,     0,     5,     6,     7,
       8,    59,    61,    62,    63,    68,    73,     4,    60,    40,
      40,    40,     5,    61,    62,    37,    41,    43,    41,    43,
      41,    43,    45,    60,    40,    65,    66,    11,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    64,    40,
      70,    71,    11,    15,    16,    17,    18,    19,    20,    21,
      22,    69,    10,    11,    12,    13,    14,    15,    16,    17,
      18,    19,    20,    21,    22,    23,    24,    25,    26,    28,
      29,    40,    47,    74,    75,    76,    77,    78,    79,    80,
      81,    82,    83,    84,    86,    86,    37,    45,    44,    45,
      42,    66,    41,    45,    42,    71,    41,     9,    42,    75,
      86,    41,    47,    49,    50,    52,    53,    41,    47,    50,
      53,    55,    41,    41,    43,    37,    36,    37,    40,    67,
      65,    37,    40,    72,    70,    48,    44,    45,    77,    37,
      48,    51,    77,    77,    37,    48,    51,    77,    40,    74,
      74,    86,    41,    43,    44,    42,    46,    44,    42,    76,
      30,    31,    32,    33,    34,    35,    36,    37,    38,    39,
      85,    86,    42,    48,    54,    42,    48,    54,    42,    42,
      41,    74,    86,    72,    86,    44,    46,    74,    42,    41,
      44,    45,    86,    42,    74,    85,    42,    44
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  However,
   YYFAIL appears to be in use.  Nevertheless, it is formally deprecated
   in Bison 2.4.2's NEWS entry, where a plan to phase it out is
   discussed.  */

#define YYFAIL		goto yyerrlab
#if defined YYFAIL
  /* This is here to suppress warnings from the GCC cpp's
     -Wunused-macros.  Normally we don't worry about that warning, but
     some users do, and we want to make it easy for users to remove
     YYFAIL uses, which will produce warnings from Bison 2.5.  */
#endif

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))

/* Error token number */
#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)                                \
    do                                                                  \
      if (YYID (N))                                                     \
        {                                                               \
          (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;        \
          (Current).first_column = YYRHSLOC (Rhs, 1).first_column;      \
          (Current).last_line    = YYRHSLOC (Rhs, N).last_line;         \
          (Current).last_column  = YYRHSLOC (Rhs, N).last_column;       \
        }                                                               \
      else                                                              \
        {                                                               \
          (Current).first_line   = (Current).last_line   =              \
            YYRHSLOC (Rhs, 0).last_line;                                \
          (Current).first_column = (Current).last_column =              \
            YYRHSLOC (Rhs, 0).last_column;                              \
        }                                                               \
    while (YYID (0))
#endif

#define YYRHSLOC(Rhs, K) ((Rhs)[K])


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef __attribute__
/* This feature is available in gcc versions 2.5 and later.  */
# if (! defined __GNUC__ || __GNUC__ < 2 \
      || (__GNUC__ == 2 && __GNUC_MINOR__ < 5))
#  define __attribute__(Spec) /* empty */
# endif
#endif

#ifndef YY_LOCATION_PRINT
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL

/* Print *YYLOCP on YYO.  Private, do not rely on its existence. */

__attribute__((__unused__))
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static unsigned
yy_location_print_ (FILE *yyo, YYLTYPE const * const yylocp)
#else
static unsigned
yy_location_print_ (yyo, yylocp)
    FILE *yyo;
    YYLTYPE const * const yylocp;
#endif
{
  unsigned res = 0;
  int end_col = 0 != yylocp->last_column ? yylocp->last_column - 1 : 0;
  if (0 <= yylocp->first_line)
    {
      res += fprintf (yyo, "%d", yylocp->first_line);
      if (0 <= yylocp->first_column)
        res += fprintf (yyo, ".%d", yylocp->first_column);
    }
  if (0 <= yylocp->last_line)
    {
      if (yylocp->first_line < yylocp->last_line)
        {
          res += fprintf (yyo, "-%d", yylocp->last_line);
          if (0 <= end_col)
            res += fprintf (yyo, ".%d", end_col);
        }
      else if (0 <= end_col && yylocp->first_column < end_col)
        res += fprintf (yyo, "-%d", end_col);
    }
  return res;
 }

#  define YY_LOCATION_PRINT(File, Loc)          \
  yy_location_print_ (File, &(Loc))

# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */
#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value, Location); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep, yylocationp)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
    YYLTYPE const * const yylocationp;
#endif
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
  YYUSE (yylocationp);
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
        break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep, yylocationp)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
    YYLTYPE const * const yylocationp;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  YY_LOCATION_PRINT (yyoutput, *yylocationp);
  YYFPRINTF (yyoutput, ": ");
  yy_symbol_value_print (yyoutput, yytype, yyvaluep, yylocationp);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
#else
static void
yy_stack_print (yybottom, yytop)
    yytype_int16 *yybottom;
    yytype_int16 *yytop;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, YYLTYPE *yylsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yylsp, yyrule)
    YYSTYPE *yyvsp;
    YYLTYPE *yylsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       , &(yylsp[(yyi + 1) - (yynrhs)])		       );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, yylsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULL, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULL;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - Assume YYFAIL is not used.  It's too flawed to consider.  See
       <http://lists.gnu.org/archive/html/bison-patches/2009-12/msg00024.html>
       for details.  YYERROR is fine as it does not invoke this
       function.
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULL, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep, YYLTYPE *yylocationp)
#else
static void
yydestruct (yymsg, yytype, yyvaluep, yylocationp)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
    YYLTYPE *yylocationp;
#endif
{
  YYUSE (yyvaluep);
  YYUSE (yylocationp);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
        break;
    }
}




/* The lookahead symbol.  */
int yychar;


#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval YY_INITIAL_VALUE(yyval_default);

/* Location data for the lookahead symbol.  */
YYLTYPE yylloc
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
  = { 1, 1, 1, 1 }
# endif
;


/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       `yyss': related to states.
       `yyvs': related to semantic values.
       `yyls': related to locations.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    /* The location stack.  */
    YYLTYPE yylsa[YYINITDEPTH];
    YYLTYPE *yyls;
    YYLTYPE *yylsp;

    /* The locations where the error started and ended.  */
    YYLTYPE yyerror_range[3];

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;
  YYLTYPE yyloc;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N), yylsp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yylsp = yyls = yylsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  yylsp[0] = yylloc;
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;
	YYLTYPE *yyls1 = yyls;

	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),
		    &yyls1, yysize * sizeof (*yylsp),
		    &yystacksize);

	yyls = yyls1;
	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss_alloc, yyss);
	YYSTACK_RELOCATE (yyvs_alloc, yyvs);
	YYSTACK_RELOCATE (yyls_alloc, yyls);
#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;
      yylsp = yyls + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END
  *++yylsp = yylloc;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];

  /* Default location.  */
  YYLLOC_DEFAULT (yyloc, (yylsp - yylen), yylen);
  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
/* Line 1792 of yacc.c  */
#line 77 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { FBE::Package::root.reset((yyvsp[(1) - (2)].package)); FBE::Package::root->body.reset((yyvsp[(2) - (2)].statements)); FBE::Package::root->initialize(); }
    break;

  case 3:
/* Line 1792 of yacc.c  */
#line 78 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { FBE::Package::root.reset((yyvsp[(1) - (3)].package)); FBE::Package::root->import.reset((yyvsp[(2) - (3)].import)); FBE::Package::root->body.reset((yyvsp[(3) - (3)].statements)); FBE::Package::root->initialize(); }
    break;

  case 4:
/* Line 1792 of yacc.c  */
#line 82 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.package) = new FBE::Package(0); (yyval.package)->name.reset((yyvsp[(2) - (2)].string)); }
    break;

  case 5:
/* Line 1792 of yacc.c  */
#line 83 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.package) = new FBE::Package(std::stoi(*(yyvsp[(4) - (4)].string))); delete (yyvsp[(4) - (4)].string); (yyval.package)->name.reset((yyvsp[(2) - (4)].string)); }
    break;

  case 6:
/* Line 1792 of yacc.c  */
#line 87 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.import) = new FBE::Import(); (yyval.import)->AddImport((yyvsp[(2) - (2)].string)); }
    break;

  case 7:
/* Line 1792 of yacc.c  */
#line 88 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.import) = (yyvsp[(1) - (3)].import); (yyval.import)->AddImport((yyvsp[(3) - (3)].string)); }
    break;

  case 9:
/* Line 1792 of yacc.c  */
#line 96 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.statements) = new FBE::Statements(); (yyval.statements)->AddStatement((yyvsp[(1) - (1)].statement)); }
    break;

  case 10:
/* Line 1792 of yacc.c  */
#line 97 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.statements) = (yyvsp[(1) - (2)].statements); (yyval.statements)->AddStatement((yyvsp[(2) - (2)].statement)); }
    break;

  case 11:
/* Line 1792 of yacc.c  */
#line 101 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.statement) = new FBE::Statement(); (yyval.statement)->e.reset((yyvsp[(1) - (1)].enum_type)); }
    break;

  case 12:
/* Line 1792 of yacc.c  */
#line 102 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.statement) = new FBE::Statement(); (yyval.statement)->f.reset((yyvsp[(1) - (1)].flags_type)); }
    break;

  case 13:
/* Line 1792 of yacc.c  */
#line 103 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.statement) = new FBE::Statement(); (yyval.statement)->s.reset((yyvsp[(1) - (1)].struct_type)); }
    break;

  case 14:
/* Line 1792 of yacc.c  */
#line 107 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.enum_type) = new FBE::EnumType(); (yyval.enum_type)->name.reset((yyvsp[(2) - (5)].string)); (yyval.enum_type)->body.reset((yyvsp[(4) - (5)].enum_body)); }
    break;

  case 15:
/* Line 1792 of yacc.c  */
#line 108 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.enum_type) = new FBE::EnumType(); (yyval.enum_type)->name.reset((yyvsp[(2) - (7)].string)); (yyval.enum_type)->base.reset((yyvsp[(4) - (7)].string)); (yyval.enum_type)->body.reset((yyvsp[(6) - (7)].enum_body)); }
    break;

  case 27:
/* Line 1792 of yacc.c  */
#line 126 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.enum_body) = new FBE::EnumBody(); (yyval.enum_body)->AddValue((yyvsp[(1) - (1)].enum_value)); }
    break;

  case 28:
/* Line 1792 of yacc.c  */
#line 127 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.enum_body) = (yyvsp[(1) - (2)].enum_body); (yyval.enum_body)->AddValue((yyvsp[(2) - (2)].enum_value)); }
    break;

  case 29:
/* Line 1792 of yacc.c  */
#line 130 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.enum_value) = new FBE::EnumValue(); (yyval.enum_value)->name.reset((yyvsp[(1) - (2)].string)); }
    break;

  case 30:
/* Line 1792 of yacc.c  */
#line 131 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.enum_value) = new FBE::EnumValue(); (yyval.enum_value)->name.reset((yyvsp[(1) - (4)].string)); (yyval.enum_value)->value.reset((yyvsp[(3) - (4)].enum_const)); }
    break;

  case 31:
/* Line 1792 of yacc.c  */
#line 135 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.enum_const) = new FBE::EnumConst(); (yyval.enum_const)->constant.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 32:
/* Line 1792 of yacc.c  */
#line 136 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.enum_const) = new FBE::EnumConst(); (yyval.enum_const)->constant.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 33:
/* Line 1792 of yacc.c  */
#line 137 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.enum_const) = new FBE::EnumConst(); (yyval.enum_const)->reference.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 34:
/* Line 1792 of yacc.c  */
#line 141 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.flags_type) = new FBE::FlagsType(); (yyval.flags_type)->name.reset((yyvsp[(2) - (5)].string)); (yyval.flags_type)->body.reset((yyvsp[(4) - (5)].flags_body)); }
    break;

  case 35:
/* Line 1792 of yacc.c  */
#line 142 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.flags_type) = new FBE::FlagsType(); (yyval.flags_type)->name.reset((yyvsp[(2) - (7)].string)); (yyval.flags_type)->base.reset((yyvsp[(4) - (7)].string)); (yyval.flags_type)->body.reset((yyvsp[(6) - (7)].flags_body)); }
    break;

  case 45:
/* Line 1792 of yacc.c  */
#line 158 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.flags_body) = new FBE::FlagsBody(); (yyval.flags_body)->AddValue((yyvsp[(1) - (1)].flags_value)); }
    break;

  case 46:
/* Line 1792 of yacc.c  */
#line 159 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.flags_body) = (yyvsp[(1) - (2)].flags_body); (yyval.flags_body)->AddValue((yyvsp[(2) - (2)].flags_value)); }
    break;

  case 47:
/* Line 1792 of yacc.c  */
#line 163 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.flags_value) = new FBE::FlagsValue(); (yyval.flags_value)->name.reset((yyvsp[(1) - (4)].string)); (yyval.flags_value)->value.reset((yyvsp[(3) - (4)].flags_const)); }
    break;

  case 48:
/* Line 1792 of yacc.c  */
#line 167 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.flags_const) = new FBE::FlagsConst(); (yyval.flags_const)->constant.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 49:
/* Line 1792 of yacc.c  */
#line 168 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.flags_const) = new FBE::FlagsConst(); (yyval.flags_const)->reference.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 50:
/* Line 1792 of yacc.c  */
#line 169 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.flags_const) = (yyvsp[(3) - (3)].flags_const); *(yyval.flags_const)->reference = *(yyvsp[(1) - (3)].string) + " | " + *(yyvsp[(3) - (3)].flags_const)->reference; delete (yyvsp[(1) - (3)].string); }
    break;

  case 51:
/* Line 1792 of yacc.c  */
#line 173 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_type) = new FBE::StructType(0, false); (yyval.struct_type)->name.reset((yyvsp[(2) - (5)].string)); (yyval.struct_type)->body.reset((yyvsp[(4) - (5)].struct_body)); }
    break;

  case 52:
/* Line 1792 of yacc.c  */
#line 174 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_type) = new FBE::StructType(0, false); (yyval.struct_type)->name.reset((yyvsp[(2) - (7)].string)); (yyval.struct_type)->base.reset((yyvsp[(4) - (7)].string)); (yyval.struct_type)->body.reset((yyvsp[(6) - (7)].struct_body)); }
    break;

  case 53:
/* Line 1792 of yacc.c  */
#line 175 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_type) = new FBE::StructType(std::stoi(*(yyvsp[(4) - (7)].string)), false); delete (yyvsp[(4) - (7)].string); (yyval.struct_type)->name.reset((yyvsp[(2) - (7)].string)); (yyval.struct_type)->body.reset((yyvsp[(6) - (7)].struct_body)); }
    break;

  case 54:
/* Line 1792 of yacc.c  */
#line 176 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_type) = new FBE::StructType(std::stoi(*(yyvsp[(4) - (9)].string)), false); delete (yyvsp[(4) - (9)].string); (yyval.struct_type)->name.reset((yyvsp[(2) - (9)].string)); (yyval.struct_type)->base.reset((yyvsp[(6) - (9)].string)); (yyval.struct_type)->body.reset((yyvsp[(8) - (9)].struct_body)); }
    break;

  case 55:
/* Line 1792 of yacc.c  */
#line 177 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_type) = new FBE::StructType(std::stoi(*(yyvsp[(5) - (8)].string)), true); delete (yyvsp[(5) - (8)].string); (yyval.struct_type)->name.reset((yyvsp[(2) - (8)].string)); (yyval.struct_type)->body.reset((yyvsp[(7) - (8)].struct_body)); }
    break;

  case 56:
/* Line 1792 of yacc.c  */
#line 178 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_type) = new FBE::StructType(std::stoi(*(yyvsp[(5) - (10)].string)), true); delete (yyvsp[(5) - (10)].string); (yyval.struct_type)->name.reset((yyvsp[(2) - (10)].string)); (yyval.struct_type)->base.reset((yyvsp[(7) - (10)].string)); (yyval.struct_type)->body.reset((yyvsp[(9) - (10)].struct_body)); }
    break;

  case 57:
/* Line 1792 of yacc.c  */
#line 182 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_body) = new FBE::StructBody(); (yyval.struct_body)->AddField((yyvsp[(1) - (1)].struct_field)); }
    break;

  case 58:
/* Line 1792 of yacc.c  */
#line 183 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_body) = (yyvsp[(1) - (2)].struct_body); (yyval.struct_body)->AddField((yyvsp[(2) - (2)].struct_field)); }
    break;

  case 59:
/* Line 1792 of yacc.c  */
#line 187 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = (yyvsp[(1) - (3)].struct_field); (yyval.struct_field)->name.reset((yyvsp[(2) - (3)].string)); }
    break;

  case 60:
/* Line 1792 of yacc.c  */
#line 188 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = (yyvsp[(1) - (5)].struct_field); (yyval.struct_field)->name.reset((yyvsp[(2) - (5)].string)); (yyval.struct_field)->value.reset((yyvsp[(4) - (5)].string)); }
    break;

  case 61:
/* Line 1792 of yacc.c  */
#line 189 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = (yyvsp[(4) - (6)].struct_field); (yyval.struct_field)->keys = true; (yyval.struct_field)->name.reset((yyvsp[(5) - (6)].string)); }
    break;

  case 62:
/* Line 1792 of yacc.c  */
#line 190 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = (yyvsp[(4) - (8)].struct_field); (yyval.struct_field)->keys = true; (yyval.struct_field)->name.reset((yyvsp[(5) - (8)].string)); (yyval.struct_field)->value.reset((yyvsp[(7) - (8)].string)); }
    break;

  case 71:
/* Line 1792 of yacc.c  */
#line 205 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 72:
/* Line 1792 of yacc.c  */
#line 206 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 73:
/* Line 1792 of yacc.c  */
#line 207 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 74:
/* Line 1792 of yacc.c  */
#line 208 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 75:
/* Line 1792 of yacc.c  */
#line 209 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 76:
/* Line 1792 of yacc.c  */
#line 210 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 77:
/* Line 1792 of yacc.c  */
#line 211 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 78:
/* Line 1792 of yacc.c  */
#line 212 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 79:
/* Line 1792 of yacc.c  */
#line 213 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 80:
/* Line 1792 of yacc.c  */
#line 214 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 81:
/* Line 1792 of yacc.c  */
#line 215 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 82:
/* Line 1792 of yacc.c  */
#line 216 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 83:
/* Line 1792 of yacc.c  */
#line 217 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 84:
/* Line 1792 of yacc.c  */
#line 218 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 85:
/* Line 1792 of yacc.c  */
#line 219 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 86:
/* Line 1792 of yacc.c  */
#line 220 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 87:
/* Line 1792 of yacc.c  */
#line 221 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 88:
/* Line 1792 of yacc.c  */
#line 222 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 89:
/* Line 1792 of yacc.c  */
#line 223 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 90:
/* Line 1792 of yacc.c  */
#line 224 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = new FBE::StructField(); (yyval.struct_field)->type.reset((yyvsp[(1) - (1)].string)); }
    break;

  case 91:
/* Line 1792 of yacc.c  */
#line 228 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = (yyvsp[(1) - (2)].struct_field); (yyval.struct_field)->optional = true; }
    break;

  case 92:
/* Line 1792 of yacc.c  */
#line 232 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = (yyvsp[(1) - (4)].struct_field); (yyval.struct_field)->array = true; (yyval.struct_field)->SetArraySize(std::stoi(*(yyvsp[(3) - (4)].string))); delete (yyvsp[(3) - (4)].string); }
    break;

  case 93:
/* Line 1792 of yacc.c  */
#line 233 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = (yyvsp[(1) - (4)].struct_field); (yyval.struct_field)->array = true; (yyval.struct_field)->SetArraySize(std::stoi(*(yyvsp[(3) - (4)].string))); delete (yyvsp[(3) - (4)].string); }
    break;

  case 94:
/* Line 1792 of yacc.c  */
#line 237 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = (yyvsp[(1) - (3)].struct_field); (yyval.struct_field)->vector = true; }
    break;

  case 95:
/* Line 1792 of yacc.c  */
#line 238 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = (yyvsp[(1) - (3)].struct_field); (yyval.struct_field)->vector = true; }
    break;

  case 96:
/* Line 1792 of yacc.c  */
#line 242 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = (yyvsp[(1) - (3)].struct_field); (yyval.struct_field)->list = true; }
    break;

  case 97:
/* Line 1792 of yacc.c  */
#line 243 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = (yyvsp[(1) - (3)].struct_field); (yyval.struct_field)->list = true; }
    break;

  case 98:
/* Line 1792 of yacc.c  */
#line 247 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = (yyvsp[(1) - (2)].struct_field); (yyval.struct_field)->set = true; (yyval.struct_field)->key = (yyvsp[(1) - (2)].struct_field)->type; }
    break;

  case 99:
/* Line 1792 of yacc.c  */
#line 251 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = (yyvsp[(1) - (4)].struct_field); (yyval.struct_field)->map = true; (yyval.struct_field)->key = (yyvsp[(3) - (4)].struct_field)->type; delete (yyvsp[(3) - (4)].struct_field); }
    break;

  case 100:
/* Line 1792 of yacc.c  */
#line 252 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = (yyvsp[(1) - (4)].struct_field); (yyval.struct_field)->map = true; (yyval.struct_field)->key = (yyvsp[(3) - (4)].struct_field)->type; delete (yyvsp[(3) - (4)].struct_field); }
    break;

  case 101:
/* Line 1792 of yacc.c  */
#line 256 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = (yyvsp[(1) - (4)].struct_field); (yyval.struct_field)->hash = true; (yyval.struct_field)->key = (yyvsp[(3) - (4)].struct_field)->type; delete (yyvsp[(3) - (4)].struct_field); }
    break;

  case 102:
/* Line 1792 of yacc.c  */
#line 257 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { (yyval.struct_field) = (yyvsp[(1) - (4)].struct_field); (yyval.struct_field)->hash = true; (yyval.struct_field)->key = (yyvsp[(3) - (4)].struct_field)->type; delete (yyvsp[(3) - (4)].struct_field); }
    break;

  case 114:
/* Line 1792 of yacc.c  */
#line 272 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { *(yyval.string) = *(yyvsp[(1) - (3)].string) + " | " + *(yyvsp[(3) - (3)].string); delete (yyvsp[(3) - (3)].string); }
    break;

  case 116:
/* Line 1792 of yacc.c  */
#line 277 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"
    { *(yyval.string) = *(yyvsp[(1) - (3)].string) + "." + *(yyvsp[(3) - (3)].string); delete (yyvsp[(3) - (3)].string); }
    break;


/* Line 1792 of yacc.c  */
#line 2202 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe-parser.cpp"
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;
  *++yylsp = yyloc;

  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }

  yyerror_range[1] = yylloc;

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval, &yylloc);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  yyerror_range[1] = yylsp[1-yylen];
  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;

      yyerror_range[1] = *yylsp;
      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp, yylsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  yyerror_range[2] = yylloc;
  /* Using YYLLOC is tempting, but would change the location of
     the lookahead.  YYLOC is available though.  */
  YYLLOC_DEFAULT (yyloc, yyerror_range, 2);
  *++yylsp = yyloc;

  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval, &yylloc);
    }
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp, yylsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


/* Line 2055 of yacc.c  */
#line 280 "Z:/projects/CppProjects/FastBinaryEncoding/source/fbe.y"

