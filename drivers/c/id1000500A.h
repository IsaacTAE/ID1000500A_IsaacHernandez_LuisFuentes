#ifndef __ID1000500A_H__
#define __ID1000500A_H__

#include <stdint.h>

/** Global variables declaration (public) */
/* These variables must be declared "extern" to avoid repetitions. They are defined in the .c file*/
/******************************************/

/** Public functions declaration */

/* Convolution process*/
int32_t id1000500A_conv(uint32_t *X, uint32_t *Y);
#endif // __id1000500A_H__

