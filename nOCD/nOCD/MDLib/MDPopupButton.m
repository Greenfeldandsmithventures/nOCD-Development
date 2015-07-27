//
//  MDPopupButton.m
//
//  Created by Sargis_Gevorgyan on 17.03.15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "MDPopupButton.h"

@implementation MDPopupButton

- (void)awakeFromNib {
    [super awakeFromNib];
    
    rightImageView = [[UIImageView alloc] initWithImage:self.imageView.image];
    [rightImageView sizeToFit];
    [self addSubview:rightImageView];
    
    lbl_title = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, self.frame.size.width - 10, self.frame.size.height - 4)];
    lbl_title.font = self.titleLabel.font;
    lbl_title.textColor = self.titleLabel.textColor;
    lbl_title.text =  self.titleLabel.text;
    lbl_title.textAlignment = NSTextAlignmentCenter;
    str_title = self.titleLabel.text;
    
    lbl_title.hidden = YES;
    rightImageView.hidden = YES;
    
    [self addSubview:lbl_title];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
   
}
- (void)layoutSubviews {
    [super layoutSubviews];
    lbl_title.center = CGPointMake(self.frame.size.width/2 - rightImageView.frame.size.width/2 - 8.0f, self.frame.size.height/2);
    rightImageView.center = CGPointMake(self.frame.size.width/2 + lbl_title.frame.size.width/2 + 8.0f, self.frame.size.height/2);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state rightImage:(UIImage*)rightImage {
    
    lbl_title.hidden = NO;
    lbl_title.text = title;
    
    float width = [[MDManager sharedInstance] getWidthByHeight:lbl_title.text :lbl_title.font :lbl_title.frame.size.height];
    CGRect frame = lbl_title.frame;
    frame.size.width = width;
    lbl_title.frame = frame;
    
    self.text = title;
    [self setTitle:@"" forState:UIControlStateNormal];
    if (rightImage) {
        rightImageView.hidden = NO;
        rightImageView.image = rightImage;
        [rightImageView sizeToFit];
        
        lbl_title.center = CGPointMake(self.frame.size.width/2 - rightImageView.frame.size.width/2 - 8.0f, self.frame.size.height/2);
        rightImageView.center = CGPointMake(self.frame.size.width/2 + lbl_title.frame.size.width/2 + 8.0f, self.frame.size.height/2);
    }
}

@end
