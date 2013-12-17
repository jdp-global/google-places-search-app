//
//  GPSDetailsViewController.h
//  GooglePlacesSearch
//
//  Created by mihata on 12/17/13.
//  Copyright (c) 2013 mihata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPSResult.h"
@interface GPSDetailsViewController : UIViewController {
    GPSResult* detailItem;
}
@property (retain, nonatomic) GPSResult* detailItem;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameFld;
@property (weak, nonatomic) IBOutlet UILabel *distanceFld;
@property (weak, nonatomic) IBOutlet UILabel *ratingFld;

@end
