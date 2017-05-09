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
        _temperature = [dictionary[kFCTemperature] stringValue];
        _precipProbability = [dictionary[kFCPrecipProbability] stringValue];
        _windBearing = [dictionary[kFCWindBearing] stringValue];
        _time = [dictionary[kFCTime] stringValue];
        _icon = [[Forecastr sharedManager] imageNameForWeatherIconType:dictionary[kFCIcon]];
    }
    return self;
}
@end
