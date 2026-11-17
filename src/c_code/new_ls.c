#include <stdio.h>
#include <dirent.h>
#include <errno.h>

void list_dir(const char *path) {
    DIR *dir = opendir(path);
    if (!dir) {
        perror(path);
        return;
    }

    struct dirent *entry;
    while ((entry = readdir(dir)) != NULL) {
        // Skip hidden files (., .., .git, etc.)
        if (entry->d_name[0] == '.') {
            continue;
        }
        printf("%s  ", entry->d_name);
    }
    printf("\n");
    closedir(dir);
}

int main(int argc, char *argv[]) {
    if (argc == 1) {
        list_dir(".");
    } else {
        for (int i = 1; i < argc; i++) {
            if (argc > 2) printf("%s:\n", argv[i]);
            list_dir(argv[i]);
        }
    }
    return 0;
}

