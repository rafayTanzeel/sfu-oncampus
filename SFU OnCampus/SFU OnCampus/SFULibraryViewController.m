//
//  SFULibraryViewController.m
//  Multi Storyboard
//
//  Created by Kevin Grant on 2015-03-14.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFULibraryViewController.h"
#import "SFULibraryCell.h"
#import "SFUWebViewController.h"

@interface SFULibraryViewController ()

@end

@implementation SFULibraryViewController

// Global dictionaries used for determining library hours
NSDictionary *burnabyHours;
NSDictionary *surreyHours;
NSDictionary *vancouverHours;

// Global dictionaries used for determining computer availability
NSDictionary *computers;
NSDictionary *laptops;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


/**
 * Gets the Hours of operation for each Library
 * If it cannot retrieve any data, a pop up is displayed to the user
 * informing them of the error.
 */
-(IBAction)getLibraryHours:(id)sender {
    
    // Prepare the URL
    NSURL *url = [NSURL URLWithString:@"http://api.lib.sfu.ca/hours/summary"];
    
    //Get URL page into NSData Object
    NSData *libraryHours = nil;
    
    @try {
        libraryHours = [NSData dataWithContentsOfURL:url];
    }
    @catch (NSException *exception) {
        
    }
    if(libraryHours == nil) {
        // Display the error pop up
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Library information cannot be displayed." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] show];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    //Read JSON and convert to object
    NSError *error;
    if(libraryHours != nil) {
        error = nil;
    }
    
    NSArray *hoursArray = [NSJSONSerialization JSONObjectWithData:libraryHours options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else {
        // Store the hours information in appropriate dictionaries
        burnabyHours = [hoursArray objectAtIndex:0];
        surreyHours = [hoursArray objectAtIndex:1];
        vancouverHours = [hoursArray objectAtIndex:2];
        
        NSLog(@"%@", hoursArray);
    }
}

/**
 * Gets the computer Availability for each Library
 * If it cannot retrieve any data, a pop up is displayed to the user
 * informing them of the error.
 */
-(IBAction)getComputerAvailability:(id)sender {
    
    // Prepare the URL
    NSURL *url = [NSURL URLWithString:@"http://api.lib.sfu.ca/equipment/computers/free_summary"];
    
    //Get URL page into NSData Object
    NSData *computerAvailability = nil;
    
    @try {
        computerAvailability = [NSData dataWithContentsOfURL:url];
    }
    @catch (NSException *exception) {
        
    }
    
    //Read JSON and convert to object
    NSError *error;
    if(computerAvailability != nil) {
        error = nil;
    }
    else {
        return;
    }

    // Store the data in the computers dictionary 
    computers = [NSJSONSerialization JSONObjectWithData:computerAvailability options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else {
        NSLog(@"%@", computers);
    }
}

/**
 * This function is run when the user pulls down to refresh the data on the page.
 */
- (void)refresh:(id)sender
{
    NSLog(@"Refreshing");
    
    // Refresh the data
    [self getLibraryHours:self];
    [self getComputerAvailability:self];
    [self.tableView reloadData];
    
    // End refreshing
     [(UIRefreshControl *)sender endRefreshing];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Library";
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    // Colour remains grey if user overscrolls
    self.view.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];

    // Set background to SFU red and tint to white 
    self.refreshControl.backgroundColor = [UIColor colorWithRed:(166/255.f) green:(25/255.f) blue:(46/255.f) alpha:1.0f];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refresh:)
                  forControlEvents:UIControlEventValueChanged];

    
    [self getLibraryHours:self];
    [self getComputerAvailability:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 4;
}

/**
 * Sets the height for each cell in the view.
 */

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 1) {
        return 348;
    }
    else if (indexPath.row == 2) {
        return 212;
    }
    else if (indexPath.row == 3) {
        return 187;
    }
    else {
        return 40;
    }
}

/**
 * Loads the table view cell. 
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // -----------------------------
    // LIBRARY CATALOGUE BUTTON
    // -----------------------------
    if (indexPath.row == 0) {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ButtonCell"];
        return cell;
    }
    
    // -----------------------------
    // SFU BURNABY
    // -----------------------------
    if (indexPath.row == 1) {
        
        SFULibraryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SFULibraryCell"];
        
        // URL for displaying study room web view
        cell.URL = @"http://roombookings.lib.sfu.ca/m/library.php?l=benn";
        
        // Set library name
        cell.libraryName.text = @"SFU Burnaby";
        
        // Library Hours, open status
        [cell updateLibraryStatusLabels:cell.hours status:cell.libraryStatus withDictionary:burnabyHours];
        
        // Computer availability for each location
        [cell updateBurnabyComputerLabels:cell withDictionary:computers];
        
        return cell;
    }
    
    // -----------------------------
    // SFU SURREY
    // -----------------------------
    if (indexPath.row == 2) {
        
        SFULibraryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SFULibraryCell"];
        
        // URL for displaying study room web view
        cell.URL = @"http://roombooking.surrey.sfu.ca/day.php";
        
        // Set library name
        cell.libraryName.text = @"SFU Surrey";
        
        // Library Hours, open status
        [cell updateLibraryStatusLabels:cell.hours status:cell.libraryStatus withDictionary:surreyHours];

        // Computer availability for each location
        [cell updateSurreyComputerLabels:cell withDictionary:computers];
        
        return cell;
    }
    
    // -----------------------------
    // SFU HARBOUR CENTER
    // -----------------------------
    else {
        
        SFULibraryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SFULibraryCell"];
        
        // URL for displaying study room web view
        cell.URL = @"http://roombookings.lib.sfu.ca/m/library.php?l=belz";
        
        // Set library name
        cell.libraryName.text = @"SFU Harbour Center";
        
        // Library Hours, open status
        [cell updateLibraryStatusLabels:cell.hours status:cell.libraryStatus withDictionary:vancouverHours];

        // Computer availability for each location
        [cell updateVancouverComputerLabels:cell withDictionary:computers];
        
        return cell;
    }
}

/**
 * Action displaying the mobile site of the SFU Library catalogue
 */
- (IBAction)displayLibraryCatalogue:(id)sender {
    
    // Instantiate the view controller
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"WebView" bundle:nil];
    SFUWebViewController *c = [secondStoryBoard instantiateInitialViewController];
    
    // Tell the view what page to display
    NSURL *URL = [NSURL URLWithString:@"http://www.lib.sfu.ca/m/find"];
    [c displayPageForURL:URL];
    
    // Push the webview
    [self.navigationController pushViewController:c animated:YES];
}

/**
 * Action displaying the mobile site to book study room 
 * uses different URL for each library
 */
- (IBAction)displayBookStudyRoom:(id)sender {
    
    // Instantiate the view controller
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"WebView" bundle:nil];
    SFUWebViewController *c = [secondStoryBoard instantiateInitialViewController];
    
    // Tell the button what page to display
    SFUBookRoomButton *button = (SFUBookRoomButton*)sender;
    NSURL *URL = [NSURL URLWithString:button.URL];
    [c displayPageForURL:URL];
    
    // Push the webview
    [self.navigationController pushViewController:c animated:YES];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
