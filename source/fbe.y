%{

#include "fbe.h"

int yylex(void);
int yyerror(const char* msg);
int yyerror(const std::string& msg);

%}

// Support locations
%locations

// Represents the many different ways we can access our data
%union
{
    int token;
    bool boolean;
    std::string* string;
    FBE::Package* package;
    FBE::Import* import;
    FBE::Version* version;
    FBE::Attributes* attributes;
    FBE::Attributes* attribute;
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
    FBE::StructRequest* struct_request;
    FBE::StructResponse* struct_response;
    FBE::StructRejects* struct_rejects;
    FBE::StructBody* struct_body;
    FBE::StructField* struct_field;
}

// Define our terminal symbols (tokens)
%token <token>  PDOMAIN PACKAGE OFFSET IMPORT VERSION ENUM FLAGS STRUCT MESSAGE BASE ID KEY HIDDEN DEPRECATED REQ RES REJ
%token <string> BOOL BYTE BYTES CHAR WCHAR INT8 UINT8 INT16 UINT16 INT32 UINT32 INT64 UINT64 FLOAT DOUBLE DECIMAL STRING USTRING TIMESTAMP UUID
%token <string> CONST_TRUE CONST_FALSE CONST_NULL CONST_EPOCH CONST_UTC CONST_UUID0 CONST_UUID1 CONST_UUID4 CONST_CHAR CONST_INT CONST_FLOAT CONST_STRING
%token <string> IDENTIFIER

%type <string> name
%type <string> domain
%type <package> package
%type <import> import
%type <version> version
%type <string> package_name
%type <attributes> attributes
%type <attribute> attribute
%type <statements> statements
%type <statement> statement
%type <enum_type> enum
%type <string> enum_type
%type <enum_body> enum_body
%type <enum_value> enum_value
%type <enum_const> enum_const
%type <flags_type> flags
%type <string> flags_type
%type <flags_body> flags_body
%type <flags_value> flags_value
%type <flags_const> flags_const
%type <struct_type> struct
%type <boolean> struct_type
%type <struct_request> struct_request
%type <struct_response> struct_response
%type <struct_rejects> struct_rejects
%type <struct_rejects> struct_reject
%type <struct_body> struct_body
%type <struct_field> struct_field
%type <struct_field> struct_field_type
%type <struct_field> struct_field_base
%type <struct_field> struct_field_optional
%type <struct_field> struct_field_reseter
%type <struct_field> struct_field_array
%type <struct_field> struct_field_vector
%type <struct_field> struct_field_list
%type <struct_field> struct_field_set
%type <struct_field> struct_field_map
%type <struct_field> struct_field_hash
%type <struct_field> struct_field_ptr
%type <string> struct_field_value
%type <string> type_name

%start fbe

%%

fbe
    : domain package version statements                                                     { FBE::Package::root.reset($2); FBE::Package::root->domain.reset($1); FBE::Package::root->version.reset($3); FBE::Package::root->body.reset($4); FBE::Package::root->initialize(); }
    | domain package version import statements                                              { FBE::Package::root.reset($2); FBE::Package::root->domain.reset($1); FBE::Package::root->version.reset($3); FBE::Package::root->import.reset($4); FBE::Package::root->body.reset($5); FBE::Package::root->initialize(); }
    ;

domain
    :                                                                                       { $$ = new std::string(); }
    | PDOMAIN type_name                                                                     { $$ = $2; }
    ;

package
    : PACKAGE package_name                                                                  { $$ = new FBE::Package(0); $$->name.reset($2); }
    | PACKAGE package_name OFFSET CONST_INT                                                 { $$ = new FBE::Package(std::stoi(*$4)); delete $4; $$->name.reset($2); }
    ;

package_name
    : name
    ;

version
    :                                                                                       { $$ = new FBE::Version(); }
    | VERSION CONST_FLOAT                                                                   { $$ = new FBE::Version(*$2); delete $2; }
    ;

import
    : IMPORT package_name                                                                   { $$ = new FBE::Import(); $$->AddImport($2); }
    | import IMPORT package_name                                                            { $$ = $1; $$->AddImport($3); }
    ;

statements
    :                                                                                       { $$ = new FBE::Statements(); }
    | statement                                                                             { $$ = new FBE::Statements(); $$->AddStatement($1); }
    | statements statement                                                                  { $$ = $1; $$->AddStatement($2); }
    ;

statement
    : enum                                                                                  { $$ = new FBE::Statement(); $$->e.reset($1); }
    | flags                                                                                 { $$ = new FBE::Statement(); $$->f.reset($1); }
    | struct                                                                                { $$ = new FBE::Statement(); $$->s.reset($1); }
    | struct_request struct_response struct_rejects struct                                  { $$ = new FBE::Statement(); $$->s.reset($4); $$->s->request.reset($1); $$->s->response.reset($2); $$->s->rejects.reset($3); }
    ;

