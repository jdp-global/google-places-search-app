//
//  GPSResultsCell.h
//  GooglePlacesSearch
//
//  Created by mihata on 12/8/13.
//  Copyright (c) 2013 mihata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPSResultsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *distance;

@property (weak, nonatomic) IBOutlet UILabel *rating;
@end
