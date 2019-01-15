//
//  RestifyTMDbRequest.h
//  RestifyTMDb
//
//  Created by siva lingam on 11/1/19.
//  Copyright © 2019 Gemalto (security to be free). All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RestifyTMDbQueryParameters;

@interface RestifyTMDbRequest : NSObject

#pragma mark -
#pragma mark initializers

+(instancetype)sharedRequest;

#pragma mark -
#pragma mark Methods

/**
 Query the TMDb to find specific movies.
 @param parameters representing the query criteria
 @param completion The block that is called when the query is complete
 @since 1.0
 */
-(void)queryMoviesWithParameters:(RestifyTMDbQueryParameters *)parameters
                      completion:(nullable void(^)(NSArray *__nullable result, NSError *__nullable error))completion;

@end

NS_ASSUME_NONNULL_END
