#!/bin/bash

echo "Computing Pi Decimal Digits (Spigot Algorithm - Infinite with bc)"
echo "=================================================================="

LOG_FILE="pi_digits_bash.log"
> "$LOG_FILE"

echo "Logging to: $LOG_FILE"
echo ""

echo -n "3." | tee -a "$LOG_FILE"

q=1
r=0
t=1
k=1
n=3
l=3

digit_count=1
max_digits=10000

for ((iterations = 0; iterations < max_digits; iterations++)); do
    condition=$(echo "4*$q + $r - $t < $n*$t" | bc)
    
    if [[ $condition -eq 1 ]]; then
        echo -n "$n" | tee -a "$LOG_FILE"
        ((digit_count++))
        
        nr=$(echo "10 * ($r - $n*$t)" | bc)
        
        n=$(echo "(10*(3*$q + $r))/$t - 10*$n" | bc)
        
        q=$(echo "10*$q" | bc)
        
        r=$nr
        
        if [[ $((digit_count % 50)) -eq 1 ]]; then
            echo "" | tee -a "$LOG_FILE"
        fi
        
        if [[ $((digit_count % 500)) -eq 0 ]]; then
            echo "Progress: $digit_count digits..." >&2
        fi
    else
        nr=$(echo "(2*$q + $r) * $l" | bc)
        
        nn=$(echo "($q*(7*$k + 2) + $r*$l) / ($t*$l)" | bc)
        
        q=$(echo "$q * $k" | bc)
        t=$(echo "$t * $l" | bc)
        l=$(echo "$l + 2" | bc)
        k=$(echo "$k + 1" | bc)
        n=$nn
        r=$nr
    fi
done

echo "" | tee -a "$LOG_FILE"
echo "Finished. Generated $digit_count digits." | tee -a "$LOG_FILE"
