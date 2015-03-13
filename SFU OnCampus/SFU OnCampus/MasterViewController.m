//
//  MasterViewController.m
//  SFU OnCampus
//
//  Created by Abram Wiebe on 2015-02-19.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "SFUWebViewController.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
        
        
        //Cannot easily programatically dismiss menu, so trust that apple users know how to dismiss a master detail menu.
        //        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissSelf)];
        //        self.navigationItem.rightBarButtonItem = doneButton;
    }
}

-(void)dismissSelf
{
    NSLog(@"Should dimiss self, not implemented");
    if (self.splitViewController) {
        
    }
    
}
-(void)updateCopyright
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"- yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    
    NSString* s = @"© 2015 ";
    NSString* sfuString=@"Simon Fraiser University";
    if( ![yearString isEqualToString:@"- 2015"])
    {
        s =[s stringByAppendingString:yearString];
    }
    self.copyrighLabel.text= [s stringByAppendingString:sfuString];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    [self updateCopyright];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //if ([[segue identifier] isEqualToString:@"showDetail"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    //NSDate *object = self.objects[indexPath.row];
    DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
    
    //UITableView* tv = (UITableView*)self.view;
    // UITableViewCell* cell =  [tv cellForRowAtIndexPath:indexPath];
    //  NSString* selected = cell.textLabel.text;
    
    //Special Case for dining button
    UITableViewCell* cell =[self.tableView cellForRowAtIndexPath:indexPath];
    if([cell.reuseIdentifier isEqualToString:@"diningOptionsCell"])
    {
        SFUWebViewController* w =  (SFUWebViewController*)[[segue destinationViewController] topViewController];
        NSURL* url = [NSURL URLWithString:@"http://dineoncampus.ca/sfu"];
        [w displayPageForURL:url inApp:YES ];
        //-(void)displayPageForURL:(NSURL*)url inApp:(BOOL)showInApp
        w.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        w.navigationItem.leftItemsSupplementBackButton = YES;
        
    }
    else
    {
        
        if([controller respondsToSelector:@selector(setDetailItem:)])
        {
            [controller setDetailItem:[segue identifier]];
        }
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
    // }
}
- (IBAction)unwindToMasterViewController:(UIStoryboardSegue *)segue {
    //nothing goes here
}
#pragma mark - Table View

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.objects.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//
//    NSDate *object = self.objects[indexPath.row];
//    cell.textLabel.text = [object description];
//    return cell;
//}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}

@end
