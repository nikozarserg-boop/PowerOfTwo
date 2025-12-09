import std.stdio;
import std.bigint;

void main() {
    writeln("Computing Pi Decimal Digits (Spigot Algorithm - Infinite)");
    writeln("=========================================================");
    
    auto logFile = File("pi_digits_d.log", "w");
    writeln("Logging to: pi_digits_d.log\n");
    
    write("3.");
    logFile.write("3.");
    stdout.flush();
    logFile.flush();
    
    BigInt q = 1, r = 0, t = 1, k = 1, n = 3, l = 3;
    int digitCount = 1;
    int maxDigits = 100000;
    
    for (int iterations = 0; iterations < maxDigits; iterations++) {
        if (4 * q + r - t < n * t) {
            write(n);
            logFile.write(n);
            digitCount++;
            
            BigInt nr = 10 * (r - n * t);
            n = ((10 * (3 * q + r)) / t) - 10 * n;
            q = 10 * q;
            r = nr;
            
            if (digitCount % 50 == 1) {
                writeln();
                logFile.writeln();
            }
            
            if (digitCount % 500 == 0) {
                stderr.writefln("Progress: %d digits...", digitCount);
            }
            
            stdout.flush();
            logFile.flush();
        } else {
            BigInt nr = (2 * q + r) * l;
            BigInt nn = (q * (7 * k + 2) + r * l) / (t * l);
            q = q * k;
            t = t * l;
            l = l + 2;
            k = k + 1;
            n = nn;
            r = nr;
        }
    }
    
    writefln("\n\nFinished. Generated %d digits.", digitCount);
    logFile.writefln("\n\nFinished. Generated %d digits.", digitCount);
    logFile.close();
}
