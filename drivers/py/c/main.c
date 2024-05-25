#include <stdio.h>
#include <stdlib.h>
//#include <conio.h> // getch
#include "id1000500A.h"

int main() 
{
    uint8_t nic_addr  = 1;
    uint8_t port = 0;
    uint16_t aip_mem_size = 32; //Originalmente 8; //Size of the input and output memories

    id1000500A_init("/dev/ttyACM0", nic_addr, port, "/home/lagisaurio/Downloads/id1000500A_config.csv");

    srand(1);

    uint32_t X[aip_mem_size];
    uint32_t Y[aip_mem_size];

    printf("\nData generated with %i\n",aip_mem_size);
    printf("\nTX Data\n");
    for(uint32_t i=0; i<aip_mem_size; i++){
        X[i] = rand() %0XFFFFFFF;
        printf("%08X\n", X[i]);
    }
    for(uint32_t i=0; i<aip_mem_size; i++){
        Y[i] = rand() %0XFFFFFFF;
        printf("%08X\n", Y[i]);
    }

    id1000500A_conv(X,Y);

    
    uint32_t RD[aip_mem_size];
    id1000500A_readData(RD, aip_mem_size);

    
    printf("\n\n Done detected \n\n");
    
    uint32_t result_size = sizeof(X) + sizeof(Y) -1;
    uint32_t conv_res [result_size];
    id1000500A_readData(conv_res,result_size);

    for(uint32_t i=0; i<aip_mem_size; i++){
        printf("Tx MemX: %08X \t | Tx MemY: %08X \t |Rx: %08X\n", X[i], Y[i], conv_res[i]);
    }

    id1000500A_disableDelay();
    id1000500A_status();
    id1000500A_finish();

    printf("\n\nPress key to close ... ");
   // getch();
    return 0;

}
