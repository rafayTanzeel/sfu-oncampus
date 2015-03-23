//
//  SFULoginViewController.h
//  OnCampus
//  Group 10
//  Nikhil Gaba, Abram Wiebe, Rafay Tanzeel, Kevin Grant, Sunny Chowdhury
//
//  Created by Kevin Grant on 2015-03-21.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Custom UIViewController used to allow the user to sign in with their
 * SFU Computing ID and password to SFU's Central Authentication Service.
 *
 * @author Kevin Grant
 * @version 1.0
 */
@interface SFULoginViewController : UIViewController

// Computing ID and password text fields
@property (weak, nonatomic) IBOutlet UITextField *computingID;
@property (weak, nonatomic) IBOutlet UITextField *password;

// Sign in button
@property (weak, nonatomic) IBOutlet UIButton *signinButton;

// Action that is run when the sign in button is touched
- (IBAction)signinButtonClicked:(id)sender;

@end
