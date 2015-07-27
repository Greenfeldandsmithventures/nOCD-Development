//
//  AppManager.h
//  nOCD
//
//  Created by Admin on 7/3/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject

+ (AppManager*) sharedInstance;

- (void)saveSettings;

- (void)login:(id)_self;
- (void)openViewController:(UIViewController*)_self :(id)vc;

- (void)scaleFontSizes:(UIView*)view;
- (void)scaleButtonsFontSizes:(UIView*)view;

@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, assign) BOOL isLogedin;
@end
