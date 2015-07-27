//
//  AppManager.m
//  nOCD
//
//  Created by Admin on 7/3/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "AppManager.h"
#import "MenuViewController.h"
#import "MyActivityViewController.h"
#import "MyDataViewController.h"
#import "MyDataDetailViewController.h"
#import "ConnectWatchViewController.h"

static AppManager * instance = nil;

@interface AppManager() {
    
}

@end

@implementation AppManager
- (id)init {
    self = [super init];
    if (self) {
        [self loadSettings];
    }
    return self;
}

+ (AppManager*) sharedInstance {
    if (!instance) {
        instance = [[AppManager alloc] init];
    }
    return instance;
}

#pragma mark - Settings
- (void)loadSettings {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![userDefaults boolForKey:@"isFirst_ver1.0"]) {
        [userDefaults setBool:YES forKey:@"isFirst_ver1.0"];
    }
    self.userInfo = [userDefaults objectForKey:@"userInfo"];
    self.isLogedin = [userDefaults boolForKey:@"isLogedin"];
}

- (void)saveSettings {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"isFirst_ver1.0"];
    [userDefaults setObject:self.userInfo forKey:@"userInfo"];
    [userDefaults setBool:self.isLogedin forKey:@"isLogedin"];
    [userDefaults synchronize];
}

- (void)login:(id)_self {
    
    __weak UIViewController *vc = _self;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController * centerViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainNavigationController"];
        
    MenuViewController * leftSideDrawerViewController = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    MMDrawerController * drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:centerViewController
                                             leftDrawerViewController:leftSideDrawerViewController];
    [drawerController setMaximumLeftDrawerWidth:265.0f*deviceScale];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [drawerController setCenterHiddenInteractionMode:MMDrawerOpenCenterInteractionModeNone];
    drawerController.view.backgroundColor = [UIColor whiteColor];
    drawerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    drawerController.showsShadow = NO;
    drawerController.shouldStretchDrawer = NO;
    drawerController.scaleDrawer = YES;
    
    [vc presentViewController:drawerController animated:YES completion:^{
        [vc.navigationController popToRootViewControllerAnimated:NO];
    }];
}

- (void)openViewController:(UIViewController*)_self :(id)vc {
    [_self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        UINavigationController *nc;
        if ([_self.mm_drawerController.centerViewController isKindOfClass:[UINavigationController class]]) {
            nc = (UINavigationController*)_self.mm_drawerController.centerViewController;
            NSMutableArray *navigationArray = [nc.viewControllers mutableCopy];
            for (int i = 0; i <navigationArray.count; i ++) {
                UIViewController *currentVc = navigationArray[i];
                if ([currentVc isKindOfClass:[MyDataViewController class]] || [currentVc isKindOfClass:[MyDataDetailViewController class]] || [currentVc isKindOfClass:[ConnectWatchViewController class]]) {
                    [navigationArray removeObject:currentVc];
                    i = 0;
                }
            }
            nc.viewControllers = navigationArray;
            nc.topViewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
            [nc pushViewController:vc animated:YES];
        }
    }];
}

- (void)scaleFontSizes:(UIView*)view {
    for (UIView *lbl in [view subviews]) {
        if ([lbl isKindOfClass:[UILabel class]]) {
            UIFont *font = [(UILabel*)lbl font];
            font = [UIFont fontWithName:font.fontName size:font.pointSize*deviceScale];
            [(UILabel*)lbl setFont:font];
        }
    }
}

- (void)scaleButtonsFontSizes:(UIView*)view {
    for (UIView *btn in [view subviews]) {
        if ([btn isKindOfClass:[UIButton class]]) {
            UIButton *scaledButton = (UIButton*)btn;
            UIFont *font = [scaledButton.titleLabel font];
            font = [UIFont fontWithName:font.fontName size:font.pointSize*deviceScale];
            [scaledButton.titleLabel setFont:font];
        }
    }
}
@end
