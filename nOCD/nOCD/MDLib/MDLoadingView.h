//
//  MDLoadingView.h
//  MD
//
//  Created by Tigran Aslanyan on 10/14/14.
//  Copyright (c) 2014 MagicDevs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDLoadingView : UIView

- (id)initWithLabel:(NSString*)label;

- (void)show;
- (void)showInView:(UIView*)view;
- (void)hide;

@end
