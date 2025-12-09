using System;
using System.IO;
using System.Numerics;

class StreamPiDigits {
    static void Main() {
        Console.WriteLine("Computing Pi Decimal Digits (Spigot Algorithm - Infinite)");
        Console.WriteLine("=========================================================");
        
        try {
            using (StreamWriter log = new StreamWriter("pi_digits_csharp.log")) {
                Console.WriteLine("Logging to: pi_digits_csharp.log\n");
                
                Console.Write("3.");
                log.Write("3.");
                
                BigInteger q = 1;
                BigInteger r = 0;
                BigInteger t = 1;
                BigInteger k = 1;
                BigInteger n = 3;
                BigInteger l = 3;
                
                int digitCount = 1;
                int maxDigits = 100000;
                
                for (int iterations = 0; iterations < maxDigits; iterations++) {
                    if (4 * q + r - t < n * t) {
                        Console.Write(n);
                        log.Write(n);
                        digitCount++;
                        
                        BigInteger nr = 10 * (r - n * t);
                        n = ((10 * (3 * q + r)) / t) - 10 * n;
                        q = 10 * q;
                        r = nr;
                        
                        if (digitCount % 50 == 1) {
                            Console.WriteLine();
                            log.WriteLine();
                        }
                        
                        if (digitCount % 500 == 0) {
                            Console.Error.WriteLine($"Progress: {digitCount} digits...");
                        }
                        
                        Console.Out.Flush();
                        log.Flush();
                    } else {
                        BigInteger nr = (2 * q + r) * l;
                        BigInteger nn = (q * (7 * k + 2) + r * l) / (t * l);
                        q = q * k;
                        t = t * l;
                        l = l + 2;
                        k = k + 1;
                        n = nn;
                        r = nr;
                    }
                }
                
                Console.WriteLine($"\n\nFinished. Generated {digitCount} digits.");
                log.WriteLine($"\n\nFinished. Generated {digitCount} digits.");
            }
        } catch (Exception ex) {
            Console.WriteLine($"Error: {ex.Message}");
        }
    }
}
