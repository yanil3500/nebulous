//
//  DailyWeather.h
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyForecast : NSObject

@property(copy, nonatomic) NSString *temperatureMax;
@property(copy, nonatomic) NSString *temperatureMin;
@property(copy, nonatomic) NSString *humidity;
@property(copy, nonatomic) NSString *dewPoint;
@property(copy, nonatomic) NSString *visibility;
@property(copy, nonatomic) NSString *pressure;
@property(copy, nonatomic) NSString *windBearing;
@property(copy, nonatomic) NSString *icon;
@property(copy, nonatomic) NSString *time;
@property(copy, nonatomic) NSString *summary;
@property(copy, nonatomic) NSString *temperatureCelsiusMax;
@property(copy, nonatomic) NSString *temperatureCelsiusMin;
@property(copy, nonatomic) NSString *sunrise;
@property(copy, nonatomic) NSString *sunset;

-(id)initWithDailyDictionary:(NSDictionary *)dictionary;
@end
