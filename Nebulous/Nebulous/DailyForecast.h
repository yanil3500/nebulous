//
//  DailyWeather.h
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyForecast : NSObject

@property(strong, nonatomic) NSString *temperatureMax;
@property(strong, nonatomic) NSString *temperatureMin;
@property(strong, nonatomic) NSString *humidity;
@property(strong, nonatomic) NSString *dewPoint;
@property(strong, nonatomic) NSString *visibility;
@property(strong, nonatomic) NSString *pressure;
@property(strong, nonatomic) NSString *windBearing;
@property(strong, nonatomic) NSString *icon;
@property(strong, nonatomic) NSString *time;
@property(strong, nonatomic) NSString *summary;
@property(strong, nonatomic) NSString *temperatureCelsiusMax;
@property(strong, nonatomic) NSString *temperatureCelsiusMin;
@property(strong, nonatomic) NSString *sunrise;
@property(strong, nonatomic) NSString *sunset;

-(id)initWithDailyDictionary:(NSDictionary *)dictionary;
@end
