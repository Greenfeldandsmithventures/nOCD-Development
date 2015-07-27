//
//  AppDelegate.m
//  nOCD
//
//  Created by Admin on 7/3/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary *replyInfo))reply
{
    if ([[userInfo valueForKey:@"type"] isEqualToString:@"fetchObsessions"])
    {
        NSArray *result = [[DateBaseManager sharedInstance] fetchObsessions];
        NSMutableArray *res = [NSMutableArray new];
        for (int i = 0; i < result.count; i++)
        {
            Obsession *obs = result[i];
            [res addObject:@{@"obsessionID":obs.obsessionID, @"obsession":obs.obsession}];
        }
        reply(@{@"result":res});
    }
    else if ([[userInfo valueForKey:@"type"] isEqualToString:@"fetchCompulsions"])
    {
        NSArray *result = [[DateBaseManager sharedInstance] fetchCompulsions];
        reply(@{@"result":result});
    }
    else if ([[userInfo valueForKey:@"type"] isEqualToString:@"fetchTriggers"])
    {
        NSArray *result = [[DateBaseManager sharedInstance] fetchTriggersByObsID:[userInfo valueForKey:@"obsID"]];
        reply(@{@"result":result});
    }

}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self customizeAppAppearance];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)customizeAppAppearance {
    
    /*
     NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
     NSArray *fontNames;
     NSInteger indFamily, indFont;
     
     for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
     {
     NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
     fontNames = [[NSArray alloc] initWithArray:
     [UIFont fontNamesForFamilyName:
     [familyNames objectAtIndex:indFamily]]];
     for (indFont=0; indFont<[fontNames count]; ++indFont)
     {
     NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
     }
     }
    */
    
    // UINavigationBar
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBarTintColor:navBarColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSBackgroundColorAttributeName:[UIColor whiteColor],
                                                           NSForegroundColorAttributeName : [UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont fontWithName:@"GothamMedium" size:17.5f]}];
    
}

@end
