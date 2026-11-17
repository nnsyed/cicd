#include <stdio.h>
#include <ctype.h>

void count_stream(FILE *fp, const char *filename) {
    long lines = 0, words = 0, bytes = 0;
    int c, in_word = 0;

    while ((c = fgetc(fp)) != EOF) {
        bytes++;
        if (c == '\n') {
            lines++;
        }
        if (isspace(c)) {
            in_word = 0;
        } else if (!in_word) {
            in_word = 1;
            words++;
        }
    }
    printf("%7ld %7ld %7ld %s\n", lines, words, bytes, filename ? filename : "");
}

int main(int argc, char *argv[]) {
    if (argc == 1) {
        count_stream(stdin, NULL);
    } else {
        for (int i = 1; i < argc; i++) {
            FILE *fp = fopen(argv[i], "r");
            if (!fp) {
                perror(argv[i]);
                continue;
            }
            count_stream(fp, argv[i]);
            fclose(fp);
        }
    }
    return 0;
}

