import std.stdio;
import std.bigint;
import std.conv;

void main()
{
    string header = "Computing powers of two (Big Integer)";
    string separator = "======================================";

    writeln(header);
    writeln(separator);
    writeln("");

    BigInt value = 1;
    long power = 0;

    while (true)
    {
        string result = "2^" ~ to!string(power) ~ " = " ~ to!string(value);
        writeln(result);

        value *= 2;
        power++;
    }
}
