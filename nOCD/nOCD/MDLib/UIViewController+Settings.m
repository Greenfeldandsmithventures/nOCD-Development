//
//  UINavigationController+Settings.m
//  ReputationRights
//
//  Created by Sargis_Gevorgyan on 12.02.15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "UIViewController+Settings.h"

@implementation UIViewController (Settings)

- (void)createLeftButton {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconMenu"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonTap:)];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)leftButtonTap:(id)sender {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)createRightButton {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconMore"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonTap:)];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)rightButtonTap:(id)sender {
}

@end
