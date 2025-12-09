#include <stdio.h>
#include <string.h>
#include <signal.h>
#include "bigint.h"

static FILE *g_log_file = NULL;

void signal_handler(int sig) {
    if (g_log_file) {
        fflush(g_log_file);
        fclose(g_log_file);
    }
    exit(sig);
}

int main() {
    char log_path[512];
    strncpy(log_path, __FILE__, sizeof(log_path) - 1);
    log_path[sizeof(log_path) - 1] = '\0';
    
    char *last_slash = strrchr(log_path, '\\');
    if (last_slash) {
        snprintf(last_slash + 1, sizeof(log_path) - (last_slash + 1 - log_path), "PowerOfTwo.log");
    } else {
        strncpy(log_path, "PowerOfTwo.log", sizeof(log_path) - 1);
    }
    
    FILE *log_file = fopen(log_path, "w");
    if (!log_file) {
        printf("Ошибка: не удалось открыть файл для записи\n");
        return 1;
    }
    
    g_log_file = log_file;
    signal(SIGINT, signal_handler);
    signal(SIGTERM, signal_handler);
    
    setvbuf(log_file, NULL, _IOLBF, 0);
    
    fprintf(log_file, "Вычисление степеней двойки (Big Integer)\n");
    fprintf(log_file, "========================================\n\n");
    printf("Вычисление степеней двойки (Big Integer)\n");
    printf("========================================\n\n");
    
    BigInt *value = bigint_new(1);
    
    BigInt *temp = malloc(sizeof(BigInt));
    temp->digits = NULL;
    temp->capacity = 0;
    temp->length = 0;
    
    char result[4096] = {0};
    
    for (long long power = 0; ; power++) {
        fprintf(log_file, "2^%lld = ", power);
        printf("2^%lld = ", power);
        
        if (value->length == 0) {
            fputc('0', log_file);
            fputc('0', stdout);
        } else {
            if (temp->capacity < value->capacity) {
                temp->digits = realloc(temp->digits, value->capacity);
                temp->capacity = value->capacity;
            }
            temp->length = value->length;
            memcpy(temp->digits, value->digits, value->length);
            
            int pos = 0;
            
            while (temp->length > 0 || temp->digits[0] > 0) {
                unsigned int remainder = 0;
                for (int i = temp->length - 1; i >= 0; i--) {
                    unsigned int temp_val = (remainder << 8) | temp->digits[i];
                    temp->digits[i] = temp_val / 10;
                    remainder = temp_val % 10;
                }
                result[pos++] = '0' + remainder;
                
                while (temp->length > 1 && temp->digits[temp->length - 1] == 0) {
                    temp->length--;
                }
                if (temp->length == 1 && temp->digits[0] == 0) break;
            }
            
            for (int i = pos - 1; i >= 0; i--) {
                char c = result[i];
                fputc(c, log_file);
                fputc(c, stdout);
            }
        }
        
        fputs("\n", log_file);
        fputs("\n", stdout);
        
        bigint_mul_2(value);
    }
    
    free(temp->digits);
    free(temp);
    bigint_free(value);
    fclose(log_file);
    return 0;
}
