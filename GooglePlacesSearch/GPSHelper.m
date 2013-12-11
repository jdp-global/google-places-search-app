//
//  VCHelper.m
//  VChat
//
//  Created by mihata on 11/28/13.
//  Copyright (c) 2013 mihata. All rights reserved.
//

#import "GPSHelper.h"

@implementation GPSHelper

+(NSURLRequest*) sendSimpleHTTPRequestFor: (NSString*)url withStringData: (NSString*)stringData {
    NSURL *fullUrl = [NSURL URLWithString:[@"https://maps.googleapis.com/maps/api/" stringByAppendingString:url]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:fullUrl];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    NSData *data = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%u", [data length]] forHTTPHeaderField:@"Content-Length"];
    return request;
}

+(NSURLRequest*)sendSimpleHTTPRequestForPlacesWithLatitude: (NSString*) latitude Longitude: (NSString*) longitude AndTypes: (NSArray*) types {
    if ([latitude length] == 0 || [longitude length] == 0) {
        [NSException raise:@"Invalid location provided" format:@"Please switch your GPS!"];
    }
    
    NSString* typesString = [@"&types=" stringByAppendingString: [types componentsJoinedByString:@"&"]];
    NSString* locationString = [[[@"location=" stringByAppendingString:latitude]
                                 stringByAppendingString:@","]
                                 stringByAppendingString:longitude];
    NSString* data = [[locationString stringByAppendingString:@"&rankby=distance&sensor=false"]
                      stringByAppendingString:typesString];
    return [self sendSimpleHTTPRequestFor:@"place/nearbysearch/json?" withStringData:data];
}

+(void) showAlertMessageWithTitle:(NSString *)title andText:(NSString *)text {
    UIAlertView *alertView = [[UIAlertView alloc ] initWithTitle:title
                                                         message:text
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil, nil];
    
    [alertView show];
}

@end
