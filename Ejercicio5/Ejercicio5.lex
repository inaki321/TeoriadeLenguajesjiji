%{


#pragma warning(disable: 4996 6011 6385)

#include <malloc.h> // para las definiciones de malloc, free que provocan warning
#include <stdlib.h> // para las definiciones de exit que provocan warning
#include <stdio.h>
#include <string.h>
FILE *ff,*fr;

char replace[15], replace_with[15], fname[50];

%}

%option outfile="Ejercicio5.c"
%option noyywrap
LETRA [A-Za-z]

%%

{LETRA}+    { if(strcmp(yytext, replace)==0)
                   fprintf(fr, "%s", replace_with);
                else
                    fprintf(fr, "%s", yytext);}
.            fprintf(fr, "%s", yytext);
%%

int main(int argc, char * argv[])
{
    	strcpy(fname, argv[1]);
		strcpy(replace, argv[2]);
		strcpy(replace_with, argv[3]);
		ff = fopen(fname, "r+");
		fr = fopen("output.txt", "w+");
		yyin=ff;
    	yylex();
    	return(0);
}