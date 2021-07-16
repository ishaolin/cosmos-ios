//
//  CMTimeFormatter.m
//  cosmos
//
//  Created by wshaolin on 2021/7/16.
//

#import "CMTimeFormatter.h"

@interface CMTimeFormatter () {
    
}

@property (nonatomic, copy, readonly) NSMutableString *mutableString;

- (NSString *)formatTime:(long)time;

@end

@implementation CMTimeFormatter

+ (CMTimeFormatter *)minutesFormatter{
    return [[CMMinutesFormatter alloc] init];
}

+ (CMTimeFormatter *)hoursFormatter{
    return [[CMHoursFormatter alloc] init];
}

- (instancetype)init{
    if(self = [super init]){
        _mutableString = [NSMutableString string];
    }
    
    return self;
}

- (void)setFormatSeconds:(long)seconds{
    
}

- (NSString *)formatTime:(long)time{
    if(time >= 10){
        return [NSString stringWithFormat:@"%ld", time];
    }
    
    return [NSString stringWithFormat:@"0%ld", time];
}

- (NSString *)toString{
    return [self.mutableString copy];
}

@end

@implementation CMMinutesFormatter

- (void)setFormatSeconds:(long)seconds{
    long minutes = seconds / 60;
    seconds = seconds % 60;
    
    [self setMinutes:minutes seconds:seconds];
}

- (void)setMinutes:(long)minutes seconds:(long)seconds{
    _minutes = minutes;
    _seconds = seconds;
    
    [self.mutableString setString:@""];
    [self.mutableString appendString:[self formatTime:_minutes]];
    [self.mutableString appendString:@":"];
    [self.mutableString appendString:[self formatTime:_seconds]];
}

@end

@implementation CMHoursFormatter

- (void)setFormatSeconds:(long)seconds{
    long minutes = seconds / 60;
    seconds = seconds % 60;
    long hours = minutes / 60;
    minutes = minutes % 60;
    
    [self setHours:hours minutes:minutes seconds:seconds];
}

- (void)setHours:(long)hours minutes:(long)minutes seconds:(long)seconds{
    _hours = hours;
    
    [self setMinutes:minutes seconds:seconds];
    [self.mutableString insertString:@":" atIndex:0];
    [self.mutableString insertString:[self formatTime:_hours] atIndex:0];
}

@end
