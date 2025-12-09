import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public class PowerOfTwo {
    private static PrintWriter logFile;
    
    static {
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            if (logFile != null) {
                logFile.flush();
                logFile.close();
            }
        }));
    }
    
    public static void main(String[] args) {
        String logPath = getLogPath();
        
        try {
            logFile = new PrintWriter(new FileWriter(logPath));
        } catch (IOException e) {
            System.out.println("Ошибка: не удалось открыть файл для записи");
            return;
        }
        
        logFile.println("Вычисление степеней двойки (Big Integer)");
        logFile.println("========================================\n");
        logFile.flush();
        
        System.out.println("Вычисление степеней двойки (Big Integer)");
        System.out.println("========================================\n");
        
        BigInt value = new BigInt(1);
        long maxPowers = 10000;
        
        for (long power = 0; power < maxPowers; power++) {
            String result = String.format("2^%d = %s", power, value.toString());
            logFile.println(result);
            logFile.flush();
            System.out.println(result);
            
            if (power % 100 == 0) {
                System.err.println("Progress: " + power + " powers computed");
            }
            
            value.mul2();
        }
        
        logFile.println("Finished. Computed " + maxPowers + " powers");
        logFile.flush();
        System.out.println("Finished. Computed " + maxPowers + " powers");
    }
    
    private static String getLogPath() {
        try {
            String currentDir = System.getProperty("user.dir");
            return currentDir + File.separator + "PowerOfTwo.log";
        } catch (Exception e) {
            return "PowerOfTwo.log";
        }
    }
}
