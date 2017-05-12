//
//  HourlyWeatherViewControlla.h
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/9/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HourlyWeatherViewControlla : UIViewController
@property(strong, nonatomic)NSDictionary *hourlyWeather;
@property(strong, nonatomic)NSArray *sectionTitles;

-(NSString *)formatDate:(NSDate *)date;
-(NSString *)unixTimeStampToNSDate:(NSString *)timeStamp;
@end
