//
//  UndecidedInterfaceController.h
//  nOCD
//
//  Created by Argam on 7/25/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "HeaderRow.h"
#import "ObsThemesRow.h"

@interface UndecidedInterfaceController : WKInterfaceController
{
    ObsThemesRow *currentRow;
    ObsThemesRow *secondRow;
    BOOL multipleSelect;
    NSArray *dataO;
    NSArray *dataC;
}

@property (weak, nonatomic) IBOutlet WKInterfaceTable *tbl;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblTitle;
@end
