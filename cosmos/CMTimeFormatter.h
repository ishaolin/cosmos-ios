//
//  CMTimeFormatter.h
//  cosmos
//
//  Created by wshaolin on 2021/7/16.
//

#import <Foundation/Foundation.h>

@interface CMTimeFormatter : NSObject

+ (CMTimeFormatter *)minutesFormatter;
+ (CMTimeFormatter *)hoursFormatter;

- (void)setFormatSeconds:(long)seconds;
- (NSString *)toString; // 00:00:00 | 00:00

@end

@interface CMMinutesFormatter : CMTimeFormatter

@property (nonatomic, assign, readonly) long seconds;
@property (nonatomic, assign, readonly) long minutes;

- (void)setMinutes:(long)minutes seconds:(long)seconds;

@end

@interface CMHoursFormatter : CMMinutesFormatter

@property (nonatomic, assign, readonly) long hours;

- (void)setHours:(long)hours minutes:(long)minutes seconds:(long)seconds;

@end
