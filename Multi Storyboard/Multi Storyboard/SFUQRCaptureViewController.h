//
//  SFUQRCaptureViewController.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

/**
 Assigning this to theentitiy of a view controller instnacei in the storboard causes it to become a QR code scanner.
 */
@interface SFUQRCaptureViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

///This view will pop destroying its contents as soon as it detects a code, so pass in an object to have it store the result
-(void)setDataObject:(NSMutableString*)data;

@end