attributes
    : attribute                                                                             { $$ = $1; }
    | attributes attribute                                                                  { $$ = $1; $$->Merge($2); }
    ;

attribute
    :                                                                                       { $$ = new FBE::Attributes(); }
    | HIDDEN                                                                                { $$ = new FBE::Attributes(); $$->hidden = true; }
    | DEPRECATED                                                                            { $$ = new FBE::Attributes(); $$->deprecated = true; }
    ;

enum
    : attributes ENUM name '{' enum_body '}'                                                { $$ = new FBE::EnumType(); $$->attributes.reset($1); $$->name.reset($3); $$->body.reset($5); }
    | attributes ENUM name ':' enum_type '{' enum_body '}'                                  { $$ = new FBE::EnumType(); $$->attributes.reset($1); $$->name.reset($3); $$->base.reset($5); $$->body.reset($7); }
    ;

enum_type
    : BYTE
    | CHAR
    | WCHAR
    | INT8
    | UINT8
    | INT16
    | UINT16
    | INT32
    | UINT32
    | INT64
    | UINT64
    ;

enum_body
    :                                                                                       { $$ = new FBE::EnumBody(); }
    | enum_value                                                                            { $$ = new FBE::EnumBody(); $$->AddValue($1); }
    | enum_body enum_value                                                                  { $$ = $1; $$->AddValue($2); }

enum_value
    : attributes name ';'                                                                   { $$ = new FBE::EnumValue(); $$->attributes.reset($1); $$->name.reset($2); }
    | attributes name '=' enum_const ';'                                                    { $$ = new FBE::EnumValue(); $$->attributes.reset($1); $$->name.reset($2); $$->value.reset($4); }
    ;

enum_const
    : CONST_CHAR                                                                            { $$ = new FBE::EnumConst(); $$->constant.reset($1); }
    | CONST_INT                                                                             { $$ = new FBE::EnumConst(); $$->constant.reset($1); }
    | name                                                                                  { $$ = new FBE::EnumConst(); $$->reference.reset($1); }
    ;

flags
    : attributes FLAGS name '{' flags_body '}'                                              { $$ = new FBE::FlagsType(); $$->attributes.reset($1); $$->name.reset($3); $$->body.reset($5); }
    | attributes FLAGS name ':' flags_type '{' flags_body '}'                               { $$ = new FBE::FlagsType(); $$->attributes.reset($1); $$->name.reset($3); $$->base.reset($5); $$->body.reset($7); }
    ;

flags_type
    : BYTE
    | INT8
    | UINT8
    | INT16
    | UINT16
    | INT32
    | UINT32
    | INT64
    | UINT64
    ;

flags_body
    :                                                                                       { $$ = new FBE::FlagsBody(); }
    | flags_value                                                                           { $$ = new FBE::FlagsBody(); $$->AddValue($1); }
    | flags_body flags_value                                                                { $$ = $1; $$->AddValue($2); }
    ;

flags_value
    : attributes name '=' flags_const ';'                                                   { $$ = new FBE::FlagsValue(); $$->attributes.reset($1); $$->name.reset($2); $$->value.reset($4); }
    ;

flags_const
    : CONST_INT                                                                             { $$ = new FBE::FlagsConst(); $$->constant.reset($1); }
    | name                                                                                  { $$ = new FBE::FlagsConst(); $$->reference.reset($1); }
    | name '|' flags_const                                                                  { $$ = $3; *$$->reference = *$1 + " | " + *$3->reference; delete $1; }
    ;

struct_request
    : '[' REQ ']'                                                                           { $$ = new FBE::StructRequest(); }
    ;

struct_response
    :                                                                                       { $$ = nullptr; }
    | '[' RES '(' type_name ')' ']'                                                         { $$ = new FBE::StructResponse(); $$->response.reset($4); }
    ;

struct_rejects
    :                                                                                       { $$ = nullptr; }
    | '[' REJ '(' struct_reject ')' ']'                                                     { $$ = $4; }
    ;

struct_reject
    : type_name                                                                             { $$ = new FBE::StructRejects(); $$->AddReject($1, false); }
    | '*' type_name                                                                         { $$ = new FBE::StructRejects(); $$->AddReject($2, true); }
    | struct_reject ',' type_name                                                           { $$ = $1; $$->AddReject($3, false); }
    ;

