//
//  SFUQRCaptureViewController.m
//  Multi Storyboard
//

//Derived From
//  igViewController.m
//  ScanBarCodes
// http://www.infragistics.com/community/blogs/torrey-betts/archive/2013/10/10/scanning-barcodes-with-ios-7-objective-c.aspx
//  Torrey Betts, 10/10/13.
//  Copyright (c) 2013 Infragistics. All rights reserved.
//

//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUQRCaptureViewController.h"

@interface SFUQRCaptureViewController ()


@end

@implementation SFUQRCaptureViewController

AVCaptureSession *session;
AVCaptureDevice *device;
AVCaptureDeviceInput *input;
AVCaptureMetadataOutput *output;
AVCaptureVideoPreviewLayer *prevLayer;
NSMutableString* result;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    session = [[AVCaptureSession alloc] init];
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (input) {
        [session addInput:input];
    } else {
        NSLog(@"Error: %@", error);
    }
    
    output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [session addOutput:output];
    
    output.metadataObjectTypes = [output availableMetadataObjectTypes];
    
    prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    prevLayer.frame = self.view.bounds;
    prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    prevLayer.autoreverses=YES;
    [self.view.layer addSublayer:prevLayer];
    
    [session startRunning];
    
}

//This view will pop destroying its contents as soon as it detects a code, so pass in an object to have it store the result
-(void)setDataObject:(NSMutableString*)data
{
    result = data;
}

-(BOOL)shouldAutorotate
{
    //orientation will become incorrect if autorotating
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark capture delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{

    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeQRCode];
    
    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }
        
        if (detectionString != nil)
        {
            NSLog(@"Detected\n%@\n",detectionString);
            [result setString:detectionString];
            [self.navigationController popViewControllerAnimated:TRUE];
            break;
        }
        else
        {// _label.text = @"(none)";}
            
        }
        
        //_highlightView.frame = highlightViewRect;
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
