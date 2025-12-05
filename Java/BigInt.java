import java.util.ArrayList;
import java.util.List;

public class BigInt {
    private List<Byte> digits;
    private int length;
    
    public BigInt(long value) {
        digits = new ArrayList<>();
        length = 0;
        
        if (value == 0) {
            digits.add((byte)0);
            length = 1;
            return;
        }
        
        while (value > 0) {
            digits.add((byte)(value & 0xFF));
            value >>= 8;
            length++;
        }
    }
    
    public BigInt(BigInt other) {
        this.digits = new ArrayList<>(other.digits);
        this.length = other.length;
    }
    
    public void mul2() {
        int carry = 0;
        
        for (int i = 0; i < length; i++) {
            int temp = ((digits.get(i) & 0xFF) << 1) | carry;
            digits.set(i, (byte)(temp & 0xFF));
            carry = temp >> 8;
        }
        
        while (carry > 0) {
            if (length >= digits.size()) {
                digits.add((byte)(carry & 0xFF));
            } else {
                digits.set(length, (byte)(carry & 0xFF));
            }
            length++;
            carry >>= 8;
        }
    }
    
    public boolean isZero() {
        return length == 1 && (digits.get(0) & 0xFF) == 0;
    }
    
    @Override
    public String toString() {
        if (length == 0) {
            return "0";
        }
        
        BigInt temp = new BigInt(this);
        
        StringBuilder result = new StringBuilder();
        
        while (!temp.isZero()) {
            int remainder = 0;
            
            for (int i = temp.length - 1; i >= 0; i--) {
                int tempVal = (remainder << 8) | (temp.digits.get(i) & 0xFF);
                temp.digits.set(i, (byte)(tempVal / 10));
                remainder = tempVal % 10;
            }
            
            result.append((char)('0' + remainder));
            
            while (temp.length > 1 && (temp.digits.get(temp.length - 1) & 0xFF) == 0) {
                temp.length--;
            }
        }
        
        return result.reverse().toString();
    }
}
