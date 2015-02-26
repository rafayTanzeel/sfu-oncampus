//
//  SFUWebViewController.h
//  SFU OnCampus
//
//  Created by Abram Wiebe on 2015-02-21.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "DetailViewController.h"

@interface SFUWebViewController : DetailViewController <UIWebViewDelegate>

@property NSURL* startURL;
@property NSMutableDictionary* completionHandlerDictionary;
@property NSURLSession* defaultSession;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

-(void)displayPageForURL:(NSURL*)url inApp:(BOOL)showInApp;
@end
