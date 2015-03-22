//
//  SFUBuildingListViewControllerTableViewController.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUMapModel.h"
@interface SFUBuildingListViewControllerTableViewController : UITableViewController

typedef enum SFUNavigationListSet
{
    SFUNavigationListSetBuildings,SFUNavigationListSetPOI
}SFUNavigationListSet;
@property(nonatomic) SFUMapModel* model;
@property SFUNavigationListSet navigationSet;
@end
