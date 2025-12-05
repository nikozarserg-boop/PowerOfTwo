#include <iostream>
#include <fstream>
#include <string>
#include <csignal>
#include <cstring>
#include "bigint.h"

static std::ofstream g_log_file;

void signal_handler(int sig) {
    if (g_log_file.is_open()) {
        g_log_file.flush();
        g_log_file.close();
    }
    exit(sig);
}

int main() {
    std::string log_path = __FILE__;
    size_t last_slash = log_path.find_last_of('\\');
    if (last_slash != std::string::npos) {
        log_path = log_path.substr(0, last_slash + 1) + "PowerOfTwo.log";
    } else {
        log_path = "PowerOfTwo.log";
    }
    
    g_log_file.open(log_path, std::ios::out);
    if (!g_log_file.is_open()) {
        std::cout << "Ошибка: не удалось открыть файл для записи\n";
        return 1;
    }
    
    std::signal(SIGINT, signal_handler);
    std::signal(SIGTERM, signal_handler);
    
    g_log_file << "Вычисление степеней двойки (Big Integer)\n";
    g_log_file << "========================================\n\n";
    g_log_file.flush();
    
    std::cout << "Вычисление степеней двойки (Big Integer)\n";
    std::cout << "========================================\n\n";
    
    BigInt value(1);
    
    char result[4096] = {0};
    
    for (long long power = 0; ; power++) {
        g_log_file << "2^" << power << " = ";
        std::cout << "2^" << power << " = ";
        
        if (value.is_zero()) {
            g_log_file << '0';
            std::cout << '0';
        } else {
            BigInt temp = value;
            int pos = 0;
            
            while (!temp.is_zero() && pos < 4096) {
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
                if (temp.length == 1 && temp.digits[0] == 0) break;
            }
            
            for (int i = pos - 1; i >= 0; i--) {
                char c = result[i];
                g_log_file << c;
                std::cout << c;
            }
        }
        
        g_log_file << "\n";
        g_log_file.flush();
        std::cout << "\n";
        
        value *= 2;
    }
    
    g_log_file.close();
    return 0;
}
