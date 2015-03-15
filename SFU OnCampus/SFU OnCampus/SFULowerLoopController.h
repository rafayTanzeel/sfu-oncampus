//
//  SFULowerLoopController.h
//  OnCampus
//
//  Created by Nikhil Gaba on 2015-03-14.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUTransitModel.h"
#import "SFUTransitDisplayViewController.h"

@interface SFULowerLoopController : UITableViewController

@property BOOL displayInApp;
@property (strong, nonatomic) IBOutlet SFUTransitModel *model;
///Do not use currently
@end
