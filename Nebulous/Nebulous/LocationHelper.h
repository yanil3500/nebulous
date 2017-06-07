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

typedef void (^LocationNameCompletionHandler)(NSString * locationName);
typedef void (^CoordinatesCompletionHandler)(CLLocation * coordinates);


-(void)getLocationName:(NSString *)locationName withCompletion:(LocationNameCompletionHandler)completion;
+(instancetype)shared;
-(void)requestPermissions;
-(void)updateLocation;




@end
