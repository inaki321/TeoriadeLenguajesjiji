%{

// Este texto es copiado tal cual a la salida
// Esta es otra linea de texto

#pragma warning(disable: 4996 6011 6385 4244 4267)

#include <malloc.h> // para las definiciones de malloc, free que provocan warning
#include <stdlib.h> // para las definiciones de exit que provocan warning


#include <stdio.h>
#include <string.h>
#include <math.h>

int variable_aux = 0;

%}

/*%option noyywrap
   Para no incluir la funcion yywrap La funci�n yywrap() es llamada por lex 
   cuando se agota la entrada. Devuelva 1 si ha terminado o 0 si se requiere
   m�s procesamiento 
*/


/*
%option pointer
%option outfile="Primer_ejemplo.c"
%option 8bit
%option backup
%option c++
%option noyywrap
*/

%array
%option outfile="prueba.c"

DIGITO [0-9]
NUMERO_ENTERO ([+|-]?[1-9]{DIGITO}*)|0
extern FILE *yyin, *yyout;

%%



{NUMERO_ENTERO}+		{

					variable_aux = atoi(yytext);
					if(variable_aux % 4 == 0){
						variable_aux += 5;
					}
					printf("Numero a usar  %i\n", variable_aux);
					
					fprintf(yyout, "%i", variable_aux);
				}
			

%%

/*

int main(int argc,char* argv[])
{
	yylex();
	return(0);
}

*/

int main(int argc, char * argv[])
{
    	++argv;
    	--argc;  

		yyout = fopen ("output.txt", "w+");
    	if (argc > 0)
            yyin = fopen( argv[0], "r" );
    	else
            yyin = stdin;
    
    	yylex();
    	return(0);
}



/* Por si se quiere manejar yywrap */


int yywrap(void) 
{
    return 1;
}

