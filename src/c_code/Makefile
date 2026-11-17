CC = gcc
CFLAGS = -Wall -Wextra -O2 -std=c11

# List of all target binaries
TARGETS = new_cat new_ls new_wc new_grep

# Default rule: builds all targets when you run 'make'
all: $(TARGETS)

# Pattern rule: compiles each .c file into its matching binary
%: %.c
	$(CC) $(CFLAGS) $< -o $@

# Remove compiled binaries
clean:
	rm -f $(TARGETS)

# Declare targets that do not represent actual files
.PHONY: all clean

