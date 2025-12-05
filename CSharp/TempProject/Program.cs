using System;
using System.IO;
using System.Numerics;
using System.Text;

class PowerOfTwo
{
    private static StreamWriter logFile;
    private static bool isRunning = true;

    static void Main()
    {
        string logPath = GetLogPath();
        
        try
        {
            logFile = new StreamWriter(logPath, false, Encoding.UTF8);
        }
        catch (IOException e)
        {
            Console.WriteLine($"Ошибка: не удалось открыть файл для записи: {e.Message}");
            return;
        }

        // Обработка сигналов прерывания
        Console.CancelKeyPress += (sender, e) =>
        {
            e.Cancel = true;
            isRunning = false;
            WriteLog("\nПрограмма прервана пользователем");
        };

        try
        {
            WriteLog("Вычисление степеней двойки (Big Integer)");
            WriteLog("========================================\n");
            
            Console.WriteLine("Вычисление степеней двойки (Big Integer)");
            Console.WriteLine("========================================\n");

            BigInteger value = 1;
            long power = 0;

            while (isRunning)
            {
                try
                {
                    string result = $"2^{power} = {value}";
                    WriteLog(result);
                    Console.WriteLine(result);

                    value *= 2;
                    power++;
                }
                catch (OutOfMemoryException e)
                {
                    string errorMsg = $"\nОшибка: недостаточно памяти на степени 2^{power}";
                    WriteLog(errorMsg);
                    WriteLog($"Детали: {e.Message}");
                    Console.WriteLine(errorMsg);
                    Console.WriteLine($"Детали: {e.Message}");
                    break;
                }
                catch (Exception e)
                {
                    string errorMsg = $"\nОшибка на степени 2^{power}: {e.GetType().Name}";
                    WriteLog(errorMsg);
                    WriteLog($"Детали: {e.Message}");
                    Console.WriteLine(errorMsg);
                    Console.WriteLine($"Детали: {e.Message}");
                    break;
                }
            }
        }
        catch (Exception e)
        {
            string errorMsg = $"\nКритическая ошибка: {e.GetType().Name}";
            WriteLog(errorMsg);
            WriteLog($"Детали: {e.Message}");
            Console.WriteLine(errorMsg);
            Console.WriteLine($"Детали: {e.Message}");
        }
        finally
        {
            if (logFile != null)
            {
                logFile.Flush();
                logFile.Close();
                logFile.Dispose();
            }
        }
    }

    static string GetLogPath()
    {
        try
        {
            string exePath = System.Reflection.Assembly.GetExecutingAssembly().Location;
            string exeDir = Path.GetDirectoryName(exePath);
            return Path.Combine(exeDir, "PowerOfTwo.log");
        }
        catch
        {
            return "PowerOfTwo.log";
        }
    }

    static void WriteLog(string message)
    {
        if (logFile != null)
        {
            logFile.WriteLine(message);
            logFile.Flush();
        }
    }
}
