//
//  ConnectWatchViewController.m
//  nOCD
//
//  Created by Argam on 7/15/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "ConnectWatchViewController.h"
#import "TYMProgressBarView.h"
#import "ConnectThoughtsController.h"

@interface ConnectWatchViewController ()
{
    __weak IBOutlet UIButton *btnConnectiongToWatch;
    __weak IBOutlet TYMProgressBarView *connectingProgress;
    
}

@end

@implementation ConnectWatchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    btnConnectiongToWatch.layer.borderColor = [UIColor whiteColor].CGColor;
    btnConnectiongToWatch.layer.borderWidth = 2.0f;
    btnConnectiongToWatch.layer.cornerRadius = 5.0f;
    
    connectingProgress.barBorderWidth = 0.0;
    connectingProgress.barInnerPadding = 0.0;
    connectingProgress.barBackgroundColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
    connectingProgress.barFillColor = [UIColor whiteColor];
    
    [self createRightButton];
    self.navigationController.navigationBar.hidden = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(incrementProgress:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
#pragma mark - Timer

- (void)incrementProgress:(NSTimer *)timer
{
    connectingProgress.progress = connectingProgress.progress + 0.02f;
    if (connectingProgress.progress == 1.0)
    {
        [timer invalidate];
        [self openConnectThoughtsController];
    }
}

- (void)openConnectThoughtsController {
    ConnectThoughtsController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ConnectThoughtsController"];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
