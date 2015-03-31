//
//  SFUMapHelpViewController.m
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-18.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUMapHelpViewController.h"

@interface SFUMapHelpViewController ()

@end

@implementation SFUMapHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //prevents whitespace at top of webview
    //http://stackoverflow.com/questions/18947872/ios7-added-new-whitespace-in-uiwebview-removing-uiwebview-whitespace-in-ios7
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    NSString* docPath = [[NSBundle mainBundle] pathForResource:@"MapHelp" ofType:@"html"];
    // docPath = [@"" stringByAppendingString:docPath];
    NSURL* url = [NSURL fileURLWithPath:docPath];
    NSURLRequest* req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];
    // Do any additional setup after loading the view.
    
    BOOL shouldShowMapHelpOnRun = [[NSUserDefaults standardUserDefaults] boolForKey:@"shouldShowMapHelpOnRun"];
    self.shouldShowHelpSwitch.on = shouldShowMapHelpOnRun;
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
- (IBAction)shouldShowHelpSwitchChanged:(UISwitch *)sender
{
    [[NSUserDefaults standardUserDefaults] setBool: sender.on forKey:@"shouldShowMapHelpOnRun"];
}

@end
