%{

#pragma warning(disable: 4996 6387 6011 6385)
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <ctype.h>

unsigned int cuenta_char = 0;
unsigned int cuenta_palabra = 0;
unsigned int cuenta_lineas = 0;
%}

%option noyywrap
%option outfile="Ejercicio3.c"

VOCAL_ACENTUADA [�����a����]
LETRA [A-Za-z]
PALABRA {VOCAL_ACENTUADA}*{LETRA}+{VOCAL_ACENTUADA}*{LETRA}*

%%


{PALABRA} {
	 	printf("Palabra: %s\n", yytext);
	 	cuenta_palabra++;
	 	cuenta_char += strlen(yytext);
	  }

\n		cuenta_lineas++;


.		cuenta_char++;
	
%%

int main( int argc, char* argv[] )
{
	++argv;
	--argc;  
	if (argc > 0)
	       yyin = fopen( argv[0], "r" );
	else
	       yyin = stdin;
	    
    	yylex();
	yylex();
	printf("Numero de palabras: %u \n",cuenta_palabra);
	printf("Numero de lineas: %u \n",cuenta_lineas);
	printf("Numero de caracteres: %u \n",cuenta_char);
}