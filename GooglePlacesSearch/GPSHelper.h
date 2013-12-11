//
//  VCHelper.h
//  VChat
//
//  Created by mihata on 11/28/13.
//  Copyright (c) 2013 mihata. All rights reserved.
//

#define kOFFSET_FOR_KEYBOARD 200.0

#import <Foundation/Foundation.h>

@interface GPSHelper : NSObject

+(NSURLRequest*) sendSimpleHTTPRequestFor: (NSString*)url withStringData: (NSString*)stringData;
+(NSURLRequest*) sendSimpleHTTPRequestForPlacesWithLatitude: (NSString*) latitude Longitude: (NSString*) longitude AndTypes: (NSArray*) types;
+(void) showAlertMessageWithTitle: (NSString*) title andText: (NSString*) text;

@end
