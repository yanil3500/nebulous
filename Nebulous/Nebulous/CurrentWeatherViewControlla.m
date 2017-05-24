//
//  CurrentWeatherViewControlla.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/10/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "CurrentWeatherViewControlla.h"
#import "WeekViewControlla.h"
#import "DailyForecast.h"
@import Social;
@interface CurrentWeatherViewControlla ()

@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *dewPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;

@property (weak, nonatomic) IBOutlet UILabel *visibilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunsetLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunriseLabel;
@property (weak, nonatomic) IBOutlet UIView *sunriseView;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation CurrentWeatherViewControlla

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.activityIndicator startAnimating];
    [self setupInitialLayout];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    
    self.sunriseView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
}

-(void)updateTimer{
    self.localTimeLabel.text = [[NSString alloc]initWithFormat:@"Local Time: %@",[self foreignTimeZoneDateFormatter:self.timeZone forDate:[NSDate date]]];
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
    self.sunriseLabel.text = @"";
    self.sunsetLabel.text = @"";
}
    
- (void)setCurrentWeather:(CurrentForecast *)currentWeather {
    _currentWeather = currentWeather;
    if (_currentWeather) {
        [self setUpCurrentWeatherViewControlla];
    }
}
    
-(void)setUpCurrentWeatherViewControlla{
    if (self.currentWeather == nil) {
        return;
    }
    self.currentTemperature.text = [[NSString alloc] initWithFormat:@"%@˚F",[[self currentWeather] temperature]];
    self.feelsLikeTemperature.text = [[NSString alloc] initWithFormat:@"Feels Like %@˚F",[[self currentWeather] feelsLikeTemp]];
    self.summary.text = self.currentWeather.summary;
    self.precipitationLabel.text = @"Precipation";
    self.precipitationDrop.image = [UIImage imageNamed:@"precipation"];
    self.weatherIcon.image = [UIImage imageNamed:[[self currentWeather] icon]];
    if (!self.timeZone) {
        self.timeZone = [NSTimeZone defaultTimeZone];
    }
    self.localTimeLabel.text = [[NSString alloc]initWithFormat:@"Local Time: %@",[self foreignTimeZoneDateFormatter:self.timeZone forDate:[NSDate date]]];
    self.precipitationPercentLabel.text = [[NSString alloc]initWithFormat:@"%@%%",[self temperatureFormatter:self.currentWeather.precipProbability]];
    self.windLabel.text = [NSString stringWithFormat:@"Wind Speed: %.02f m/s", [self.currentWeather.windSpeed floatValue] ];
    self.dewPointLabel.text = [NSString stringWithFormat:@"Dew Point: %@˚F", self.currentWeather.dewPoint];
    self.pressureLabel.text = [NSString stringWithFormat:@"Pressure: %@ hPa", self.currentWeather.pressure];
    self.visibilityLabel.text = [NSString stringWithFormat:@"Visibility: %.02f km",[self.currentWeather.visibility floatValue]];
    
    // Grab weekViewController in order to access dailyForecast
    WeekViewControlla *weekVC = self.parentViewController.childViewControllers[2];
    DailyForecast *dailyForecast = weekVC.dailyWeather.firstObject;
    self.sunriseLabel.text = [self foreignTimeZoneDateFormatter:self.timeZone forDate: [self unixTimeStampToDate:dailyForecast.sunrise]];
    self.sunsetLabel.text = [self foreignTimeZoneDateFormatter:self.timeZone forDate: [self unixTimeStampToDate:dailyForecast.sunset]];
    [self.activityIndicator stopAnimating];

}

-(NSString *)foreignTimeZoneDateFormatter:(NSTimeZone *)timeZone forDate:(NSDate *)date{
    NSTimeZone *tZone = [[NSTimeZone alloc]init];
    tZone = timeZone;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:tZone];
    [formatter setDateFormat:@"h:mm a"];
    return [formatter stringFromDate:date];
}

-(NSString *)temperatureFormatter:(NSString *)temperature{
    return [[NSString alloc] initWithFormat:@"%.0f", [temperature doubleValue]];
}

-(NSDate *)unixTimeStampToDate:(NSString *)timeStamp{
    NSTimeInterval interval = [timeStamp doubleValue];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    return date;
}

@end
