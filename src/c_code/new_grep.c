#define _POSIX_C_SOURCE 200809L
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void search_stream(FILE *fp, const char *pattern, const char *filename, int show_name) {
    char *line = NULL;
    size_t len = 0;

    while (getline(&line, &len, fp) != -1) {
        if (strstr(line, pattern) != NULL) {
            if (show_name) printf("%s:", filename);
            printf("%s", line);
        }
    }
    free(line);
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <pattern> [file...]\n", argv[0]);
        return 1;
    }

    const char *pattern = argv[1];
    if (argc == 2) {
        search_stream(stdin, pattern, NULL, 0);
    } else {
        int show_name = (argc > 3);
        for (int i = 2; i < argc; i++) {
            FILE *fp = fopen(argv[i], "r");
            if (!fp) {
                perror(argv[i]);
                continue;
            }
            search_stream(fp, pattern, argv[i], show_name);
            fclose(fp);
        }
    }
    return 0;
}

