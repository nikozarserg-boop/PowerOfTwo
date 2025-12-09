import java.math.BigInteger;
import java.io.*;

public class StreamPiDigits {
    public static void main(String[] args) {
        System.out.println("Computing Pi Decimal Digits (Spigot Algorithm - Infinite)");
        System.out.println("=========================================================");
        
        try {
            FileWriter logFile = new FileWriter("pi_digits_java.log");
            
            System.out.println("Logging to: pi_digits_java.log\n");
            System.out.print("3.");
            logFile.write("3.");
            System.out.flush();
            logFile.flush();
            
            BigInteger q = BigInteger.ONE;
            BigInteger r = BigInteger.ZERO;
            BigInteger t = BigInteger.ONE;
            BigInteger k = BigInteger.ONE;
            BigInteger n = BigInteger.valueOf(3);
            BigInteger l = BigInteger.valueOf(3);
            
            int digitCount = 1;
            int maxDigits = 100000;
            
            for (int iterations = 0; iterations < maxDigits; iterations++) {
                BigInteger fourQ = q.multiply(BigInteger.valueOf(4));
                BigInteger condition = fourQ.add(r).subtract(t);
                BigInteger nTimesT = n.multiply(t);
                
                if (condition.compareTo(nTimesT) < 0) {
                    System.out.print(n);
                    logFile.write(n.toString());
                    digitCount++;
                    
                    BigInteger rMinusNT = r.subtract(n.multiply(t));
                    BigInteger nr = rMinusNT.multiply(BigInteger.valueOf(10));
                    
                    BigInteger threeQPlusR = BigInteger.valueOf(3).multiply(q).add(r);
                    BigInteger nn = threeQPlusR.multiply(BigInteger.valueOf(10)).divide(t)
                            .subtract(BigInteger.valueOf(10).multiply(n));
                    
                    q = q.multiply(BigInteger.valueOf(10));
                    r = nr;
                    n = nn;
                    
                    if (digitCount % 50 == 1) {
                        System.out.println();
                        logFile.write("\n");
                    }
                    
                    if (digitCount % 500 == 0) {
                        System.err.println("Progress: " + digitCount + " digits...");
                    }
                    
                    System.out.flush();
                    logFile.flush();
                } else {
                    BigInteger twoQPlusR = BigInteger.valueOf(2).multiply(q).add(r);
                    BigInteger nr = twoQPlusR.multiply(l);
                    
                    BigInteger sevenKPlus2 = BigInteger.valueOf(7).multiply(k).add(BigInteger.valueOf(2));
                    BigInteger numerator = q.multiply(sevenKPlus2).add(r.multiply(l));
                    BigInteger denominator = t.multiply(l);
                    BigInteger nn = numerator.divide(denominator);
                    
                    q = q.multiply(k);
                    t = t.multiply(l);
                    l = l.add(BigInteger.valueOf(2));
                    k = k.add(BigInteger.ONE);
                    n = nn;
                    r = nr;
                }
            }
            
            System.out.println("\n\nFinished. Generated " + digitCount + " digits.");
            logFile.write("\n\nFinished. Generated " + digitCount + " digits.");
            logFile.close();
        } catch (IOException e) {
            System.err.println("Error: " + e.getMessage());
        }
    }
}
