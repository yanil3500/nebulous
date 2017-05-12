//
//  CurrentWeatherViewControlla.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/10/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "CurrentWeatherViewControlla.h"

@interface CurrentWeatherViewControlla ()


@end

@implementation CurrentWeatherViewControlla

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupInitialLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndicator startAnimating];
}

- (void)setupInitialLayout {
    self.currentTemperature.text = @"";
    self.feelsLikeTemperature.text = @"";
    self.summary.text = @"";
}
    
- (void)setCurrentWeather:(CurrentForecast *)currentWeather {
    _currentWeather = currentWeather;
    if (_currentWeather) {
        [self.activityIndicator stopAnimating];
    }
    [self setUpCurrentWeatherViewControlla];
}
    
-(void)setUpCurrentWeatherViewControlla{
    [[self currentTemperature] setText:[[NSString alloc] initWithFormat:@"%@˚F",[[self currentWeather] temperature]]];
    [[self feelsLikeTemperature] setText:[[NSString alloc] initWithFormat:@"Feels Like %@˚F",[[self currentWeather] feelsLikeTemp]]];
    [[self summary] setText:[[self currentWeather]summary]];
    [[self precipitationDrop] setImage:[UIImage imageNamed:@"precipation"]];
    [[self weatherIcon] setImage:[UIImage imageNamed:[[self currentWeather] icon]]];
}

@end
