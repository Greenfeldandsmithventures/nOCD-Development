//
//  QuestionsView.h
//  nOCD
//
//  Created by Admin on 7/7/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionsView : UIView


- (void)configureTableInfo:(NSArray*)arrInfo;
- (NSArray*)answersArray;
- (NSDictionary*)answersWithHeaders;
- (void)hideKeyBoard;

@end
