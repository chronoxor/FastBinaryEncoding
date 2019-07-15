D [0-9]
L [a-zA-Z_]
H [a-fA-F0-9]
E [Ee][+-]?{D}+

%{

#include "fbe.h"
#include "fbe-parser.hpp"
#include "generator_cpp.h"
#include "generator_csharp.h"
#include "generator_go.h"
#include "generator_java.h"
#include "generator_javascript.h"
#include "generator_kotlin.h"
#include "generator_python.h"
#include "generator_ruby.h"

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

"domain"                { yycount(); return yytoken(PDOMAIN); }
"package"               { yycount(); return yytoken(PACKAGE); }
"offset"                { yycount(); return yytoken(OFFSET); }
"import"                { yycount(); return yytoken(IMPORT); }
"version"               { yycount(); return yytoken(VERSION); }
"enum"                  { yycount(); return yytoken(ENUM); }
"flags"                 { yycount(); return yytoken(FLAGS); }
"struct"                { yycount(); return yytoken(STRUCT); }
"base"                  { yycount(); return yytoken(BASE); }
"[id]"                  { yycount(); return yytoken(ID); }
"[key]"                 { yycount(); return yytoken(KEY); }
"[hidden]"              { yycount(); return yytoken(HIDDEN); }
"[deprecated]"          { yycount(); return yytoken(DEPRECATED); }
"request"               { yycount(); return yytoken(REQ); }
"response"              { yycount(); return yytoken(RES); }
"reject"                { yycount(); return yytoken(REJ); }

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
"epoch"                 { yycount(); return yystring(CONST_EPOCH); }
"utc"                   { yycount(); return yystring(CONST_UTC); }
"uuid0"                 { yycount(); return yystring(CONST_UUID0); }
"uuid1"                 { yycount(); return yystring(CONST_UUID1); }
"uuid4"                 { yycount(); return yystring(CONST_UUID4); }

'(\\.|[^\\'])+'         { yycount(); return yystring(CONST_CHAR); }
[-]?0[xX]{H}+           { yycount(); return yystring(CONST_INT); }
[-]?0{D}+               { yycount(); return yystring(CONST_INT); }
[-]?{D}+                { yycount(); return yystring(CONST_INT); }
[-]?{D}+{E}             { yycount(); return yystring(CONST_FLOAT); }
[-]?{D}*"."{D}+({E})?   { yycount(); return yystring(CONST_FLOAT); }
[-]?{D}+"."{D}*({E})?   { yycount(); return yystring(CONST_FLOAT); }
\"(\\.|[^\\"\n])*\"     { yycount(); return yystring(CONST_STRING); }

{L}({L}|{D})*           { yycount(); return yystring(IDENTIFIER); }

