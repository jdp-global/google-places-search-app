//
//  GPSResultsTableViewController.m
//  GooglePlacesSearch
//
//  Created by mihata on 12/8/13.
//  Copyright (c) 2013 mihata. All rights reserved.
//

#import "GPSResultsTableViewController.h"
#import "GPSResult.h"
#import "GPSResultsCell.h"
#import "UIImageView+WebCache.h"

@interface GPSResultsTableViewController ()

@end

@implementation GPSResultsTableViewController
@synthesize resultSet;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)setResultSet:(NSMutableArray *)result
{
    if (resultSet != result) {
        resultSet = result;
        
        // Update the view.
        [self.tableView reloadData];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];

//    resultSet = [[NSMutableArray alloc] init];
//    
//    GPSResult* resultObject = [[GPSResult alloc] init];
//    resultObject.name = @"name";
//    resultObject.rating = [[NSDecimalNumber alloc] initWithDouble:3.3];
//    resultObject.iconUrl = [NSURL URLWithString:@"http://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png"];
//    resultObject.distance = [[NSDecimalNumber alloc] initWithDouble:3.0];
//    
//    [resultSet addObject:resultObject];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [resultSet count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ResultCell";
    GPSResultsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    GPSResult* resultObj = [resultSet objectAtIndex:indexPath.row];
    // Configure the cell...
    cell.name.text = resultObj.name;
    cell.rating.text = [NSString stringWithFormat:@"%.1lf", [resultObj.rating doubleValue]];
    cell.distance.text = [NSString stringWithFormat:@"%.1lf", [resultObj.distance doubleValue]];

    NSURL* imageUrl = [resultObj iconUrl];

    [cell.imageView setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"placeholder_icon"]];
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
