# *.o targets
SRCS = system_stm32f4xx.c main.c
SRCS += joltik.s tweakableBC.s 64_operation.s

PROJ_NAME=joltik

###################################################

CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
GDB = arm-none-eabi-gdb

CFLAGS = -g -Wall -Tstm32_flash.ld 
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m4
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16

# for benchmark
#CFLAGS += -mabi=aapcs
#CFLAGS += -specs=rdimon.specs -lgcc -lc -lm -lrdimon

###################################################

vpath %.c src
vpath %.s src
vpath %.a lib

ROOT=$(shell pwd)

CFLAGS += -Iinc -Ilib -Ilib/inc 
CFLAGS += -Ilib/inc/core -Ilib/inc/peripherals 

SRCS += lib/startup_stm32f4xx.s # add startup file to build

OBJS = $(SRCS:.c=.o)

###################################################

.PHONY: all lib proj debug clean

all: lib proj

lib:
	$(MAKE) -C lib

proj: 	$(PROJ_NAME).elf

$(PROJ_NAME).elf: $(SRCS)
	$(CC) $(CFLAGS) $^ -o $@ -Llib -lstm32f4
	$(OBJCOPY) -O ihex $(PROJ_NAME).elf $(PROJ_NAME).hex
	$(OBJCOPY) -O binary $(PROJ_NAME).elf $(PROJ_NAME).bin

# make sure openocd server is up
debug: $(PROJ_NAME).elf
	$(GDB) -q -ex "target remote :3333" -ex "load" $(PROJ_NAME).elf

clean:
	$(MAKE) -C lib clean
	rm -f $(PROJ_NAME).elf
	rm -f $(PROJ_NAME).hex
	rm -f $(PROJ_NAME).bin
