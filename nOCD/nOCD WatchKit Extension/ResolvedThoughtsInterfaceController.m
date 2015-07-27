//
//  ResolvedThoughtsInterfaceController.m
//  nOCD
//
//  Created by Argam on 7/27/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "ResolvedThoughtsInterfaceController.h"

@interface ResolvedThoughtsInterfaceController ()

@end

@implementation ResolvedThoughtsInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [self setTitle:@"Back"];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)btnUseERPTap
{
    [self pushControllerWithName:@"ObsessionalInterfaceController" context:@{@"fromResolved":@1}];
}

- (IBAction)btnUndecidedTap
{
    [self pushControllerWithName:@"UndecidedInterfaceController" context:@{@"type":@"undecided"}];
}

- (IBAction)btnDontUseERPTap
{
    [self pushControllerWithName:@"UndecidedInterfaceController" context:@{@"resolved":@"dontuse"}];
}
@end



