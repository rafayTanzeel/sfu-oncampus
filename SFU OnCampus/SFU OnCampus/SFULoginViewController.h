//
//  SFULoginViewController.h
//  OnCampus
//
//  Created by Kevin Grant on 2015-03-21.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFULoginViewController : UIViewController

// Computing ID and password text fields
@property (weak, nonatomic) IBOutlet UITextField *computingID;
@property (weak, nonatomic) IBOutlet UITextField *password;

// Sign in button
@property (weak, nonatomic) IBOutlet UIButton *signinButton;
- (IBAction)signinButtonClicked:(id)sender;

@end
