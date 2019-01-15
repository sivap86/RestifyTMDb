//
//  RestifyTMDbConfig.h
//  RestifyTMDb
//
//  Created by siva lingam on 13/1/19.
//  Copyright © 2019 Gemalto (security to be free). All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RestifyTMDbConfig : NSObject

#pragma mark -
#pragma mark Methods

/** Set the API Key to be used for the TMDb API Request. To register API Key refer https://www.themoviedb.org/settings/api
 @param secretKey application apiKey
 @return whether the apiKey was set
 @since 1.0
 */
+(BOOL)configureWithKey:(NSString *)secretKey;

/** Indicates whether the API key has been set.
 @return  YES if API key set, else  NO
 @since 1.0
 */
+(NSString*) apiKey;

@end

NS_ASSUME_NONNULL_END
