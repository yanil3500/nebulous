//
//  Location.h
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherForecast.h"


@import CoreLocation;

@interface Location : NSObject

@property(strong, nonatomic)CLLocation *location;

@property(strong, nonatomic)NSString *locationName;

@property(strong, nonatomic)WeatherForecast *weatherForecast;

@property(strong, nonatomic)NSTimeZone *locationTimeZone;

-(id)initWithLocation:(CLLocation *)location andLocationName:(NSString *)locationName;
@end
