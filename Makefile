BINARY = bin
CODEDIRS = src
INCDIRS = include
OBJECTDIR = object
TARGETDIR = target

CC = gcc
OPT = -O0
DEPFLAGS = -MP -MD
CFLAGS = -Wall -Wextra -g $(foreach D,$(INCDIRS),-I$(D)) $(OPT) $(DEPFLAGS)

CFILES = $(foreach D,$(CODEDIRS),$(wildcard $(D)/*.c))
OBJECTS = $(patsubst src/%,$(OBJECTDIR)/%,$(patsubst %.c,%.o,$(CFILES)))
DEPS = $(patsubst %.o,%.d,$(OBJECTS))

all: $(BINARY)

$(BINARY): $(OBJECTS) | target
	$(CC) -o ./$(TARGETDIR)/$@ $^

target:
	mkdir ./$(TARGETDIR)

$(OBJECTDIR)/%.o: src/%.c | object
	$(CC) $(CFLAGS) -c -o $@ $^

object:
	mkdir -p $@

clean:
	rm -rf $(BINARY) $(OBJECTS) $(DEPS) $(TARGETDIR)