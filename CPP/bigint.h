#ifndef BIGINT_H
#define BIGINT_H

#include <cstdlib>
#include <cstring>
#include <iostream>
#include <vector>

class BigInt {
public:
    std::vector<unsigned char> digits;
    int length;
    
    BigInt(unsigned long long value = 0) : length(0) {
        if (value == 0) {
            digits.push_back(0);
            length = 1;
            return;
        }
        
        while (value > 0) {
            digits.push_back(static_cast<unsigned char>(value & 0xFF));
            value >>= 8;
            length++;
        }
    }
    
    BigInt(const BigInt &other) : digits(other.digits), length(other.length) {}
    
    BigInt& operator=(const BigInt &other) {
        if (this != &other) {
            digits = other.digits;
            length = other.length;
        }
        return *this;
    }
    
    BigInt& operator*=(int multiplier) {
        if (multiplier != 2) {
            throw std::invalid_argument("Only multiplication by 2 is supported");
        }
        
        unsigned int carry = 0;
        
        for (int i = 0; i < length; i++) {
            unsigned int temp = (digits[i] << 1) | carry;
            digits[i] = temp & 0xFF;
            carry = temp >> 8;
        }
        
        while (carry > 0) {
            digits.push_back(carry & 0xFF);
            length++;
            carry >>= 8;
        }
        
        return *this;
    }
    
    bool is_zero() const {
        return length == 1 && digits[0] == 0;
    }
    
    void print() const {
        if (length == 0) {
            std::cout << "0";
            return;
        }
        
        BigInt temp = *this;
        
        char result[1024] = {0};
        int pos = 0;
        
        while (!temp.is_zero()) {
            unsigned int remainder = 0;
            
            for (int i = temp.length - 1; i >= 0; i--) {
                unsigned int temp_val = (remainder << 8) | temp.digits[i];
                temp.digits[i] = temp_val / 10;
                remainder = temp_val % 10;
            }
            
            result[pos++] = '0' + remainder;
            
            while (temp.length > 1 && temp.digits[temp.length - 1] == 0) {
                temp.length--;
            }
        }
        
        for (int i = pos - 1; i >= 0; i--) {
            std::cout << result[i];
        }
    }
};

#endif
