//
//  ConnectThoughtsController.m
//  nOCD
//
//  Created by Admin on 7/27/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "ConnectThoughtsController.h"
#import "ObsessionsController.h"

@interface ConnectThoughtsController () {
    
    __weak IBOutlet UIView *viewGridButtons;
    __weak IBOutlet UIButton *btnObsession;
    __weak IBOutlet UILabel *lblDate;
}

@end

@implementation ConnectThoughtsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureViews];
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

- (void)configureViews {
    self.title = @"";
    [self createRightButton];
    [[AppManager sharedInstance] scaleButtonsFontSizes:viewGridButtons];
    for (UIView *view in viewGridButtons.subviews) {
        if ([view isKindOfClass:[UIButton class]] && view.tag > 0) {
            UIButton *btn = (UIButton*)view;
            btn.layer.borderColor = btn.titleLabel.textColor.CGColor;
            btn.layer.borderWidth = 3.0f;
            btn.layer.cornerRadius = btn.frame.size.width/2;
        }
    }
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"h:mm a"];
    
    lblDate.text =[[dateFormatter stringFromDate:[NSDate date]] lowercaseString];
}

- (IBAction)btnBackTap:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnObsessionTap:(id)sender {
    ObsessionsController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ObsessionsController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)btnCompulsionTap:(id)sender {
}

- (IBAction)btnBothTap:(id)sender {
}
@end
