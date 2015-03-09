//
//  SFUFacebookController.h
//  OnCampus
//
//  Created by Ashwani Gaba on 2015-03-08.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "DetailViewController.h"
#import "SFUWebListModel.h"
#import "SFUFacebookModel.h"

@interface SFUFacebookController : UITableViewController
@property (strong, nonatomic) IBOutlet SFUFacebookModel *model;
@property BOOL displayInApp;

@end
