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
/*

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [SFUWebListModel alloc];
    [self.model initWithPlist:@"SFUSocialServiceURLs"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(id)table didSelectRowAtIndexPath:( NSIndexPath*)index
{
    serviceName = [self.model titleStringForIndex:index.row];
    [self performSegueWithIdentifier:@"sugueSocialList" sender:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    return self.objects.count;
    return [self.model sizeOfArray];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
    
    //    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [self.model titleStringForIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed: [self.model imageNameForIndex:indexPath.row]];
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

*/
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//if ([[segue identifier] isEqualToString:@"showDetail"]) {
//NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

//NSString* URL=[self.model urlStringForIndex:indexPath.row];
    UIViewController *controller = (UIViewController *)[segue destinationViewController];



controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
controller.navigationItem.leftItemsSupplementBackButton = YES;
 
}





@end
