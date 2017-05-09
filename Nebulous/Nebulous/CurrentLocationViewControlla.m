//
//  ViewController.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "CurrentLocationViewControlla.h"
#import "LocationHelper.h"//;
#import "Location.h"
#import "Forecastr+CLLocation.h"
#import "CurrentWeather.h"
#import "DailyWeather.h"

@interface CurrentLocationViewControlla () <LocationHelperDelegate>
@property(strong, nonatomic)Location *currentLocation;
@property(strong, nonatomic)CurrentWeather *currentWeather;
@property(strong, nonatomic)NSMutableArray *dailyWeather;
@end

@implementation CurrentLocationViewControlla

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentLocation = [[Location alloc]init];
    self.currentWeather = [[CurrentWeather alloc]init];
    [[LocationHelper shared] setDelegate:self];
    
}

#pragma - CurrentLocationViewControlla helper methods
-(void)getForecastForCurrentLocation:(CLLocationCoordinate2D)location{
    NSArray *exclusions = @[kFCAlerts, kFCFlags, kFCMinutelyForecast, kFCOzone];
    [[Forecastr sharedManager]getForecastForLatitude:location.latitude longitude:location.longitude time:nil exclusions:exclusions success:^(id JSON) {
        NSLog(@"Daily Weather: %@", JSON[kFCCurrentlyForecast]);
        NSArray *dailyForecast = [[NSArray alloc] initWithArray:JSON[kFCDailyForecast][@"data"]];
        self.dailyWeather = [[NSMutableArray alloc] init];
        for (NSDictionary* daily in dailyForecast) {
            DailyWeather *dailyForeca = [[DailyWeather alloc] initWithDailyDictionary:daily];
            NSLog(@"The daily forecast: %@",dailyForeca.humidity);
            [self.dailyWeather addObject:dailyForeca];
        }
        self.currentWeather = [[CurrentWeather alloc]initWithCurrentlyDictionary:JSON[kFCCurrentlyForecast]];
    } failure:^(NSError *error, id response) {
        NSLog(@"Error while retrieving weather data: %@",[[Forecastr sharedManager] messageForError:error withResponse:response]);
    }];
}

#pragma - LocationHelperMethods
-(void)didGetLocation:(CLLocation *)location{
    [self.currentLocation setLocation:location.coordinate];
    [self getForecastForCurrentLocation:self.currentLocation.location];
    

}
-(void)didFindLocationName:(NSString *)locationName{
    [self.currentLocation setLocationName:locationName];
}

@end
