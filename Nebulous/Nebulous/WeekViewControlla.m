//
//  WeekViewControlla.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/9/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "WeekViewControlla.h"
#import "DailyForecast.h"
#import "WeekViewCell.h"
#define kRowHeight 50

@interface WeekViewControlla () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *weekTableView;

@end

@implementation WeekViewControlla

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    // Do any additional setup after loading the view.
}

-(void)setDailyWeather:(NSArray *)dailyWeather{
    _dailyWeather = dailyWeather;
    [_weekTableView reloadData];
}

#pragma - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dailyWeather.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DailyForecast *daily = [self.dailyWeather objectAtIndex:indexPath.row];
    WeekViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeekViewCell" forIndexPath:indexPath];
    [[cell lowTemp] setText:[[NSString alloc] initWithFormat:@"Low: %@˚F",daily.temperatureMin]];
    [[cell hiTemp] setText:[[NSString alloc] initWithFormat:@"High: %@˚F",daily.temperatureMax]];
    [[cell date] setText:[self unixTimeStampToDate:[daily time]]];
    [[cell summary] setText:[daily summary]];
    [[cell weatherIcon] setImage:[UIImage imageNamed:[daily icon]]];
    return cell;
}

-(void)setUpTableView{
    [[self weekTableView]setDataSource:self];
    UINib *hourlyViewNib = [UINib nibWithNibName:@"WeekViewCell" bundle:[NSBundle mainBundle]];
    
    [[self weekTableView] setEstimatedRowHeight:kRowHeight];
    [[self weekTableView] setRowHeight:UITableViewAutomaticDimension];
    [[self weekTableView] registerNib:hourlyViewNib forCellReuseIdentifier:@"WeekViewCell"];
    
}


-(NSString *)unixTimeStampToDate:(NSString *)timeStamp{
    NSTimeInterval interval = [timeStamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, MMM d, yyyy"];
    return [formatter stringFromDate:date];
}
@end
