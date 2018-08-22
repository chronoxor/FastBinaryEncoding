D [0-9]
L [a-zA-Z_]
H [a-fA-F0-9]
E [Ee][+-]?{D}+

%{

#include "fbe.h"
#include "fbe-parser.hpp"
#include "generator_cpp.h"
#include "generator_csharp.h"
#include "generator_java.h"
#include "generator_javascript.h"
#include "generator_python.h"

#include <OptionParser.h>

void yycount();
int yychar(char c);
int yytoken(int t);
int yystring(int s);
int yyerror(const char* msg);
int yyerror(const std::string& msg);

%}

%option noinput
%option nounput
%option noyywrap
%option yylineno

%%

"//"[^\n]*              { /* Single line comment */ }
"/*"[^*]*|[*]*"*/"      { /* Multilines comment */ }

"package"               { yycount(); return yytoken(PACKAGE); }
"offset"                { yycount(); return yytoken(OFFSET); }
"import"                { yycount(); return yytoken(IMPORT); }
"enum"                  { yycount(); return yytoken(ENUM); }
"flags"                 { yycount(); return yytoken(FLAGS); }
"struct"                { yycount(); return yytoken(STRUCT); }
"key"                   { yycount(); return yytoken(KEY); }

"bool"                  { yycount(); return yystring(BOOL); }
"byte"                  { yycount(); return yystring(BYTE); }
"bytes"                 { yycount(); return yystring(BYTES); }
"char"                  { yycount(); return yystring(CHAR); }
"wchar"                 { yycount(); return yystring(WCHAR); }
"int8"                  { yycount(); return yystring(INT8); }
"uint8"                 { yycount(); return yystring(UINT8); }
"int16"                 { yycount(); return yystring(INT16); }
"uint16"                { yycount(); return yystring(UINT16); }
"int32"                 { yycount(); return yystring(INT32); }
"uint32"                { yycount(); return yystring(UINT32); }
"int64"                 { yycount(); return yystring(INT64); }
"uint64"                { yycount(); return yystring(UINT64); }
"float"                 { yycount(); return yystring(FLOAT); }
"double"                { yycount(); return yystring(DOUBLE); }
"decimal"               { yycount(); return yystring(DECIMAL); }
"string"                { yycount(); return yystring(STRING); }
"timestamp"             { yycount(); return yystring(TIMESTAMP); }
"uuid"                  { yycount(); return yystring(UUID); }

"true"                  { yycount(); return yystring(CONST_TRUE); }
"false"                 { yycount(); return yystring(CONST_FALSE); }
"null"                  { yycount(); return yystring(CONST_NULL); }
"utc"                   { yycount(); return yystring(CONST_UTC); }
"uuid1"                 { yycount(); return yystring(CONST_UUID1); }
"uuid4"                 { yycount(); return yystring(CONST_UUID4); }

'(\\.|[^\\'])+'         { yycount(); return yystring(CONST_CHAR); }
[+-]?0[xX]{H}+          { yycount(); return yystring(CONST_INT); }
[+-]?0{D}+              { yycount(); return yystring(CONST_INT); }
[+-]?{D}+               { yycount(); return yystring(CONST_INT); }
[+-]?{D}+{E}            { yycount(); return yystring(CONST_FLOAT); }
[+-]?{D}*"."{D}+({E})?  { yycount(); return yystring(CONST_FLOAT); }
[+-]?{D}+"."{D}*({E})?  { yycount(); return yystring(CONST_FLOAT); }
\"(\\.|[^\\"\n])*\"     { yycount(); return yystring(CONST_STRING); }

{L}({L}|{D})*           { yycount(); return yystring(IDENTIFIER); }

"."                     { yycount(); return yychar('.'); }
":"                     { yycount(); return yychar(':'); }
";"                     { yycount(); return yychar(';'); }
"="                     { yycount(); return yychar('='); }
"|"                     { yycount(); return yychar('|'); }
"!"                     { yycount(); return yychar('!'); }
"?"                     { yycount(); return yychar('?'); }
"("                     { yycount(); return yychar('('); }
")"                     { yycount(); return yychar(')'); }
"["                     { yycount(); return yychar('['); }
"]"                     { yycount(); return yychar(']'); }
"<"                     { yycount(); return yychar('<'); }
">"                     { yycount(); return yychar('>'); }
"{"                     { yycount(); return yychar('{'); }
"}"                     { yycount(); return yychar('}'); }

[ \t\n\r\b\v\f]         { yycount(); }

.                       { yycount(); yyerror("Unknown token!"); }

%%

int yycolumn = 0;
std::string yyfile;
std::string yyline;

void yycount()
{
    for (int i = 0; yytext[i] != '\0'; ++i)
    {
        yyline += yytext[i];
        if (yytext[i] == '\n')
        {
            yycolumn = 0;
            yyline.clear();
        }
        else if (yytext[i] == '\t')
            yycolumn += 8 - (yycolumn % 8);
        else
            ++yycolumn;
    }
}

int yychar(char c)
{
    return c;
}

int yytoken(int t)
{
    yylval.token = t;
    return t;
}

int yystring(int s)
{
    yylval.string = new std::string(yytext, yyleng);
    return s;
}

