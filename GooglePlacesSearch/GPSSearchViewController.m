//
//  GPSSearchViewController.m
//  GooglePlacesSearch
//
//  Created by mihata on 12/7/13.
//  Copyright (c) 2013 mihata. All rights reserved.
//

#import "GPSSearchViewController.h"

@interface GPSSearchViewController ()
@property (retain, nonatomic) NSArray* cellData;
@property (retain, nonatomic) NSMutableDictionary* selectedCells;

@end

@implementation GPSSearchViewController
@synthesize cellData, selectedCells;

- (void)viewDidLoad
{
    [super viewDidLoad];
    selectedCells = [[NSMutableDictionary alloc] init];
    
    cellData  = [NSArray arrayWithObjects: @"Bank", @"Coffee", @"Gym", nil];
    self.tableView.allowsMultipleSelection = YES;
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
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString* isCellSelected = [selectedCells objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]];
    
    if (isCellSelected != nil) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // Configure the cell...
    cell.textLabel.text = cellData[indexPath.row % [cellData count]];
    
    return cell;
}

-(UITableViewCell*)checkOrUncheckTableCell: (UITableViewCell*)thisCell {
    if (thisCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        thisCell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        thisCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return thisCell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath];
    
    thisCell = [self checkOrUncheckTableCell:thisCell];
    
    [selectedCells setObject:thisCell.textLabel.text forKey:[NSString stringWithFormat:@"%d",  indexPath.row]];
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

- (IBAction)searchButtonTapped:(id)sender {
    @try {
        [NSURLConnection connectionWithRequest:[GPSHelper sendSimpleHTTPRequestForPlacesWithLatitude:@"-33.8670522" Longitude:@"151.1957362" AndTypes:[NSArray arrayWithObjects:@"food", nil]] delegate:self];
    }
    @catch (NSException *exception) {
        [GPSHelper showAlertMessageWithTitle:@"Error sending request" andText:@"Please try again later"];
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    //    [responseData appendData:data];
    self.responseData = data;
    //    [self stopAnimation];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSError* error;
    NSDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableContainers error:&error];
    //    int success = [[jsonData objectForKey:@"success"] intValue];
    //    NSArray* allKeys = [jsonData allKeys];
    
    if (error == nil) {
        
        [self.tableView reloadData];
    } else {
        [GPSHelper showAlertMessageWithTitle:@"No Results" andText:@"No result where sent, please try again later!"];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"error");
}
@end
