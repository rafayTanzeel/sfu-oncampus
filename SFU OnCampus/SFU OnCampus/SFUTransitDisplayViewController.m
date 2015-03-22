//
//  SFUTransitDisplayViewController.m
//  OnCampus
//
//  Created by Nikhil Gaba on 2015-03-14.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUTransitDisplayViewController.h"
#import "SFUWebViewController.h"


@interface SFUTransitDisplayViewController (){

    NSXMLParser *parser;
    NSMutableArray *times;
    NSMutableDictionary *item;
    NSMutableString *leaveTime;
    NSDate *dateTime;
    NSString *element;
    NSString *apiURL;
}

@end


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
    apiURL=[thirdHalfurl stringByAppendingString:[self.model routeStringForIndex:BusIndex]];
    NSLog(apiURL);
    
    [NSTimer scheduledTimerWithTimeInterval:30.0
    target:self
    selector:@selector(refreshData)
    userInfo:nil
    repeats:YES];
    
    [self refreshData];
    

    
   // NSLog([[times objectAtIndex:0] objectForKey: @"leavetime"]);
    
    

}

-(void) refreshData{
    times = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:apiURL];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"Schedule"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        leaveTime   = [[NSMutableString alloc] init];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"ExpectedLeaveTime"]) {
        [leaveTime appendString:string];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"Schedule"]) {
        
        @try {
        
        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"hh:mma yyyy-L-d"];
        dateTime = [dateFormat dateFromString:leaveTime];
        [dateFormat setDateFormat:@"hh:mma"];
        
        NSString *stringFromDate = [dateFormat stringFromDate:dateTime];
        
        NSTimeInterval dtime=[dateTime timeIntervalSinceNow];
        double dtimebysixty=dtime/60.0;
        double mins=(long long)(dtimebysixty);
        NSString *deltatime=[NSString stringWithFormat:@"%.0f mins",mins];
        
        [item setObject:dateTime forKey:@"leavetime"];
        [item setObject:stringFromDate forKey:@"stringtime"];
        [item setObject:deltatime forKey:@"deltatime"];
        
        [times addObject:[item copy]];
            
        }
        
        @catch(NSException* e ){
            //do nothing
        }
        
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    
    self.nextBusTime.text=[[times objectAtIndex:0] objectForKey:@"stringtime"];
    self.nextBusDeltaTime.text=[[times objectAtIndex:0] objectForKey:@"deltatime"];
    [self.upcomingTableView reloadData];
    [times removeObjectAtIndex:0];
    [self.upcomingTableView reloadData];
    
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
    return [times count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [[times objectAtIndex:indexPath.row] objectForKey:@"stringtime"];
    cell.detailTextLabel.text= [[times objectAtIndex:indexPath.row] objectForKey:@"deltatime"];
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



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
 
 SFUWebViewController *controller = (SFUWebViewController *)[segue destinationViewController];
 
 [controller displayPageForURL:[NSURL URLWithString:@"http://www.sfu.ca/busstop.html"] inApp:YES];
 
 controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
 controller.navigationItem.leftItemsSupplementBackButton = YES;

 
}


@end
