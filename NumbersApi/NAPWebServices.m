//
//  NAPWebServices.m
//  NumbersApi
//
//  Created by Jaime on 12/10/14.
//  Copyright (c) 2014 Jaime Aranaz. All rights reserved.
//

#import "NAPWebServices.h"

#define kBaseUrl "http://numbersapi.com"
#define kMathPath "math"
#define kTriviaPath "trivia"
#define kDatePath "date"
#define kYearPath "year"

@implementation NAPWebServices

+ (id)sharedInstance
{
    static NAPWebServices *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NAPWebServices alloc] init];
    });
    return sharedInstance;
}

- (void)sendRequestToPath:(NSString *)path
               withNumber:(NSString *)number
                 onSucces:(void(^)(NAPNumberFact *fact))success
                   onFail:(void(^)(NSError *error))fail
{
    NSString *dataUrl = [NSString stringWithFormat:@"%s/%@/%@", kBaseUrl, number, path];
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    // Configure session with "Content-Type" header and MIME type "application/json"
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{@"Content-Type" : @"application/json"};
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    
    _dataTask = [session
                 dataTaskWithURL:url
                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                     NSError *localError = nil;
                     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:&localError];
                     if (!error) {
                         NAPNumberFact *fact = [[NAPNumberFact alloc] initWithDictionary:json];
                         success(fact);
                     } else {
                         fail(error);
                     }
                 }];
    
    [_dataTask resume];
}

- (void)getMathFactWithNumber:(NSString *)number onSucces:(void(^)(NAPNumberFact *fact))success onFail:(void(^)(NSError *error))fail
{
    [self sendRequestToPath:@kMathPath
                 withNumber:number
                   onSucces:success
                     onFail:fail];
}

- (void)getDateFactWithNumber:(NSString *)number onSucces:(void(^)(NAPNumberFact *fact))success onFail:(void(^)(NSError *error))fail
{
    [self sendRequestToPath:@kDatePath
                 withNumber:number
                   onSucces:success
                     onFail:fail];
}

- (void)getYearFactWithNumber:(NSString *)number onSucces:(void(^)(NAPNumberFact *fact))success onFail:(void(^)(NSError *error))fail
{
    [self sendRequestToPath:@kYearPath
                 withNumber:number
                   onSucces:success
                     onFail:fail];
}

- (void)getTriviaFactWithNumber:(NSString *)number onSucces:(void(^)(NAPNumberFact *fact))success onFail:(void(^)(NSError *error))fail
{
    [self sendRequestToPath:@kTriviaPath
                 withNumber:number
                   onSucces:success
                     onFail:fail];
}

@end
