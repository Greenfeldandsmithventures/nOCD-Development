//
//  MDWebServiceManage.h
//  MD
//
//  Created by Tigran Aslanyan on 10/14/14.
//  Copyright (c) 2014 MagicDevs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDWebServiceManager : NSObject

+ (void) userRegister:(NSDictionary *)regInfo completion:( void (^) (id response, NSError *error))handler;
+ (void) userlogin:(NSString *)identifier password:(NSString*)password completion:( void (^) (id response, NSError *error))handler;
+ (void) resetPass:(NSString *)email completion:( void (^) (id response, NSError *error))handler;

@end
