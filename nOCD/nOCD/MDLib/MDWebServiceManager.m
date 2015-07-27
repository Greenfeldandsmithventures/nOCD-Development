//
//  MDWebServiceManage.m
//  MD
//
//  Created by Tigran Aslanyan on 10/14/14.
//  Copyright (c) 2014 MagicDevs. All rights reserved.
//

#import "MDWebServiceManager.h"
#import "NSDictionary+UrlEncoding.h"
#import "MDJSON.h"
#import "XMLReader.h"
#import "Reachability.h"

#define requsetTimeoutInterval 60.0f
static NSString* apiUrl = @"http://www.magicdevs.com/nocd/api/";

@implementation MDWebServiceManager

+ (void) userRegister:(NSDictionary *)regInfo completion:( void (^) (id response, NSError *error))handler {
    NSString *method = @"register";
    NSString *params = [NSString stringWithFormat:@"info=%@",[regInfo JSONString]];
    
    NSMutableURLRequest *request = [self requestForMethod:method withParams:params];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURLResponse* response = nil;
        NSError *error = nil;
        NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            handler([data objectFromJSONData], error);
        });
        
    });
}

+ (void) userlogin:(NSString *)identifier password:(NSString*)password completion:( void (^) (id response, NSError *error))handler {
    NSString *method = @"login";
    NSString *params = [NSString stringWithFormat:@"identifier=%@&password=%@",identifier,password];
    
    NSMutableURLRequest *request = [self requestForMethod:method withParams:params];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURLResponse* response = nil;
        NSError *error = nil;
        NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            handler([data objectFromJSONData], error);
        });
        
    });
}

+ (void) resetPass:(NSString *)email completion:( void (^) (id response, NSError *error))handler {
    NSString *method = @"reset";
    NSString *params = [NSString stringWithFormat:@"email=%@",email];
    
    NSMutableURLRequest *request = [self requestForMethod:method withParams:params];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURLResponse* response = nil;
        NSError *error = nil;
        NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            handler([data objectFromJSONData], error);
        });
        
    });
}

#pragma mark Request

+ (NSMutableURLRequest *) requestForPostMethod:(NSString *)method withParams:(NSString *)params {
    
    NSString* url = apiUrl;
    url =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0f];
    
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", (int)[params length]];
    
    [request addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue: [NSString stringWithFormat:@"http://tempuri.org/%@",method] forHTTPHeaderField:@"SOAPAction"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [params dataUsingEncoding:NSUTF8StringEncoding]];
    return request;
}

+ (NSMutableURLRequest *) requestForPostMethod:(NSString *)method withParams:(NSDictionary *)params  withAttachements:(NSArray *)attachments {
    
    NSString* url = [NSString stringWithFormat:@"%@", apiUrl];
    url =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0f];
    
    [request setHTTPMethod:@"POST"];
    
    NSMutableData *body = [NSMutableData data];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    // attachments
    for (NSDictionary *attachment in attachments) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"%@\"; filename=\"%@.png\"\r\n", attachment[@"name"], attachment[@"fileName"]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:attachment[@"data"]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // method
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"action"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[method dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // parameters
    for (NSString *key in [params allKeys]) {
        
        if (![params[key] isKindOfClass:[NSString class]]) {
            continue;
        } else if ([params[key] length] == 0 ) {
            continue;
        }
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[params[key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // set request body
    [request setHTTPBody:body];
    
    return request;
}

#pragma mark - requests
+ (NSMutableURLRequest *) requestForGetMethod:(NSString *)method withParams:(NSString *)params {
    
    NSString* url = [NSString stringWithFormat:@"%@%@?%@", apiUrl, method, params];
    if (params.length == 0) {
        url = [NSString stringWithFormat:@"%@%@", apiUrl, method];
    }
    
    url =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [url stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:requsetTimeoutInterval];
    [request setHTTPMethod:@"GET"];
    
    return request;
}

+ (NSMutableURLRequest *) requestForMethod:(NSString *)method withParams:(NSString *)params {
    
    NSString* url = [NSString stringWithFormat:@"%@%@", apiUrl, method];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:requsetTimeoutInterval];
    
    [request setHTTPMethod:@"POST"];
    
    params = [params stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSData *postData = [params dataUsingEncoding:NSUTF8StringEncoding];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    
    return request;
}


+ (NSMutableURLRequest *) requestForPutMethod:(NSString *)method withParams_string:(NSString *)params {
    
    NSString* url = [NSString stringWithFormat:@"%@%@", apiUrl, method];
    url =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:requsetTimeoutInterval];
    
    [request setHTTPMethod:@"PUT"];
    
    params = [params stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    [request addValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded;boundary=%@",boundary] forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"*/*" forHTTPHeaderField:@"Accept"];
    NSData *postData = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:postData];
    
    return request;
}



+ (NSMutableURLRequest *) requestForDeleteMethod:(NSString *)method withParams:(NSString *)params {
    
    NSString* url = [NSString stringWithFormat:@"%@%@?%@", apiUrl, method, params];
    if (params.length == 0) {
        url = [NSString stringWithFormat:@"%@%@", apiUrl, method];
    }
    url =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:requsetTimeoutInterval];
    [request setHTTPMethod:@"DELETE"];
    
    return request;
}

+ (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

@end