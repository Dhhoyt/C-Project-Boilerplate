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

GREEN = \033[1;32m
BLUE = \033[1;34m
ORANGE = \033[1;33m
LIGHTPURPLE = \033[1;35m

all: $(BINARY)
	@echo -e "$(GREEN)Successfully Compiled :3"

$(BINARY): $(OBJECTS) | target
	@echo -e "$(BLUE)Linking"
	@$(CC) -o ./$(TARGETDIR)/$@ $^

target:
	@mkdir ./$(TARGETDIR)

$(OBJECTDIR)/%.o: src/%.c | object
	@echo -e "$(ORANGE)Compiling $(LIGHTPURPLE)'$^'"
	@$(CC) $(CFLAGS) -c -o $@ $^

object:
	@mkdir -p $@

clean:
	@rm -rf $(BINARY) $(OBJECTDIR) $(DEPS) $(TARGETDIR)
	@echo -e "$(GREEN)All Clean"