//
//  MDManager.m
//  nOCD
//
//  Created by Admin on 7/3/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "MDManager.h"

@implementation MDManager

static MDManager* instance = nil;

+(MDManager*) sharedInstance {
    if (!instance) {
        instance = [[MDManager alloc] init];
    }
    
    return instance;
}

- (id)init {
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (float)getHeightByWidth:(NSString*)commentText :(UIFont*)tmpFont :(float)myWidth {
    
    if (!commentText) {
        return 0;
    }
    CGSize boundingSize = CGSizeMake(myWidth, CGFLOAT_MAX);
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:commentText attributes:@{ NSFontAttributeName: tmpFont }];
    
    CGRect rect = [attributedText boundingRectWithSize:boundingSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGSize requiredSize = rect.size;
    return requiredSize.height;
}

- (float)getWidthByHeight:(NSString*)commentText :(UIFont*)tmpFont :(float)myHeight {
    
    if (!commentText) {
        return 0.0f;
    }
    CGSize boundingSize = CGSizeMake(CGFLOAT_MAX, myHeight);
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:commentText
                                                                         attributes:@{ NSFontAttributeName: tmpFont }];
    
    CGRect rect = [attributedText boundingRectWithSize:boundingSize
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize requiredSize = rect.size;
    return requiredSize.width;
}

- (CGSize)stringSizeByWidth:(NSString*)text font:(UIFont*)font size:(CGSize)maxSize {
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:text
     attributes:@
     {
     NSFontAttributeName: font
     }];
    CGRect rect = [attributedText boundingRectWithSize:maxSize
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    return size;
}

#pragma mark - cropImage
+ (UIImage*)cropImage:(CGRect)cropFrame originalImage:(UIImage*)image{
    //    NSLog(@"%@",NSStringFromCGSize(image.size));
    if (image.size.width>cropFrame.size.width) {
        float wc = image.size.width/cropFrame.size.width;
        image = [self resizeImage:image newSize:CGSizeMake(image.size.width/wc,image.size.height/wc)];
    }
    if (image.size.height>cropFrame.size.height) {
        float wc = image.size.height/cropFrame.size.height;
        image = [self resizeImage:image newSize:CGSizeMake(image.size.width/wc,image.size.height/wc)];
    }
    //    NSLog(@"%@",NSStringFromCGSize(image.size));
    UIView * whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2*cropFrame.size.width, 2*cropFrame.size.height)];
    whiteView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    UIImageView *imgB = [[UIImageView alloc] initWithImage:image];
    imgB.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [whiteView addSubview:imgB];
    imgB.center = whiteView.center;
    
    UIGraphicsBeginImageContext(whiteView.bounds.size);
    [whiteView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *savedImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //    NSLog(@"%@",NSStringFromCGSize(savedImg.size));
    
    return savedImg;
}

+ (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);
    // Draw into the context; this scales the image
    CGContextDrawImage(context, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage*)cropImageAndScale:(CGRect)cropFrame originalImage:(UIImage*)image{
    
    if (image.size.width<cropFrame.size.width) {
        float wc = image.size.width/cropFrame.size.width;
        image = [self resizeImage:image newSize:CGSizeMake(image.size.width/wc,image.size.height/wc)];
    }
    if (image.size.height<cropFrame.size.height) {
        float wc = image.size.height/cropFrame.size.height;
        image = [self resizeImage:image newSize:CGSizeMake(image.size.width/wc,image.size.height/wc)];
    }
    UIView * whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2*cropFrame.size.width, 2*cropFrame.size.height)];
    whiteView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    UIImageView *imgB = [[UIImageView alloc] initWithImage:image];
    imgB.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [whiteView addSubview:imgB];
    imgB.center = whiteView.center;
    
    UIGraphicsBeginImageContext(whiteView.bounds.size);
    [whiteView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *savedImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //    NSLog(@"%@",NSStringFromCGSize(savedImg.size));
    
    return savedImg;
}

+ (UIImage *)cropImage_cropFrame:(CGRect)cropFrame latestFrame:(CGRect)latestFrame originalImage:(UIImage*)originalImage{
    
    CGRect squareFrame = cropFrame;
    CGFloat scaleRatio = latestFrame.size.width / originalImage.size.width;
    CGFloat x = (squareFrame.origin.x - latestFrame.origin.x) / scaleRatio;
    CGFloat y = (squareFrame.origin.y - latestFrame.origin.y) / scaleRatio;
    CGFloat w = squareFrame.size.width / scaleRatio;
    CGFloat h = squareFrame.size.height / scaleRatio;
    if (latestFrame.size.width < cropFrame.size.width) {
        CGFloat newW = originalImage.size.width;
        CGFloat newH = newW * (cropFrame.size.height / cropFrame.size.width);
        x = 0; y = y + (h - newH) / 2;
        w = newH; h = newH;
    }
    if (latestFrame.size.height < cropFrame.size.height) {
        CGFloat newH = originalImage.size.height;
        CGFloat newW = newH * (cropFrame.size.width / cropFrame.size.height);
        x = x + (w - newW) / 2; y = 0;
        w = newH; h = newH;
    }
    
    CGRect myImageRect = CGRectMake(x, y, w, h);
    CGImageRef imageRef = originalImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = myImageRect.size.width;
    size.height = myImageRect.size.height;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    return smallImage;
}

- (UIImage *)blurWithCoreImage:(UIImage *)sourceImage inView:(UIView*)view
{
    CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
    
    // Apply Affine-Clamp filter to stretch the image so that it does not
    // look shrunken when gaussian blur is applied
    CGAffineTransform transform = CGAffineTransformIdentity;
    CIFilter *clampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    [clampFilter setValue:inputImage forKey:@"inputImage"];
    [clampFilter setValue:[NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)] forKey:@"inputTransform"];
    
    // Apply gaussian blur filter with radius of 30
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:clampFilter.outputImage forKey: @"inputImage"];
    [gaussianBlurFilter setValue:@3.0f forKey:@"inputRadius"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:gaussianBlurFilter.outputImage fromRect:[inputImage extent]];
    
    // Set up output context.
    UIGraphicsBeginImageContext(view.frame.size);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    
    // Invert image coordinates
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -view.frame.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, view.frame, cgImage);
    
    // Apply white tint
    CGContextSaveGState(outputContext);
    CGContextSetFillColorWithColor(outputContext, [UIColor colorWithRed:20.0f/255.0f green:185.0f/255.0f blue:214.0f/255.0f alpha:0.85f].CGColor);
    CGContextFillRect(outputContext, view.frame);
    CGContextRestoreGState(outputContext);
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

#pragma mark -

+ (void)showAlert:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"nOCD" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
    });
}

+ (void)showAlert:(NSString*)message Title:(NSString*)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
    });
}

-(BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL) validateUrl: (NSString *) candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

+ (NSString*)generateGUID{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return [NSString stringWithFormat:@"%@", string];
}

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

@end
