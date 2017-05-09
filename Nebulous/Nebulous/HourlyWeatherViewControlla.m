//
//  HourlyWeatherViewControlla.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/9/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "HourlyWeatherViewControlla.h"
#import "HourlyForecast.h"
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hourlyWeather.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    [[cell textLabel] setText:[[[self hourlyWeather] objectAtIndex:indexPath.row] feelsLike]];
    HourlyForecast *object = self.hourlyWeather[indexPath.row];
    cell.textLabel.text = object.feelsLike;
    return cell;
}

-(void)reloadTable {
    [self.hourlyTableView reloadData];
}

-(void)setUpTableView{
    self.hourlyTableView.dataSource = self;
    [self.hourlyTableView setEstimatedRowHeight:kRowHeight];
    [[self hourlyTableView] setRowHeight:UITableViewAutomaticDimension];
    
}
@end
