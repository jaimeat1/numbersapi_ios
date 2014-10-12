//
//  NAPNumberFact.h
//  NumbersApi
//
//  Created by Jaime on 12/10/14.
//  Copyright (c) 2014 Jaime Aranaz. All rights reserved.
//

#import <Foundation/Foundation.h>

// This class represents a number fact, provided by web service
@interface NAPNumberFact : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic) BOOL found;
@property (nonatomic) NSInteger number;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *date;

/**
 Initialize a NPANumberFact with a JSON response from web services
 @param json dictionary with JSON data
 @return a NAPNumberFact object initialized with data
 */
- (id)initWithDictionary:(NSDictionary *)json;

@end
