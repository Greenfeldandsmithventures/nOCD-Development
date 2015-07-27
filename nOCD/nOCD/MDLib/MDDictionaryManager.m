//
//  MDDictionaryManager.m
//  E-Citizen
//
//  Created by Sargis_Gevorgyan on 01.12.14.
//  Copyright (c) 2014 MagicDevs. All rights reserved.
//

#import "MDDictionaryManager.h"

@implementation DictionaryManager

+ (NSString*)get_String_From_Dictionary:(id)dictionary key:(NSString*)key {
    if (dictionary) {
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            if ([dictionary valueForKey:key]) {
                if (![[dictionary valueForKey:key] isKindOfClass:[NSNull class]]) {
                    if ([[dictionary valueForKey:key] isKindOfClass:[NSString class]]) {
                        NSString * str = [dictionary valueForKey:key];
                        return str;
                    } else {
                        NSLog(@"Warning!!! --- this value for \"%@\" key is not NSString",key);
                    }
                }
            }
        }
    }
    NSLog(@"Warning!!! --- this value for \"%@\" key is not NSString or Not found",key);
    return @"";
}

+ (NSDictionary*)get_Dictionary_From_Dictionary:(id)dictionary key:(NSString*)key {
    if (dictionary) {
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            if ([dictionary valueForKey:key]) {
                if (![[dictionary valueForKey:key] isKindOfClass:[NSNull class]]) {
                    if ([[dictionary valueForKey:key] isKindOfClass:[NSDictionary class]]) {
                        NSDictionary * dict = [dictionary valueForKey:key];
                        return dict;
                    }
                }
            }
        }
    }
     NSLog(@"Warning!!! --- this value for \"%@\" key is not NSDictionary",key);
    return nil;
}

+ (NSArray*)get_Array_From_Dictionary:(id)dictionary key:(NSString*)key; {
    if (dictionary) {
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            if ([dictionary valueForKey:key]) {
                if (![[dictionary valueForKey:key] isKindOfClass:[NSNull class]]) {
                    if ([[dictionary valueForKey:key] isKindOfClass:[NSArray class]]) {
                        NSArray * array = [dictionary valueForKey:key];
                        return array;
                    }
                }
            }
        }
    }
    NSLog(@"Warning!!! --- this value for \"%@\" key is not NSArray",key);
    return nil;
}

+ (BOOL)get_Bool_From_Dictionary:(id)dictionary key:(NSString*)key {
    if (dictionary) {
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            if ([dictionary valueForKey:key]) {
                if (![[dictionary valueForKey:key] isKindOfClass:[NSNull class]]) {
                    if ([[dictionary valueForKey:key] isKindOfClass:[NSNumber class]]) {
                        NSNumber * boolNumber = [dictionary valueForKey:key];
                        BOOL  isBool = [boolNumber boolValue];
                        return isBool;
                    }
                }
            }
        }
    }
    NSLog(@"Warning!!! --- this value for \"%@\" key is not BOOL",key);
    return NO;
}

+ (float)get_Float_From_Dictionary:(id)dictionary key:(NSString*)key {
    if (dictionary) {
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            if ([dictionary valueForKey:key]) {
                if (![[dictionary valueForKey:key] isKindOfClass:[NSNull class]]) {
                    if ([[dictionary valueForKey:key] isKindOfClass:[NSNumber class]]) {
                        NSNumber * floatNumber = [dictionary valueForKey:key];
                        if ([floatNumber floatValue]) {
                            return [floatNumber floatValue];
                        }
                    }
                    if ([[dictionary valueForKey:key] isKindOfClass:[NSString class]]) {
                        NSString * floatNumber = [dictionary valueForKey:key];
                        if ([floatNumber floatValue]) {
                            return [floatNumber floatValue];
                        }
                    }
                }
            }
        }
    }
    NSLog(@"Warning!!! --- this value for \"%@\" key is not CGFloat or equal 0.00",key);
    return 0.0f;
}

+ (NSInteger)get_int_From_Dictionary:(id)dictionary key:(NSString*)key {
    if (dictionary) {
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            if ([dictionary valueForKey:key]) {
                if (![[dictionary valueForKey:key] isKindOfClass:[NSNull class]]) {
                    if ([[dictionary valueForKey:key] isKindOfClass:[NSNumber class]]) {
                        NSNumber * integerNumber = [dictionary valueForKey:key];
                        if ([integerNumber intValue]) {
                            return [integerNumber intValue];
                        }
                        if ([integerNumber integerValue]) {
                            return [integerNumber integerValue];
                        }
                        if ([integerNumber longValue]) {
                            return [integerNumber longValue];
                        }
                    }
                    if ([[dictionary valueForKey:key] isKindOfClass:[NSString class]]) {
                        NSString * integerNumber = [dictionary valueForKey:key];
                        if ([integerNumber intValue]) {
                            return [integerNumber intValue];
                        }
                    }
                }
            }
        }
    }
    NSLog(@"Warning!!! --- this value for \"%@\" key is not NSInteger or equal 0",key);
    return 0;
}
@end
