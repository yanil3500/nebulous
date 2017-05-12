//
//  DailyWeather.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//
#import "Forecastr.h"
#import "DailyForecast.h"

@implementation DailyForecast

-(id)initWithDailyDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _temperatureMax = [self temperatureFormatter:dictionary[kFCApparentTemperatureMax]];
        _temperatureMin = [self temperatureFormatter:dictionary[kFCApparentTemperatureMin]];
        _icon = [[Forecastr sharedManager] imageNameForWeatherIconType:dictionary[kFCIcon]];
        _pressure = dictionary[kFCPressure];
        _dewPoint = dictionary[kFCDewPoint];
        _visibility = dictionary[kFCVisibility];
        _windBearing = dictionary[kFCWindBearing];
        _humidity = dictionary[kFCHumidity];
        _summary = dictionary[kFCSummary];
        _time = dictionary[kFCTime];
        _temperatureCelsiusMax = [self fahrenheitToCelsius:dictionary[kFCApparentTemperatureMax]];
        _temperatureCelsiusMin = [self fahrenheitToCelsius:dictionary[kFCApparentTemperatureMin]];
        _sunrise = dictionary[kFCSunriseTime];
        _sunset = dictionary[kFCSunsetTime];
    }
    return self;
}

-(NSString *)fahrenheitToCelsius:(NSString *)temperature{
    
    return [[NSString alloc] initWithFormat:@"%.02f",(([temperature doubleValue] - 32) * (5 / 9))];
}
-(NSString *)temperatureFormatter:(NSString *)temperature{
    return [[NSString alloc] initWithFormat:@"%.0f", [temperature doubleValue]];
}


@end
