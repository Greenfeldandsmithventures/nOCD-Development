//
//  ObsessionalInterfaceController.m
//  nOCD
//
//  Created by Argam on 7/25/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "ObsessionalInterfaceController.h"

@interface ObsessionalInterfaceController ()

@end

@implementation ObsessionalInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [self setTitle:@"Back"];
    [self setupTable];
    
    if (context)
    {
        if ([context[@"fromResolved"] boolValue])
        {
            [self.lblTitle setText:@"Great Job! Choose your Obsessional Theme, and Keep up the Good Work!"];
        }
        
        if ([context[@"fromCompulsive"] boolValue])
        {
            fromCompulseive = true;
        }
    }
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
//    NSDictionary *applicationData = @{@"type":@"fetchObsessions"};
//    
//    //Handle reciever in app delegate of parent app
//    [WKInterfaceController openParentApplication:applicationData reply:^(NSDictionary *replyInfo, NSError *error) {
//        data = [replyInfo valueForKey:@"result"];
//        [self setupTable];
//    }];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)setupTable
{
    data = [[NSArray alloc] initWithObjects:@"What If I caught Ebola?", @"What If I have Aids?", @"Add a New Theme", nil];
  
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
//        [themeRow.themeNameLabel setText:[data[i] valueForKey:@"obsession"]];
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
    if (fromCompulseive)
    {
        [self pushControllerWithName:@"ExposureAndAcceptanceInterfaceController" context:nil];
        return;
    }
    [self pushControllerWithName:@"TriggerInterfaceController" context:nil];
}

@end



