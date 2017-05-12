//
//  WeatherForecast.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "WeatherForecast.h"
#import "DailyForecast.h"
#import "HourlyForecast.h"
#import "Forecastr.h"

@implementation WeatherForecast


-(id)initWithWeatherDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _currentForecast = [[CurrentForecast alloc]initWithCurrentlyDictionary:dictionary[kFCCurrentlyForecast]];
        _dailyForecasts = [[NSMutableArray alloc] init];
        for (NSDictionary *dailyDictionary in dictionary[kFCDailyForecast][@"data"]) {
            DailyForecast *dailyWeather = [[DailyForecast alloc] initWithDailyDictionary:dailyDictionary];
            [self.dailyForecasts addObject:dailyWeather];
        }
        _hourlyForecasts = [[NSMutableArray alloc] init];
        for (NSDictionary *hourlyDictionary in dictionary[kFCHourlyForecast][@"data"]) {
            HourlyForecast* hourlyWeather = [[HourlyForecast alloc] initWithHourlyDictionary:hourlyDictionary];
            [self.hourlyForecasts addObject:hourlyWeather];
        }
        
    }
    return self;
}

-(void)getTheWeatherforLocation:(CLLocation *)location{
    NSArray *exclusions = @[kFCAlerts, kFCFlags, kFCMinutelyForecast, kFCOzone];
    [[Forecastr sharedManager]getForecastForLatitude:location.coordinate.latitude longitude:location.coordinate.longitude time:nil exclusions:exclusions success:^(id JSON) {
        WeatherForecast *weather = [[WeatherForecast alloc] initWithWeatherDictionary:JSON];
        NSLog(@"Current temp: %@", weather.currentForecast.temperature);
        [self.delegate currentWeatherForLocation:weather];
    } failure:^(NSError *error, id response) {
        NSLog(@"Error while retrieving weather data: %@",[[Forecastr sharedManager] messageForError:error withResponse:response]);
    }];
}


@end
