//
//  MyLocationsTableViewControlla.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/11/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "MyLocationsTableViewControlla.h"
#import "LocationHelper.h"

@interface MyLocationsTableViewControlla ()

@end

@implementation MyLocationsTableViewControlla


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"savedResults"] != nil){
        self.savedLocations = [[NSMutableArray alloc] initWithArray:[[[NSUserDefaults standardUserDefaults] objectForKey:@"savedResults"] mutableCopy]];
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        self.locationTableHeaders = @[@"Current Location",@"Saved Locations"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)setCurrentLocation:(Location *)currentLocation{
    _currentLocation = currentLocation;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.locationTableHeaders.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.locationTableHeaders objectAtIndex:section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1){
        return self.savedLocations.count;
    }
    return section;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            [[cell textLabel] setText:self.currentLocation.locationName];
            break;
        case 1:
            [[cell textLabel] setText:self.savedLocations[indexPath.row]];
        default:
            break;
    }
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//     Return NO if you do not want the specified item to be editable.
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected locaiton : %@", self.savedLocations[indexPath.row]);
    [[LocationHelper shared] findLatitudeAndLongitudeForAddress:self.savedLocations[indexPath.row]];
    [[self navigationController] popToRootViewControllerAnimated:YES];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.savedLocations removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [NSUserDefaults.standardUserDefaults setObject:self.savedLocations forKey:@"savedResults"];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {

    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
