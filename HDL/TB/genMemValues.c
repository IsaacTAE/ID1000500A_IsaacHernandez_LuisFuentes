#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void writeToFile(FILE* archivo, const uint8_t* values);

int main (void){

	srand(time(NULL));
	uint8_t  valuesX[32] = {};
	uint8_t  valuesY[32] = {};
	
	for (int i=0; i<32; i++){
		valuesX[i] = rand() % 256;
		valuesY[i] = rand() % 256;
	}
	
	FILE* archivoX = NULL;
	FILE* archivoY = NULL;

	archivoX = fopen("memX_values.txt", "w");
	writeToFile(archivoX, valuesX);
	fclose(archivoX);

	archivoY = fopen("memY_values.txt", "w");
	writeToFile(archivoY, valuesY);
	fclose(archivoY);
	
	return 0;
}

void writeToFile(FILE* archivo, const uint8_t* values){
	for(int i=0; i<32; i++){
		fprintf(archivo, "%02X\n", values[i]);
	}
}

