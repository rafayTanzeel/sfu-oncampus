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

typedef enum SFUTransitEstimateDocumentElement
{
    SCHEDULE,DOCUMENT,LEAVE_TIME
} SFUTransitEstimateDocumentElement;

NSMutableArray*a;

@implementation SFUTransitDisplayViewController
SFUTransitEstimateDocumentElement state = DOCUMENT;
-(void)debugAPI
{
    NSLog(@"Should parse");
    NSURL* url = [NSURL URLWithString:@"http://api.translink.ca/rttiapi/v1/stops/51861/estimates?apikey=qij3Jo3VrVDKuO8uAXOk&routeNo=145"];
    NSXMLParser* p = [[NSXMLParser alloc] initWithContentsOfURL:url];
    p.delegate =self;
    [p parse];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSInteger BusIndex=[self.BusPath row];
    
    [self debugAPI];

    //Use this to properly formate date and time,(ege is the system using 24-h time?
    NSDateFormatter* f = [NSDateFormatter new];
    a = [NSMutableArray new];
   NSMutableDictionary* d = [NSMutableDictionary new];
    [d setObject:@"12:00pm" forKey:@"time"];
    [d setObject:@"1h" forKey:@"dtime"];
    [a addObject:d];
    NSMutableDictionary* d2 = [NSMutableDictionary new];
    [d2 setObject:@"12:01pm" forKey:@"time"];
    [d2 setObject:@"1h" forKey:@"dtime"];
    [a addObject:d2];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark parse delegate
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"<%@>",elementName);
    //NSLog(elementName);
    if([elementName isEqualToString:@"Schedule"])
    {
        state=SCHEDULE;
    }
    
    if(state == SCHEDULE)
    {
        if([@"ExpectedLeaveTime" isEqualToString:elementName])
        {
            state=LEAVE_TIME;
        }
    }


}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    NSLog(@"</%@>",elementName);
    if(state == SCHEDULE && [elementName isEqualToString: @"Schedule"])
    {
        NSLog(@"    </schedule>");
    }
//    switch(state)
//    {
//        case DOCUMENT:
//            break;
//        case SCHEDULE:
//            state=DOCUMENT;
//            break;
//        case LEAVE_TIME:
//            state=SCHEDULE;
//            break;
//    }
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
    if(state== LEAVE_TIME)
    {
        NSLog(@"Encountered leave time : %@",string);
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //[self.upcomingTableView updateConstraints];
}


#pragma mark upcoming Tabledelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSMutableDictionary* d = [a objectAtIndex:indexPath.row];
    //    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [d objectForKey:@"time"];
    cell.detailTextLabel.text= [d objectForKey:@"dtime"];
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
