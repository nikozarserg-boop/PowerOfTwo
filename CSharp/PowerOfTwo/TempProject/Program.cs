using System;
using System.IO;
using System.Numerics;
using System.Text;

class Program
{
    static void Main()
    {
        string logPath = Path.Combine(Directory.GetCurrentDirectory(), "PowerOfTwo.log");
        
        try
        {
            using (StreamWriter logFile = new StreamWriter(logPath, false, Encoding.UTF8))
            {
                logFile.WriteLine("Computing powers of two (Big Integer)");
                logFile.WriteLine("=====================================\n");
                logFile.Flush();

                Console.WriteLine("Computing powers of two (Big Integer)");
                Console.WriteLine("=====================================\n");

                BigInteger value = 1;
                long power = 0;

                while (power < 1000)
                {
                    string result = $"2^{power} = {value}";
                    logFile.WriteLine(result);
                    logFile.Flush();
                    Console.WriteLine(result);

                    value *= 2;
                    power++;
                }

                Console.WriteLine($"Finished. Computed {power} powers");
                logFile.WriteLine($"Finished. Computed {power} powers");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
        }
    }
}
