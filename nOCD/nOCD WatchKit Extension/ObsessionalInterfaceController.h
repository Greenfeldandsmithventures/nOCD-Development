//
//  ObsessionalInterfaceController.h
//  nOCD
//
//  Created by Argam on 7/25/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "ObsThemesRow.h"

@interface ObsessionalInterfaceController : WKInterfaceController
{
    ObsThemesRow *currentRow;
    BOOL fromCompulseive;
    NSArray *data;
}

@property (weak, nonatomic) IBOutlet WKInterfaceTable *tblThemes;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblTitle;
@end
