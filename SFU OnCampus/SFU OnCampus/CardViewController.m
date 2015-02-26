//
//  CardViewController.m
//  test
//
//  Created by Kevin Grant on 2/25/15.
//  Copyright (c) 2015 Kevin Grant. All rights reserved.
//

#import "CardViewController.h"
#import "CardCell.h"

@interface CardViewController ()

@end

@implementation CardViewController

NSMutableDictionary *currentObservation;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)getCurrentWeather:(id)sender {
    // Prepare the URL that we'll get the country info data from.
    NSURL *url = [NSURL URLWithString:@"http://api.wunderground.com/api/3ff62c9b4941d736/conditions/q/Canada/Burnaby.json"];
    //Get URL page into NSData Object
    NSData *currentWeatherData = [NSData dataWithContentsOfURL:url];
    //Read JSON and convert to object
    
    NSError *error;
    if(currentWeatherData != nil)
    {
        error = nil;
        
        //id result = [NSJSONSerialization JSONObjectWithData:currentWeatherData options:NSJSONReadingMutableContainers error:&error];
        
        //if(error == nil)
         //   NSLog(@"%@", result);
    }
    NSMutableDictionary *currentDictionary = [NSJSONSerialization JSONObjectWithData:currentWeatherData options:kNilOptions error:&error];

    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        currentObservation = [currentDictionary objectForKey:@"current_observation"];
        NSLog(@"%@", currentObservation);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.view.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1]; //%%% This is so if you overscroll, the color is still gray
    
    [self getCurrentWeather:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CardCell"];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CardCell"];
    }
    
    cell.location.text = @"SFU Burnaby";
    
    cell.description.text = [currentObservation valueForKey:@"dewpoint_c"];
    
    return cell;
}

//-(IBAction)getCurrentWeather:(id)sender {
//    // Prepare the URL that we'll get the country info data from.
//    NSURL *url = [NSURL URLWithString:@"http://api.wunderground.com/api/3ff62c9b4941d736/conditions/q/Canada/Burnaby.json"];
//    //Get URL page into NSData Object
//    NSData *currentWeather = [NSData dataWithContentsOfURL:url];
//    //Read JSON and convert to object
//    if(currentWeather != nil)
//    {
//        NSError *error = nil;
//        
//        id result = [NSJSONSerialization JSONObjectWithData:currentWeather options:NSJSONReadingMutableContainers error:&error];
//        
//        if(error == nil)
//            NSLog(@"%@", result);
//    }
//    
//}
//-(void)getForecastWeather;


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
