//
//  SFUSocialViewController.m
//  OnCampus
//
//  Created by Rafay Tanzeel on 2015-02-26.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUSocialTableViewController.h"
#import "SFUWebViewController.h"
@interface SFUSocialTableViewController ()

@end

@implementation SFUSocialTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//if ([[segue identifier] isEqualToString:@"showDetail"]) {
NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
NSString* URL=[self.model urlStringForIndex:indexPath.row];
    SFUWebViewController *controller = (SFUWebViewController *)[[segue destinationViewController] topViewController];
    
    [controller displayPageForURL:[NSURL URLWithString:URL] inApp:YES];

controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
controller.navigationItem.leftItemsSupplementBackButton = YES;
}





@end