struct
    : attributes struct_type name '{' struct_body '}'                                       { $$ = new FBE::StructType(0, false); $$->attributes.reset($1); $$->message = $2; $$->name.reset($3); $$->body.reset($5); }
    | attributes struct_type name ':' type_name '{' struct_body '}'                         { $$ = new FBE::StructType(0, false); $$->attributes.reset($1); $$->message = $2; $$->name.reset($3); $$->base.reset($5); $$->body.reset($7); }
    | attributes struct_type name '(' '+' CONST_INT ')' '{' struct_body '}'                 { $$ = new FBE::StructType(std::stoi(*$6), false); delete $6; $$->attributes.reset($1); $$->message = $2; $$->name.reset($3); $$->body.reset($9); }
    | attributes struct_type name '(' '+' CONST_INT ')' ':' type_name '{' struct_body '}'   { $$ = new FBE::StructType(std::stoi(*$6), false); delete $6; $$->attributes.reset($1); $$->message = $2; $$->name.reset($3); $$->base.reset($9); $$->body.reset($11); }
    | attributes struct_type name '(' BASE ')' ':' type_name '{' struct_body '}'            { $$ = new FBE::StructType(0, true); $$->attributes.reset($1); $$->message = $2; $$->name.reset($3); $$->base.reset($8); $$->body.reset($10); }
    | attributes struct_type name '(' CONST_INT ')' '{' struct_body '}'                     { $$ = new FBE::StructType(std::stoi(*$5), true); delete $5; $$->attributes.reset($1); $$->message = $2; $$->name.reset($3); $$->body.reset($8); }
    | attributes struct_type name '(' CONST_INT ')' ':' type_name '{' struct_body '}'       { $$ = new FBE::StructType(std::stoi(*$5), true); delete $5; $$->attributes.reset($1); $$->message = $2; $$->name.reset($3); $$->base.reset($8); $$->body.reset($10); }
    ;

struct_type
    : STRUCT                                                                                { $$ = false; }
    | MESSAGE                                                                               { $$ = true; }

struct_body
    :                                                                                       { $$ = new FBE::StructBody(); }
    | struct_field                                                                          { $$ = new FBE::StructBody(); $$->AddField($1); }
    | struct_body struct_field                                                              { $$ = $1; $$->AddField($2); }
    ;

struct_field
    : attributes struct_field_type type_name ';'                                            { $$ = $2; $$->attributes.reset($1); $$->name.reset($3); }
    | attributes struct_field_type type_name '=' struct_field_value ';'                     { $$ = $2; $$->attributes.reset($1); $$->name.reset($3); $$->value.reset($5); }
    | attributes struct_field_type ID ';'                                                   { $$ = $2; $$->id = true; $$->attributes.reset($1); $$->name = std::make_shared<std::string>("id"); }
    | attributes struct_field_type ID '=' struct_field_value ';'                            { $$ = $2; $$->id = true; $$->attributes.reset($1); $$->name = std::make_shared<std::string>("id"); $$->value.reset($5); }
    | attributes KEY struct_field_type type_name ';'                                        { $$ = $3; $$->keys = true; $$->attributes.reset($1); $$->name.reset($4); }
    | attributes KEY struct_field_type type_name '=' struct_field_value ';'                 { $$ = $3; $$->keys = true; $$->attributes.reset($1); $$->name.reset($4); $$->value.reset($6); }
    ;

struct_field_type
    : struct_field_base
    | struct_field_optional
    | struct_field_reseter
    | struct_field_array
    | struct_field_vector
    | struct_field_list
    | struct_field_set
    | struct_field_map
    | struct_field_hash
    | struct_field_ptr
    ;

struct_field_base
    : BOOL                                                                                  { $$ = new FBE::StructField(); $$->type.reset($1); }
    | BYTE                                                                                  { $$ = new FBE::StructField(); $$->type.reset($1); }
    | BYTES                                                                                 { $$ = new FBE::StructField(); $$->type.reset($1); }
    | CHAR                                                                                  { $$ = new FBE::StructField(); $$->type.reset($1); }
    | WCHAR                                                                                 { $$ = new FBE::StructField(); $$->type.reset($1); }
    | INT8                                                                                  { $$ = new FBE::StructField(); $$->type.reset($1); }
    | UINT8                                                                                 { $$ = new FBE::StructField(); $$->type.reset($1); }
    | INT16                                                                                 { $$ = new FBE::StructField(); $$->type.reset($1); }
    | UINT16                                                                                { $$ = new FBE::StructField(); $$->type.reset($1); }
    | INT32                                                                                 { $$ = new FBE::StructField(); $$->type.reset($1); }
    | UINT32                                                                                { $$ = new FBE::StructField(); $$->type.reset($1); }
    | INT64                                                                                 { $$ = new FBE::StructField(); $$->type.reset($1); }
    | UINT64                                                                                { $$ = new FBE::StructField(); $$->type.reset($1); }
    | FLOAT                                                                                 { $$ = new FBE::StructField(); $$->type.reset($1); }
    | DOUBLE                                                                                { $$ = new FBE::StructField(); $$->type.reset($1); }
    | DECIMAL                                                                               { $$ = new FBE::StructField(); $$->type.reset($1); }
    | STRING                                                                                { $$ = new FBE::StructField(); $$->type.reset($1); }
    | TIMESTAMP                                                                             { $$ = new FBE::StructField(); $$->type.reset($1); }
    | UUID                                                                                  { $$ = new FBE::StructField(); $$->type.reset($1); }
    | type_name                                                                             { $$ = new FBE::StructField(); $$->type.reset($1); }
    ;

