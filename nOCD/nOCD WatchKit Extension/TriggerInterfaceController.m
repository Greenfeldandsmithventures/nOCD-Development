//
//  TriggerInterfaceController.m
//  nOCD
//
//  Created by Argam on 7/27/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "TriggerInterfaceController.h"

@interface TriggerInterfaceController ()

@end

@implementation TriggerInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [self setTitle:@"Back"];
    [self setupTable];
    
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

- (void)setupTable
{
    NSArray *data = [[NSArray alloc] initWithObjects:@"Trigger 1", @"Trigger 2", @"Trigger 3", nil];
    
    NSMutableArray *rowTypesList = [NSMutableArray array];
    
    for (int i = 0; i < data.count; i++)
    {
        [rowTypesList addObject:@"ObsThemesRow"];
    }
    
    [self.tblThemes setRowTypes:rowTypesList];
    
    for (NSInteger i = 0; i < self.tblThemes.numberOfRows; i++)
    {
        NSObject *row = [self.tblThemes rowControllerAtIndex:i];
        ObsThemesRow *themeRow = (ObsThemesRow *) row;
        [themeRow.themeNameLabel setText:data[i]];
        currentRow = themeRow;
    }
}

-(void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex
{
    [currentRow.imgArrow setImageNamed:@"imgWArrowBlue"];
    [currentRow.bgGroup setBackgroundColor:[UIColor whiteColor]];
    [currentRow.themeNameLabel setTextColor:[UIColor colorWithRed:20.0f/255.0f green:185.0f/255.0f blue:214.0f/255.0f alpha:1.0f]];
    
    currentRow = [table rowControllerAtIndex:rowIndex];
    [currentRow.imgArrow setImageNamed:@"imgWArrowWhite"];
    [currentRow.themeNameLabel setTextColor:[UIColor whiteColor]];
    [currentRow.bgGroup setBackgroundColor:[UIColor colorWithRed:20.0f/255.0f green:185.0f/255.0f blue:214.0f/255.0f alpha:1.0f]];
}

- (IBAction)btnProceedToExpouseTap
{
    [self pushControllerWithName:@"ExposureAndAcceptanceInterfaceController" context:nil];
}

@end



