BINARY = bin
CODEDIRS = src
INCDIRS = include
TARGET = object

CC = gcc
OPT = -O0
DEPFLAGS = -MP -MD
CFLAGS = -Wall -Wextra -g $(foreach D,$(INCDIRS),-I$(D)) $(OPT) $(DEPFLAGS)

CFILES = $(foreach D,$(CODEDIRS),$(wildcard $(D)/*.c))
OBJECTS = $(patsubst src/%,$(TARGET)/%,$(patsubst %.c,%.o,$(CFILES)))
DEPS = $(patsubst %.o,%.d,$(OBJECTS))

all: $(BINARY)

$(BINARY): $(OBJECTS)
	$(CC) -o $@ $^

$(TARGET)/%.o: src/%.c | object
	$(CC) $(CFLAGS) -c -o $@ $^

object:
	mkdir -p $@

clean:
	rm $(BINARY) $(OBJECTS) $(DEPS)

list:
	echo $(CFILES)