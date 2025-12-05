#import <Foundation/Foundation.h>

@interface BigInt : NSObject {
    NSMutableArray *digits;
}

- (instancetype)initWithInt:(int)value;
- (void)multiplyBy2;
- (NSString *)description;

@end

@implementation BigInt

- (instancetype)initWithInt:(int)value {
    self = [super init];
    if (self) {
        digits = [[NSMutableArray alloc] init];
        [digits addObject:@(value)];
    }
    return self;
}

- (void)multiplyBy2 {
    int carry = 0;
    for (NSInteger i = 0; i < [digits count]; i++) {
        int digit = [[digits objectAtIndex:i] intValue];
        int product = digit * 2 + carry;
        [digits replaceObjectAtIndex:i withObject:@(product % 10)];
        carry = product / 10;
    }
    
    while (carry > 0) {
        [digits addObject:@(carry % 10)];
        carry = carry / 10;
    }
}

- (NSString *)description {
    NSMutableString *result = [[NSMutableString alloc] init];
    for (NSInteger i = [digits count] - 1; i >= 0; i--) {
        [result appendString:[NSString stringWithFormat:@"%@", [digits objectAtIndex:i]]];
    }
    return result;
}

- (void)dealloc {
    [digits release];
    [super dealloc];
}

@end

int main(int argc, char *argv[]) {
    @autoreleasepool {
        NSString *logPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"PowerOfTwo.log"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:logPath error:nil];
        
        NSFileHandle *logFile = [NSFileHandle fileHandleForWritingAtPath:logPath];
        if (!logFile) {
            [[NSFileManager defaultManager] createFileAtPath:logPath contents:nil attributes:nil];
            logFile = [NSFileHandle fileHandleForWritingAtPath:logPath];
        }
        
        NSString *header = @"Computing powers of two (Big Integer)\n";
        NSString *separator = @"======================================\n\n";
        
        [logFile writeData:[header dataUsingEncoding:NSUTF8StringEncoding]];
        [logFile writeData:[separator dataUsingEncoding:NSUTF8StringEncoding]];
        
        printf("%s%s", [header UTF8String], [separator UTF8String]);
        
        BigInt *value = [[BigInt alloc] initWithInt:1];
        long power = 0;
        
        while (1) {
            NSString *result = [NSString stringWithFormat:@"2^%ld = %@\n", power, value];
            
            [logFile writeData:[result dataUsingEncoding:NSUTF8StringEncoding]];
            printf("%s", [result UTF8String]);
            fflush(stdout);
            
            [value multiplyBy2];
            power++;
        }
        
        [logFile closeFile];
        [value release];
    }
    
    return 0;
}
