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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
