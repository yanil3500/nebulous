//
//  Location.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "Location.h"
#import "WeatherForecast.h"

@implementation Location

-(id)initWithLocation:(CLLocation *)location andLocationName:(NSString *)locationName{
    self = [super init];
    if (self) {
        self.location = location;
        self.locationName = locationName;
    }
    return self;
}

-(void)setLocation:(CLLocation *)location{
    _location = location;
    [self.weatherForecast getTheWeatherforLocation:location];
}

@end
