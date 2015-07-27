//
//  MDTextView.m
//  MD
//
//  Created by Tigran Aslanyan on 10/14/14.
//  Copyright (c) 2014 MagicDevs. All rights reserved.
//

#import "MDTextView.h"

@implementation MDTextView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setPlaceholder:@""];
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
    self.layer.borderColor = [[UIColor blueColor] CGColor];
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 1.0f;
    self.backgroundColor = [UIColor whiteColor];
}

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}


-(CGSize) getContentSize{
    return [self sizeThatFits:CGSizeMake(self.frame.size.width, FLT_MAX)];
}

- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    
    if([[self text] length] == 0)
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    else
    {
        [[self viewWithTag:999] setAlpha:0];
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)setRightView:(UIView*)rightView {
    for (UIView *view in self.subviews) {
        if (view.tag == 99) {
            [view removeFromSuperview];
        }
    }
    rightView.tag = 99;
    rightView.frame = CGRectMake(self.frame.size.width - rightView.frame.size.width - 10, 10, rightView.frame.size.width, rightView.frame.size.height);
    [self addSubview:rightView];
}

- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        if ( self.placeHolderLabel == nil )
        {
            self.placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
            self.placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            self.placeHolderLabel.numberOfLines = 0;
            self.placeHolderLabel.font = self.font;
            self.placeHolderLabel.backgroundColor = [UIColor clearColor];
            self.placeHolderLabel.textColor = self.placeholderColor;
            self.placeHolderLabel.alpha = 0;
            self.placeHolderLabel.tag = 999;
            [self addSubview:self.placeHolderLabel];
        }
        
        self.placeHolderLabel.text = self.placeholder;
        [self.placeHolderLabel sizeToFit];
        [self sendSubviewToBack:self.placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
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

- (void)showToolbarWithDoneAndOther:(NSString*)otherButtonTitle {
    
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
    
    UIButton *btnOther = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnOther setFrame:CGRectMake(10, 6, 60, 33)];
    
    [btnOther setBackgroundImage:image forState:UIControlStateNormal];
    [btnOther setTitle:otherButtonTitle forState:UIControlStateNormal];
    btnOther.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
    [btnOther addTarget:self action:@selector(otherButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [keyboardHeader addSubview:btnOther];
    
    self.inputAccessoryView = keyboardHeader;
    
}

-(void)deleteBackward;
{
    //[super deleteBackward];
    NSLog(@"BackSpace Detected");
}

- (void)closeKeyboard:(id)sender {
    
    [self resignFirstResponder];
    
}

- (void)otherButtonPressed:(id)sender {
    
    if ([self.md_delegate respondsToSelector:@selector(otherButtonPressed)]) {
        [self.md_delegate otherButtonPressed];
    }
}

@end
