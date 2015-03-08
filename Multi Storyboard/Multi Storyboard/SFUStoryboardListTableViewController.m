//
//  SFUStoryboardListTableViewController.m
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-08.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUStoryboardListTableViewController.h"
#import "SFUStoryboardListModel.h"
@interface SFUStoryboardListTableViewController ()

@end

@implementation SFUStoryboardListTableViewController

SFUStoryboardListModel* model;
- (void)viewDidLoad {
    [super viewDidLoad];
    model = [SFUStoryboardListModel new];
    [model initWithPlist:@"storyboardlist"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    return self.objects.count;
    return [model sizeOfArray];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [model titleStringForIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed: [model imageNameForIndex:indexPath.row]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* URL=[model storyboardStringForIndex:indexPath.row];
    
    self.targetViewIdentifier=[model targetViewStringForIndex:indexPath.row];
    //NSDate *object = self.objects[indexPath.row];
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:URL bundle:nil];
    UIViewController *controller = nil;
    
    if(self.targetViewIdentifier == nil)
    {
        controller = [secondStoryBoard instantiateInitialViewController];
    }
    else
    {
        controller = [secondStoryBoard instantiateViewControllerWithIdentifier:self.targetViewIdentifier];
    }
    
    if(controller == nil)
    {
        NSLog(@"SFUStorboardListController:: Error: Could not transition, no target view with given identifier");
        return;
    }
    
    [self.navigationController pushViewController:controller animated:YES];
    //[controller displayPageForURL:[NSURL URLWithString:URL] inApp:YES];
    
    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    controller.navigationItem.leftItemsSupplementBackButton = YES;
  
}
- (void)setDetailItem:(id)newDetailItem {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

@end
