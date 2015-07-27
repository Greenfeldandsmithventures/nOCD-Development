//
//  MDTextView.h
//  MD
//
//  Created by Tigran Aslanyan on 10/14/14.
//  Copyright (c) 2014 MagicDevs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MDTextViewDelegate <UITextViewDelegate>

@optional
- (void)otherButtonPressed;

@end

@interface MDTextView : UITextView

@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, assign) id<MDTextViewDelegate> md_delegate;

- (void)textChanged:(NSNotification*)notification;
- (void)showToolbarWithDone;
- (void)showToolbarWithDoneAndOther:(NSString*)otherButtonTitle;
-(CGSize) getContentSize;

- (void)setRightView:(UIView*)view;
@end
