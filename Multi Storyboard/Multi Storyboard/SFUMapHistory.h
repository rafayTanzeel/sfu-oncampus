//
//  SFUMapHistory.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-18.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class represents the history of finding locations on the map in the same way a webbrowser tracks page frequency.
 It is not currently implemented.
 \todo Implement
 */
@interface SFUMapHistory : NSObject

-(NSUInteger)getAbsoluteFrequencyOfShortcode:(NSString*)s;
-(NSArray*)getTopShortCodesWithLimit:(NSUInteger)i;

-(NSUInteger)incrementFrequencyOfShortcode:(NSString*)s;
-(void)clearHistory;

@end
