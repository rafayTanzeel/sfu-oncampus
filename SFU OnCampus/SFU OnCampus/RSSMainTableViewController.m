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
    
    self.title = @"News";
    
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model sizeOfArray]; //creates number of rows specified in SocialUrls plist
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Gives each cell it's respective image and text
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.model titleStringForIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed: [self.model imageNameForIndex:indexPath.row]];
    return cell;
}




 #pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {//Seguges and shows all the links of the selected cell
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSString* URL=[self.model urlStringForIndex:indexPath.row];
    RSSTableViewController *controller = (RSSTableViewController *)[segue destinationViewController];
    controller.rssUrl=[[NSURL alloc] initWithString:URL];
}


@end
