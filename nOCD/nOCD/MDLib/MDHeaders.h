//
//  MDHeaders.h
//  BucketList
//
//  Created by Sargis_Gevorgyan on 02.03.15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

static NSString * const kClientId = @"350048939852-f8dqr8tet2sm0f9jth61cph8oo2s9hqe.apps.googleusercontent.com";

#ifndef BucketList_MDHeaders_h
#define BucketList_MDHeaders_h

#define screenWidth [[UIScreen mainScreen]bounds].size.width
#define screenHeight [[UIScreen mainScreen]bounds].size.height
#define deviceScale (screenWidth/320.0f)

#define MDLoadingViewColor [UIColor colorWithRed:20.0f/255.0f green:185.0/255.0f blue:214.0f/255.0f alpha:1.0f]
#define navBarColor [UIColor colorWithRed:20.0f/255.0f green:185.0/255.0f blue:214.0f/255.0f alpha:1.0f]
#define tabBarColor [UIColor colorWithRed:0.0f green:122.0/255.0f blue:170.0f/255.0f alpha:1.0f]
#define appMainColor [UIColor colorWithRed:93.0f/255.0f green:29.0f/255.0f blue:79.0f/255.0f alpha:1.0f]
#define MDBlueColor [UIColor colorWithRed:(float)44.0f/255.0f green:(float)62.0f/255.0f blue:(float)80.0f/255.0f alpha:1.0f]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define wrongTextColor UIColorFromRGB(0xf27935)

#import "MDManager.h"
#import "MDLoadingView.h"
#import "MDTextField.h"
#import "MDTextView.h"
#import "MDJSON.h"
#import "MDDictionaryManager.h"
#import "Reachability.h"
#import "UIViewController+Settings.h"
#import "UIImageView+WebCache.h"
#import "MDWebServiceManager.h"
#import "NSString+MD5.h"
#import "UIViewController+MMDrawerController.h"
#import "AppManager.h"
#import "PNChart.h"
#import "MDPopupButton.h"

#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)

#endif
