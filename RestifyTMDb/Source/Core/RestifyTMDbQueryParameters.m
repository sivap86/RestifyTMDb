//
//  RestifyTMDbQueryParameters.m
//  RestifyTMDb
//
//  Created by siva lingam on 12/1/19.
//  Copyright © 2019 Gemalto (security to be free). All rights reserved.
//

#import "RestifyTMDbQueryParameters.h"

@implementation RestifyTMDbQueryParameters

#pragma mark Singleton Methods

+ (id)queryParameters {
    static RestifyTMDbQueryParameters *queryParameters = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queryParameters = [[self alloc] init];
    });
    return queryParameters;
}

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

@end
