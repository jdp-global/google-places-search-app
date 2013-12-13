//
//  GPSSearchViewController.h
//  GooglePlacesSearch
//
//  Created by mihata on 12/7/13.
//  Copyright (c) 2013 mihata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface GPSSearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchField;
@property (retain, nonatomic) NSData* responseData;
@property (retain, nonatomic) NSDictionary* data;
- (IBAction)searchButtonTapped:(id)sender;

@end
