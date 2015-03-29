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
{
@private
SFUStoryboardListModel* model;
}

@end

@implementation SFUStoryboardListTableViewController

-(void)loginSelected
{
    UIStoryboard* s = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    [self transitionStoryboardWithName:s performingSelector:nil withParameter:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    model = [SFUStoryboardListModel new];
    [model initWithPlist:@"storyboardlist"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    UIBarButtonItem* navItem = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStyleBordered target:self action:@selector(loginSelected)];
    self.navigationItem.rightBarButtonItem = navItem;
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
    return [model sizeOfArray]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([model sizeOfArray] == indexPath.row)
    {
       return [tableView dequeueReusableCellWithIdentifier:@"LogoCell" forIndexPath:indexPath];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [model titleStringForIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed: [model imageNameForIndex:indexPath.row]];
    
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == [model sizeOfArray])
    {
        return 300.0;
    }
    else
    {
        return 44.0;
    }
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

-(void)transitionStoryboardWithName:(UIStoryboard*)secondStoryBoard performingSelector:(SEL)f withParameter:(id)param
{
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
    
    //[self.navigationController setViewControllers:a];
    ///TODO split into seperate function
    @try{
        //since the main menu is on another navigation controller, we don't need to push it, instead the first view controller of the detail view is the selected item
        NSArray* a = [NSArray arrayWithObjects:controller, nil];
        //On an ipad, use the 2nd view controller in the split
        UINavigationController* n = [self.splitViewController.viewControllers objectAtIndex:1];
        [n setViewControllers:a];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }@catch (NSException* e)
    {
        NSArray* a = [NSArray arrayWithObjects:self, nil];// get self into an array, so we can pop back to main menu
        //On iPhone or any device where the split view is not used, use the 0th element (ie the same view as the menu)
        UINavigationController* n = [self.splitViewController.viewControllers objectAtIndex:0];
        [n setViewControllers:a];
        [n pushViewController:controller animated:YES];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
    
    
    
    if([controller respondsToSelector:f])
    {

        [controller performSelector:f withObject:param];
    }
    
    [self splitViewController ];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* URL=[model storyboardStringForIndex:[self.tableView indexPathForSelectedRow].row];
    
    self.targetViewIdentifier=[model targetViewStringForIndex:[self.tableView indexPathForSelectedRow].row];
    //NSDate *object = self.objects[indexPath.row];
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:URL bundle:nil];
    SEL f = NSSelectorFromString([model selectorForIndex:indexPath.row]);
    id param = [model parameterForIndex:indexPath.row];
    [self transitionStoryboardWithName:secondStoryBoard performingSelector:f withParameter:param];
  
}
- (void)setDetailItem:(id)newDetailItem {
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}
- (IBAction)unwindToSFUStoryboardListTableViewController:(UIStoryboardSegue *)segue {
    //nothing goes here
}



@end
