import java.math.BigInteger;

public class StreamPiDigits {
    public static void main(String[] args) {
        System.out.println("Computing Pi Decimal Digits (Spigot Algorithm)");
        System.out.println("================================================");
        
        BigInteger q = BigInteger.ONE;
        BigInteger r = BigInteger.ZERO;
        BigInteger t = BigInteger.ONE;
        BigInteger k = BigInteger.ONE;
        BigInteger n = BigInteger.valueOf(3);
        BigInteger l = BigInteger.valueOf(3);
        
        System.out.print("3.");
        System.out.flush();
        
        int digitCount = 1;
        int maxDigits = 10000;
        
        while (digitCount < maxDigits) {
            BigInteger four_q = q.multiply(BigInteger.valueOf(4));
            BigInteger four_q_plus_r = four_q.add(r);
            BigInteger four_q_plus_r_minus_t = four_q_plus_r.subtract(t);
            BigInteger n_times_t = n.multiply(t);
            
            if (four_q_plus_r_minus_t.compareTo(n_times_t) < 0) {
                System.out.print(n);
                digitCount++;
                
                BigInteger r_minus_n_t = r.subtract(n.multiply(t));
                BigInteger nr = BigInteger.valueOf(10).multiply(r_minus_n_t);
                
                BigInteger three_q_plus_r = BigInteger.valueOf(3).multiply(q).add(r);
                BigInteger ten_three_q_plus_r = BigInteger.valueOf(10).multiply(three_q_plus_r);
                BigInteger nn = ten_three_q_plus_r.divide(t).subtract(BigInteger.valueOf(10).multiply(n));
                
                q = BigInteger.valueOf(10).multiply(q);
                r = nr;
                n = nn;
                
                if (digitCount % 50 == 1) {
                    System.out.println();
                }
                
                System.out.flush();
            } else {
                BigInteger two_q_plus_r = BigInteger.valueOf(2).multiply(q).add(r);
                BigInteger nr = two_q_plus_r.multiply(l);
                
                BigInteger seven_k_plus_2 = BigInteger.valueOf(7).multiply(k).add(BigInteger.valueOf(2));
                BigInteger q_times_seven_k_plus_2 = q.multiply(seven_k_plus_2);
                BigInteger r_times_l = r.multiply(l);
                BigInteger numerator = q_times_seven_k_plus_2.add(r_times_l);
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
        
        System.out.println();
    }
}
