//
//  SFUHourlyForecastTableViewController.m
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-08.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUHourlyForecastTableViewController.h"

@implementation SFUHourlyForecastTableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    return self.objects.count;
    return 10;
    //return [model sizeOfArray];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    
//    //    NSDate *object = self.objects[indexPath.row];
//    cell.timeOfDay.text = @"12:00PM";
//    //cell.imageView.image=[UIImage imageNamed: [model imageNameForIndex:indexPath.row]];
//    cell.conditions.text = @"Mostly crappy";
//    cell.temperature.text= @"500°C";
    return cell;
}

@end
