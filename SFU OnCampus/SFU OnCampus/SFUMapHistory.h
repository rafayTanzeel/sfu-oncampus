//
//  SFUMapHistory.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-18.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFUMapHistory : NSObject

-(NSUInteger)getAbsoluteFrequencyOfShortcode:(NSString*)s;
-(NSArray*)getTopShortCodesWithLimit:(NSUInteger)i;

-(NSUInteger)incrementFrequencyOfShortcode:(NSString*)s;
-(void)clearHistory;

@end
