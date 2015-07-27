//
//  MDDictionaryManager.h
//  E-Citizen
//
//  Created by Sargis_Gevorgyan on 01.12.14.
//  Copyright (c) 2014 MagicDevs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictionaryManager : NSObject

+ (NSString*)get_String_From_Dictionary:(id)dictionary key:(NSString*)key;
+ (NSDictionary*)get_Dictionary_From_Dictionary:(id)dictionary key:(NSString*)key;
+ (NSArray*)get_Array_From_Dictionary:(id)dictionary key:(NSString*)key;
+ (BOOL)get_Bool_From_Dictionary:(id)dictionary key:(NSString*)key;
+ (float)get_Float_From_Dictionary:(id)dictionary key:(NSString*)key;
+ (NSInteger)get_int_From_Dictionary:(id)dictionary key:(NSString*)key;

@end
