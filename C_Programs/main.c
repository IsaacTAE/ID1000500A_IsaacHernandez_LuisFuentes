#include <stdio.h>
#include <stdint.h>

void readMemFile(const char* file_name, uint32_t* mem);
void loadMemValues(uint32_t* memX, uint32_t* memY);

int main(void)
{
	uint64_t dataZ;
	uint32_t dataX, dataY;
	uint32_t sizeX, sizeY;
	uint8_t memX_addr, memY_addr, memZ_addr;

	uint32_t memX [32] = {};
	uint32_t memY [32] = {}; 
	uint64_t memZ [65] = {};

	sizeX = 5;
	sizeY = 10;
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
		for (int j = i, k = sizeY-1; j < sizeX; j++, k--){
			dataX = memX[j];
			dataY = memY[k];
			dataZ += dataX * dataY;
		}
		memZ[memZ_addr] = dataZ;
		memZ_addr++;
	}

	// Mostrar resultados
	for (int i = 0; i < memZ_addr; i++){
		printf("[%i] -- %lu\n", i, memZ[i]);
	}

	return 0;
}

void loadMemValues(uint32_t* memX, uint32_t* memY){
	readMemFile("/home/ihc/Documents/TAE/Soc/ConvolucionadorPractica1/CodigoSV/memX_values.txt", memX);
	readMemFile("/home/ihc/Documents/TAE/Soc/ConvolucionadorPractica1/CodigoSV/memY_values.txt", memY);
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
		fscanf(file, "%02X", &mem[i]);
		i++;
	}

	fclose(file);
}


