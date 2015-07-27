//
//  Interests.h
//  nOCD
//
//  Created by Argam on 7/27/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Interests : NSManagedObject

@property (nonatomic, retain) NSString * interestID;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSString * interest;

@end
