#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#define ADDR_LOCATIONS 32 

void writeToFile(FILE* archivo, const uint32_t* values);

int main (int argc, char** argv){

	if (argc != 2){
		printf("argc = %d \n", argc);
		printf("Falta el argumento de ruta destino");
		return -1;
	}

	const char *ruta = argv[1];

	srand(time(NULL));
	uint32_t  valuesX[ADDR_LOCATIONS] = {};
	uint32_t  valuesY[ADDR_LOCATIONS] = {};
	
	for (int i=0; i<ADDR_LOCATIONS; i++){
		valuesX[i] = rand() % 256;
		valuesY[i] = rand() % 256;
	}
	
	FILE* archivoX = NULL;
	FILE* archivoY = NULL;

	//Escribir los valores aleatorios en un archivo
	char* pathMemX = (char*)malloc(strlen(ruta) + strlen("memX_values.ipd") + 1);
	strcpy(pathMemX, ruta);
	strcat(pathMemX, "memX_values.ipd");
	archivoX = fopen(pathMemX, "w");
	writeToFile(archivoX, valuesX);
	fclose(archivoX);
	free(pathMemX);

	char* pathMemY = (char*)malloc(strlen(ruta) + strlen("memY_values.ipd") + 1);
	strcpy(pathMemY, ruta);
	strcat(pathMemY, "memY_values.ipd");
	archivoY = fopen(pathMemY, "w");
	writeToFile(archivoY, valuesY);
	fclose(archivoY);
	free(pathMemY);

	return 0;
}

void writeToFile(FILE* archivo, const uint32_t* values){
	for(int i=0; i<ADDR_LOCATIONS; i++){
		fprintf(archivo, "%X\n", values[i]);
	}
}

