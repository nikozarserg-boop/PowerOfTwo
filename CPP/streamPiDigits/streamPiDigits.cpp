#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("Computing Pi Decimal Digits (Spigot Algorithm - Infinite)\n");
    printf("=========================================================\n");
    
    const char *log_file = "pi_digits_cpp.log";
    FILE *log_fp = fopen(log_file, "w");
    if (!log_fp) {
        perror("Cannot open log file");
        return 1;
    }
    
    printf("Logging to: %s\n\n", log_file);
    printf("3.");
    fprintf(log_fp, "3.");
    fflush(stdout);
    fflush(log_fp);
    
    int maxDigits = 100000;
    int len = (10 * maxDigits) / 3;
    
    int *a = (int *)malloc((len + 1) * sizeof(int));
    
    for (int j = 0; j <= len; j++) {
        a[j] = 2;
    }
    
    int nines = 0;
    int predigit = 0;
    
    for (int j = 1; j <= maxDigits; j++) {
        int q = 0;
        
        for (int i = len; i >= 1; i--) {
            int x = 10 * a[i] + q * i;
            a[i] = x % (2 * i - 1);
            q = x / (2 * i - 1);
        }
        
        a[1] = q % 10;
        q = q / 10;
        
        if (q == 9) {
            nines++;
        } else if (q == 10) {
            printf("%d", predigit + 1);
            fprintf(log_fp, "%d", predigit + 1);
            for (int k = 0; k < nines; k++) {
                printf("0");
                fprintf(log_fp, "0");
            }
            predigit = 0;
            nines = 0;
        } else {
            printf("%d", predigit);
            fprintf(log_fp, "%d", predigit);
            predigit = q;
            if (nines != 0) {
                for (int k = 0; k < nines; k++) {
                    printf("9");
                    fprintf(log_fp, "9");
                }
                nines = 0;
            }
        }
        
        if (j % 50 == 0) {
            printf("\n");
            fprintf(log_fp, "\n");
        }
        
        if (j % 500 == 0) {
            fprintf(stderr, "Progress: %d digits...\n", j);
        }
        
        fflush(stdout);
        fflush(log_fp);
    }
    
    printf("%d\n", predigit);
    fprintf(log_fp, "%d\n", predigit);
    
    fprintf(stderr, "Finished. Generated %d digits.\n", maxDigits);
    fprintf(log_fp, "\nFinished. Generated %d digits.\n", maxDigits);
    
    free(a);
    fclose(log_fp);
    
    return 0;
}
