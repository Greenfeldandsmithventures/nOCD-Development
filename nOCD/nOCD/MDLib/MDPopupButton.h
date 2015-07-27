//
//  MDPopupButton.h
//
//  Created by Sargis_Gevorgyan on 17.03.15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDPopupButton : UIButton {
    UIImageView * rightImageView;
    UILabel * lbl_title;
    NSString * str_title;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state rightImage:(UIImage*)rightImage;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) int room;
@property (nonatomic, assign) int adult;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *text;
@end