","                     { yycount(); return yychar(','); }
"."                     { yycount(); return yychar('.'); }
":"                     { yycount(); return yychar(':'); }
";"                     { yycount(); return yychar(';'); }
"+"                     { yycount(); return yychar('+'); }
"*"                     { yycount(); return yychar('*'); }
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
    auto parser = optparse::OptionParser().version(FBE::version);

    parser.add_option("-i", "--input").dest("input").help("Input path");
    parser.add_option("-o", "--output").dest("output").help("Output path");
    parser.add_option("-q", "--quiet").dest("quiet").action("store_true").help("Launch in quiet mode. No progress will be shown!");
    parser.add_option("-n", "--indent").dest("indent").action("store").type("int").set_default(0).help("Format indent. Default: %default");
    parser.add_option("-t", "--tabs").dest("tabs").action("store_true").set_default(0).help("Format with tabs. Default: off");
    parser.add_option("--cpp").dest("cpp").action("store_true").set_default(0).help("Generate C++ code");
    parser.add_option("--cpp-logging").dest("cpp-logging").action("store_true").set_default(0).help("Generate C++ logging code");
    parser.add_option("--csharp").dest("csharp").action("store_true").set_default(0).help("Generate C# code");
    parser.add_option("--go").dest("go").action("store_true").set_default(0).help("Generate Go code");
    parser.add_option("--java7").dest("java7").action("store_true").set_default(0).help("Generate Java code (old Java 7 for Android)");
    parser.add_option("--java").dest("java").action("store_true").set_default(0).help("Generate Java code");
    parser.add_option("--javascript").dest("javascript").action("store_true").set_default(0).help("Generate JavaScript code");
    parser.add_option("--kotlin7").dest("kotlin7").action("store_true").set_default(0).help("Generate Kotlin code (old Java 7 for Android)");
    parser.add_option("--kotlin").dest("kotlin").action("store_true").set_default(0).help("Generate Kotlin code");
    parser.add_option("--python").dest("python").action("store_true").set_default(0).help("Generate Python code");
    parser.add_option("--ruby").dest("ruby").action("store_true").set_default(0).help("Generate Ruby code");
    parser.add_option("--final").dest("final").action("store_true").set_default(0).help("Generate Final serialization code");
    parser.add_option("--json").dest("json").action("store_true").set_default(0).help("Generate JSON serialization code");
    parser.add_option("--proto").dest("proto").action("store_true").set_default(0).help("Generate Sender/Receiver protocol code");

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
    bool cpp_logging = options.get("cpp-logging");
    bool csharp = options.get("csharp");
    bool go = options.get("go");
    bool java = options.get("java");
    bool java7 = options.get("java7");
    bool javascript = options.get("javascript");
    bool kotlin = options.get("kotlin");
    bool kotlin7 = options.get("kotlin7");
    bool python = options.get("python");
    bool ruby = options.get("ruby");
    bool final = options.get("final");
    bool json = options.get("json");
    bool proto = options.get("proto");
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
        FBE::GeneratorCpp(input, output, (indent ? indent : 4), space).Final(final).JSON(json).Proto(proto).Logging(cpp_logging).Generate(FBE::Package::root);
        if (!quiet) std::cout << "Done!" << std::endl;
    }
    if (csharp)
    {
        if (!quiet) std::cout << "Generating C# code...";
        FBE::GeneratorCSharp(input, output, (indent ? indent : 4), space).Final(final).JSON(json).Proto(proto).Generate(FBE::Package::root);
        if (!quiet) std::cout << "Done!" << std::endl;
    }
    if (go)
    {
        if (!quiet) std::cout << "Generating Go code...";
        FBE::GeneratorGo(input, output, (indent ? indent : 4), space).Final(final).JSON(json).Proto(proto).Generate(FBE::Package::root);
        if (!quiet) std::cout << "Done!" << std::endl;
    }
    if (java || java7)
    {
        if (!quiet) std::cout << "Generating Java code...";
        FBE::GeneratorJava(input, output, (indent ? indent : 4), space).Final(final).JSON(json).Proto(proto).Version(java7 ? 7 : 8).Generate(FBE::Package::root);
        if (!quiet) std::cout << "Done!" << std::endl;
    }
    if (javascript)
    {
        if (!quiet) std::cout << "Generating JavaScript code...";
        FBE::GeneratorJavaScript(input, output, (indent ? indent : 2), space).Final(final).JSON(json).Proto(proto).Generate(FBE::Package::root);
        if (!quiet) std::cout << "Done!" << std::endl;
    }
    if (kotlin || kotlin7)
    {
        if (!quiet) std::cout << "Generating Kotlin code...";
        FBE::GeneratorKotlin(input, output, (indent ? indent : 4), space).Final(final).JSON(json).Proto(proto).Version(kotlin7 ? 7 : 8).Generate(FBE::Package::root);
        if (!quiet) std::cout << "Done!" << std::endl;
    }
    if (python)
    {
        if (!quiet) std::cout << "Generating Python code...";
        FBE::GeneratorPython(input, output, (indent ? indent : 4), space).Final(final).JSON(json).Proto(proto).Generate(FBE::Package::root);
        if (!quiet) std::cout << "Done!" << std::endl;
    }
    if (ruby)
    {
        if (!quiet) std::cout << "Generating Ruby code...";
        FBE::GeneratorRuby(input, output, (indent ? indent : 2), space).Final(final).JSON(json).Proto(proto).Generate(FBE::Package::root);
        if (!quiet) std::cout << "Done!" << std::endl;
    }

    // Destroy the lexical parser
    yylex_destroy();

    return 0;
}
