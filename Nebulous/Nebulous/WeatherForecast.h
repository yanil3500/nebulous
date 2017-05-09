//
//  WeatherForecast.h
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "CurrentForecast.h"
#import <Foundation/Foundation.h>
@import CoreLocation;

@protocol WeatherForecastDelegate <NSObject>

-(void)currentWeatherForLocation:(id)weather;

@end

@interface WeatherForecast : NSObject



@property(strong, nonatomic) NSMutableArray *dailyForecasts;
@property(strong, nonatomic) NSMutableArray *hourlyForecasts;
@property(strong, nonatomic) CurrentForecast *currentForecast;
@property(weak, nonatomic) id <WeatherForecastDelegate> delegate;
-(id)initWithWeatherDictionary:(NSDictionary *)dictionary;

-(void)getTheWeatherforLocation:(CLLocation *)location;

@end

