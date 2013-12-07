//
//  GPSResult.h
//  GooglePlacesSearch
//
//  Created by mihata on 12/8/13.
//  Copyright (c) 2013 mihata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPSResult : NSObject
{
    NSString* name;
    NSDecimalNumber* distance;
    NSURL* iconUrl;
    NSDecimalNumber* rating;
}

@property (retain, nonatomic) NSString* name;
@property (retain, nonatomic) NSDecimalNumber* distance;
@property (retain, nonatomic) NSURL* iconUrl;
@property (retain, nonatomic) NSDecimalNumber* rating;
@end
