//
//  BImageViewController.m
//  Chat SDK
//
//  Created by Benjamin Smiley-andrews on 16/04/2014.
//  Copyright (c) 2014 chatsdk.co All rights reserved. The Chat SDK is issued under the MIT liceense and is available for free at http://github.com/chat-sdk
//

#import "BImageViewController.h"
#import <ChatSDK/ChatCore.h>
#import <ChatSDK/ChatUI.h>

@interface BImageViewController ()

@end

@implementation BImageViewController

@synthesize imageView;
@synthesize image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"BImageViewController" bundle:[NSBundle chatUIBundle]];
    if (self) {
        self.title = [NSBundle t:bImageMessage];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSBundle t: bBack] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [imageView setImage:image];
    
    // We want to make sure the image always fits in the screen
    // Check the ratio of the height and width against the screens ratio, use this to determine the height and width set
    double screenRatio = [[UIScreen mainScreen] bounds].size.height / [[UIScreen mainScreen] bounds].size.width;
    double imageRatio = image.size.height / image.size.width;
    
    CGRect screenSize = [UIScreen mainScreen].applicationFrame;
    
    // Make sure the status bar and navigation bar don't overlap our view
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    if (screenRatio >= imageRatio) {
        
        // We want the image to be the size of the screen - the user can then zoom in more from there
        imageView.keepWidth.equal = screenSize.size.width;
        imageView.keepHeight.equal = image.size.height * screenSize.size.width / image.size.width;
        
        // Make sure the image is in the middle of the screen
        imageView.keepVerticalCenter.equal = 0.5;
    }
    else {
        
        // We want the image to be the size of the screen - the user can then zoom in more from there
        // We need to find the visible screen heigh otherwise the status bar changes the calculations
        CGFloat visibleScreenHeight = screenSize.size.height - screenSize.origin.y;
        
        imageView.keepHeight.equal = visibleScreenHeight;
        imageView.keepWidth.equal = image.size.width * visibleScreenHeight / image.size.height;
        
        // Make sure the image is in the middle of the screen
        imageView.keepHorizontalCenter.equal = 0.5;
    }
    
    // Make sure the image fits into the image view exactly
    imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imageView;
}

-(void) backButtonPressed {
    [self dismissViewControllerAnimated:YES completion:Nil];
}

@end
