//
//  RestifyTMDbQueryParameters.h
//  RestifyTMDb
//
//  Created by siva lingam on 12/1/19.
//  Copyright © 2019 Gemalto (security to be free). All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** Order by which the movies need to be sorted.
 @since 1.0
 */
typedef NS_ENUM(NSInteger, TMDbSortOrder) {
    TMDbSortOrderDescending = 0
};

/** Order in which to sort query results
 @since 1.0
 */
typedef NS_ENUM(NSInteger, TMDbOrderBy) {
    TMDbOrderByRating = 0
};

@interface RestifyTMDbQueryParameters : NSObject

#pragma mark -
#pragma mark initializers

-(instancetype)init;
+(instancetype)queryParameters;

#pragma mark -
#pragma mark properties

/** The maximum number of movies that should be returned.
 @note For consistent ordering of results when using pagination, you should also provide a value for `#orderByField`.
 @since 1.0
 */
@property (nonatomic, assign, readwrite) NSInteger maxRecords;

/** Keyword of the movies that the query should be restricted to.
 @since 1.0
 */
@property (nonatomic, copy, readwrite) NSString *keyword;

/** The release date years that the query should be restricted to.
 @since 1.0
 */
@property (nonatomic, copy, readwrite) NSArray<NSString *> *years;

/** Field by which the movies need to be ordered.
 @since 1.0
 */
@property (nonatomic, assign, readwrite) TMDbOrderBy orderBy;

/** Order by which the movies need to be sorted.
 @since 1.0
 */
@property (nonatomic, assign, readwrite) TMDbSortOrder sortOrder;

@end

NS_ASSUME_NONNULL_END