int yyerror(const char* msg)
{
    if (yyfile.empty())
        yyfile = "<stdin>";
    fprintf(stderr, "\n%s:%d: error: %s\n", yyfile.c_str(), yylineno, msg);
    fprintf(stderr, "%s\n", yyline.c_str());
    fprintf(stderr, "%*s--- %s\n", yycolumn, "^", msg);
    yyterminate();
    return -1;
}

int yyerror(const std::string& msg)
{
    return yyerror(msg.c_str());
}

extern int yyparse();

int main(int argc, char** argv)
{
    auto parser = optparse::OptionParser().version("1.0.0.0");

    parser.add_option("-h", "--help").help("Show help");
    parser.add_option("-i", "--input").help("Input path");
    parser.add_option("-o", "--output").help("Output path");
    parser.add_option("-q", "--quiet").action("store_true").help("Launch in quiet mode. No progress will be shown!");
    parser.add_option("-n", "--indent").action("store").type("int").set_default(0).help("Format indent. Default: %default");
    parser.add_option("-t", "--tabs").action("store_true").set_default(0).help("Format with tabs. Default: off");
    parser.add_option("--cpp").action("store_true").set_default(0).help("Generate C++ code");
    parser.add_option("--csharp").action("store_true").set_default(0).help("Generate C# code");
    parser.add_option("--java").action("store_true").set_default(0).help("Generate Java code");
    parser.add_option("--javascript").action("store_true").set_default(0).help("Generate JavaScript code");
    parser.add_option("--python").action("store_true").set_default(0).help("Generate Python code");
    parser.add_option("--final").action("store_true").set_default(0).help("Generate Final protocol code");
    parser.add_option("--json").action("store_true").set_default(0).help("Generate JSON protocol code");

    optparse::Values options = parser.parse_args(argc, argv);

    // Print help
    if (options.get("help"))
    {
        parser.print_help();
        return 0;
    }

    // Client parameters
    std::string directory;
    std::string input(options.get("input"));
    std::string output(options.get("output"));
    int indent = options.get("indent");
    bool tabs = options.get("tabs");
    bool quiet = options.get("quiet");
    bool cpp = options.get("cpp");
    bool csharp = options.get("csharp");
    bool java = options.get("java");
    bool javascript = options.get("javascript");
    bool python = options.get("python");
    bool final = options.get("final");
    bool json = options.get("json");
    char space = tabs ? '\t' : ' ';

    // Check for the input path
    if (input.empty())
    {
        std::cerr << "Input path is not provided!" << std::endl;
        parser.print_help();
        return -1;
    }

    // Check for the output path
    if (output.empty())
    {
        std::cerr << "Output path is not provided!" << std::endl;
        parser.print_help();
        return -1;
    }

    // Open the input file
    if (!quiet) std::cout << "Open input file - " + input + "...";

    CppCommon::File file(input);

    // Check if the input file exist
    if (!file.IsFileExists())
        yyerror("Input file not exist - " + input);

    // Decompose the parent directory
    directory = file.parent().string();

    // Open the input file
    FILE* in = fopen(input.c_str(), "r");

    // Setup the lexical parser input
    yyfile = input;
    yyset_in(in);

    if (!quiet) std::cout << "Done!" << std::endl;

    // Parse the input
    if (!quiet) std::cout << "Parsing input...";
    yyparse();
    if (!quiet) std::cout << "Done!" << std::endl;

    // Close the input file
    if (!input.empty())
    {
        if (!quiet) std::cout << "Close input file...";
        fclose(yyget_in());
        if (!quiet) std::cout << "Done!" << std::endl;
    }

    // Generate the output
    if (cpp)
    {
        if (!quiet) std::cout << "Generating C++ code...";
        FBE::GeneratorCpp(output, (indent ? indent : 4), space).Final(final).JSON(json).Generate(FBE::Package::root);
        if (!quiet) std::cout << "Done!" << std::endl;
    }
    if (csharp)
    {
        if (!quiet) std::cout << "Generating C# code...";
        FBE::GeneratorCSharp(output, (indent ? indent : 4), space).Final(final).JSON(json).Generate(FBE::Package::root);
        if (!quiet) std::cout << "Done!" << std::endl;
    }
    if (java)
    {
        if (!quiet) std::cout << "Generating Java code...";
        FBE::GeneratorJava(output, (indent ? indent : 4), space).Final(final).JSON(json).Generate(FBE::Package::root);
        if (!quiet) std::cout << "Done!" << std::endl;
    }
    if (javascript)
    {
        if (!quiet) std::cout << "Generating JavaScript code...";
        FBE::GeneratorJavaScript(output, (indent ? indent : 2), space).Final(final).JSON(json).Generate(FBE::Package::root);
        if (!quiet) std::cout << "Done!" << std::endl;
    }
    if (python)
    {
        if (!quiet) std::cout << "Generating Python code...";
        FBE::GeneratorPython(output, (indent ? indent : 4), space).Final(final).JSON(json).Generate(FBE::Package::root);
        if (!quiet) std::cout << "Done!" << std::endl;
    }

    // Destroy the lexical parser
    yylex_destroy();

    return 0;
}
