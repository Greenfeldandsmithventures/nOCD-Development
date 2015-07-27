//
//  Hobbies.h
//  nOCD
//
//  Created by Argam on 7/27/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Hobbies : NSManagedObject

@property (nonatomic, retain) NSString * hobbyID;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSString * hobby;

@end
