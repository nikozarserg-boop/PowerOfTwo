#!/usr/bin/env python

import os
import sys

def compute_pi_digits():
    q, r, t, k, n, l = 1, 0, 1, 1, 3, 3
    
    while True:
        if 4 * q + r - t < n * t:
            yield n
            
            nr = 10 * (r - n * t)
            n = ((10 * (3 * q + r)) // t) - 10 * n
            q *= 10
            r = nr
        else:
            nr = (2 * q + r) * l
            nn = (q * (7 * k + 2) + r * l) // (t * l)
            q *= k
            t *= l
            l += 2
            k += 1
            n = nn
            r = nr

def count_digits_in_file(filepath):
    if not os.path.exists(filepath):
        return 0
    
    with open(filepath, "r") as f:
        content = f.read()
    
    content = content.replace("\n", "").replace(" ", "")
    
    if content.startswith("3."):
        return len(content) - 2
    
    return 0

if __name__ == "__main__":
    script_dir = os.path.dirname(os.path.abspath(__file__))
    log_file = os.path.join(script_dir, "pi_digits.log")
    
    digits_already_computed = count_digits_in_file(log_file)
    
    print("Computing Pi Decimal Digits (Spigot Algorithm)")
    print("=" * 50)
    print(f"Логирование в: {log_file}")
    
    if digits_already_computed > 0:
        print(f"Найден существующий лог с {digits_already_computed} цифрами")
        print(f"Пропускаем {digits_already_computed} цифр...")
    else:
        print("Новый лог файл\n")
    
    pi_gen = compute_pi_digits()
    digit_count = 0
    
    if digits_already_computed > 0:
        for i in range(digits_already_computed + 1):
            next(pi_gen)
            if (i + 1) % 5000 == 0:
                print(f"  Пропущено {i + 1} цифр...", flush=True)
        digit_count = digits_already_computed
        print(f"Продолжаем с позиции {digits_already_computed + 1}...\n")
    
    mode = "a" if digits_already_computed > 0 else "w"
    
    with open(log_file, mode) as f:
        if digits_already_computed == 0:
            first_digit = next(pi_gen)
            output = f"{first_digit}."
            print(output, end="", flush=True)
            f.write(output)
            f.flush()
        
        try:
            while True:
                digit = next(pi_gen)
                print(digit, end="", flush=True)
                f.write(str(digit))
                f.flush()
                
                digit_count += 1
                
                if digit_count % 50 == 0:
                    print(f"  [{digit_count}]")
                    f.write("\n")
                    f.flush()
        except KeyboardInterrupt:
            print(f"\n\nОстановлено. Всего вычислено {digit_count + 1} цифр (включая 3)")
            f.write(f"\n\n[Остановлено. Всего {digit_count + 1} цифр]\n")
