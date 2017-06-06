//
//  HourlyWeather.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "HourlyForecast.h"
#import "Forecastr.h"

@implementation HourlyForecast

-(id)initWithHourlyDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _feelsLike = [dictionary[kFCApparentTemperature] stringValue];
        _humidity = [dictionary[kFCHumidity] stringValue];
        _temperature = [self temperatureFormatter:[dictionary[kFCTemperature] stringValue]];
        _precipProbability = [dictionary[kFCPrecipProbability] stringValue];
        _windBearing = [dictionary[kFCWindBearing] stringValue];
        _time = [dictionary[kFCTime] stringValue];
        
//        NSLog(@"The time: %@", [self formatDate:[self unixTimeStampToDate:_time]]);
        _icon = [[Forecastr sharedManager] imageNameForWeatherIconType:dictionary[kFCIcon]];
        _celsius = [self fahrenheitToCelsius:[dictionary[kFCTemperature] stringValue]];
    }
    return self;
}

-(NSString *)fahrenheitToCelsius:(NSString *)temperature{
    
    return [[NSString alloc] initWithFormat:@"%.02f",(([temperature doubleValue] - 32) * (5 / 9))];
}
-(NSString *)temperatureFormatter:(NSString *)temperature{
    return [[NSString alloc] initWithFormat:@"%.0f", [temperature doubleValue]];
}

//-(NSDate *)unixTimeStampToDate:(NSString *)timeStamp{
//    NSTimeInterval interval = [timeStamp doubleValue];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
//    return date;
//}
//-(NSString *)formatDate:(NSDate *)date{
//    if (!date) {
//        NSException *exception = [NSException exceptionWithName:@"InvalidException" reason:@"Argument passed was nil." userInfo:nil];
//        @throw exception;
//    }
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"HH:mm:ss EEEE, MMM d, yyyy"];
//    return [formatter stringFromDate:date];
//}

@end
