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

@interface CurrentLocationViewControlla () <LocationHelperDelegate>
@property(strong, nonatomic)Location *currentLocation;
@property(strong, nonatomic)NSMutableArray *dailyWeather;
@end

@implementation CurrentLocationViewControlla

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentLocation = [[Location alloc]init];
    [[LocationHelper shared] setDelegate:self];
    
}

#pragma - CurrentLocationViewControlla helper methods
//-(void)getForecastForCurrentLocation:(CLLocationCoordinate2D)location{
//    NSArray *exclusions = @[kFCAlerts, kFCFlags, kFCMinutelyForecast, kFCOzone];
//    [[Forecastr sharedManager]getForecastForLatitude:location.latitude longitude:location.longitude time:nil exclusions:exclusions success:^(id JSON) {
//        NSLog(@"Daily Weather: %@", JSON[kFCHourlyForecast][@"data"]);
//        NSArray *dailyForecasts = [[NSArray alloc] initWithArray:JSON[kFCDailyForecast][@"data"]];
//        NSArray *hourlyForecasts = [[NSArray alloc] initWithArray:JSON[kFCHourlyForecast][@"data"]];
//        self.dailyWeather = [[NSMutableArray alloc] init];
//        for (NSDictionary* daily in dailyForecasts) {
//            DailyWeather *dailyForeca = [[DailyWeather alloc] initWithDailyDictionary:daily];
//            NSLog(@"The daily forecast: %@",dailyForeca.humidity);
//            [self.dailyWeather addObject:dailyForeca];
//        }
//        for (NSDictionary *hourly in hourlyForecasts) {
//            HourlyWeather *hourForecast = [[HourlyWeather alloc]initWithHourlyDictionary:hourly];
//            NSLog(@"The hourly forecast: %@", hourForecast.temperature );
//        }
//        
//        self.currentWeather = [[CurrentWeather alloc]initWithCurrentlyDictionary:JSON[kFCCurrentlyForecast]];
//    } failure:^(NSError *error, id response) {
//        NSLog(@"Error while retrieving weather data: %@",[[Forecastr sharedManager] messageForError:error withResponse:response]);
//    }];
//}

#pragma - LocationHelperMethods
-(void)didGetLocation:(CLLocation *)location{
    [self.currentLocation setLocation:location.coordinate];
//    [self getForecastForCurrentLocation:self.currentLocation.location];
    

}
-(void)didFindLocationName:(NSString *)locationName{
    [self.currentLocation setLocationName:locationName];
}

@end
