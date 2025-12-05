#ifndef BIGINT_H
#define BIGINT_H

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef struct {
    unsigned char *digits;
    int length;
    int capacity;
} BigInt;

BigInt* bigint_new(unsigned long long value) {
    BigInt *bi = (BigInt *)malloc(sizeof(BigInt));
    bi->capacity = 16;
    bi->digits = (unsigned char *)malloc(bi->capacity);
    bi->length = 0;
    
    if (value == 0) {
        bi->digits[0] = 0;
        bi->length = 1;
        return bi;
    }
    
    while (value > 0) {
        if (bi->length >= bi->capacity) {
            bi->capacity *= 2;
            bi->digits = (unsigned char *)realloc(bi->digits, bi->capacity);
        }
        bi->digits[bi->length++] = value & 0xFF;
        value >>= 8;
    }
    
    return bi;
}

void bigint_free(BigInt *bi) {
    if (bi) {
        free(bi->digits);
        free(bi);
    }
}

void bigint_mul_2(BigInt *bi) {
    unsigned int carry = 0;
    
    for (int i = 0; i < bi->length; i++) {
        unsigned int temp = (bi->digits[i] << 1) | carry;
        bi->digits[i] = temp & 0xFF;
        carry = temp >> 8;
    }
    
    while (carry > 0) {
        if (bi->length >= bi->capacity) {
            bi->capacity *= 2;
            bi->digits = (unsigned char *)realloc(bi->digits, bi->capacity);
        }
        bi->digits[bi->length++] = carry & 0xFF;
        carry >>= 8;
    }
}

void bigint_print(BigInt *bi) {
    if (bi->length == 0) {
        printf("0");
        return;
    }
    
    BigInt *temp = (BigInt *)malloc(sizeof(BigInt));
    temp->capacity = bi->capacity;
    temp->digits = (unsigned char *)malloc(temp->capacity);
    temp->length = bi->length;
    memcpy(temp->digits, bi->digits, bi->length);
    
    char result[1024] = {0};
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
        printf("%c", result[i]);
    }
    
    free(temp->digits);
    free(temp);
}

#endif
