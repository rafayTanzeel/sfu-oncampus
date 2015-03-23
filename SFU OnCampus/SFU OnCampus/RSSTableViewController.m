//
//  RSSTableViewController.m
//  RSSSSSSS
//
//  Created by Rafay Tanzeel on 2015-03-15.
//  Copyright (c) 2015 Rafay Tanzeel. All rights reserved.
//

#import "RSSTableViewController.h"
#import "SFUWebViewController.h"
@interface RSSTableViewController (){
    BOOL access; //Acts as a detection variable to initiate the parsing process once we reach the entry point of RSS
}

@end

@implementation RSSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    access=NO;
    
    _feeds=[[NSMutableArray alloc] init];


    NSError *error;
    NSString *XML = [NSString stringWithContentsOfURL:_rssUrl encoding:NSASCIIStringEncoding error:&error];
    
    //REMOVE ALL NON-ASCII CHARACTERS
    NSMutableString *asciiCharacters = [NSMutableString string];
    for (NSInteger i = 32; i < 127; i++)
    {
        [asciiCharacters appendFormat:@"%c", (char)i];
    }
    
    NSCharacterSet *nonAsciiCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:asciiCharacters] invertedSet];
    
    @try {
        XML = [[XML componentsSeparatedByCharactersInSet:nonAsciiCharacterSet] componentsJoinedByString:@""];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    if(XML == nil) //Error handling, if internet connection is unavailable
    {
        // Display the error pop up
        [[[UIAlertView alloc] initWithTitle:@"Network Unavailable" message:@"RSS cannot be displayed" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] show];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    NSData *data = [XML dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser parse];
    
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
    return [_feeds count]; //Dynamically creates number of rows from the RSS XML list after parsing it
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text=[[_feeds objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text=[[_feeds objectAtIndex:indexPath.row] objectForKey:@"summary"];
    
    // Configure the cell with there respective title and summary
    
    return cell;
}


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    
    self.currentElement=[elementName copy];
    
    if ([self.currentElement isEqualToString:@"entry"]) //Once <entry> tag is found then start extracting
    {   access=YES;
        self.entry=[[NSMutableDictionary alloc] init];
        self.currentTitle=[[NSMutableString alloc] init];
        self.currentPublished=[[NSMutableString alloc] init];
        self.currentSummary=[[NSMutableString alloc] init];
        self.currentLink=[[NSMutableString alloc] init];
    }
    
    if(access && [self.currentElement isEqualToString:@"link"]){
        [self.currentLink setString:(NSString *)[attributeDict objectForKey:@"href"]];

    }

    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if(!self.currentElement) return;
    if(access){
        if([self.currentElement isEqualToString:@"title"]){ //Once <title> tag is found then start extracting
            [self.currentTitle setString:string];
        }
        else if([self.currentElement isEqualToString:@"summary"]){ //Once <summary> tag is found then start extracting
            [self.currentSummary setString:string];
        }
        else if([self.currentElement isEqualToString:@"published"]){ //Once <published> tag is found then start extracting
            NSString *publishedDate= [string substringWithRange:NSMakeRange(0, 10)];
            [self.currentPublished setString:publishedDate];
        }
    }
    
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if([elementName isEqualToString:@"entry"]){ //Once </entry> tag is found then stop extracting
        access=NO;
        [self.entry setObject:self.currentTitle forKey:@"title"];
        [self.entry setObject:self.currentSummary forKey:@"summary"];
        [self.entry setObject:self.currentLink forKey:@"link"];
        [self.entry setObject:self.currentPublished forKey:@"published"];
        [_feeds addObject:[self.entry copy]];
    }
    
    self.currentElement=nil; //set the current Element to nil once the extraction and storing is ended
    
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender { //Extracts the url of the selected RSS and directs it to a webview
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

    NSString* URL=[self.feeds[indexPath.row] objectForKey:@"link"];

    SFUWebViewController *controller = (SFUWebViewController *)[segue destinationViewController];
    
    [controller displayPageForURL:[NSURL URLWithString:URL] inApp:YES];
    
    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    controller.navigationItem.leftItemsSupplementBackButton = YES;
    
    
}

@end
