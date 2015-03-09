//
//  SFUWebListController.h
//  SFU OnCampus
//
//  Created by Abram Wiebe on 2015-02-21.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUWebListModel.h"
@interface SFUWebListController : UITableViewController

@property BOOL displayInApp;
@property IBOutlet SFUWebListModel* model;

-(void)facebookList;
-(void)twitterList;

-(void)setModel:(SFUWebListModel*)model;
@end
