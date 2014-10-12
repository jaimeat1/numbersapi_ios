//
//  NAPWebServices.h
//  NumbersApi
//
//  Created by Jaime on 12/10/14.
//  Copyright (c) 2014 Jaime Aranaz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NAPNumberFact.h"

// This class represents the API with Numbers API web services. Implements Singleton pattern
@interface NAPWebServices : NSObject <NSURLSessionDataDelegate>

// Last current data task operation
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

/**
 Creates and/or returns a common instance of NAPWebServices
 @returns an instance of NAPWebServices
 */
+ (id)sharedInstance;

/**
 Gets a math number fact from web service. You can specify a number or "random" value
 @param number number to get a fact; if "random", a random number is generated in web service
 @param success block to execute if success; it contains a NAPNumberFact object
 @param fail block to execute if any error
 */
- (void)getMathFactWithNumber:(NSString *)number onSucces:(void(^)(NAPNumberFact *fact))success onFail:(void(^)(NSError *error))fail;

/**
 Gets a date number fact from web service. You can specify a number or "random" value
 @param number number to get a fact; if "random", a random number is generated in web service
 @param success block to execute if success; it contains a NAPNumberFact object
 @param fail block to execute if any error
 */
- (void)getDateFactWithNumber:(NSString *)number onSucces:(void(^)(NAPNumberFact *fact))success onFail:(void(^)(NSError *error))fail;

/**
 Gets a year number fact from web service. You can specify a number or "random" value
 @param number number to get a fact; if "random", a random number is generated in web service
 @param success block to execute if success; it contains a NAPNumberFact object
 @param fail block to execute if any error
 */
- (void)getYearFactWithNumber:(NSString *)number onSucces:(void(^)(NAPNumberFact *fact))success onFail:(void(^)(NSError *error))fail;

/**
 Gets a trivia number fact from web service. You can specify a number or "random" value
 @param number number to get a fact; if "random", a random number is generated in web service
 @param success block to execute if success; it contains a NAPNumberFact object
 @param fail block to execute if any error
 */
- (void)getTriviaFactWithNumber:(NSString *)number onSucces:(void(^)(NAPNumberFact *fact))success onFail:(void(^)(NSError *error))fail;

@end
