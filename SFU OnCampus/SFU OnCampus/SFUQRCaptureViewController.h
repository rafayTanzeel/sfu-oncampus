//
//  SFUQRCaptureViewController.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SFUQRCaptureDelegate.h"
@interface SFUQRCaptureViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, assign) id< SFUQRCaptureDelegate > delegate;
-(NSString*)composeShortcode;

@end
