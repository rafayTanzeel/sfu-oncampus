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
    self.balance = [n unsignedIntegerValue];
    self.balance += redeemedValue;
    n= [NSNumber numberWithUnsignedInteger:self.balance];
    [[NSUserDefaults standardUserDefaults] setObject:n forKey:@"kSFUPointCardBalance"];
    return self.balance;
}

@end
