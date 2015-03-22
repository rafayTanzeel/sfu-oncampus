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
    //-----------------------
    //all required variables for parsing
    //------------------------------
    NSXMLParser *parser;
    NSMutableArray *times; //holds dictionary of schedules
    NSMutableDictionary *item; //dictionary that holds leaveTime and deltaTimeFromApi
    NSMutableString *leaveTime; //bus time
    NSMutableString *deltaTimeFromApi; //how much time till bus time
    NSDate *dateTime; //holds date from string
    NSString *element;
    NSString *apiURL; //holds url for api call
}

@end


@implementation SFUTransitDisplayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.model=[[SFUTransitModel alloc] initWithPlist:self.loopName]; //initialize with plist
    NSInteger BusIndex=[self.BusPath row]; //determine which bus was clicked
    //NSLog([self.model stopStringForIndex:BusIndex]);
    //NSLog([self.model routeStringForIndex:BusIndex]);
    
    //------------------------------------------
    //loads api url with route number and stop id
    //-------------------------------------------
    NSString *firstHalfurl=@"http://api.translink.ca/rttiapi/v1/stops/";
    NSString *secondHalfurl=[firstHalfurl stringByAppendingString:[self.model stopStringForIndex:BusIndex]];
    NSString *thirdHalfurl=[secondHalfurl stringByAppendingString:@"/estimates?apikey=qij3Jo3VrVDKuO8uAXOk&count=6&timeframe=1440&routeNo="];
    
    apiURL=[thirdHalfurl stringByAppendingString:[self.model routeStringForIndex:BusIndex]];
    
    
    NSLog(apiURL);
    
    //-----------------------------------------------
    //refreshes the page every 30 seconds to update data
    //------------------------------------------------
    [NSTimer scheduledTimerWithTimeInterval:30.0
    target:self
    selector:@selector(refreshData)
    userInfo:nil
    repeats:YES];
    
    [self refreshData];
    
    
    
    // NSLog([[times objectAtIndex:0] objectForKey: @"leavetime"]);
    
    
    
}
//logic that runs everytime the page refreshes
-(void) refreshData{
    times = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:apiURL];
    @try {
        parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        [parser setDelegate:self];
        [parser setShouldResolveExternalEntities:NO];
        [parser parse];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    if(parser == nil)
    {
        // Display the error pop up
        [[[UIAlertView alloc] initWithTitle:@"Network Unavailable" message:@"Bus Time cannot be displayed" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] show];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    //want the information from element Schedule
    if ([element isEqualToString:@"Schedule"]) {
        
        //when element found initialized the following
        item    = [[NSMutableDictionary alloc] init];
        leaveTime   = [[NSMutableString alloc] init];
        deltaTimeFromApi =[[NSMutableString alloc] init];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    //when element is ExpectedLeaveTime store the data
    if ([element isEqualToString:@"ExpectedLeaveTime"]) {
        [leaveTime appendString:string];
    }
    
    //when element is ExpectedCountdown store the data
    if ([element isEqualToString:@"ExpectedCountdown"]){
        [deltaTimeFromApi appendString:string];
    }
    
}
//runs when hits end element
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    //reach end element Schedule
    if ([elementName isEqualToString:@"Schedule"]) {
        
        @try {
            
            // Convert string to date object
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            NSString *stringFromDate;
            
            //translink provides leavetime in two different formats, no consistency
            //store data according to format
            if ([leaveTime length]>7)
            {
                [dateFormat setDateFormat:@"hh:mma yyyy-L-d"]; //format 1
                dateTime = [dateFormat dateFromString:leaveTime]; //create date object from string
                [dateFormat setDateFormat:@"hh:mma"]; //convert to this format
                stringFromDate =[dateFormat stringFromDate:dateTime]; //store new format date in string
                dateTime=[dateFormat dateFromString: stringFromDate]; //put back in date object
            }
            else
            {
                [dateFormat setDateFormat:@"hh:mma"]; //format 2
                dateTime = [dateFormat dateFromString:leaveTime]; //create date object from string
                stringFromDate = [dateFormat stringFromDate:dateTime]; //get string from date
            }
            //[dateFormat setDateFormat:@"hh:mma yyyy-L-d"];
            //dateTime = [dateFormat dateFromString:leaveTime];
            //[dateFormat setDateFormat:@"hh:mma"];
            //dateTime = [dateFormat dateFromString:leaveTime];
            //NSString *stringFromDate = [dateFormat stringFromDate:dateTime];
            
            //NSDate *today=[NSDate date];
            //NSString *todayString=[dateFormat stringFromDate:today];
            //NSDate *todayTime=[dateFormat dateFromString:todayString];
            //NSDate *test=[dateFormat dateFromString:@"10:00PM"];
            
            
            //NSTimeInterval dtime=[dateTime timeIntervalSinceDate:todayTime];
            //double mins=(long long)(dtime/60.0);
            double dtime=[deltaTimeFromApi doubleValue]; //convert to double
            NSString *deltatime; //used to add values to dictionary
            /*if (mins<0)
             {
             mins=mins*(-1);
             mins=1440.0-mins;
             
             }*/
            
            if (dtime>120.0) //if time till next bus is over 2 hours
            {
                double hours=(long long) (dtime/60.0); //give an hour estimation
                deltatime=[NSString stringWithFormat:@"Over %.0f h",hours];
            }
            else if (dtime<0) //if bus has just passed
            {
                deltatime=[NSString stringWithFormat:@"0 mins"];
                
            }
            else
            {
                deltatime=[NSString stringWithFormat:@"%.0f mins",dtime];

            }
            
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

//runs when reaches end of xml doc
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    //---------------------------------------
    //sets the bustime and time till next bus
    //----------------------------------------
    self.nextBusTime.text=[[times objectAtIndex:0] objectForKey:@"stringtime"]; //
    self.nextBusDeltaTime.text=[[times objectAtIndex:0] objectForKey:@"deltatime"];
    [self.upcomingTableView reloadData];
    [times removeObjectAtIndex:0]; //removes next bus info once set
    [self.upcomingTableView reloadData]; //load the table again
    
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
    
    //sets tableview cells to appropiate fields
    cell.textLabel.text = [[times objectAtIndex:indexPath.row] objectForKey:@"stringtime"];
    cell.detailTextLabel.text= [[times objectAtIndex:indexPath.row] objectForKey:@"deltatime"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
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
    
    //-----------------------------------------------------------
    //initialize url for "Missed Bus Button", and seque to webview
    //------------------------------------------------------------
    SFUWebViewController *controller = (SFUWebViewController *)[segue destinationViewController];
    
    [controller displayPageForURL:[NSURL URLWithString:@"http://www.sfu.ca/busstop.html"] inApp:YES];
    
    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    controller.navigationItem.leftItemsSupplementBackButton = YES;
    
    
}


@end
