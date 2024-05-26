#include "ID1000500A.h"
#include "caip.h"
#include <stdio.h>
#include <stdbool.h>
#include <string.h> // For memset
#include <stdlib.h> // For malloc

#ifdef _WIN32
#else
#include <unistd.h>
#endif // _WIN32

//Defines
#define INT_DONE    0
#define ONE_FLIT    1
#define ZERO_OFFSET 0
#define STATUS_BITS 8
#define INT_DONE_BIT    0x00000001


/** Global variables declaration (private) */
caip_t      *ID1000500A_aip;
uint32_t    ID1000500A_id = 0;
/*********************************************************************/

/** Private functions declaration */
static uint32_t ID1000500A_getID(uint32_t* id);
static uint32_t ID1000500A_clearStatus(void);
static int32_t ID1000500A_writeData(uint32_t *dataX, uint8_t sizeX, uint32_t *dataY, uint8_t sizeY);
static int32_t ID1000500A_readData(uint32_t *data, uint8_t data_size);
static int32_t ID1000500A_startIP(void);
static int32_t ID1000500A_configurationRegister(uint8_t sizeX, uint8_t sizeY);
static int32_t ID1000500A_waitINT(void);

/* Convolution process*/

//PRIVATE FUNCTIONS

/* Driver initialization*/
int32_t ID1000500A_init(const char *connector, uint8_t nic_addr, uint8_t port, const char *csv_file)
{
    ID1000500A_aip = caip_init(connector, nic_addr, port, csv_file);

    if(ID1000500A_aip == NULL){
        printf("CAIP Object not created");
        return -1;
    }
    ID1000500A_aip->reset();

    ID1000500A_getID(&ID1000500A_id);
    ID1000500A_clearStatus();

    printf("\nIP Convolutioner controller created with IP ID: %08X\n\n", ID1000500A_id);
    return 0;
}

/* Write data MemX*/
int32_t ID1000500A_writeData(uint32_t* dataX, uint8_t sizeX, uint32_t* dataY, uint8_t sizeY)
{
    ID1000500A_aip->writeMem("MMemX", dataX, sizeX, ZERO_OFFSET);

    ID1000500A_aip->writeMem("MMemY", dataY, sizeY, ZERO_OFFSET);
    return 0;
}

/* Read data*/
int32_t ID1000500A_readData(uint32_t *data, uint8_t data_size)
{
    ID1000500A_aip->readMem("MMemOUT", data, data_size, ZERO_OFFSET);
    return 0;
}

/* Start processing*/
int32_t ID1000500A_startIP(void)
{
    ID1000500A_aip->start();
    return 0;
}

/* Configuration Register*/
int32_t ID1000500A_configurationRegister(uint8_t sizeX, uint8_t sizeY)
{
    const uint8_t ADDR_WIDTH = 5;

    unsigned int confRegSize = 0;
    confRegSize = sizeY;
    confRegSize = confRegSize << ADDR_WIDTH;
    confRegSize |= sizeX;
    ID1000500A_aip->writeConfReg("CConfReg", &confRegSize, ONE_FLIT, ZERO_OFFSET);

    return 0;
}

/* Enable interruption notification "Done"*/
int32_t ID1000500A_enableINT(void) {
    ID1000500A_aip->enableINT(INT_DONE, NULL);
    printf("\nINT Done enabled");
    return 0;
}

/* Disable interruption notification "Done"*/
int32_t ID1000500A_disableINT(void)
{
    ID1000500A_aip->disableINT(INT_DONE);
    printf("\nINT Done disabled");
    return 0;
}

/* Show status*/
int32_t ID1000500A_status(void)
{
    uint32_t status;
    ID1000500A_aip->getStatus(&status);
    printf("\nStatus: %08X",status);
    return 0;
}

/* Wait interruption*/
int32_t ID1000500A_waitINT(void)
{
    bool waiting = true;
    uint32_t status;

    while(waiting)
    {
        ID1000500A_aip->getStatus(&status);

        if((status & INT_DONE_BIT)>0)
            waiting = false;

        #ifdef _WIN32
        Sleep(500); // ms
        #else
        sleep(0.1); // segs
        #endif
    }

    ID1000500A_aip->clearINT(INT_DONE);

    return 0;
}

/* Finish*/
int32_t ID1000500A_finish(void)
{
    ID1000500A_aip->finish();
    return 0;
}

uint32_t ID1000500A_getID(uint32_t* id)
{
    ID1000500A_aip->getID(id);

    return 0;
}

uint32_t ID1000500A_clearStatus(void)
{
    for(uint8_t i = 0; i < STATUS_BITS; i++)
        ID1000500A_aip->clearINT(i);

    return 0;
}


void ID1000500A_conv(uint8_t* X, uint8_t sizeX, uint8_t* Y, uint8_t sizeY, uint16_t* result){
    const uint8_t sizeZ = sizeX + sizeY - 1;

    if (sizeX == 0 || sizeY == 0)
        printf("SizeX and SizeY can't be 0");
    if (sizeX > 31 || sizeY > 31)
        printf("SizeX and SizeY can't be higher than 31");


    uint32_t* dataX32 = (uint32_t*)malloc(sizeX * sizeof (uint32_t));
    uint32_t* dataY32 = (uint32_t*)malloc(sizeY * sizeof (uint32_t));
    uint32_t* dataZ32 = (uint32_t*)malloc(sizeZ * sizeof (uint32_t));

    // Inicializar en cero
    memset(dataX32, 0, sizeX);
    memset(dataY32, 0, sizeY);
    memset(dataZ32, 0, sizeZ);

    // Copiar los datos de 8 bits a 32 bits
    for (int i=0; i<sizeX; i++)
        dataX32[i] = X[i];

    for (int i=0; i<sizeY; i++)
        dataY32[i] = Y[i];

    ID1000500A_writeData(dataX32, sizeX, dataY32, sizeY);
    ID1000500A_configurationRegister(sizeX, sizeY);
    ID1000500A_startIP();
    ID1000500A_waitINT();
    ID1000500A_readData(dataZ32, sizeZ);

    for (int i=0; i<sizeZ; i++)
        result[i] = dataZ32[i];
}
