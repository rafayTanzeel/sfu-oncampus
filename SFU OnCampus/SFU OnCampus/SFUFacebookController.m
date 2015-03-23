//
//  SFUFacebookController.m
//  OnCampus
//  Group 10
//  Nikhil Gaba, Abram Wiebe, Rafay Tanzeel, Kevin Grant, Sunny Chowdhury
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUFacebookController.h"
#import "SFUWebListController.h"
#import "SFUWebViewController.h"
@implementation SFUFacebookController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model sizeOfArray]; //Create number of rows from plist using SFUFacebookModel class
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];

    cell.textLabel.text = [self.model titleStringForIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed: [self.model imageNameForIndex:indexPath.row]];
    return cell;
}




 #pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender { //Segue to the webview
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSString* URL=[self.model urlStringForIndex:indexPath.row];

    SFUWebViewController *controller = (SFUWebViewController *)[[segue destinationViewController] topViewController];
    
    [controller displayPageForURL:[NSURL URLWithString:URL] inApp:YES];
    
    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    controller.navigationItem.leftItemsSupplementBackButton = YES;

}




@end
