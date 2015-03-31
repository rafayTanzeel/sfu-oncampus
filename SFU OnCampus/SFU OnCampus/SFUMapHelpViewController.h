//
//  SFUMapHelpViewController.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-18.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Loads the local help webpage to give instructions on using map view
 */
@interface SFUMapHelpViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UISwitch *shouldShowHelpSwitch;

@end
