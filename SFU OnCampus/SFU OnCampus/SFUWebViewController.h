//
//  SFUWebViewController.h
//  OnCampus
//  Group 10
//  Nikhil Gaba, Abram Wiebe, Rafay Tanzeel, Kevin Grant, Sunny Chowdhury
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//
// Changelog: https://github.com/nikhilgaba/sfu-oncampus
//
//
//
// Presently no known bugs
#import "DetailViewController.h"

///Displays URL to a webview from various controllers such as facebook, twitter, and student services
@interface SFUWebViewController : DetailViewController <UIWebViewDelegate>

@property NSURL* startURL;
@property NSMutableDictionary* completionHandlerDictionary;
@property NSURLSession* defaultSession;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *forwardButton;

/**
 Display the given URL
 @param showInApp ignored
 */
-(void)displayPageForURL:(NSURL*)url inApp:(BOOL)showInApp;
-(void)displayPageForURL:(NSURL*)url;
@end
