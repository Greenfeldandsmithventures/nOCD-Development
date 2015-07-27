//
//  MDTextField.m
//  MD
//
//  Created by Tigran Aslanyan on 10/14/14.
//  Copyright (c) 2014 MagicDevs. All rights reserved.
//
#import "MDTextField.h"

#define topPlaceHolderTextColor [UIColor colorWithRed:141.0/255.0f green:141.0/255.0f blue:141.0/255.0 alpha:1.0f]

@interface MDTextField ()<UITextFieldDelegate> {
    NSString *mdText;
    NSString *textFieldText;
    UIView *rView;
    NSString *strPlaceHolder;
}

@end

@implementation MDTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        self.layer.cornerRadius = 3;
        self.layer.borderWidth = 1.0f;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _x = 0.0f;
    _y = 0.0f;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer.cornerRadius = 1;
    self.layer.borderWidth = 0.0f;
    self.backgroundColor = [UIColor clearColor];
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    topPlaceHolderCanShow = NO;
    
    [self addTarget:self action:@selector(textFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setRightView:(UIView *)rightView {
    [super setRightView:rightView];
    if (rightView) {
        rView = rightView;
    }
}
- (void)setLeftViewImageName:(NSString*)imageName {
    _x = 50.0f;
    self.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.layer.borderWidth = 0.0f;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setTopPlaceHolderWithFont:(UIFont*)font rightViewImageName:(NSString*)imageName {
    _y = 7.0f;
    topPlaceHolder = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.origin.x + _x, self.bounds.origin.y-12, self.bounds.size.width - 14, self.bounds.size.height)];
    topPlaceHolder.textColor = topPlaceHolderTextColor;
    topPlaceHolder.text = self.placeholder;
    topPlaceHolder.alpha = 0.0;
    topPlaceHolder.font = font;//[UIFont fontWithName:@"HelveticaNeue" size:14.0]
    topPlaceHolderCanShow = YES;
    [self addSubview:topPlaceHolder];
    self.layer.borderWidth = 0.0f;
    self.backgroundColor = [UIColor clearColor];
    
    if (imageName) {
        self.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        self.rightViewMode = UITextFieldViewModeAlways;
    }
}

- (void)reset {
    _x = 7.0f;
    _y = 0.0f;
    self.rightView = nil;
    [topPlaceHolder removeFromSuperview];
    topPlaceHolder = nil;
}

- (void)textFieldTextChanged:(id)sender {
    if (self.validate) {
        self.required = self.text.length == 0;
    }
}

- (void)setRequired:(BOOL)required {
    _required = required;
    
    if (self.validate) {
        if (required && self.text.length == 0) {
            self.layer.borderColor = [[UIColor redColor] CGColor];
        } else {
            self.layer.borderColor = [[UIColor blackColor] CGColor];
        }
    }
    
}

//- (void) drawPlaceholderInRect:(CGRect)rect {
//    [[UIColor yellowColor] setFill];
//    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//    [style setLineBreakMode:NSLineBreakByWordWrapping];
//
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14], NSParagraphStyleAttributeName: style,NSForegroundColorAttributeName:[UIColor yellowColor]};
//    [[self placeholder] drawInRect:rect withAttributes:attributes];
//}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + _x, bounds.origin.y, bounds.size.width - 14, bounds.size.height);
    return inset;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + _x, bounds.origin.y + _y, bounds.size.width - 30, bounds.size.height);
    return inset;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(self.bounds.size.width - self.rightView.frame.size.width - 3.0 , self.bounds.size.height - self.rightView.frame.size.height - 7, self.rightView.frame.size.width, self.rightView.frame.size.height);
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    [self showPlaceHolder];
    
    CGRect inset = CGRectMake(bounds.origin.x + _x, bounds.origin.y + _y, bounds.size.width - 30, bounds.size.height);
    return inset;
}

- (void)showPlaceHolder {
    if (self.text.length > 0 && self.rightView) {
        self.rightView.hidden = NO;
    }else {
        self.rightView.hidden = YES;
    }
    
    if (self.rightViewMode == UITextFieldViewModeAlways) {
        self.rightView.hidden = NO;
    }
    if (self.clearButtonMode != UITextFieldViewModeNever && self.text.length > 0) {
        self.rightView = nil;
    } else {
        self.rightView = rView;
    }
    if (!topPlaceHolderCanShow) {
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        if (self.text.length > 0) {
            topPlaceHolder.alpha = 1.0;
        } else {
            topPlaceHolder.alpha = 0.0;
        }
    }];
}

