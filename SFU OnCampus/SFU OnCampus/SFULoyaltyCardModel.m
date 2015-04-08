//
//  SFULoyaltyCardModel.m
//  OnCampus
//
//  Created by Abram Wiebe on 2015-03-03.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFULoyaltyCardModel.h"

@interface SFULoyaltyCardModel()
{
    @private NSInteger balance;
}
@end

@implementation SFULoyaltyCardModel

-(NSInteger)addBalance:(NSInteger)input
{
    NSUInteger redeemedValue =input;
    NSNumber* n = [[NSUserDefaults standardUserDefaults] objectForKey:@"kSFUPointCardBalance"];
    balance = [n unsignedIntegerValue];
    balance += redeemedValue;
    n= [NSNumber numberWithUnsignedInteger:balance];
    [[NSUserDefaults standardUserDefaults] setObject:n forKey:@"kSFUPointCardBalance"];
    return balance;
}

-(NSInteger)getBalance
{
    NSNumber* n = [[NSUserDefaults standardUserDefaults] objectForKey:@"kSFUPointCardBalance"];
    return [n integerValue];
}

@end
