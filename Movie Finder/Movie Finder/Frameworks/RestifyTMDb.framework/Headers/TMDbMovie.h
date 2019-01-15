//
//  TMDbMovie.h
//  RestifyTMDb
//
//  Created by siva lingam on 14/1/19.
//  Copyright © 2019 Gemalto (security to be free). All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMDbMovie : NSObject

/** Movie title
 @since 1.0
 */
@property (nonatomic, copy, readwrite) NSString* title;

/** Movie rating
 @since 1.0
 */
@property (nonatomic, assign, readwrite) float rating;

/** Movie Id
 @since 1.0
 */
@property (nonatomic, assign, readwrite) int movieId;

@end

NS_ASSUME_NONNULL_END
