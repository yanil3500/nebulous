//
//  WeatherForecast.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "WeatherForecast.h"
#import "DailyForecast.h"
#import "WeatherForecast.h"
#import "HourlyForecast.h"
#import "Forecastr.h"

@implementation WeatherForecast


-(id)initWithWeatherDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.currentForecast = [[CurrentForecast alloc]initWithCurrentlyDictionary:dictionary[kFCCurrentlyForecast]];
        self.dailyForecasts = [[NSMutableArray alloc] init];
        for (NSDictionary *dailyDictionary in dictionary[kFCDailyForecast][@"data"]) {
            DailyForecast *dailyWeather = [[DailyForecast alloc] initWithDailyDictionary:dailyDictionary];
            [self.dailyForecasts addObject:dailyWeather];
        }
        self.hourlyForecasts = [[NSMutableArray alloc] init];
        for (NSDictionary *hourlyDictionary in dictionary[kFCHourlyForecast][@"data"]) {
            HourlyForecast* hourlyWeather = [[HourlyForecast alloc] initWithHourlyDictionary:hourlyDictionary];
            [self.hourlyForecasts addObject:hourlyWeather];
        }
        
    }
    return self;
}

-(void)getTheWeatherforLocation:(CLLocation *)location{
    __block WeatherForecast *weather;
    NSArray *exclusions = @[kFCAlerts, kFCFlags, kFCMinutelyForecast, kFCOzone];
    [[Forecastr sharedManager]getForecastForLatitude:location.coordinate.latitude longitude:location.coordinate.longitude time:nil exclusions:exclusions success:^(id JSON) {
        weather = [[WeatherForecast alloc] initWithWeatherDictionary:JSON];
        [self.delegate currentWeatherForLocation:weather];
    } failure:^(NSError *error, id response) {
        NSLog(@"Error while retrieving weather data: %@",[[Forecastr sharedManager] messageForError:error withResponse:response]);
    }];
}


@end
