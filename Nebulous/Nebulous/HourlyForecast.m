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
        self.feelsLike = dictionary[kFCApparentTemperature];
        self.humidity = dictionary[kFCHumidity];
        self.temperature = dictionary[kFCTemperature];
        self.precipProbability = dictionary[kFCPrecipProbability];
        self.windBearing = dictionary[kFCWindBearing];
        self.time = dictionary[kFCTime];
        self.icon = [[Forecastr sharedManager] imageNameForWeatherIconType:dictionary[kFCIcon]];
    }
    return self;
}
@end
