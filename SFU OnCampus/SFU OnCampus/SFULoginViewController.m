//
//  SFULoginViewController.m
//  OnCampus
//
//  Created by Kevin Grant on 2015-03-21.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFULoginViewController.h"
#import "SFUWebViewController.h"
@interface SFULoginViewController ()

@end

@implementation SFULoginViewController

// Round the corners, and give it a shadow
- (void)signinButtonProperties
{
    // Round the corners, and give it a shadow
    self.signinButton.layer.cornerRadius = 5;
    self.signinButton.layer.shadowOffset = CGSizeMake(-.2f, .2f);
    self.signinButton.layer.shadowRadius = 5;
    self.signinButton.layer.shadowOpacity = 0.3;
    
    // Lowers the performance required to build shadows.
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.signinButton.bounds];
    self.signinButton.layer.shadowPath = path.CGPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self signinButtonProperties];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 * Sends an HTTP Post request to https://cs.sfu.ca/ with the user's inputed computing ID and password.
 * Checks if the user filled in both fields, and informs the user whether or not they were successfuly signed
 * in.
 */
- (IBAction)signinButtonClicked:(id)sender {
    NSInteger success = 0;
    @try {
        
        // If both fields were not filled in
        if([[self.computingID text] isEqualToString:@""] || [[self.password text] isEqualToString:@""] ) {
            
            // display an alert
            [self alertStatus:@"Please enter ID and Password" :@"Sign in Failed!" :0];
            
        }
        else {
            // computingID and password
            NSString *post =[NSString stringWithFormat:@"username=%@&password=%@",[self.computingID text],[self.password text]];
            // NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"https://cas.sfu.ca/cgi-bin/WebObjects/cas.woa/wa/login"];
            
            // convert string to data
            NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            
            // calculate length of post request
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            // Set up the request
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            NSLog(@"Response code: %ld", (long)[response statusCode]);

            
            // Request OK
            if ([response statusCode] >= 200 && [response statusCode] < 300)
            {
                // Response Data
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
    
                
                NSArray* allCookies;
                allCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
                for (NSHTTPCookie *cookie in allCookies) {
                    NSLog(@"hello\n\n");
                    NSLog(@"%@",cookie);
                    //if ([cookie.name isEqualToString:goodCookie]) {
                        
                    //}
                }
                
                
                NSError *error = nil;
      /*
                if(success == 1)
                {
                    NSLog(@"Login SUCCESS");
                } else {
                    
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    [self alertStatus:error_msg :@"Sign in Failed!" :0];
                }
      */
            } else {
                //if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    if (success) {
        [self performSegueWithIdentifier:@"login_success" sender:self];
    }
}

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{



NSString* URL=@"https://cas.sfu.ca/cgi-bin/WebObjects/cas.woa/wa/login";

//[self.feeds[indexPath.row] objectForKey:@"link"];



SFUWebViewController *controller = (SFUWebViewController *)[segue destinationViewController];

[controller displayPageForURL:[NSURL URLWithString:URL] inApp:YES];

controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
controller.navigationItem.leftItemsSupplementBackButton = YES;
    
}
@end
