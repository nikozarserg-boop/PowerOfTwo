#!/usr/bin/env python3

import os
import sys
from pathlib import Path

if sys.version_info >= (3, 11):
    sys.set_int_max_str_digits(0)


def get_log_path():
    script_dir = Path(__file__).resolve().parent
    return script_dir / "PowerOfTwo.log"


def main():
    log_path = get_log_path()
    
    try:
        log_file = open(log_path, 'w', encoding='utf-8')
    except IOError as e:
        print(f"Ошибка: не удалось открыть файл для записи: {e}")
        return 1
    
    try:
        log_file.write("Вычисление степеней двойки (Big Integer)\n")
        log_file.write("========================================\n\n")
        log_file.flush()
        
        print("Вычисление степеней двойки (Big Integer)")
        print("========================================\n")
        
        power = 0
        value = 1
        
        while True:
            try:
                result = f"2^{power} = {value}"
                log_file.write(result + "\n")
                log_file.flush()
                print(result)
                
                value *= 2
                power += 1
            except MemoryError as e:
                error_msg = f"\nОшибка: недостаточно памяти на степени 2^{power}\n"
                log_file.write(error_msg)
                log_file.write(f"Детали: {str(e)}\n")
                log_file.flush()
                print(error_msg)
                print(f"Детали: {e}")
                break
            except Exception as e:
                error_msg = f"\nОшибка на степени 2^{power}: {type(e).__name__}\n"
                log_file.write(error_msg)
                log_file.write(f"Детали: {str(e)}\n")
                log_file.flush()
                print(error_msg)
                print(f"Детали: {e}")
                break
    
    except KeyboardInterrupt:
        log_file.write("\nПрограмма прервана пользователем\n")
        log_file.flush()
        print("\nПрограмма прервана пользователем")
    except Exception as e:
        log_file.write(f"\nКритическая ошибка: {type(e).__name__}\n")
        log_file.write(f"Детали: {str(e)}\n")
        log_file.flush()
        print(f"\nКритическая ошибка: {e}")
    finally:
        log_file.close()
    
    return 0


if __name__ == "__main__":
    sys.exit(main())
