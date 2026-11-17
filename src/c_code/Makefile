CC = gcc
CFLAGS = -Wall -Wextra -O2 -std=c11

# List of all target binaries and archive name
TARGETS = my_cat my_ls my_wc my_grep
ARCHIVE = utilities.tar.gz

# Default rule: builds all targets
all: $(TARGETS)

# Pattern rule: compiles each .c file into its matching binary
%: %.c
	$(CC) $(CFLAGS) $< -o $@

# Package compiled binaries into a compressed tarball
package: $(TARGETS)
	tar -czvf $(ARCHIVE) $(TARGETS)

# Remove compiled binaries and the archive
clean:
	rm -f $(TARGETS) $(ARCHIVE)

# Declare targets that do not represent actual files
.PHONY: all package clean
