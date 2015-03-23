//
//  SFUSocialViewController.m
//  OnCampus
//
//  Created by Rafay Tanzeel on 2015-02-26.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUSocialTableViewController.h"
#import "SFUWebListController.h"
@interface SFUSocialTableViewController ()

@end

@implementation SFUSocialTableViewController

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UIViewController *controller = (UIViewController *)[segue destinationViewController];



controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
controller.navigationItem.leftItemsSupplementBackButton = YES;
 
}





@end
