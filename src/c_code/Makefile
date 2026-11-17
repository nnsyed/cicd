CC = gcc
CFLAGS = -Wall -Wextra -O2 -std=c11

# Output directory, target binaries, and archive path
BUILD_DIR = targets
TARGETS = $(addprefix $(BUILD_DIR)/, new_cat new_ls new_wc new_grep)
ARCHIVE = $(BUILD_DIR)/utilities.tar.gz

# Default rule: builds all binaries and packages them into the archive
all: $(ARCHIVE)

# Pattern rule: creates the directory if missing and compiles each .c file
$(BUILD_DIR)/%: %.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $< -o $@

# Archive rule: packages all compiled binaries into utilities.tar.gz
$(ARCHIVE): $(TARGETS)
	tar -czvf $@ -C $(BUILD_DIR) $(notdir $(TARGETS))

# Optional alias so "make package" still works
package: $(ARCHIVE)

# Remove the targets directory and all its contents
clean:
	rm -rf $(BUILD_DIR)

# Declare targets that do not represent actual files
.PHONY: all package clean
