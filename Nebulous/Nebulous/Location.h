//
//  Location.h
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <Foundation/Foundation.h>


@import CoreLocation;

@interface Location : NSObject

@property(readwrite)CLLocationCoordinate2D location;

@property(strong, nonatomic)NSString *locationName;

-(id)initWithLocation:(CLLocationCoordinate2D)location andLocationName:(NSString *)locationName;
@end
