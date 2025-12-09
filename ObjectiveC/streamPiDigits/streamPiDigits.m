#import <Foundation/Foundation.h>

int main() {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSLog(@"Computing Pi Decimal Digits (Spigot Algorithm)");
    NSLog(@"================================================");
    
    int maxDigits = 10000;
    int len = (10 * maxDigits) / 3;
    
    int *a = (int *)malloc((len + 1) * sizeof(int));
    for (int i = 0; i <= len; i++) {
        a[i] = 2;
    }
    
    int nines = 0;
    int predigit = 0;
    
    printf("3.");
    fflush(stdout);
    
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
            for (int k = 0; k < nines; k++) {
                printf("0");
            }
            predigit = 0;
            nines = 0;
        } else {
            printf("%d", predigit);
            predigit = q;
            if (nines != 0) {
                for (int k = 0; k < nines; k++) {
                    printf("9");
                }
                nines = 0;
            }
        }
        
        if (j % 50 == 0) {
            printf("\n");
        }
        
        fflush(stdout);
    }
    
    printf("%d\n", predigit);
    
    free(a);
    [pool drain];
    
    return 0;
}
