//
//  MDManager.h
//  nOCD
//
//  Created by Admin on 7/3/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDManager : NSObject

+(MDManager*) sharedInstance;

- (float)getWidthByHeight:(NSString*)commentText :(UIFont*)tmpFont :(float)myHeight;
- (float)getHeightByWidth:(NSString*)commentText :(UIFont*)tmpFont :(float)myWidth;
- (CGSize)stringSizeByWidth:(NSString*)text font:(UIFont*)font size:(CGSize)size;

+ (UIImage *)cropImage:(CGRect)cropFrame originalImage:(UIImage*)image;
+ (UIImage *)cropImageAndScale:(CGRect)cropFrame originalImage:(UIImage*)image;
+ (UIImage *)cropImage_cropFrame:(CGRect)cropFrame latestFrame:(CGRect)latestFrame originalImage:(UIImage*)originalImage;
- (UIImage *)blurWithCoreImage:(UIImage *)sourceImage inView:(UIView*)view;
+ (void)showAlert:(NSString *)message;
+ (void)showAlert:(NSString*)message Title:(NSString*)title;

- (BOOL)validateEmail:(NSString *)email;
- (BOOL) validateUrl: (NSString *) candidate;

+ (NSString*)generateGUID;

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
@end
