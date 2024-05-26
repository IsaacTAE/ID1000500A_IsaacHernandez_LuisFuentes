#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "ID1000500A.h"

int main()
{

    const uint8_t nic_addr  = 1;
    const uint8_t port = 0;
    const uint8_t AIP_MEM_SIZE = 31; //Size of the input and output memories
    const uint8_t sizeX = 5;
    const uint8_t sizeY = 10;

    ID1000500A_init("/dev/ttyACM0", nic_addr, port, "/home/ihc/Documents/TAE/Soc/ConvolucionadorPractica1/CodigoSV/HDL/ID1000500A/config/ID1000500A_config.csv");

    srand(time(NULL));

    uint8_t X[AIP_MEM_SIZE];
    uint8_t Y[AIP_MEM_SIZE];

    printf("\nData generated with %i\n",AIP_MEM_SIZE);

    printf("\nX Data\n");

    for(uint8_t i=0; i<AIP_MEM_SIZE; i++){
        X[i] = rand() %0XFFFFFFF;
        printf("%X\n", X[i]);

    }

    printf("\nY Data\n");
    for(uint8_t i=0; i<AIP_MEM_SIZE; i++){
        Y[i] = rand() %0XFFFFFFF;
        printf("%X\n", Y[i]);

    }


    uint8_t sizeResult = sizeX + sizeY - 1;
    uint16_t result_conv[sizeResult];

    ID1000500A_conv(X, sizeX, Y, sizeY, result_conv);

    printf("\n\n Done detected \n\n");
    ID1000500A_status();

    printf("\n");
    for(int i=0; i<sizeResult; i++){
        printf("Rx[%d]: %X\n", i, result_conv[i]);
    }

    ID1000500A_finish();
}
