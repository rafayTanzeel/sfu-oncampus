//
//  SFUShortCodeComposerViewController.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUMapViewController.h"

@interface SFUShortCodeComposerViewController : UITableViewController

-(void)fillBuildingFieldWithString:(NSString*)s;
@property (strong, nonatomic) IBOutlet UITextField *buildingCodeField;
- (IBAction)doneButton:(id)sender;
-(NSString*)composeShortcode;
@end
