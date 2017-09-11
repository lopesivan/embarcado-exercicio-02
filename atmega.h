#ifndef ATMEGA_H
#define ATMEGA_H

#ifdef ENABLE_ATMEGA328P
    #include <avr/io.h>
    #include <util/delay.h>

    #include "configure.h"
    #include "util.h"
#else
    #include "debug.h"
#endif

#endif 		// ATMEGA_H
/* -*- vim: set ts=4 sw=4 tw=78 ft=header: -*- */
