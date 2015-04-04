//
//  SFULoyaltyCardModel.h
//  OnCampus
//
//  Created by Abram Wiebe on 2015-03-03.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFULoyaltyCardModel : NSObject

///Create a card that will identify itself to the server as the given user
-(SFULoyaltyCardModel*)initWithUsername:(NSString*)name;

/**
 Redeem a token
 @param code the token
 @post Value synced with server.
 @return point value for code
 */
-(NSInteger)setBalance:(NSInteger)input;

///Get the current point balance stored on the card.

///Verify the card balance with the server
-(void)syncBalance;
@end
