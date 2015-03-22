//
//  RSSMainTableViewController.m
//  OnCampus
//
//  Created by Rafay Tanzeel on 2015-03-16.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "RSSMainTableViewController.h"
#import "RSSTableViewController.h"
@interface RSSMainTableViewController ()

@end

@implementation RSSMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    return self.objects.count;
    return [self.model sizeOfArray];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [self.model titleStringForIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed: [self.model imageNameForIndex:indexPath.row]];
    return cell;
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //if ([[segue identifier] isEqualToString:@"showDetail"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSString* URL=[self.model urlStringForIndex:indexPath.row];
    //NSDate *object = self.objects[indexPath.row];
    RSSTableViewController *controller = (RSSTableViewController *)[[segue destinationViewController] topViewController];
    controller.rssUrl=[[NSURL alloc] initWithString:URL];

}


@end
