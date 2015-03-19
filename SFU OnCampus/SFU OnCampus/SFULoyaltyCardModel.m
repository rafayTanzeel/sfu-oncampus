//
//  SFULoyaltyCardModel.m
//  OnCampus
//
//  Created by Abram Wiebe on 2015-03-03.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFULoyaltyCardModel.h"

@implementation SFULoyaltyCardModel

-(NSUInteger)redeemCode:(NSString*)code
{
    NSUInteger redeemedValue =0;
    NSNumber* n = [[NSUserDefaults standardUserDefaults] objectForKey:@"kSFUPointCardBalance"];
    NSUInteger balance = [n unsignedIntegerValue];
    balance += redeemedValue;
    n= [NSNumber numberWithUnsignedInteger:balance];
    [[NSUserDefaults standardUserDefaults] setObject:n forKey:@"kSFUPointCardBalance"];
    return balance;
}

@end
