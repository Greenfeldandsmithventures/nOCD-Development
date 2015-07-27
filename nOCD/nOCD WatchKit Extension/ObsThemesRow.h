//
//  ObsThemesRow.h
//  nOCD
//
//  Created by Argam on 7/24/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface ObsThemesRow : NSObject
{
    
}
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *imgArrow;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *bgGroup;
@property(nonatomic) int pos;

@end
