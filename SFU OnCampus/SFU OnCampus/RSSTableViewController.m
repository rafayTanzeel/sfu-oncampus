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
    BOOL access;
}

@end

@implementation RSSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    access=NO;
    _feeds=[[NSMutableArray alloc] init];
    
    // NSXMLParser *parser=[[NSXMLParser alloc] initWithContentsOfURL:rssUrl];
    //NSLog(@"%@",_rssUrl);
    NSError *error;
    NSString *XML = [NSString stringWithContentsOfURL:_rssUrl encoding:NSASCIIStringEncoding error:&error];
    
    //NSLog(@"%@",XML);
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
    if(XML == nil)
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
    
    // NSString *path = [[NSBundle mainBundle] pathForResource:@"RSSInfoFeeds" ofType:@"plist"];
    // NSString *savingPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //savingPath = [savingPath stringByAppendingPathComponent:@"Modified.plist"];
    //[Dict writeToFile:savingPath atomically:YES];
    /*   NSDictionary *newContent=[[NSDictionary alloc] initWithContentsOfURL:path];
     NSLog(@"%lu",(unsigned long)[newContent count]);
     
     */
    
    //NSArray *newContent = [[NSArray alloc]initWithContentsOfFile:path];
    /*
     for ((i = 0; i < [newContent count]; i++)){
     //here you take the member (dictionary) of the array
     NSDictionary *dictOfArray = [newContent objectAtIndex:i];
     [dictOfArray objectForKey:@"Enabled"]=@"NO";
     }
     //if you update the same pList you can use the same path (otherwise use another path)
     [newContent writeToFile:path atomically:YES];
     */
    
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
    return [_feeds count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text=[[_feeds objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text=[[_feeds objectAtIndex:indexPath.row] objectForKey:@"summary"];
    
    // Configure the cell...
    
    return cell;
}


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    
    self.currentElement=[elementName copy];
    
    if ([self.currentElement isEqualToString:@"entry"])
    {   access=YES;
        self.entry=[[NSMutableDictionary alloc] init];
        self.currentTitle=[[NSMutableString alloc] init];
        self.currentPublished=[[NSMutableString alloc] init];
        self.currentSummary=[[NSMutableString alloc] init];
        self.currentLink=[[NSMutableString alloc] init];
        // NSLog(@"%@",[attributeDict objectForKey:@"href"]);
        //NSString *href = attributeDict[@"href"];
    }
    
    if(access && [self.currentElement isEqualToString:@"link"]){
        [self.currentLink setString:(NSString *)[attributeDict objectForKey:@"href"]];
        //NSLog(@"Link: %@\n",self.currentLink);
    }
    
    //email
    //name
    //published
    //updated
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if(!self.currentElement) return;
    if(access){
        if([self.currentElement isEqualToString:@"title"]){
            [self.currentTitle setString:string];
            // NSLog(@"Title: %@",self.currentTitle);
        }
        else if([self.currentElement isEqualToString:@"summary"]){
            [self.currentSummary setString:string];
            // NSLog(@"Summary: %@\n",self.currentSummary);
        }
        else if([self.currentElement isEqualToString:@"published"]){
            NSString *publishedDate= [string substringWithRange:NSMakeRange(0, 10)];
            [self.currentPublished setString:publishedDate];
            // NSLog(@"Published: %@\n",self.currentPublished);
        }
    }
    
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if([elementName isEqualToString:@"entry"]){
        access=NO;
        [self.entry setObject:self.currentTitle forKey:@"title"];
        [self.entry setObject:self.currentSummary forKey:@"summary"];
        [self.entry setObject:self.currentLink forKey:@"link"];
        [self.entry setObject:self.currentPublished forKey:@"published"];
        [_feeds addObject:[self.entry copy]];
        // NSLog(@"%@",self.feeds);
        
    }
    
    self.currentElement=nil;
    
    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //if ([[segue identifier] isEqualToString:@"showDetail"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

    
    NSString* URL=[self.feeds[indexPath.row] objectForKey:@"link"];
    URL=@"http://www.sfu.ca/sfunews/people.feed";
    NSLog(@"Here it is: %@",URL);
    
    
    //[self.feeds[indexPath.row] objectForKey:@"link"];
    
    
    
    SFUWebViewController *controller = (SFUWebViewController *)[[segue destinationViewController] topViewController];
    
    [controller displayPageForURL:[NSURL URLWithString:URL] inApp:YES];
    
    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    controller.navigationItem.leftItemsSupplementBackButton = YES;
    
    
}

//http://www.sfu.ca/sfunews/stories/2015/sfu-library-to-host-controversial-g-g-award-winner-raziel-reid.html



@end


/*
 
 <feed xmlns="http://www.w3.org/2005/Atom"><id>http://www.sfu.ca/sfunews/people</id><updated>2015-03-15T21:43:49.168Z</updated><title type="html">People</title><link href="http://www.sfu.ca/sfunews/people.feed" rel="self" /><generator uri="http://adobe.com/aem" version="6.0">Adobe Experience Manager</generator><entry><title type="html">SFU announces 2015 honorary degree recipients</title><link href="http://www.sfu.ca/sfunews/stories/2015/sfu-announces-2015-honorary-degree-recipients.html" rel="alternate" /><author><email>noemail@noemail.org</email><name>dluckow</name></author><category term="people" /><summary type="html">SFU to recognize 12 individuals during the June and October convocation ceremonies.</summary><id>http://www.sfu.ca/sfunews/stories/2015/sfu-announces-2015-honorary-degree-recipients</id><published>2015-03-12T17:45:15.757Z</published><updated>2015-03-12T17:45:15.757Z</updated></entry><entry><title type="html">2014 staff achievers honoured</title><link href="http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured.html" rel="alternate" /><author><email>noemail@noemail.org</email><name>dluckow</name></author><category term="people" /><category term="features" /><summary type="html">Meet the 2014 Staff Achievement Award winners. </summary><id>http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured</id><published>2015-03-12T17:44:42.008Z</published><updated>2015-03-12T17:44:42.008Z</updated></entry><entry><title type="html">Communication is the foundation of any successful team</title><link href="http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured/communication-is-the-foundation-to-any-successful-team.html" rel="alternate" /><author><email>noemail@noemail.org</email><name>dluckow</name></author><category term="people" /><id>http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured/communication-is-the-foundation-to-any-successful-team</id><published>2015-03-04T18:02:19.029Z</published><updated>2015-03-04T18:02:19.029Z</updated></entry><entry><title type="html">Julie Saitos legacy is improved alumni engagement</title><link href="http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured/julie-saito-s-legacy-is-improved-alumni-engagement.html" rel="alternate" /><author><email>noemail@noemail.org</email><name>dluckow</name></author><category term="people" /><id>http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured/julie-saito-s-legacy-is-improved-alumni-engagement</id><published>2015-03-03T23:27:08.612Z</published><updated>2015-03-03T23:27:08.612Z</updated></entry><entry><title type="html">Jeanne Persoons work performance attracts accolades</title><link href="http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured/jeanne-persoon-s-work-performance-attracts-accolades.html" rel="alternate" /><author><email>noemail@noemail.org</email><name>dluckow</name></author><category term="people" /><id>http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured/jeanne-persoon-s-work-performance-attracts-accolades</id><published>2015-03-04T18:00:49.049Z</published><updated>2015-03-04T18:00:49.049Z</updated></entry><entry><title type="html">Lifelong friendships enhance Anita Turner's lifetime career achievements</title><link href="http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured/lifelong-friendships-enhance-lifetime-career-achievement.html" rel="alternate" /><author><email>noemail@noemail.org</email><name>dluckow</name></author><category term="people" /><id>http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured/lifelong-friendships-enhance-lifetime-career-achievement</id><published>2015-03-04T22:16:43.065Z</published><updated>2015-03-04T22:16:43.065Z</updated></entry><entry><title type="html">Fred Heep's hands-on skills training a boon for students</title><link href="http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured/fred-heep-s-hands-on-skills-training-a-boon-for-students.html" rel="alternate" /><author><email>noemail@noemail.org</email><name>dluckow</name></author><category term="people" /><id>http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured/fred-heep-s-hands-on-skills-training-a-boon-for-students</id><published>2015-03-03T23:32:41.862Z</published><updated>2015-03-03T23:32:41.862Z</updated></entry><entry><title type="html">Collaboration key to Annette Santos innovations</title><link href="http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured/collaboration-key-to-annette-santos-innovations.html" rel="alternate" /><author><email>noemail@noemail.org</email><name>dluckow</name></author><category term="people" /><id>http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured/collaboration-key-to-annette-santos-innovations</id><published>2015-03-03T23:26:47.883Z</published><updated>2015-03-03T23:26:47.883Z</updated></entry><entry><title type="html">Desire Nazareths community spirit inspires</title><link href="http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured/desiree-nazareths-community-spirit-inspires.html" rel="alternate" /><author><email>noemail@noemail.org</email><name>dluckow</name></author><category term="people" /><id>http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured/desiree-nazareths-community-spirit-inspires</id><published>2015-03-03T23:26:31.452Z</published><updated>2015-03-03T23:26:31.452Z</updated></entry><entry><title type="html">Helping others all in a days work for Neil Dobson</title><link href="http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured/helping-others-all-in-a-days-work-for-neil-dobson.html" rel="alternate" /><author><email>noemail@noemail.org</email><name>dluckow</name></author><category term="people" /><id>http://www.sfu.ca/sfunews/stories/2015/2014-staff-achievers-honoured/helping-others-all-in-a-days-work-for-neil-dobson</id><published>2015-03-04T17:56:30.619Z</published><updated>2015-03-04T17:56:30.619Z</updated></entry></feed>
 
 */