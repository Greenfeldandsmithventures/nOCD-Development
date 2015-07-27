//
//  ExposureAndAcceptanceInterfaceController.m
//  nOCD
//
//  Created by Argam on 7/25/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "ExposureAndAcceptanceInterfaceController.h"

@interface ExposureAndAcceptanceInterfaceController ()

@end

@implementation ExposureAndAcceptanceInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [self setTitle:@"Back"];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



