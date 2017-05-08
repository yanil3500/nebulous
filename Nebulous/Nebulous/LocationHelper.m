//
//  LocationHelper.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "LocationHelper.h"


@interface LocationHelper()
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@end

@implementation LocationHelper

+(instancetype)shared{
    static LocationHelper *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[[self class] alloc] init];
    });
    return shared;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self requestPermissions];
        self.location = [[CLLocation alloc] init];
    }
    
    return self;
}
-(void)requestPermissions {
    self.locationManager = [[CLLocationManager alloc]init];
    
    [[self locationManager] requestAlwaysAuthorization];
    
    [[self locationManager]setDelegate:self];
    
    
    [[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [[self locationManager] setDistanceFilter: 100];
    
    [[self locationManager] startUpdatingLocation];
}


-(void)findNameForLocation:(CLLocation *)location{
    __block NSString *locationName;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed to get location name. Error: %@",error.localizedDescription);
            locationName = [self coordinateStringForLocation:location];
        } else if (placemarks && placemarks.count > 0){
            CLPlacemark *result = [placemarks objectAtIndex:0];
            
            locationName = [result locality];
            
            //if the locality returns nil, return the coordinate string instead
            if (!locationName) {
                locationName = [self coordinateStringForLocation:location];
            }
            
        }
        [self.delegate didFindLocationName:locationName];
    }];
    
}

-(NSString *)coordinateStringForLocation:(CLLocation *)location{
    NSString *str = [[NSString alloc] initWithFormat:@"Lat: %f, Lon: %f",location.coordinate.latitude, location.coordinate.longitude];
    return str;
}

#pragma mark - CLLocationManagerDelegate methods

//Stop the CLLocation from updating the location (to save battery power)
-(void)stopUpdating{
    NSLog(@"Stopped updating location.");
    
    [[self locationManager] stopUpdatingLocation];
    [[self locationManager] setDelegate:nil];
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations lastObject];
    
    self.location = location;
    
    //maximize batter power by stopping the location manager as soon as possible
    [self stopUpdating];
    
    [self.delegate didGetLocation:self.location];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if (error) {
        NSLog(@"Failed to find location : %@", error.localizedDescription);
    }
}


@end
