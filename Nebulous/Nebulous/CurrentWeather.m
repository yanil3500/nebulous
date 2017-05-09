//
//  CurrentWeather.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "CurrentWeather.h"
#import "Forecastr.h"
@implementation CurrentWeather

-(id)initWithCurrentlyDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.feelsLikeTemp = dictionary[kFCApparentTemperature];
        self.icon = [[Forecastr sharedManager] imageNameForWeatherIconType:dictionary[kFCIcon]];
        self.pressure = dictionary[kFCPressure];
        self.precipIntensity = dictionary[kFCPrecipIntensity];
        self.precipProbability = dictionary[kFCPrecipProbability];
        self.temperature = dictionary[kFCTemperature];
        self.time = dictionary[kFCTime];
        self.summary = dictionary[kFCSummary];
    }
    return self;
}

@end
