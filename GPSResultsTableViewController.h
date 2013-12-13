//
//  GPSResultsTableViewController.h
//  GooglePlacesSearch
//
//  Created by mihata on 12/8/13.
//  Copyright (c) 2013 mihata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPSResultsCell.h"

@interface GPSResultsTableViewController : UITableViewController <UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) NSMutableArray* resultSet;
@end
