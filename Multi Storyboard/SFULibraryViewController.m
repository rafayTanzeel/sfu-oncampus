//
//  SFULibraryViewController.m
//  Multi Storyboard
//
//  Created by Kevin Grant on 2015-03-14.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFULibraryViewController.h"
#import "SFULibraryCell.h"

@interface SFULibraryViewController ()

@end

@implementation SFULibraryViewController

// Global dictionaries used for determining library hours
NSDictionary *burnabyHours;
NSDictionary *surreyHours;
NSDictionary *vancouverHours;

// Global dictionaries used for determining computer availability
NSDictionary *computersAvailable;
NSDictionary *computerTotals;

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
    @finally {
        
    }
    if(libraryHours == nil)
    {
        // Display the error pop up
        [[[UIAlertView alloc] initWithTitle:@"Network Unavailable" message:@"Weather cannot be displayed" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] show];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    //Read JSON and convert to object
    NSError *error;
    if(libraryHours != nil)
    {
        error = nil;
    }
    NSArray *hoursArray = [NSJSONSerialization JSONObjectWithData:libraryHours options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
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
    @finally {
        
    }
    if(computerAvailability == nil)
    {
        // Display the error pop up
        [[[UIAlertView alloc] initWithTitle:@"Network Unavailable" message:@"Weather cannot be displayed" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] show];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    //Read JSON and convert to object
    NSError *error;
    if(computerAvailability != nil)
    {
        error = nil;
    }
    NSDictionary *computers = [NSJSONSerialization JSONObjectWithData:computerAvailability options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        computersAvailable = [computers valueForKey:@"locations"];
        computerTotals = [computers valueForKey:@"totals"];
    }
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    // Colour remains grey if user overscrolls
    self.view.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
    
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
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // BURNABY
    if (indexPath.row == 0) {
        
        SFULibraryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SFULibraryCell"];
        
        // Set library name
        cell.libraryName.text = @"SFU Burnaby";
        
        // Library Hours
        NSString *open = [burnabyHours valueForKey:@"open_time"];
        NSString *close = [burnabyHours valueForKey:@"close_time"];
        NSString *hours = [NSString stringWithFormat:@"%@ - %@", open, close];
        cell.hours.text = hours;
        
        // Computer availability label
        cell.availabilityLabel.text = @"Computer Availability";
        
        // Computer availability for each location
        
        
        
        return cell;
    }
    
    // SURREY
    if (indexPath.row == 1) {
        
        SFULibraryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SFULibraryCell"];
        return cell;
    }
    
    // VANCOUVER
    else {
        
        SFULibraryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SFULibraryCell"];
        return cell;
    }
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
