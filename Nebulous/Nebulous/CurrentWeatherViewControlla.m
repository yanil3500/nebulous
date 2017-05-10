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

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self currentTemperature] setText:[[self currentWeather] temperature]];
    [[self feelsLikeTemperature] setText:[[NSString alloc] initWithFormat:@"Feels Like %@˚F",[[self currentWeather] feelsLikeTemp]]];
    [[self summary] setText:[[self currentWeather]summary]];
    [[self weatherIcon] setImage:[UIImage imageNamed:[[self currentWeather] icon]]];
}

@end
