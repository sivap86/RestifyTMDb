//
//  Constants.h
//  RestifyTMDb
//
//  Created by siva lingam on 12/1/19.
//  Copyright © 2019 Gemalto (security to be free). All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Constants : NSObject

//TMDb server URL
extern NSString *const kTMDbBaseServerUrl;
//TMDb server scheme
extern NSString *const kTMDbServerScheme;
//API Key
extern NSString *const kTMDbAPIKey;
//Search Movie Path
extern NSString *const kTMDbSearchMovie;

//Query Constants
extern NSString *const kApiKey;
extern NSString *const kQuery;
extern NSString *const kReleaseYear;

@end

NS_ASSUME_NONNULL_END
