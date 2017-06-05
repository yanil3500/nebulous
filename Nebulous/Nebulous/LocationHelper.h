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
- (void)locationHelperDidFindLocationName:(NSString *)locationName;
- (void)locationHelperDidGetTimeZone:(NSTimeZone *)timeZone;

// Deny to access user's location
- (void)locationHelperUserDidDeny;

// Fail finding location
- (void)locationHelperDidFailWithError:(NSError *)error;
@end

@interface LocationHelper : NSObject <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocation *location;
@property(nonatomic, weak) id <LocationHelperDelegate>delegate;
@property(nonatomic, weak) id <LocationHelperDelegate>fetchDelegate;

+(instancetype)shared;
-(void)requestPermissions;
-(void)findNameForLocation:(CLLocation *)location;
-(void)updateLocation;
-(void)findLatitudeAndLongitudeForAddress:(NSString *)address;

@end
