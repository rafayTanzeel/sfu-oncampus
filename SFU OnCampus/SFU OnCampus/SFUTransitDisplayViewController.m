//
//  SFUTransitDisplayViewController.m
//  OnCampus
//
//  Created by Nikhil Gaba on 2015-03-14.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUTransitDisplayViewController.h"


@interface SFUTransitDisplayViewController ()

@end

NSMutableArray*parsedData;

@implementation SFUTransitDisplayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.model=[[SFUTransitModel alloc] initWithPlist:self.loopName];
    NSInteger BusIndex=[self.BusPath row];
    //NSLog([self.model stopStringForIndex:BusIndex]);
    //NSLog([self.model routeStringForIndex:BusIndex]);
    NSString *firstHalfurl=@"http://api.translink.ca/rttiapi/v1/stops/";
    NSString *secondHalfurl=[firstHalfurl stringByAppendingString:[self.model stopStringForIndex:BusIndex]];
    NSString *thirdHalfurl=[secondHalfurl stringByAppendingString:@"/estimates?apikey=qij3Jo3VrVDKuO8uAXOk&routeNo="];
    NSString *apiURL=[thirdHalfurl stringByAppendingString:[self.model routeStringForIndex:BusIndex]];
    //NSString *apiURL=@"http://api.translink.ca/rttiapi/v1/stops/60980/estimates?apikey=qij3Jo3VrVDKuO8uAXOk&routeNo=050";
    

    //Use this to properly formate date and time,(ege is the system using 24-h time?
    NSDateFormatter* f = [NSDateFormatter new];
    parsedData = [NSMutableArray new];
    
   NSMutableDictionary* individualBus1 = [NSMutableDictionary new];
    [individualBus1 setObject:@"12:00pm" forKey:@"time"];
    [individualBus1 setObject:@"1h" forKey:@"dtime"];
    [parsedData addObject:individualBus1];
    
    NSMutableDictionary* individualBus2 = [NSMutableDictionary new];
    [individualBus2 setObject:@"12:01pm" forKey:@"time"];
    [individualBus2 setObject:@"1h" forKey:@"dtime"];
    [parsedData addObject:individualBus2];
    
    NSMutableDictionary* individualBus3 = [NSMutableDictionary new];
    [individualBus3 setObject:@"12:01pm" forKey:@"time"];
    [individualBus3 setObject:@"1h" forKey:@"dtime"];
    [parsedData addObject:individualBus3];
    
    NSMutableDictionary* individualBus4 = [NSMutableDictionary new];
    [individualBus4 setObject:@"12:01pm" forKey:@"time"];
    [individualBus4 setObject:@"1h" forKey:@"dtime"];
    [parsedData addObject:individualBus4];
    
    NSMutableDictionary* individualBus5 = [NSMutableDictionary new];
    [individualBus5 setObject:@"12:01pm" forKey:@"time"];
    [individualBus5 setObject:@"1h" forKey:@"dtime"];
    [parsedData addObject:individualBus5];
    
    NSMutableDictionary* individualBus6 = [NSMutableDictionary new];
    [individualBus6 setObject:@"12:01pm" forKey:@"time"];
    [individualBus6 setObject:@"1h" forKey:@"dtime"];
    [parsedData addObject:individualBus6];
    
    NSMutableDictionary* individualBus7 = [NSMutableDictionary new];
    [individualBus7 setObject:@"12:01pm" forKey:@"time"];
    [individualBus7 setObject:@"1h" forKey:@"dtime"];
    [parsedData addObject:individualBus7];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark upcoming Tabledelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSMutableDictionary* data = [parsedData objectAtIndex:indexPath.row];
    //    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [data objectForKey:@"time"];
    cell.detailTextLabel.text= [data objectForKey:@"dtime"];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
