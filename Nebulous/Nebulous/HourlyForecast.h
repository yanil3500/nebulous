//
//  HourlyWeather.h
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HourlyForecast : NSObject
@property(strong, nonatomic) NSString *feelsLike;
@property(strong, nonatomic) NSString *humidity;
@property(strong, nonatomic) NSString *precipProbability;
@property(strong, nonatomic) NSString *icon;
@property(strong, nonatomic) NSString *windBearing;
@property(strong, nonatomic) NSString *temperature;
@property(strong, nonatomic) NSString *time;
@property(strong, nonatomic) NSString *celsius;


-(id)initWithHourlyDictionary:(NSDictionary *)dictionary;
@end
