//
//  CurrentWeather.h
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentForecast : NSObject


@property(strong, nonatomic) NSString *feelsLikeTemp;
@property(strong, nonatomic) NSString *icon;
@property(strong, nonatomic) NSString *pressure;
@property(strong, nonatomic) NSString *precipIntensity;
@property(strong, nonatomic) NSString *precipProbability;
@property(strong, nonatomic) NSString *temperature;
@property(strong, nonatomic) NSString *time;
@property(strong, nonatomic) NSString *summary;


-(id)initWithCurrentlyDictionary:(NSDictionary *)dictionary;


@end
