//
//  MDLoadingView.m
//  MD
//
//  Created by Tigran Aslanyan on 10/14/14.
//  Copyright (c) 2014 MagicDevs. All rights reserved.
//

#import "MDLoadingView.h"

@interface MDLoadingView () {
    UIView *loadingBGView;
    UIActivityIndicatorView *activityIndicator;
    UILabel *lblText;
}

@end


@implementation MDLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithLabel:(NSString*)label {
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
        
        loadingBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 160)];
        loadingBGView.backgroundColor = MDLoadingViewColor;
        loadingBGView.alpha = 0.70;
        loadingBGView.center = self.center;
        loadingBGView.layer.cornerRadius = 5;
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.center = CGPointMake(loadingBGView.frame.size.width/2,loadingBGView.frame.size.height/2);
        [activityIndicator startAnimating];
        
        [loadingBGView addSubview:activityIndicator];
        
        lblText = [[UILabel alloc] initWithFrame:CGRectMake(0, loadingBGView.frame.size.height - 40, loadingBGView.frame.size.width, 30)];
        lblText.textColor = [UIColor whiteColor];
        lblText.textAlignment = NSTextAlignmentCenter;
        lblText.text = label;
        
        [loadingBGView addSubview:lblText];
        
        [self addSubview:loadingBGView];
        
    }
    return self;
}

- (void)show {
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self];
    [window bringSubviewToFront:self];
}

- (void)showInView:(UIView*)view {
    self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    loadingBGView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [view addSubview:self];
    [view bringSubviewToFront:self];
    loadingBGView.backgroundColor = [UIColor clearColor];
}


- (void)hide {
    [self removeFromSuperview];
    loadingBGView.backgroundColor = MDLoadingViewColor;
    
}

@end
