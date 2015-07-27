//
//  MDTextField.h
//  MD
//
//  Created by Tigran Aslanyan on 10/14/14.
//  Copyright (c) 2014 MagicDevs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDTextField;

@protocol MDTextFieldDelegate <NSObject>
@optional
- (void)nextDidPressed:(MDTextField*)textField;
- (void)previousDidPressed:(MDTextField*)textField;
- (void)doneDidPressed:(MDTextField*)textField;
- (BOOL)textFieldShouldBeginEditing:(MDTextField *)textField;
- (void)textFieldDidBeginEditing:(MDTextField *)textField;
- (BOOL)textFieldShouldReturn:(MDTextField *)textField;
- (void)textFieldDidEndEditing:(MDTextField *)textField;
- (void)textFieldDidChange:(MDTextField *)textField;
@end

@interface MDTextField : UITextField {
    UILabel * topPlaceHolder;
    BOOL topPlaceHolderCanShow;
    float _x,_y;
}

@property (nonatomic, strong) id <MDTextFieldDelegate> mddelegate;
@property (nonatomic, assign) BOOL required;
@property (nonatomic, assign) BOOL validate;
@property (nonatomic, strong) NSString *currencyPrefix;
@property (nonatomic, readonly) NSString *absoluteString;
//
@property (nonatomic, assign) int room;
@property (nonatomic, assign) int adult;
@property (nonatomic, strong) NSString *type;

- (void) showToolbarWithPrevEnabled:(BOOL)prevEnabled NextEnabled:(BOOL)nextEnabled DoneEnabled:(BOOL)doneEnabled;
- (void) showToolbarWithDone;
- (void)setTopPlaceHolderWithFont:(UIFont*)font rightViewImageName:(NSString*)imageName;
- (void)setLeftViewImageName:(NSString*)imageName;
- (void)reset;
@end
