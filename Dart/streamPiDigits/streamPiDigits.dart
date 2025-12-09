import 'dart:io';

void main() async {
  print('Computing Pi Decimal Digits (Spigot Algorithm - Infinite)');
  print('=========================================================');
  
  var logFile = File('pi_digits_dart.log');
  var sink = logFile.openWrite();
  
  print('Logging to: pi_digits_dart.log\n');
  
  stdout.write('3.');
  sink.write('3.');
  
  BigInt q = BigInt.one;
  BigInt r = BigInt.zero;
  BigInt t = BigInt.one;
  BigInt k = BigInt.one;
  BigInt n = BigInt.from(3);
  BigInt l = BigInt.from(3);
  
  int digitCount = 1;
  int maxDigits = 100000;
  
  for (int iterations = 0; iterations < maxDigits; iterations++) {
    if ((BigInt.from(4) * q + r - t) < (n * t)) {
      String digit = n.toString();
      stdout.write(digit);
      sink.write(digit);
      digitCount++;
      
      BigInt nr = BigInt.from(10) * (r - n * t);
      n = ((BigInt.from(10) * (BigInt.from(3) * q + r)) ~/ t) -
          (BigInt.from(10) * n);
      q = BigInt.from(10) * q;
      r = nr;
      
      if (digitCount % 50 == 1) {
        stdout.writeln('');
        sink.write('\n');
      }
      
      if (digitCount % 500 == 0) {
        stderr.writeln('Progress: $digitCount digits...');
      }
    } else {
      BigInt nr = (BigInt.from(2) * q + r) * l;
      BigInt nn = (q * (BigInt.from(7) * k + BigInt.from(2)) + r * l) ~/ (t * l);
      q = q * k;
      t = t * l;
      l = l + BigInt.from(2);
      k = k + BigInt.one;
      n = nn;
      r = nr;
    }
  }
  
  print('\n\nFinished. Generated $digitCount digits.');
  sink.write('\n\nFinished. Generated $digitCount digits.');
  
  await sink.close();
}
