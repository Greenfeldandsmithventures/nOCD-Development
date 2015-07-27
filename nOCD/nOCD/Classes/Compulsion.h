//
//  Compulsion.h
//  nOCD
//
//  Created by Argam on 7/27/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Compulsion : NSManagedObject

@property (nonatomic, retain) NSString * compulsionID;
@property (nonatomic, retain) NSString * obsessionID;
@property (nonatomic, retain) NSString * compulsion;

@end
