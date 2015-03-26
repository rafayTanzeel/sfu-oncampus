//
//  SFUMapAnnotation.m
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUMapAnnotation.h"

@interface SFUMapAnnotation()
{
    @private
    NSString* title;
    NSString* subtitle;
    NSString* shortcode;
}

@end


@implementation SFUMapAnnotation

-(SFUMapAnnotation*)initWithTitle:(NSString*)t subtitle:(NSString*)sub shortcode:(NSString*)aShortcode
{
    title=t;
    subtitle=sub;
    shortcode=aShortcode;
    return self;
}

- (NSString *)title
{
    return title;
}

// optional
- (NSString *)subtitle
{
    return [NSString stringWithFormat:@"%@ - %@",[shortcode uppercaseString],subtitle];
}
@end
