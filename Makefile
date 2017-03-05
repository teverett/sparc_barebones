
all	: boot

CCARGS=-g -std=c99
OBJ_DIR=objs
SRC_ROOT=src

# C sources
SRCS_C=$(shell find $(SRC_ROOT) -type f -iname '*.c')

# assembler sources
SRCS_ASM=$(shell find $(SRC_ROOT) -type f -iname '*.s')

# all sources
SRCS=$(SRCS_ASM)$(SRCS_C)$(SRCS_CPP)

# obj dirs
OBJS_ASM=$(subst $(SRC_ROOT)/, , $(SRCS_ASM:.s=.o))
OBJS_C=$(subst $(SRC_ROOT)/, , $(SRCS_C:.c=.o))

# object files
OBJS=$(addprefix $(OBJ_DIR)/, $(OBJS_ASM) $(OBJS_C))

# set search paths
vpath %.c $(SRC_ROOT)/
vpath %.s $(SRC_ROOT)/

# c files	
$(OBJ_DIR)/%.o: %.c
	mkdir -p $(@D)
	$(CC) $(CCARGS) $(EXTRA_CCARGS) -c -o $@ $<

# s files
$(OBJ_DIR)/%.o: %.s
	mkdir -p $(@D)
	$(AS) $(ASARGS) -o $@ $< 

	
boot:objdir $(OBJS)
	$(CC) $(OBJS) -o boot
	
objdir:
	rm -rf $(OBJ_DIR)	
	mkdir $(OBJ_DIR)
	
clean:
	rm -rf $(OBJS)
	rm -f boot
