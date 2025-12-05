import 'dart:io';

void main() {
  final logPath = '${Directory.current.path}${Platform.pathSeparator}PowerOfTwo.log';
  final logFile = File(logPath);

  final header = 'Computing powers of two (Big Integer)';
  final separator = '======================================';

  logFile.writeAsStringSync('$header\n$separator\n\n');

  print(header);
  print(separator);
  print('');

  BigInt value = BigInt.one;
  int power = 0;

  try {
    while (power < 1000) {
      final result = '2^$power = $value';

      logFile.writeAsStringSync('$result\n', mode: FileMode.append);

      print(result);

      value = value * BigInt.two;
      power++;
    }
  } catch (e) {
    print('Error: $e');
  }
}
