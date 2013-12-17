//
//  GPSDetailsViewController.m
//  GooglePlacesSearch
//
//  Created by mihata on 12/17/13.
//  Copyright (c) 2013 mihata. All rights reserved.
//

#import "GPSDetailsViewController.h"
#import "UIImageView+WebCache.h"

@interface GPSDetailsViewController ()

@end

@implementation GPSDetailsViewController
@synthesize detailItem, imageView, nameFld, distanceFld, ratingFld;


-(void) setDetailItem:(GPSResult *)item {
    if (detailItem != item) {
        detailItem = item;
    }
    
    [self configureView];
}

-(void) configureView {
    [self.imageView setImageWithURL:detailItem.iconUrl  placeholderImage:[UIImage imageNamed:@"placeholder_icon"]];
    [self.nameFld setText:detailItem.name];
    [self.distanceFld setText:[NSString stringWithFormat:@"%.2f m", [detailItem.distance doubleValue]] ];
    [self.ratingFld setText:[detailItem.rating stringValue]];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
