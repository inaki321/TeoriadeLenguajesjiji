%{
#include <string.h>
#include <stdio.h>
#pragma warning(disable: 4996)

char palabra_temp[30];
%}

%option noyywrap
%option outfile="Ej6.c"

PALABRA_RESERVADA 	("inicio"|"fin"|"leer"|"escribir"|"si"|"entonces"|"si_no"|"fin_si"|"mientras"|"hacer"|"fin_mientras"|"repetir"|"hasta_que"|"para"|"desde"|"hasta"|"paso"|"fin_para")
CADENA 			['].*[']
IDENTIFICADOR		[a-z](_?[a-z0-9]+)*
ID_NO_VALIDO		[_a-z0-9]*
NUM_ENTERO		[0-9]+
NUM_REAL		[0-9]+"."[0-9]+
NUM_CIENTIFICA		[0-9]+("."[0-9]*)?E[-|+][0-9]+
NUMERO_ERROR		[0-9]*"."?[0-9]*E?[-|+]*[0-9]*
OP_ASIGNACION 		"="
OP_ARITMETICO 		("+"|"-"|"*"|"/"|"mod"|"**")
OP_RELACIONAL 		("<"|"<="|">"|">="|"=="|"<>")
OP_LOGICO 		("o"|"y"|"no")

%x comentario_mult

%%

{CADENA}		{
				strncpy(palabra_temp, yytext+1,yyleng - 2);
				printf("Cadena encontrada: %s\n", palabra_temp);
			}
			
"(*"			{
				BEGIN(comentario_mult);
				printf("Inicia comentario de varias lineas\n");
			}
			
<comentario_mult>"*)"	{
				printf("Termina comentario de varias lineas\n");
				BEGIN(INITIAL);
			}
			
<comentario_mult>.

<comentario_mult>\n|\t

#.*			printf("Comentario de una linea %s\n", yytext);
			
{OP_ASIGNACION}		printf("Operador de asignacion %s\n", yytext);

{OP_ARITMETICO} 	printf("Operador aritmetico %s\n", yytext);

{OP_RELACIONAL} 	printf("Operador relacional %s\n", yytext);

{OP_LOGICO} 		printf("Operador logico %s\n", yytext);
			
{NUM_CIENTIFICA}	printf("Numero en notacion cientifica %s\n", yytext);

{NUM_REAL}		printf("Numero real %s\n", yytext);

{NUM_ENTERO}		printf("Numero entero %s\n", yytext);

{NUMERO_ERROR}		printf("Numero mal escrito %s\n", yytext);
			
{PALABRA_RESERVADA}	printf("Palabra reservada %s\n", yytext);

{IDENTIFICADOR}		printf("Identificador valido %s\n", yytext);

{ID_NO_VALIDO}		printf("Identificador invalido %s\n", yytext);

\n|\t|" "
			
. 			printf("Simbolo no permitido %s\n", yytext);


%%

int main(int argc, char** argv) {
	++argv, --argc;
	if(argc>0)
		yyin = fopen(argv[0], "r");
	else
		yyin = stdin;
	yylex();
	return 0;
}