- (void) showToolbarWithDone {
    
    UIView * keyboardHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    keyboardHeader.backgroundColor = [UIColor darkGrayColor];
    UIImage *image = [UIImage imageNamed:@"barButton"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 12, 0.0, 12)];
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDone setFrame:CGRectMake(240, 6, 70, 33)];
    
    [btnDone setBackgroundImage:image forState:UIControlStateNormal];
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    btnDone.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
    [btnDone addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    
    [keyboardHeader addSubview:btnDone];
    self.inputAccessoryView = keyboardHeader;
    
}

- (void)closeKeyboard:(id)sender {
    
    if  ([self isFirstResponder]) {
        [self resignFirstResponder];
    }
}
- (void)showToolbarWithPrevEnabled:(BOOL)prevEnabled NextEnabled:(BOOL)nextEnabled DoneEnabled:(BOOL)doneEnabled
{
    UIView * keyboardHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    keyboardHeader.backgroundColor = [UIColor darkGrayColor];
    UIImage *image = [UIImage imageNamed:@"barButton"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 12, 0.0, 12)];
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDone setFrame:CGRectMake(240, 6, 70, 33)];
    [btnDone setBackgroundImage:image forState:UIControlStateNormal];
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    btnDone.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
    [btnDone addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    
    [keyboardHeader addSubview:btnDone];
    
    UIButton *btnPrev = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPrev setFrame:CGRectMake(10, 6, 80, 33)];
    [btnPrev setBackgroundImage:image forState:UIControlStateNormal];
    [btnPrev setTitle:@"Previous" forState:UIControlStateNormal];
    btnPrev.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
    btnPrev.tag = 1;
    [btnPrev addTarget:self action:@selector(nextPrevHandlerDidChange:) forControlEvents:UIControlEventTouchUpInside];
    [keyboardHeader addSubview:btnPrev];
    
    UIButton *btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnNext setFrame:CGRectMake(90, 6, 70, 33)];
    [btnNext setBackgroundImage:image forState:UIControlStateNormal];
    [btnNext setTitle:@"Next" forState:UIControlStateNormal];
    btnNext.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
    btnNext.tag = 2;
    [btnNext addTarget:self action:@selector(nextPrevHandlerDidChange:) forControlEvents:UIControlEventTouchUpInside];
    
    [keyboardHeader addSubview:btnNext];
    self.inputAccessoryView = keyboardHeader;
    
}

- (void)nextPrevHandlerDidChange:(id)sender {
    if (!self.mddelegate) return;
    
    switch ([(UIBarButtonItem*)sender tag])
    {
        case 1:
            NSLog(@"Previous");
            [self.mddelegate previousDidPressed:self];
            break;
        case 2:
            NSLog(@"Next");
            [self.mddelegate nextDidPressed:self];
            break;
        default:
            break;
    }
}

- (void)doneDidClick:(id)sender {
    if (!self.mddelegate) return;
    
    NSLog(@"Done");
    [self.mddelegate doneDidPressed:self];
    
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidChange:(UITextField *)textField {
    
    if ([self.mddelegate respondsToSelector:@selector(textFieldDidChange:)]) {
        [self.mddelegate textFieldDidChange:self];
    }
}


- (NSString *)absoluteString
{
    return mdText;
}


- (void)deleteBackward
{
    NSInteger decimalPosition = self.text.length - self.currencyPrefix.length - 1;
    
    
    if (decimalPosition == -1) {
        self.text = @"";
    } else {
        self.text = [self.text substringWithRange:NSMakeRange(0, decimalPosition)];
    }
    
    mdText = self.text;
    
    //Since iOS6 the UIControlEventEditingChanged is not triggered by programmatically changing the text property of UITextField.
    //
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.mddelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.mddelegate textFieldShouldBeginEditing:self];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.mddelegate textFieldDidBeginEditing:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.mddelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.mddelegate textFieldShouldReturn:self];
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.mddelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.mddelegate textFieldDidEndEditing:self];
    }
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}
@end
