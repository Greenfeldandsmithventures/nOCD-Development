//
//  UndecidedInterfaceController.m
//  nOCD
//
//  Created by Argam on 7/25/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "UndecidedInterfaceController.h"

@interface UndecidedInterfaceController ()

@end

@implementation UndecidedInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [self setTitle:@"Back"];
    [self setupTable];
    
    if (context)
    {
        if ([context[@"type"] isEqualToString:@"undecided"])
        {
            [self.lblTitle setText:@"Choose two Undecided  Themes:"];
        }
        else{
            [self.lblTitle setText:@"Don't give up, Choose two  Themes:"];
        }
        multipleSelect = true;
    }
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
    dataO = [[NSArray alloc] initWithObjects:@"What If I caught Ebola?", @"What If I have Aids?", @"Add a New Theme", nil];
    dataC = [[NSArray alloc] initWithObjects:@"Washing My Hands", @"Mentally Checking Past Events", @"Add a New Theme", nil];
    
    NSMutableArray *rowTypesList = [NSMutableArray array];
    
    [rowTypesList addObject:@"HeaderRow"];
    for (int i = 0; i < dataO.count; i++)
    {
        [rowTypesList addObject:@"ObsThemesRow"];
    }
    
    [rowTypesList addObject:@"HeaderRow"];
    for (int i = 0; i < dataC.count; i++)
    {
        [rowTypesList addObject:@"ObsThemesRow"];
    }
    
    [self.tbl setRowTypes:rowTypesList];
    
    for (NSInteger i = 0; i < self.tbl.numberOfRows; i++)
    {
        NSObject *row = [self.tbl rowControllerAtIndex:i];
        
        if ([row isKindOfClass:[HeaderRow class]])
        {
            if (i < dataO.count)
            {
                [((HeaderRow*) row).titleLabel setText:@"O"];
            }
            else
            {
                [((HeaderRow*) row).titleLabel setText:@"C"];
            }
        }
        else
        {
            ObsThemesRow *themeRow = (ObsThemesRow*) row;
            
            if (i <= dataO.count)
            {
                [themeRow.themeNameLabel setText:dataO[i - 1]];
            }
            else
            {
                [themeRow.themeNameLabel setText:dataC[i - dataO.count - 2]];
            }
        }
    }
}

-(void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex
{
    if (rowIndex == 0 || rowIndex == dataO.count + 1)
    {
        return;
    }
    
    if (multipleSelect)
    {
        if (rowIndex <= dataO.count)
        {
            [currentRow.imgArrow setImageNamed:@"imgWArrowBlue"];
            [currentRow.bgGroup setBackgroundColor:[UIColor whiteColor]];
            [currentRow.themeNameLabel setTextColor:[UIColor colorWithRed:20.0f/255.0f green:185.0f/255.0f blue:214.0f/255.0f alpha:1.0f]];
            
            currentRow = [table rowControllerAtIndex:rowIndex];
            [currentRow.imgArrow setImageNamed:@"imgWArrowWhite"];
            [currentRow.themeNameLabel setTextColor:[UIColor whiteColor]];
            [currentRow.bgGroup setBackgroundColor:[UIColor colorWithRed:20.0f/255.0f green:185.0f/255.0f blue:214.0f/255.0f alpha:1.0f]];
        }
        else
        {
            [secondRow.imgArrow setImageNamed:@"imgWArrowBlue"];
            [secondRow.bgGroup setBackgroundColor:[UIColor whiteColor]];
            [secondRow.themeNameLabel setTextColor:[UIColor colorWithRed:20.0f/255.0f green:185.0f/255.0f blue:214.0f/255.0f alpha:1.0f]];
            
            secondRow = [table rowControllerAtIndex:rowIndex];
            [secondRow.imgArrow setImageNamed:@"imgWArrowWhite"];
            [secondRow.themeNameLabel setTextColor:[UIColor whiteColor]];
            [secondRow.bgGroup setBackgroundColor:[UIColor colorWithRed:20.0f/255.0f green:185.0f/255.0f blue:214.0f/255.0f alpha:1.0f]];
        }
        return;
    }
    
    [currentRow.imgArrow setImageNamed:@"imgWArrowBlue"];
    [currentRow.bgGroup setBackgroundColor:[UIColor whiteColor]];
    [currentRow.themeNameLabel setTextColor:[UIColor colorWithRed:20.0f/255.0f green:185.0f/255.0f blue:214.0f/255.0f alpha:1.0f]];
    
    currentRow = [table rowControllerAtIndex:rowIndex];
    [currentRow.imgArrow setImageNamed:@"imgWArrowWhite"];
    [currentRow.themeNameLabel setTextColor:[UIColor whiteColor]];
    [currentRow.bgGroup setBackgroundColor:[UIColor colorWithRed:20.0f/255.0f green:185.0f/255.0f blue:214.0f/255.0f alpha:1.0f]];
    
    currentRow.pos = (int)rowIndex;
}

- (IBAction)btnProceedToExpouseTap
{
    if (multipleSelect)
    {
        [self pushControllerWithName:@"ExposureAndAcceptanceInterfaceController" context:nil];
        return;
    }
    
    if (currentRow.pos <= dataO.count)
    {
        [self pushControllerWithName:@"ObsessionalInterfaceController" context:nil];
    }
    else
    {
        [self pushControllerWithName:@"CompulsiveInterfaceController" context:nil];
    }
}

@end