struct_field_optional
    : struct_field_base '?'                                                                 { $$ = $1; $$->optional = true; }
    ;

struct_field_reseter
    : struct_field_base '~'                                                                 { $$ = $1; $$->reseter = true; }
    ;

struct_field_array
    : struct_field_base '[' CONST_INT ']'                                                   { $$ = $1; $$->array = true; $$->SetArraySize(std::stoi(*$3)); delete $3; }
    | struct_field_optional '[' CONST_INT ']'                                               { $$ = $1; $$->array = true; $$->SetArraySize(std::stoi(*$3)); delete $3; }
    ;

struct_field_vector
    : struct_field_base '[' ']'                                                             { $$ = $1; $$->vector = true; }
    | struct_field_optional '[' ']'                                                         { $$ = $1; $$->vector = true; }
    ;

struct_field_list
    : struct_field_base '(' ')'                                                             { $$ = $1; $$->list = true; }
    | struct_field_optional '(' ')'                                                         { $$ = $1; $$->list = true; }
    ;

struct_field_set
    : struct_field_base '!'                                                                 { $$ = $1; $$->set = true; $$->key = $1->type; }
    ;

struct_field_map
    : struct_field_base '<' struct_field_base '>'                                           { $$ = $1; $$->map = true; $$->key = $3->type; delete $3; }
    | struct_field_optional '<' struct_field_base '>'                                       { $$ = $1; $$->map = true; $$->key = $3->type; delete $3; }
    ;

struct_field_hash
    : struct_field_base '{' struct_field_base '}'                                           { $$ = $1; $$->hash = true; $$->key = $3->type; delete $3; }
    | struct_field_optional '{' struct_field_base '}'                                       { $$ = $1; $$->hash = true; $$->key = $3->type; delete $3; }
    ;

struct_field_ptr
    : struct_field_base '*'                                                                 { $$ = $1; $$->ptr = true; }
    | struct_field_optional '*'                                                             { $$ = $1; $$->ptr = true; }
    | struct_field_reseter '*'                                                              { $$ = $1; $$->ptr = true; }
    | struct_field_array '*'                                                                { $$ = $1; $$->ptr = true; }
    | struct_field_vector '*'                                                               { $$ = $1; $$->ptr = true; }
    | struct_field_list '*'                                                                 { $$ = $1; $$->ptr = true; }
    | struct_field_set '*'                                                                  { $$ = $1; $$->ptr = true; }
    | struct_field_map '*'                                                                  { $$ = $1; $$->ptr = true; }
    | struct_field_hash '*'                                                                 { $$ = $1; $$->ptr = true; }
    ;

struct_field_value
    : CONST_TRUE
    | CONST_FALSE
    | CONST_NULL
    | CONST_EPOCH
    | CONST_UTC
    | CONST_UUID0
    | CONST_UUID1
    | CONST_UUID4
    | CONST_CHAR
    | CONST_INT
    | CONST_FLOAT
    | CONST_STRING
    | type_name
    | struct_field_value '|' type_name                                                      { *$$ = *$1 + " | " + *$3; delete $3; }
    ;

type_name
    : name
    | type_name '.' name                                                                    { *$$ = *$1 + "." + *$3; delete $3; }
    ;

name
    : IDENTIFIER
    | PDOMAIN                                                                               { $$ = new std::string("domain"); }
    | PACKAGE                                                                               { $$ = new std::string("package"); }
    | OFFSET                                                                                { $$ = new std::string("offset"); }
    | IMPORT                                                                                { $$ = new std::string("import"); }
    | VERSION                                                                               { $$ = new std::string("version"); }
    | REQ                                                                                   { $$ = new std::string("request"); }
    | RES                                                                                   { $$ = new std::string("response"); }
    | REJ                                                                                   { $$ = new std::string("reject"); }
    ;

%%
