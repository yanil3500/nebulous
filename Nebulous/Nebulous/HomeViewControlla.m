//
//  ViewController.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "HomeViewControlla.h"
#import "LocationHelper.h"//;
#import "Location.h"
#import "DailyForecast.h"
#import "Forecastr+CLLocation.h"
#import "HourlyWeatherViewControlla.h"
#import "WeekViewControlla.h"

@interface HomeViewControlla () <LocationHelperDelegate, WeatherForecastDelegate>
@property(strong, nonatomic)Location *currentLocation;
@property(weak, nonatomic) IBOutlet UIView *currentWeatherView;
@property(weak, nonatomic) IBOutlet UIView *hourlyWeatherView;
@property(weak, nonatomic) IBOutlet UIView *weekWeatherView;
@property(strong, nonatomic)NSMutableArray *dailyWeather;
@property(strong, nonatomic)HourlyWeatherViewControlla *hourlyViewControlla;
@property(strong, nonatomic)WeekViewControlla *weekViewControlla;
@end

@implementation HomeViewControlla
//Uses segmented controls to change views
- (IBAction)segmentedControl:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.navigationItem setTitle:self.currentLocation.locationName];
            [self.currentWeatherView setAlpha:1];
            [self.hourlyWeatherView setAlpha:0];
            [self.weekWeatherView setAlpha:0];
        }];
    } else if (sender.selectedSegmentIndex == 1){
        [UIView animateWithDuration:0.2 animations:^{
            [self.currentWeatherView setAlpha:0];
            [self.hourlyWeatherView setAlpha:1];
            [self.weekWeatherView setAlpha:0];
        }];
    } else{
        [UIView animateWithDuration:0.2 animations:^{
            [self.currentWeatherView setAlpha:0];
            [self.hourlyWeatherView setAlpha:0];
            [self.weekWeatherView setAlpha:1];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.hourlyWeatherView setAlpha:0];
    [self.weekWeatherView setAlpha:0];
    self.currentLocation = [[Location alloc]init];
    [[LocationHelper shared] setDelegate:self];
    self.currentLocation.weatherForecast = [[WeatherForecast alloc]init];
    self.currentLocation.weatherForecast.delegate = self;
    self.hourlyViewControlla = self.childViewControllers[1];
    self.weekViewControlla = self.childViewControllers[2];
}


#pragma - LocationHelperMethods
-(void)didGetLocation:(CLLocation *)location{
    [self.currentLocation setLocation:location];
    [self.currentLocation.weatherForecast getTheWeatherforLocation:location];
}
-(void)didFindLocationName:(NSString *)locationName{
    [self.currentLocation setLocationName:locationName];
    NSLog(@"Location: %@",self.currentLocation.locationName);
}

#pragma - WeatherForecastDelegate method
-(void)currentWeatherForLocation:(id)weather{
    WeatherForecast *forecast = (WeatherForecast *)weather;
    self.currentLocation.weatherForecast = forecast;
    [self.hourlyViewControlla setHourlyWeather:forecast.hourlyForecasts];
    [self.weekViewControlla setDailyWeather:forecast.dailyForecasts];
    for (DailyForecast *dailyforecast in self.currentLocation.weatherForecast.dailyForecasts) {
        NSLog(@"Daily Summary: %@",dailyforecast.summary
              );
    }
}




@end
