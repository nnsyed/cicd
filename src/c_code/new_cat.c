#include <stdio.h>
#include <stdlib.h>

void copy_stream(FILE *in, FILE *out) {
    char buffer[4096];
    size_t bytes;
    while ((bytes = fread(buffer, 1, sizeof(buffer), in)) > 0) {
        fwrite(buffer, 1, bytes, out);
    }
}

int main(int argc, char *argv[]) {
    if (argc == 1) {
        copy_stream(stdin, stdout);
        return 0;
    }

    for (int i = 1; i < argc; i++) {
        FILE *fp = fopen(argv[i], "rb");
        if (!fp) {
            perror(argv[i]);
            continue;
        }
        copy_stream(fp, stdout);
        fclose(fp);
    }
    return 0;
}

