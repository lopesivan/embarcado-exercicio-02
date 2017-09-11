OBJS = main.o
BIN  = main.elf
HEX  = main.hex
##############################################################################
# ubuntu install: sudo apt install gcc-avr avr-libc binutils-avr avrdude make
##############################################################################
PORT        = /dev/ttyACM0

# The path of Arduino IDE
ARDUINO_DIR = /opt/arduino-0022
# Boardy type: use "arduino" for Uno or "stk500v1" for Duemilanove
BOARD_TYPE  = arduino
# Baud-rate: use "115200" for Uno or "19200" for Duemilanove
BAUD_RATE   = 115200

#Compiler and uploader configuration
MCU         = atmega328p
DF_CPU      = 16000000UL
CC          = /usr/bin/avr-gcc
LD          = /usr/bin/avr-gcc
DEFINE      = -DF_CPU=$(DF_CPU) -DENABLE_ATMEGA328P
CFLAGS      = -g -Os -w -Wall $(DEFINE) -ffunction-sections -fdata-sections -fno-exceptions -std=gnu99 -mmcu=$(MCU) -c
LDFLAGS     = -mmcu=$(MCU) -o $@
LIBS        =
CPP         = /usr/bin/avr-g++
AVR_OBJCOPY = /usr/bin/avr-objcopy
AVR_OBJDUMP = /usr/bin/avr-objdump
AVRDUDE     = /usr/bin/avrdude
PROTOCOL    = arduino
##############################################################################
include etc/gmsl
##############################################################################
all: $(HEX) $(BIN).lst

.c.o:
	$(CC) -c $(CFLAGS) -o $@ $<

$(BIN): $(OBJS)
	$(LD) $(LDFLAGS) $+ $(LIBS)

$(HEX): $(BIN)
	$(AVR_OBJCOPY)  -j .text -j .data -O ihex -R .eeprom $+ $@

$(BIN).lst: $(BIN)
	$(AVR_OBJDUMP) -d $+ >$@

up:
	echo avrdude -F -V -c $(PROTOCOL) -p $(call uc,$(MCU)) -P $(PORT) -b $(BAUD_RATE) -U flash:w:$(HEX)

backup:
	echo avrdude -F -V -c $(PROTOCOL) -p $(call uc,$(MCU)) -P $(PORT) -b $(BAUD_RATE) -U flash:r:flash_backup.hex:i

clean:
	rm -f $(OBJS) $(BIN) $(HEX) $(BIN).lst core

sim: $(HEX)
	simavr --gdb  -m atmega328 -f 8000000 $(HEX)

proto:
	cproto -I . -I /usr/lib/avr/include main.c
###
