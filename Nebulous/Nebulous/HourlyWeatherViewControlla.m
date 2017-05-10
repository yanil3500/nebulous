//
//  HourlyWeatherViewControlla.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/9/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "HourlyWeatherViewControlla.h"
#import "HourlyForecast.h"
#import "HourlyViewCell.h"
#define kRowHeight 50

@interface HourlyWeatherViewControlla () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *hourlyTableView;

@end

@implementation HourlyWeatherViewControlla

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    // Do any additional setup after loading the view.
}

- (void)setHourlyWeather:(NSArray *)hourlyWeather {
    _hourlyWeather = hourlyWeather;
    
    [_hourlyTableView reloadData];

}
#pragma - UITableViewDataSource methods
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *date = [self unixTimeStampToDate:[[self.hourlyWeather objectAtIndex:section] time]];
    return date
    ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hourlyWeather.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HourlyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HourlyViewCell" forIndexPath:indexPath];
    HourlyForecast *hour = self.hourlyWeather[indexPath.row];
    [[cell temperature ]setText:[[NSString alloc] initWithFormat:@"%@˚F",[hour temperature]]];
    [[cell time ]setText:[self unixTimeStampToNSDate:[hour time]]];
    [[cell precipitation]setText:[[NSString alloc] initWithFormat:@"%@%%",[self precipitationDouble:[hour precipProbability]]]];
    
    [[cell weatherIcon] setImage:[UIImage imageNamed:[hour icon]]];
    return cell;
}

-(void)setUpTableView{
    [[self hourlyTableView]setDataSource:self];
    UINib *hourlyViewNib = [UINib nibWithNibName:@"HourlyViewCell" bundle:[NSBundle mainBundle]];
    
    [[self hourlyTableView] setEstimatedRowHeight:kRowHeight];
    [[self hourlyTableView] setRowHeight:UITableViewAutomaticDimension];
    [[self hourlyTableView] registerNib:hourlyViewNib forCellReuseIdentifier:@"HourlyViewCell"];
    
}

-(NSString *)unixTimeStampToDate:(NSString *)timeStamp{
    NSTimeInterval interval = [timeStamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, MMM d, yyyy"];
    return [formatter stringFromDate:date];
}


-(NSString *)unixTimeStampToNSDate:(NSString *)timeStamp{
    NSTimeInterval _interval=[timeStamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"h a"];
    return [_formatter stringFromDate:date];
}
-(NSString *)precipitationDouble:(NSString *)precipitation{
    return (NSString *)[[NSNumber alloc] initWithDouble:([precipitation doubleValue] * 100)];
}
@end
