# Makefile for assembling and linking multiple assembly programs

# Compiler and flags
AS = nasm
ASFLAGS = -f elf64
LD = ld
LDFLAGS = 

# Source and output files
SRCS = $(wildcard *.asm)
OBJS = $(SRCS:.asm=.o)
OUT = multitool

# Default target
all: $(OUT)

# Assemble each source file
%.o: %.asm
	$(AS) $(ASFLAGS) -o $@ $<

# Link all object files
$(OUT): $(OBJS)
	$(LD) $(LDFLAGS) -o $(OUT) $(OBJS)

# Clean up generated files
clean:
	rm -f $(OBJS) $(OUT)

.PHONY: all clean