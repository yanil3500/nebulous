//
//  CurrentWeatherViewControlla.h
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/10/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentForecast.h"

@interface CurrentWeatherViewControlla : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *currentTemperature;
@property (weak, nonatomic) IBOutlet UILabel *precipitationPercentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *feelsLikeTemperature;
@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (weak, nonatomic) IBOutlet UIImageView *precipitationDrop;
@property (strong, nonatomic) CurrentForecast *currentWeather;
@property (weak, nonatomic) IBOutlet UILabel *precipitationLabel;
@property (weak, nonatomic) IBOutlet UILabel *localTimeLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSTimeZone *timeZone;
@property(strong, nonatomic) NSString *locationName;
-(NSString *)foreignTimeZoneDateFormatter:(NSTimeZone *)timeZone forDate:(NSDate *)date;
-(NSString *)temperatureFormatter:(NSString *)temperature;
@end
