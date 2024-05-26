#ifndef __ID1000500A_H__
#define __ID1000500A_H__

#include <stdint.h>

/** Global variables declaration (public) */
/* These variables must be declared "extern" to avoid repetitions. They are defined in the .c file*/
/******************************************/

/** Public functions declaration */
int32_t ID1000500A_init(const char *connector, uint8_t nic_addr, uint8_t port, const char *csv_file);
int32_t ID1000500A_enableINT(void);
int32_t ID1000500A_disableINT(void);
int32_t ID1000500A_status(void);
int32_t ID1000500A_finish(void);


/* Convolution process*/
void ID1000500A_conv(uint8_t* X, uint8_t sizeX, uint8_t* Y, uint8_t sizeY, uint16_t* result);
#endif // __ID1000500A_H__
