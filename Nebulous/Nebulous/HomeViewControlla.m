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
    
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            [UIView animateWithDuration:0.18 animations:^{
                [self.currentWeatherView setAlpha:1];
                [self.hourlyWeatherView setAlpha:0];
                [self.weekWeatherView setAlpha:0];
            }];
            break;
        }
        case 1:
        {
            [UIView animateWithDuration:0.18 animations:^{
                [self.currentWeatherView setAlpha:0];
                [self.hourlyWeatherView setAlpha:1];
                [self.weekWeatherView setAlpha:0];
            }];
            break;
        }
        case 2:
        {
            [UIView animateWithDuration:0.18 animations:^{
                [self.currentWeatherView setAlpha:0];
                [self.hourlyWeatherView setAlpha:0];
                [self.weekWeatherView setAlpha:1];
            }];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hourlyWeatherView.alpha = 0.0;
    self.weekWeatherView.alpha   = 0.0;
    self.currentLocation = [[Location alloc] init];
    self.currentLocation.locationTimeZone = [[NSTimeZone alloc] init];
    [LocationHelper shared].delegate = self;
    
    self.currentLocation.weatherForecast = [[WeatherForecast alloc] init];
    self.currentLocation.weatherForecast.delegate = self;

    // Get child view controllers
    self.currentWeatherViewControlla = self.childViewControllers[0];
    self.hourlyViewControlla = self.childViewControllers[1];
    self.weekViewControlla = self.childViewControllers[2];
}


#pragma - LocationHelperMethods
-(void)didGetLocation:(CLLocation *)location{
    self.currentLocation.location = location;
}

-(void)locationHelperDidFindLocationName:(NSString *)locationName{
    self.currentLocation.locationName = locationName;
    NSLog(@"Location: %@",self.currentLocation.locationName);
    self.currentWeatherViewControlla.locationName = locationName;
    self.navigationItem.title = self.currentLocation.locationName;
}

- (void)locationHelperDidGetTimeZone:(NSTimeZone *)timeZone{
    self.currentLocation.locationTimeZone = timeZone;
}

- (void)locationHelperUserDidDeny {
    [self showAlertControllerWithTitle:@"Application requires location."
                               message:@"Go to 'Settings' to change the permissions."
                         okActionTitle:@"Settings" okHandler:^() {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    } cancelActionTitle:@"Cancel"];
    
}

-(void)locationHelperDidFailWithError:(NSError *)error {
    if (error) {
        [self showAlertControllerWithTitle:@"Can't get the weather data" message:@"Sorry! We're unable to fetch data from server. Please try again later!" okActionTitle:@"OK" okHandler:^() {
            [self.currentWeatherViewControlla.activityIndicator stopAnimating];
        } cancelActionTitle: nil];
    }
}

- (void)showAlertControllerWithTitle:(NSString *)title
                             message:(NSString *)message
                       okActionTitle:(NSString *)okayTitle
                           okHandler:(void (^ __nullable)())okayHandler
                   cancelActionTitle:(nullable NSString *)cancelTitle {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:okayTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (okayHandler) {
            okayHandler();
        }
    }];
    [alertController addAction:okayAction];

    if (cancelTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma - WeatherForecastDelegate method
-(void)currentWeatherForLocation:(id)weather{
    WeatherForecast *forecast = (WeatherForecast *)weather;
    self.currentLocation.weatherForecast = forecast;
    
    NSMutableDictionary *hourDictionary = [[NSMutableDictionary alloc] init];
    NSMutableArray *hourKeys = [[NSMutableArray alloc] init];
    for (HourlyForecast *hourlyWeather in forecast.hourlyForecasts) {
        NSString *hourlyWeatherTime = [self unixTimeStampToDate:hourlyWeather.time];
        
        if (![[hourDictionary allKeys] containsObject:hourlyWeatherTime]) {
            hourDictionary[hourlyWeatherTime] = [[NSMutableArray alloc] init];
            [hourKeys addObject:hourlyWeatherTime];
        }
        [hourDictionary[hourlyWeatherTime] addObject:hourlyWeather];
    }
    
    self.hourlyViewControlla.sectionTitles = hourKeys;
    self.hourlyViewControlla.hourlyWeather = hourDictionary;
    self.weekViewControlla.dailyWeather = forecast.dailyForecasts;
    
    self.currentWeatherViewControlla.timeZone = self.currentLocation.locationTimeZone;
    self.currentWeatherViewControlla.currentWeather = forecast.currentForecast;
}

#pragma - prepareForSegue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"MyLocationsTableViewControlla"]){
        MyLocationsTableViewControlla *destinationController = (MyLocationsTableViewControlla *)segue.destinationViewController;
        destinationController.currentLocation = self.currentLocation;
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
