//
//  SFULoyaltyCardViewController.h
//  OnCampus
//
//  Created by Abram Wiebe on 2015-03-19.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUQRCaptureViewController.h"
#import "SFUQRCaptureDelegate.h"
@interface SFULoyaltyCardViewController : UIViewController <SFUQRCaptureDelegate>
- (IBAction)scanCode:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *pointsLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLine;

-(IBAction)unwindToSFULoyaltyCardViewController:(UIStoryboardSegue *)segue ;

    

@end
