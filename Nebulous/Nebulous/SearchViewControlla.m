//
//  SearchViewControlla.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/11/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "SearchViewControlla.h"
#import "LocationHelper.h"
@import CoreLocation;

@interface SearchViewControlla () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, LocationHelperDelegate>
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *savedResults;
@end

@implementation SearchViewControlla

- (void)viewDidLoad {
    self.navigationItem.title = @"Add Location";
    [super viewDidLoad];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"savedResults"] != nil) {
        self.savedResults = [[[NSUserDefaults standardUserDefaults] objectForKey:@"savedResults"] mutableCopy];
    } else {
        self.savedResults = [[NSMutableArray alloc]init];
    }
    self.searchResults = [[NSMutableArray alloc]init];
    self.searchTableView.dataSource = self;
    self.searchTableView.delegate = self;
    self.searchBar.delegate = self;
    [LocationHelper shared].fetchDelegate = self;
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchResults.count;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (![self isAlphaNumericOnly:searchText] && [searchText length] != 0) {
        NSInteger lastIndex = [searchText length] - 1;
        NSLog(@"before: %@", searchBar.text);
        searchBar.text = [searchText substringToIndex:lastIndex];
        NSLog(@"after: %@", searchBar.text);
    }
    [[self searchResults] removeAllObjects];
    [self.searchTableView reloadData];
}

-(BOOL)isAlphaNumericOnly:(NSString *)input{
    NSString *alphaNum = @"^[ 0-9a-zA-Z,-]+";
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", alphaNum];
    
    return [regexTest evaluateWithObject:input];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (searchBar.text != nil) {
        [[LocationHelper shared] findLatitudeAndLongitudeForAddress:searchBar.text];
    }
    [self.searchBar resignFirstResponder];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchResults removeAllObjects];
    [self.searchTableView reloadData];
    [self.searchBar resignFirstResponder];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.searchResults.count > 0) {
        cell.textLabel.text = self.searchResults[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *location = self.searchResults[indexPath.row];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add to 'My Locations'?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       //TODO: Save "location" to user defaults
        NSLog(@"Save location :%@", location);
        if (![self.savedResults containsObject:location]) {
            [self.savedResults addObject: location];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:self.savedResults forKey:@"savedResults"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okayAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    self.searchBar.text = @"";
    [self.searchResults removeAllObjects];
    [self.searchTableView reloadData];

}

#pragma LocationHelperDelegate methods

-(void)didGetLocation:(CLLocation *)location{
    NSLog(@"Location (SearchViewControlla): %f, %f",location.coordinate.latitude,location.coordinate.longitude);
}


-(void)locationHelperDidFindLocationName:(NSString *)locationName{
    [self.searchResults addObject:locationName];
    [self.searchTableView reloadData];
    NSLog(@"Search Results: %@",locationName);
}
@end
