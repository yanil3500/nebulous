//
//  MyLocationsTableViewControlla.h
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/11/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface MyLocationsTableViewControlla : UITableViewController

@property(strong, nonatomic)Location *currentLocation;
@property(strong, nonatomic)NSArray *locationTableHeaders;
@property(strong, nonatomic)NSMutableArray *savedLocations;

@end
