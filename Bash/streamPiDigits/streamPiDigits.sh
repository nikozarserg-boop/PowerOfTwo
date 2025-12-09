#!/bin/bash

echo "Computing Pi Decimal Digits (Spigot Algorithm)"
echo "================================================"

MAX_DIGITS=10000
LEN=$((10 * MAX_DIGITS / 3))

# Initialize array with 2s
declare -a a
for ((j = 0; j <= LEN; j++)); do
    a[$j]=2
done

nines=0
predigit=0

printf "3."

for ((j = 1; j <= MAX_DIGITS; j++)); do
    q=0
    
    for ((i = LEN; i >= 1; i--)); do
        x=$((10 * a[i] + q * i))
        a[$i]=$((x % (2 * i - 1)))
        q=$((x / (2 * i - 1)))
    done
    
    a[1]=$((q % 10))
    q=$((q / 10))
    
    if [[ $q -eq 9 ]]; then
        ((nines++))
    elif [[ $q -eq 10 ]]; then
        printf "%d" $((predigit + 1))
        for ((k = 0; k < nines; k++)); do
            printf "0"
        done
        predigit=0
        nines=0
    else
        printf "%d" $predigit
        predigit=$q
        if [[ $nines -ne 0 ]]; then
            for ((k = 0; k < nines; k++)); do
                printf "9"
            done
            nines=0
        fi
    fi
    
    if [[ $((j % 50)) -eq 0 ]]; then
        printf "\n"
    fi
done

echo
echo "$predigit"
