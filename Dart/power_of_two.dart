import 'dart:io';

void main() {
  final logPath = '${Directory.current.path}${Platform.pathSeparator}PowerOfTwo.log';
  final logFile = File(logPath);

  final header = 'Computing powers of two (Big Integer)';
  final separator = '======================================';

  // Write to log file
  logFile.writeAsStringSync('$header\n$separator\n\n');

  // Print to console
  print(header);
  print(separator);
  print('');

  BigInt value = BigInt.one;
  int power = 0;

  try {
    while (power < 1000) {
      final result = '2^$power = $value';

      // Write to log file
      logFile.writeAsStringSync('$result\n', mode: FileMode.append);

      // Print to console
      print(result);

      value = value * BigInt.two;
      power++;
    }
  } catch (e) {
    print('Error: $e');
  }
}
