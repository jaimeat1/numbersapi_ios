//
//  NAPNumberFact.m
//  NumbersApi
//
//  Created by Jaime on 12/10/14.
//  Copyright (c) 2014 Jaime Aranaz. All rights reserved.
//

#import "NAPNumberFact.h"

@implementation NAPNumberFact

- (id)initWithDictionary:(NSDictionary *)json
{
    self = [super init];
    
    if (self) {
        _text = [json objectForKey:@"text"];
        _found = [[json objectForKey:@"found"] boolValue];
        _number = [[json objectForKey:@"number"] integerValue];
        _type = [json objectForKey:@"type"];
        _date = [json objectForKey:@"date"];
    }
    
    return self;
}

@end
