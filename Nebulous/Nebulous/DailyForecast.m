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
        self.temperatureMax = dictionary[kFCApparentTemperatureMax];
        self.temperatureMin = dictionary[kFCApparentTemperatureMin];
        self.icon = [[Forecastr sharedManager] imageNameForWeatherIconType:dictionary[kFCIcon]];
        self.pressure = dictionary[kFCPressure];
        self.dewPoint = dictionary[kFCDewPoint];
        self.visibility = dictionary[kFCVisibility];
        self.windBearing = dictionary[kFCWindBearing];
        self.humidity = dictionary[kFCHumidity];
        self.summary = dictionary[kFCSummary];
        self.time = dictionary[kFCTime];
        
    }
    return self;
}


@end
