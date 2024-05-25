#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

void readMemFile(const char* file_name, uint32_t* mem);
void loadMemValues(uint32_t* memX, uint32_t* memY);
void writeMemOutValues(const char* file_name, uint64_t* memOut, uint8_t sizeX, uint8_t sizeY);

static char* ruta = "/home/ihc/Documents/TAE/Soc/ConvolucionadorPractica1/CodigoSV/HDL/TB/";

int main(void)
{
	uint64_t dataZ;
	uint32_t dataX, dataY;
	uint32_t sizeX, sizeY;
	uint8_t memX_addr, memY_addr, memZ_addr;

	uint32_t memX [32] = {};
	uint32_t memY [32] = {}; 
	uint64_t memZ [63] = {};

	sizeX = 10;
	sizeY = 5;
	memX_addr = 0;
	memY_addr = 0;
	memZ_addr = 0;

	loadMemValues(memX, memY);

	for (int i = 0; i < sizeY; i++){
		dataZ = 0;
		for (int j = 0; (j<=i) && (j<sizeX); j++){
			// Cargar valores de memorias
			dataX = memX[j];
			dataY = memY[i-j];
			dataZ += dataX * dataY;
		}
		memZ[memZ_addr] = dataZ;
		memZ_addr++;
	}

	for (int i = 1; i < sizeX; i++){
		dataZ = 0;
		for (int j = i, k = sizeY-1; (j<sizeX) && (k>=0) ; j++, k--){
			dataX = memX[j];
			dataY = memY[k];
			dataZ += dataX * dataY;
		}
		memZ[memZ_addr] = dataZ;
		memZ_addr++;
	}

	// Guardar los resultados en un archivo
	char* pathResult = (char*)malloc(strlen(ruta) + strlen("resultValues.txt") + 1);
	strcpy(pathResult, ruta);
	strcat(pathResult, "resultValues.txt");
	writeMemOutValues(pathResult, memZ, sizeX, sizeY);
	free(pathResult);

	return 0;
}

void loadMemValues(uint32_t* memX, uint32_t* memY){
	char* pathMemX = (char*)malloc(strlen(ruta) + strlen("memX_values.ipd") + 1);
	strcpy(pathMemX, ruta);
	strcat(pathMemX, "memX_values.ipd");
	readMemFile(pathMemX, memX);
	free (pathMemX);

	char* pathMemY = (char*)malloc(strlen(ruta) + strlen("memY_values.ipd") + 1);
	strcpy(pathMemY, ruta);
	strcat(pathMemY, "memY_values.ipd");
	readMemFile(pathMemY, memY);
	free (pathMemY);
}


void writeMemOutValues(const char* file_name, uint64_t* memOut, uint8_t sizeX, uint8_t sizeY){
	FILE* file = fopen(file_name, "w");
	if (file == NULL){
		perror("Imposible abrir archivo de escritura");
		return;
	}

	for (int i = 0; i < (sizeX + sizeY - 1); i++){
		fprintf(file, "%lX\n", memOut[i]);
	}

	fclose(file);
}

void readMemFile(const char* file_name, uint32_t* mem){
	uint32_t value;

	FILE* file = fopen(file_name, "r");
	if (file == NULL){
		perror("Archivo no encontrado");
		return;
	}
	
	int i = 0;
	while (!feof(file)){
		fscanf(file, "%X", &mem[i]);
		i++;
	}

	fclose(file);
}


