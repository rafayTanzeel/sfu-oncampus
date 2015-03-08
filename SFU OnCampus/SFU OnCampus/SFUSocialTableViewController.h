//
//  SFUSocialViewController.h
//  OnCampus
//
//  Created by Rafay Tanzeel on 2015-02-26.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "DetailViewController.h"
#import "SFUWebListModel.h"

@interface SFUSocialTableViewController : UITableViewController
@property IBOutlet SFUWebListModel* model;
@property (strong, nonatomic) IBOutlet NSObject *otherModel;
@property BOOL displayInApp;
@end
