//
//  SFULocation.m
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFULocation.h"

@implementation SFULocation

-(SFULocation*)initWithShortcodeString:(NSString*)shortcode
{
    NSArray* componenets = [shortcode componentsSeparatedByString:@"-"];
    self.buildingCode = [componenets objectAtIndex:0];
    NSArray* roomData = [[componenets objectAtIndex:1] componentsSeparatedByString:@"."];
    self.roomCode = [roomData objectAtIndex:0];
    self.partitionNumber = [roomData objectAtIndex:1];
    shortcode = shortcode;
    return self;
}

@end
