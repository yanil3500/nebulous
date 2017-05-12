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
#import "HourlyForecast.h"
#import "Forecastr+CLLocation.h"
#import "HourlyWeatherViewControlla.h"
#import "WeekViewControlla.h"
#import "CurrentWeatherViewControlla.h"
#import "MyLocationsTableViewControlla.h"

@interface HomeViewControlla () <LocationHelperDelegate, WeatherForecastDelegate>
@property(strong, nonatomic)Location *currentLocation;
@property(weak, nonatomic) IBOutlet UIView *currentWeatherView;
@property(weak, nonatomic) IBOutlet UIView *hourlyWeatherView;
@property(weak, nonatomic) IBOutlet UIView *weekWeatherView;
@property(strong, nonatomic)NSMutableArray *dailyWeather;
@property(strong, nonatomic)HourlyWeatherViewControlla *hourlyViewControlla;
@property(strong, nonatomic)WeekViewControlla *weekViewControlla;
@property(strong, nonatomic)CurrentWeatherViewControlla *currentWeatherViewControlla;
@property(strong, nonatomic)MyLocationsTableViewControlla *myLocationTableViewControlla;
@end

@implementation HomeViewControlla
//Uses segmented controls to change views
- (IBAction)segmentedControl:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [UIView animateWithDuration:0.18 animations:^{
            [self.currentWeatherView setAlpha:1];
            [self.hourlyWeatherView setAlpha:0];
            [self.weekWeatherView setAlpha:0];
        }];
    } else if (sender.selectedSegmentIndex == 1){
        [UIView animateWithDuration:0.18 animations:^{
            [self.currentWeatherView setAlpha:0];
            [self.hourlyWeatherView setAlpha:1];
            [self.weekWeatherView setAlpha:0];
        }];
    } else{
        [UIView animateWithDuration:0.18 animations:^{
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
    [self didGetLocation:self.currentLocation.location];
    self.currentLocation.weatherForecast = [[WeatherForecast alloc]init];
    self.currentWeatherViewControlla = self.childViewControllers[0];
    self.hourlyViewControlla = self.childViewControllers[1];
    self.weekViewControlla = self.childViewControllers[2];
}


#pragma - LocationHelperMethods
-(void)didGetLocation:(CLLocation *)location{
    self.currentLocation.weatherForecast.delegate = self;
    [self.currentLocation setLocation:location];
}

-(void)didFindLocationName:(NSString *)locationName{
    [self.currentLocation setLocationName:locationName];
    NSLog(@"Location: %@",self.currentLocation.locationName);
    [self.navigationItem setTitle:self.currentLocation.locationName];
}


#pragma - WeatherForecastDelegate method
-(void)currentWeatherForLocation:(id)weather{
    WeatherForecast *forecast = (WeatherForecast *)weather;
    self.currentLocation.weatherForecast = forecast;
    
    NSMutableDictionary *hourDictionary = [[NSMutableDictionary alloc]init];
    NSMutableArray *hourKeys = [[NSMutableArray alloc]init];
    for (HourlyForecast *hourlyWeather in forecast.hourlyForecasts) {
        if (![[hourDictionary allKeys] containsObject:[self unixTimeStampToDate:hourlyWeather.time]]) {
            hourDictionary[[self unixTimeStampToDate:hourlyWeather.time]] = [[NSMutableArray alloc]init];
            [hourKeys addObject:[self unixTimeStampToDate:hourlyWeather.time]];
        } else {
            [hourDictionary[[self unixTimeStampToDate:hourlyWeather.time]] addObject:hourlyWeather];
        }
    }    
    [self.hourlyViewControlla setSectionTitles:hourKeys];
    [self.hourlyViewControlla setHourlyWeather: hourDictionary];
    [self.weekViewControlla setDailyWeather:forecast.dailyForecasts];
    [self.currentWeatherViewControlla setCurrentWeather:forecast.currentForecast];
    for (DailyForecast *dailyforecast in self.currentLocation.weatherForecast.dailyForecasts) {
        NSLog(@"Daily Summary: %@\nWeather Icon: %@",dailyforecast.summary, dailyforecast.icon
              );
    }
}

#pragma - prepareForSegue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [super prepareForSegue:segue sender:sender];
    if ([[segue identifier] isEqualToString:@"MyLocationsTableViewControlla"]){
        MyLocationsTableViewControlla *destinationController = (MyLocationsTableViewControlla *)segue.destinationViewController;
        [destinationController setCurrentLocation:self.currentLocation];
        
    }
}

-(NSString *)unixTimeStampToDate:(NSString *)timeStamp{
    NSTimeInterval interval = [timeStamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    return [self formatDate:date];
}
-(NSString *)formatDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, MMM d, yyyy"];
    return [formatter stringFromDate:date];
}



@end
