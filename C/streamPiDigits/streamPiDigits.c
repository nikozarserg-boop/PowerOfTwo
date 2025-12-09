#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    printf("Computing Pi Decimal Digits (Spigot Algorithm - No Dependencies)\n");
    printf("=================================================================\n");
    
    const char *log_file = "pi_digits_c.log";
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
    if (!a) {
        fprintf(stderr, "Memory allocation failed\n");
        fclose(log_fp);
        return 1;
    }
    
    for (int j = 0; j <= len; j++) {
        a[j] = 2;
    }
    
    int nines = 0;
    int predigit = 0;
    int digit_count = 0;
    
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
        
        digit_count = j;
        
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
    
    fprintf(stderr, "\nFinished. Generated %d digits.\n", digit_count);
    fprintf(log_fp, "\nFinished. Generated %d digits.\n", digit_count);
    
    free(a);
    fclose(log_fp);
    
    return 0;
}
