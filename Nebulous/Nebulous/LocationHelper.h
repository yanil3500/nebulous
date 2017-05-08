//
//  LocationHelper.h
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@protocol LocationHelperDelegate <NSObject>

- (void)didGetLocation:(CLLocation *)location;

@optional
- (void)didFindLocationName:(NSString *)locationName;
@end

@interface LocationHelper : NSObject <CLLocationManagerDelegate>

@property(nonatomic, weak) id <LocationHelperDelegate>delegate;

+(instancetype)shared;
-(void)findNameForLocation:(CLLocation *)location;

@end
