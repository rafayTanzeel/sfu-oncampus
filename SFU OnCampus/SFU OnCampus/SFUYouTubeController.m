//
//  SFUYouTubeController.m
//  OnCampus
//
//  Created by Sunny Chowdhury on 2015-03-21.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUYouTubeController.h"
#import "SFUWebViewController.h"
@interface SFUYouTubeController ()

@end

@implementation SFUYouTubeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model sizeOfArray]; //Creates the rows from the plist elements
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
    cell.textLabel.text = [self.model titleStringForIndex:indexPath.row];
    return cell;
    //Assign each cell with there respective title from plist
}



 #pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSString* URL=[self.model urlStringForIndex:indexPath.row];
    SFUWebViewController *controller = (SFUWebViewController *)[[segue destinationViewController] topViewController];
    
    [controller displayPageForURL:[NSURL URLWithString:URL] inApp:YES];
    
    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    controller.navigationItem.leftItemsSupplementBackButton = YES;
    //Segues to the webview
}

@end
