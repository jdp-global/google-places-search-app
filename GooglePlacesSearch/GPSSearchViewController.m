//
//  GPSSearchViewController.m
//  GooglePlacesSearch
//
//  Created by mihata on 12/7/13.
//  Copyright (c) 2013 mihata. All rights reserved.
//

#import "GPSSearchViewController.h"
#import "GPSResult.h"
#import "GPSResultsTableViewController.h"

@interface GPSSearchViewController ()
@property (retain, nonatomic) NSArray* cellData;
@property (retain, nonatomic) NSMutableDictionary* selectedCells;

@end

@implementation GPSSearchViewController
@synthesize cellData, selectedCells, data;

- (void)viewDidLoad
{
    [super viewDidLoad];
    data = [[NSMutableArray alloc] init];
    selectedCells = [[NSMutableDictionary alloc] init];
    
    cellData  = [NSArray arrayWithObjects: @"Bank", @"Cafe", @"Gym", nil];
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
    return 3;
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

-(UITableViewCell*)checkOrUncheckTableCell: (UITableViewCell*)thisCell withIndex:(NSIndexPath*)indexPath {
    if (thisCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        thisCell.accessoryType = UITableViewCellAccessoryNone;
        [selectedCells removeObjectForKey:[NSString stringWithFormat:@"%d",  indexPath.row]];
    } else {
        thisCell.accessoryType = UITableViewCellAccessoryCheckmark;
        [selectedCells setObject:thisCell.textLabel.text forKey:[NSString stringWithFormat:@"%d",  indexPath.row]];
    }
    
    return thisCell;
}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath];
    thisCell = [self checkOrUncheckTableCell:thisCell withIndex:indexPath];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath];
    
    thisCell = [self checkOrUncheckTableCell:thisCell withIndex:indexPath];
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

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"submitSearch"]) {
        [[segue destinationViewController] setResultSet:data];
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"submitSearch"]) {
        return NO;
    }
    return YES;
}

#pragma mark - UIButton handling

- (IBAction)searchButtonTapped:(id)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{};
    NSString* types = @"";
    NSString* glue = @"";
    for (id itr in selectedCells) {
        types = [types stringByAppendingString:[glue stringByAppendingString: selectedCells[itr]]];
        glue = @"%7C";
    }
    types = [types lowercaseString];
    NSString* url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&rankby=distance&sensor=false&types=%@&key=AIzaSyAJs7aFhIV3pp0stOa7SWkyqlhrK8TBtLM", types];
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [data removeAllObjects];
        if ([responseObject[@"status"] isEqualToString:@"OK"]) {
            for (id obj in responseObject[@"results"]) {
                GPSResult *resultObj = [[GPSResult alloc] init];
                resultObj.iconUrl = obj[@"icon"];
                resultObj.name = obj[@"name"];
                resultObj.rating = obj[@"rating"];
                resultObj.distance = [[NSDecimalNumber alloc] initWithDouble:3.0];
                [data addObject:resultObj];
            }
            [self performSegueWithIdentifier:@"submitSearch" sender:self];
        } else {

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [GPSHelper showAlertMessageWithTitle:@"No Results" andText:@"No result where sent, please try again later!"];
    }];

}
@end
