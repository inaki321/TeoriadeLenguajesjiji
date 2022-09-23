%{


#pragma warning(disable: 4996 6011 6385)

#include <malloc.h> // para las definiciones de malloc, free que provocan warning
#include <stdlib.h> // para las definiciones de exit que provocan warning
#include <stdio.h>

unsigned int n1;
unsigned int n2;

%}

%option outfile="Ejercicio2.c"
%option noyywrap

NO_CERO [1-9]
DIGITOS [0-9]
NUMERO_ENTERO {NO_CERO}{DIGITOS}*


%%

{NUMERO_ENTERO}	       {
				int aux = atoi(yytext);
				if (aux%n2==0){
					aux += n1;
					fprintf(yyout, "%i", aux);
				}
			}

\t			//escribir en txt

.			printf("Caracter invalido%s\n",yytext);

%%

int main(int argc, char * argv[])
{
    	
    	printf("Introduce el primer numero: ");
	scanf("%u",n1);
	printf("Introduce el segundo numero: ");
	scanf("%u",n2);
    	
		yyout = fopen ("output.txt", "w+");
        yyin = fopen( argv[0], "r" );
    
    
    	yylex();

    	return(0);
}



