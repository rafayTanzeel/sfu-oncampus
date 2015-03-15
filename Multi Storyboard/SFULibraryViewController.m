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

// Global dictionary used for determining computer availability
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
    computers = [NSJSONSerialization JSONObjectWithData:computerAvailability options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        NSLog(@"%@", computers);
    }
}

/*
 * Gets the laptop availability

-(IBAction)getLaptopAvailability:(id)sender {
    
    // Prepare the URL
    NSURL *url = [NSURL URLWithString:@"http://api.lib.sfu.ca/hours/summary"];
    
    //Get URL page into NSData Object
    NSData *laptopAvailability = nil;
    
    @try {
        laptopAvailability = [NSData dataWithContentsOfURL:url];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    if(laptopAvailability == nil)
    {
        // Display the error pop up
        [[[UIAlertView alloc] initWithTitle:@"Network Unavailable" message:@"Data cannot be displayed" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] show];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }

    //Read JSON and convert to object
    NSError *error;
    if(laptopAvailability != nil)
    {
        error = nil;
    }
    laptops = [NSJSONSerialization JSONObjectWithData:laptopAvailability options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        NSLog(@"%@", laptops);
    }
}
    */
/**
 * Gets the transit info
 */
-(IBAction)getTransitJSON:(id)sender {
    
    // Prepare the URL
    NSURL *url = [NSURL URLWithString:@"http://api.translink.ca/rttiapi/v1/stops/60980/estimates?apikey=hwnVuhVaVWlOp48qZvNY&routeNo=050"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url      cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];

    
    [request setHTTPMethod:@"GET"];
    
    [request addValue:@"application/JSON" forHTTPHeaderField:@"content-type"];
    
    
    //Get URL page into NSData Object
    NSURLResponse *response = NULL;
    NSError *error = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary *transit = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    NSLog(@"hello\n");
    NSLog(@"url to send request= %@\n",url);
    NSLog(@"%@",transit);
    NSLog(@"\n\n");
    /*
    @try {
        transitData = [NSData dataWithContentsOfURL:url];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    if(transitData == nil)
    {
        // Display the error pop up
        [[[UIAlertView alloc] initWithTitle:@"Network Unavailable" message:@"Weather cannot be displayed" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] show];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    //Read JSON and convert to object
    NSError *error;
    if(transitData != nil)
    {
        error = nil;
    }
    NSArray *transit = [NSJSONSerialization JSONObjectWithData:transitData options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        NSLog(@"%@", transit);

    }
     */
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    // Colour remains grey if user overscrolls
    self.view.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
    
    [self getLibraryHours:self];
    [self getComputerAvailability:self];
    [self getTransitJSON:self];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ButtonCell"];
        return cell;
    }
    // BURNABY
    if (indexPath.row == 1) {
        
        SFULibraryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SFULibraryCell"];
        
        // Set library name
        cell.libraryName.text = @"SFU Burnaby";
        
        // Library Hours
        NSString *open = [burnabyHours valueForKey:@"open_time"];
        NSString *close = [burnabyHours valueForKey:@"close_time"];
        NSString *hours = [NSString stringWithFormat:@"%@ - %@", open, close];
        cell.hours.text = hours;
        
        // Computer availability label, available label, in use label
        cell.availabilityLabel.text = @"Computer Availability";
        cell.available.text = @"available";
        
        // Library Status
        NSNumber *status = [burnabyHours valueForKey:@"in_range"];
        if ([status integerValue] == 1) {
            cell.libraryStatus.text = @"OPEN";
            cell.libraryStatus.textColor = [UIColor colorWithRed:(0/255.f) green:(150/255.f) blue:(0/255.f) alpha:1.0f];
        }
        else {
            cell.libraryStatus.text = @"CLOSED";
            cell.libraryStatus.textColor = [UIColor colorWithRed:(226/255.f) green:(8/255.f) blue:(19/255.f) alpha:1.0f];
        }
        
        // Computer availability for each location
        
        // 6th floor
        [cell updateComputerAvaiability:cell.availableOne used:cell.usedOne locationLabel:cell.locationOne locationName:@"6th floor" locationValue:@"ben-6-pc" progressBar:cell.progressOne withDictionary:computers];
        
        // 5th floor
        [cell updateComputerAvaiability:cell.availableTwo used:cell.usedTwo locationLabel:cell.locationTwo locationName:@"5th floor" locationValue:@"ben-5-pc" progressBar:cell.progressTwo withDictionary:computers];
        
        // 4th floor
        [cell updateComputerAvaiability:cell.availableThree used:cell.usedThree locationLabel:cell.locationThree locationName:@"4th floor" locationValue:@"ben-4-4009-pc" progressBar:cell.progressThree withDictionary:computers];
        
        // 3rd floor east PCs
        [cell updateComputerAvaiability:cell.availableFour used:cell.usedFour locationLabel:cell.locationFour locationName:@"3rd floor East - PCs" locationValue:@"ben-3-e-pc" progressBar:cell.progressFour withDictionary:computers];
        
        // 3rd floor east Macs
        [cell updateComputerAvaiability:cell.availableFive used:cell.usedFive locationLabel:cell.locationFive locationName:@"3rd floor East - Macs" locationValue:@"ben-3-e-mac" progressBar:cell.progressFive withDictionary:computers];
        
        // 3rd floor west
        [cell updateComputerAvaiability:cell.availableSix used:cell.usedSix locationLabel:cell.locationSix locationName:@"3rd floor West" locationValue:@"ben-3-w-pc" progressBar:cell.progressSix withDictionary:computers];
        
        // 2nd floor
        [cell updateComputerAvaiability:cell.availableSeven used:cell.usedSeven locationLabel:cell.locationSeven locationName:@"2nd floor" locationValue:@"ben-2-2105-pc" progressBar:cell.progressSeven withDictionary:computers];
        
        // Laptops
        [cell updateComputerAvaiability:cell.availableEight used:cell.usedEight locationLabel:cell.locationEight locationName:@"Laptops" locationValue:@"ben-checkout-laptops" progressBar:cell.progressEight withDictionary:computers];
        
        
        return cell;
    }
    
    // SURREY
    if (indexPath.row == 2) {
        
        SFULibraryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SFULibraryCell"];
        
        // Set library name
        cell.libraryName.text = @"SFU Surrey";
        
        // Library Hours
        NSString *open = [surreyHours valueForKey:@"open_time"];
        NSString *close = [surreyHours valueForKey:@"close_time"];
        NSString *hours = [NSString stringWithFormat:@"%@ - %@", open, close];
        cell.hours.text = hours;
        
        // Computer availability label, available label, in use label
        cell.availabilityLabel.text = @"Computer Availability";
        cell.available.text = @"available";
        
        // Library Status
        NSNumber *status = [surreyHours valueForKey:@"in_range"];
        if ([status integerValue] == 1) {
            cell.libraryStatus.text = @"OPEN";
            cell.libraryStatus.textColor = [UIColor colorWithRed:(0/255.f) green:(150/255.f) blue:(0/255.f) alpha:1.0f];
        }
        else {
            cell.libraryStatus.text = @"CLOSED";
            cell.libraryStatus.textColor = [UIColor colorWithRed:(226/255.f) green:(8/255.f) blue:(19/255.f) alpha:1.0f];
        }
        
        // Computer availability for each location
        
        // PCs
        [cell updateComputerAvaiability:cell.availableOne used:cell.usedOne locationLabel:cell.locationOne locationName:@"Library PCs" locationValue:@"surrey-lib" progressBar:cell.progressOne withDictionary:computers];
        
        // Macs
        [cell updateComputerAvaiability:cell.availableTwo used:cell.usedTwo locationLabel:cell.locationTwo locationName:@"Library Macs" locationValue:@"surrey-lib-mac" progressBar:cell.progressTwo withDictionary:computers];
        
        // Empty the rest of the values
        [cell emptyComputerLabels:cell.availableThree used:cell.usedThree locationLabel:cell.locationThree progressBar:cell.progressThree];
        
        [cell emptyComputerLabels:cell.availableFour used:cell.usedFour locationLabel:cell.locationFour progressBar:cell.progressFour];
        
        [cell emptyComputerLabels:cell.availableFive used:cell.usedFive locationLabel:cell.locationFive progressBar:cell.progressFive];
        
        [cell emptyComputerLabels:cell.availableSix used:cell.usedSix locationLabel:cell.locationSix progressBar:cell.progressSix];
        
        [cell emptyComputerLabels:cell.availableSeven used:cell.usedSeven locationLabel:cell.locationSeven progressBar:cell.progressSeven];
        
        [cell emptyComputerLabels:cell.availableEight used:cell.usedEight locationLabel:cell.locationEight progressBar:cell.progressEight];
        
        return cell;
    }
    
    // VANCOUVER
    else {
        
        SFULibraryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SFULibraryCell"];
        
        // Set library name
        cell.libraryName.text = @"SFU Harbour Center";
        
        // Library Hours
        NSString *open = [vancouverHours valueForKey:@"open_time"];
        NSString *close = [vancouverHours valueForKey:@"close_time"];
        NSString *hours = [NSString stringWithFormat:@"%@ - %@", open, close];
        cell.hours.text = hours;
        
        // Computer availability label, available label, in use label
        cell.availabilityLabel.text = @"Computer Availability";
        cell.available.text = @"available";
        
        // Library Status
        NSNumber *status = [vancouverHours valueForKey:@"in_range"];
        if ([status integerValue] == 1) {
            cell.libraryStatus.text = @"OPEN";
            cell.libraryStatus.textColor = [UIColor colorWithRed:(0/255.f) green:(150/255.f) blue:(0/255.f) alpha:1.0f];
        }
        else {
            cell.libraryStatus.text = @"CLOSED";
            cell.libraryStatus.textColor = [UIColor colorWithRed:(226/255.f) green:(8/255.f) blue:(19/255.f) alpha:1.0f];
        }
        
        // Computer availability for each location
        
        // PCs
        [cell updateComputerAvaiability:cell.availableOne used:cell.usedOne locationLabel:cell.locationOne locationName:@"Library Computers" locationValue:@"bel-pc" progressBar:cell.progressOne withDictionary:computers];
        
        // Empty the rest of the values
        [cell emptyComputerLabels:cell.availableTwo used:cell.usedTwo locationLabel:cell.locationTwo progressBar:cell.progressTwo];
        
        [cell emptyComputerLabels:cell.availableThree used:cell.usedThree locationLabel:cell.locationThree progressBar:cell.progressThree];
        
        [cell emptyComputerLabels:cell.availableFour used:cell.usedFour locationLabel:cell.locationFour progressBar:cell.progressFour];
        
        [cell emptyComputerLabels:cell.availableFive used:cell.usedFive locationLabel:cell.locationFive progressBar:cell.progressFive];
        
        [cell emptyComputerLabels:cell.availableSix used:cell.usedSix locationLabel:cell.locationSix progressBar:cell.progressSix];
        
        [cell emptyComputerLabels:cell.availableSeven used:cell.usedSeven locationLabel:cell.locationSeven progressBar:cell.progressSeven];
        
        [cell emptyComputerLabels:cell.availableEight used:cell.usedEight locationLabel:cell.locationEight progressBar:cell.progressEight];
        
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) {
        return 40;
    }
    if(indexPath.row == 1) {
        return 348;
    }
    else if (indexPath.row == 2) {
        return 212;
    }
    else {
        return 187;
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
