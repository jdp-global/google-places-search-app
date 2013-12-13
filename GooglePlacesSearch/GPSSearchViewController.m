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
@synthesize cellData, selectedCells, data;

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

#pragma mark - UIButton handling

- (IBAction)searchButtonTapped:(id)sender {
    @try {
        NSURLRequest* request = [GPSHelper sendSimpleHTTPRequestForPlacesWithLatitude:@"-33.8670522" Longitude:@"151.1957362" AndTypes:[NSArray arrayWithObjects:@"food", nil]];
        [NSURLConnection connectionWithRequest:request delegate:self];
        
//        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//            NSLog(@"App.net Global Stream: %@", JSON);
//        } failure:nil];
//        [operation start];

        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"foo": @"bar"};
        [manager POST:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&rankby=distance&sensor=false&types=food&key=AIzaSyAJs7aFhIV3pp0stOa7SWkyqlhrK8TBtLM" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            data = responseObject;
            if ([data[@"status"] isEqualToString:@"OK"]) {
                
                [self.tableView reloadData];
            } else {

            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [GPSHelper showAlertMessageWithTitle:@"No Results" andText:@"No result where sent, please try again later!"];
        }];
    }
    @catch (NSException *exception) {
        [GPSHelper showAlertMessageWithTitle:@"Error sending request" andText:@"Please try again later"];
    }
}
@end
