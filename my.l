/*
 *	  Title:			Test lexer for C++ parser.
 *
 *	  File Name:		My.l
 *
 *	  Author:			Jason
 *
 *	This is a complete lexer for C++, intended for use with CxxParser.y.
 *	All actions are done by macros, so that there is some chance that customisation
 *	can be performed within the bounds of the CxxLexing.hxx and CxxLexing.cxx
 *	include files.
 *END
 */
%{
#include <iostream>
%}

%a 5000
%e 1500
%n 1000
%o 10000
%p 10000

ws                              [ \f\v\t]

digit                           [0-9]
hex                             [0-9A-Fa-f]
letter                          [A-Z_a-z]
simple_escape_sequence          (\\\'|\\\"|\\\?|\\\\|\\a|\\b|\\f|\\n|\\r|\\t|\\v)
octal_escape_sequence           (\\[0-7]|\\[0-7][0-7]|\\[0-7][0-7][0-7])
hexadecimal_escape_sequence     (\\x{hex}+)
escape_sequence                 ({simple_escape_sequence}|{octal_escape_sequence}|{hexadecimal_escape_sequence})
universal_character_name		(\\u{hex}{hex}{hex}{hex}|\\U{hex}{hex}{hex}{hex}{hex}{hex}{hex}{hex})
non_digit						({letter}|{universal_character_name})
identifier						({non_digit}({non_digit}|{digit})*)
character_lit					(L?\'([^\'\\\n]|\\.)*)
character_literal				({character_lit}\')
string_lit						(L?\"([^\"\\\n]|\\.)*)
string_literal					({string_lit}\")
pp_number						(\.?{digit}({digit}|{non_digit}|[eE][-+]|\.)*)

%%                               
^{ws}*"#".*						{ std::cout << yytext << "\t ---- Preprocessor" << std::endl;}
                                 
{character_lit}\'				{ std::cout << yytext << " "; }
{character_lit}\\				{ std::cerr << yytext << " <---- End of line assumed to terminate character with trailing escape" << std::endl; }
{character_lit}					{ std::cerr << yytext << " <---- End of line assumed to terminate charater." <<  std::endl; }
                                 
{string_lit}\"					{ std::cout << yytext << " "; }
{string_lit}\\					{ std::cerr << yytext << " <---- End of line assumed to terminate string with trailing escape." << std::endl; }
								 
{string_lit}					{ std::cerr << yytext << " <---- End of line assuemed to terminate string." << std::endl;; }

"asm"							{ std::cout << "ASM " ; }
"auto"							{ std::cout << "AUTO " ; }
"bool"							{ std::cout << "BOOL " ; }
"break"							{ std::cout << "BREAK " ; }
"case"							{ std::cout << "CASE " ; }
"catch"							{ std::cout << "CATCH " ; }
"char"							{ std::cout << "CHAR " ; }
"class"							{ std::cout << "CLASS " ; }
"const"							{ std::cout << "CONST " ; }
"const_cast"					{ std::cout << "CONST_CAST " ; }
"continue"						{ std::cout << "CONTINUE " ; }
"default"						{ std::cout << "DEFAULT " ; }
"delete"						{ std::cout << "DELETE " ; }
"do"							{ std::cout << "DO " ; }
"double"						{ std::cout << "DOUBLE " ; }
"dynamic_cast"					{ std::cout << "DYNAMIC_CAST " ; }
"else"							{ std::cout << "ELSE " ; }
"enum"							{ std::cout << "ENUM " ; }
"explicit"						{ std::cout << "EXPLICIT " ; }
"export"						{ std::cout << "EXPORT " ; }
"extern"						{ std::cout << "EXTERN " ; }
"false"							{ std::cout << "FALSE " ; }
"float"							{ std::cout << "FLOAT " ; }
"for"							{ std::cout << "FOR " ; }
"friend"						{ std::cout << "FRIEND " ; }
"goto"							{ std::cout << "GOTO " ; }
"if"							{ std::cout << "IF " ; }
"inline"						{ std::cout << "INLINE " ; }
"int"							{ std::cout << "INT " ; }
"long"							{ std::cout << "LONG " ; }
"mutable"						{ std::cout << "MUTABLE " ; }
"namespace"						{ std::cout << "NAMESPACE " ; }
"new"							{ std::cout << "NEW " ; }
"operator"						{ std::cout << "OPERATOR " ; }
"private"						{ std::cout << "PRIVATE " ; }
"protected"						{ std::cout << "PROTECTED " ; }
"public"						{ std::cout << "PUBLIC " ; }
"register"						{ std::cout << "REGISTER " ; }
"reinterpret_cast"				{ std::cout << "REINTERPRET_CAST "; }
"return"						{ std::cout << "RETURN "; }
"short"							{ std::cout << "SHORT "; }
"signed"						{ std::cout << "SIGNED "; }
"sizeof"						{ std::cout << "SIZEOF "; }
"static"						{ std::cout << "STATIC "; }
"static_cast"					{ std::cout << "STATIC_CAST "; }
"struct"						{ std::cout << "STRUCT "; }
"switch"						{ std::cout << "SWITCH "; }
"template"						{ std::cout << "TEMPLATE "; }
"this"							{ std::cout << "THIS "; }
"throw"							{ std::cout << "THROW "; }
"true"							{ std::cout << "TRUE "; }
"try"							{ std::cout << "TRY "; }
"typedef"						{ std::cout << "TYPEDEF "; }
"typeid"						{ std::cout << "TYPEID "; }
"typename"						{ std::cout << "TYPENAME "; }
"union"							{ std::cout << "UNION "; }
"unsigned"						{ std::cout << "UNSIGNED "; }
"using"							{ std::cout << "USING "; }
"virtual"						{ std::cout << "VIRTUAL "; }
"void"							{ std::cout << "VOID "; }
"volatile"						{ std::cout << "VOLATILE "; }
"wchar_t"						{ std::cout << "WCHAR_T "; }
"while"							{ std::cout << "WHILE "; }

"::"							{ std::cout << "SCOPE "; }
"..."							{ std::cout << "ELLIPSIS "; }
"<<"							{ std::cout << "SHL "; }
">>"							{ std::cout << "SHR "; }
"=="							{ std::cout << "EQ "; }
"!="							{ std::cout << "NE "; }
"<="							{ std::cout << "LE "; }
">="							{ std::cout << "GE "; }
"&&"							{ std::cout << "LOG_AND "; }
"||"							{ std::cout << "LOG_OR "; }
"++"							{ std::cout << "INC "; }
"--"							{ std::cout << "DEC "; }
"->*"							{ std::cout << "ARROW_STAR "; }
"->"							{ std::cout << "ARROW "; }
".*"							{ std::cout << "DOT_STAR "; }
"+="							{ std::cout << "ASS_ADD "; }
"-="							{ std::cout << "ASS_SUB "; }
"*="							{ std::cout << "ASS_MUL "; }
"/="							{ std::cout << "ASS_DIV "; }
"%="							{ std::cout << "ASS_MOD "; }
"^="							{ std::cout << "ASS_XOR "; }
"&="							{ std::cout << "ASS_AND "; }
"|="							{ std::cout << "ASS_OR "; }
">>="							{ std::cout << "ASS_SHR "; }
"<<="							{ std::cout << "ASS_SHL "; }

{pp_number}						{ std::cout << "NUMBER "; }

{identifier}					{ std::cout << yytext << " "; }
                                  
{escape_sequence}				| 
{universal_character_name}		{ std::cout << yytext << " "; }

\n								{ std::cout << std::endl; } 
{ws}+							{ }
.								{ }
                                   
%%                                

int yywrap(){}
int main(int argc, char **argv) {
  ++argv, --argc;
  if (argc > 0) 
    yyin = fopen(argv[1], "r");
  else
    yyin = stdin;
  yylex();
  return 0;
}
