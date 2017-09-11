#include <avr/io.h>
#include <util/delay.h>

#define BV(bit)              (1 << bit)
#define setBit(byte, bit)    (byte |= BV(bit))
#define clearBit(byte, bit)  (byte &= ~BV(bit))
#define toggleBit(byte, bit) (byte ^= BV(bit))

int main (void)
{
    uint8_t     pb0 = 0,
                pb1 = 1,
                pb2 = 2,
                pb3 = 3,
                pb4 = 4;

    /* set PORTB for output*/
    DDRB = BV (pb1);
    setBit (PORTB, pb4);
    _delay_ms (2000);

    while (1)
    {

        if ((PINB & BV (pb4)) == 0)
        {
            toggleBit (PORTB, pb1);
            _delay_ms (2000);
        }

    }

    return 0;
}
