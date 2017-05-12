//
//  CurrentWeatherViewControlla.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/10/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "CurrentWeatherViewControlla.h"
@import Social;
@interface CurrentWeatherViewControlla ()




@end

@implementation CurrentWeatherViewControlla

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupInitialLayout];
    [self setUpCurrentWeatherViewControlla];
}
- (IBAction)userLongPressed:(UILongPressGestureRecognizer *)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        NSLog(@"longPressed:");
        [slComposeViewController setInitialText:[[NSString alloc] initWithFormat:@"It is %@˚F degrees in %@. With %@ skies.\n#weatha4Eva#nebulous",self.currentWeather.temperature,self.locationName,self.currentWeather.summary]];
        [slComposeViewController addImage:[UIImage imageNamed:[[self currentWeather] icon]]];
        [self presentViewController:slComposeViewController animated:YES completion:nil];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndicator startAnimating];
}

- (void)setupInitialLayout {
    self.currentTemperature.text = @"";
    self.feelsLikeTemperature.text = @"";
    self.precipitationLabel.text = @"";
    self.precipitationPercentLabel.text = @"";
    self.precipitationDrop.image = nil;
    self.weatherIcon.image = nil;
    self.localTimeLabel.text = @"";
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
    self.currentTemperature.text = [[NSString alloc] initWithFormat:@"%@˚F",[[self currentWeather] temperature]];
    self.feelsLikeTemperature.text = [[NSString alloc] initWithFormat:@"Feels Like %@˚F",[[self currentWeather] feelsLikeTemp]];
    self.summary.text = self.currentWeather.summary;
    self.precipitationLabel.text = @"Precipation";
    self.precipitationDrop.image = [UIImage imageNamed:@"precipation"];
    self.weatherIcon.image = [UIImage imageNamed:[[self currentWeather] icon]];
    self.localTimeLabel.text = [[NSString alloc]initWithFormat:@"Local Time: %@",[self foreignTimeZoneDateFormatter:self.timeZone]];
    self.precipitationPercentLabel.text = [[NSString alloc]initWithFormat:@"%@%%",[self temperatureFormatter:self.currentWeather.precipProbability]
                                           ];
}

-(NSString *)foreignTimeZoneDateFormatter:(NSTimeZone *)timeZone{
    NSTimeZone *tZone = [[NSTimeZone alloc]init];
    if (!timeZone) {
        tZone = [NSTimeZone defaultTimeZone];
    } else {
        tZone = timeZone;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:tZone];
    [formatter setDateFormat:@"h:mm a"];
    return [formatter stringFromDate:[NSDate date]];
}

-(NSString *)temperatureFormatter:(NSString *)temperature{
    return [[NSString alloc] initWithFormat:@"%.0f", [temperature doubleValue]];
}


@end
