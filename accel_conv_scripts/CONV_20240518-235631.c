#include "caip.h"

#include <stdint.h>
#include <stdio.h>

#include <conio.h>

int main(){
    const char *connector = "/dev/ttyACM0";
    uint8_t nic_addr = 1;
    uint8_t port = 0;
    const char *csv_file = "/home/ihc/Documents/TAE/Soc/ConvolucionadorPractica1/CodigoSV/HDL/ID40048008/config/ID40048008_config.csv";

    caip_t *aip = caip_init(connector, nic_addr, port, csv_file);

    aip->reset();

    /*========================================*/
    /* Code generated with IPAccelerator */

    uint32_t ID[1];


    aip->getID(ID);
    printf("Read ID: %08X\n\n", ID[0]);


    uint32_t STATUS[1];


    aip->getStatus(STATUS);
    printf("Read STATUS: %08X\n\n", STATUS[0]);


    uint32_t memX_fromFile[32] = {0x0000002C, 0x000000A1, 0x0000009B, 0x000000BF, 0x00000003, 0x00000063, 0x0000004F, 0x00000084, 0x000000C1, 0x00000091, 0x00000068, 0x00000097, 0x00000028, 0x00000086, 0x00000044, 0x00000078, 0x0000003F, 0x000000CB, 0x000000E1, 0x0000009A, 0x00000050, 0x0000009B, 0x000000B3, 0x0000005F, 0x0000007E, 0x000000A1, 0x00000024, 0x000000D9, 0x000000B5, 0x0000008C, 0x000000D9, 0x0000006A};
    uint32_t memX_fromFile_size = sizeof(memX_fromFile) / sizeof(uint32_t);


    printf("Write memory: MMemX\n");
    aip->writeMem("MMemX", memX_fromFile, 32, 0);
    printf("memX_fromFile Data: [");
    for(int i=0; i<memX_fromFile_size; i++){
        printf("0x%08X", memX_fromFile[i]);
        if(i != memX_fromFile_size-1){
            printf(", ");
        }
    }
    printf("]\n\n");


    uint32_t memY_fromFile[32] = {0x000000C6, 0x0000005B, 0x000000C7, 0x000000BF, 0x000000C5, 0x000000B7, 0x000000B6, 0x000000C0, 0x0000005E, 0x0000002C, 0x00000034, 0x000000F3, 0x0000007C, 0x00000040, 0x00000079, 0x00000070, 0x00000019, 0x000000DB, 0x0000008B, 0x000000E4, 0x000000FD, 0x0000009F, 0x00000020, 0x00000075, 0x000000F0, 0x000000E6, 0x00000039, 0x0000004C, 0x0000005F, 0x000000F9, 0x00000004, 0x00000018};
    uint32_t memY_fromFile_size = sizeof(memY_fromFile) / sizeof(uint32_t);


    printf("Write memory: MMemY\n");
    aip->writeMem("MMemY", memY_fromFile, 32, 0);
    printf("memY_fromFile Data: [");
    for(int i=0; i<memY_fromFile_size; i++){
        printf("0x%08X", memY_fromFile[i]);
        if(i != memY_fromFile_size-1){
            printf(", ");
        }
    }
    printf("]\n\n");


    uint32_t configReg_sizeX5_sizeY10[1] = {0x00000145};
    uint32_t configReg_sizeX5_sizeY10_size = sizeof(configReg_sizeX5_sizeY10) / sizeof(uint32_t);


    printf("Write configuration register: CConfReg\n");
    aip->writeConfReg("CConfReg", configReg_sizeX5_sizeY10, 1, 0);
    printf("configReg_sizeX5_sizeY10 Data: [");
    for(int i=0; i<configReg_sizeX5_sizeY10_size; i++){
        printf("0x%08X", configReg_sizeX5_sizeY10[i]);
        if(i != configReg_sizeX5_sizeY10_size-1){
            printf(", ");
        }
    }
    printf("]\n\n");


    printf("Start IP\n\n");
    aip->start();


    aip->getStatus(STATUS);
    printf("Read STATUS: %08X\n\n", STATUS[0]);


    uint32_t processed_Data[16];
    uint32_t processed_Data_size = sizeof(processed_Data) / sizeof(uint32_t);


    printf("Read memory: MMemOut\n");
    aip->readMem("MMemOut", processed_Data, 16, 0);
    printf("processed_Data Data: [");
    for(int i=0; i<processed_Data_size; i++){
        printf("0x%08X", processed_Data[i]);
        if(i != processed_Data_size-1){
            printf(", ");
        }
    }
    printf("]\n\n");



    /*========================================*/

    aip->finish();

    printf("\n\nPress key to close ... ");
    getch();

    return 0;

}
