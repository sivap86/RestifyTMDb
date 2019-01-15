//
//  RestifyTMDbRequest.m
//  RestifyTMDb
//
//  Created by siva lingam on 11/1/19.
//  Copyright © 2019 Gemalto (security to be free). All rights reserved.
//

#import  "RestifyTMDbRequest.h"
#import  "RestifyTMDbConfig.h"
#import  "RestifyTMDbQueryParameters.h"
#import  "Constants.h"
#import  "TMDbMovie.h"
#include "SortMovies.h"

@implementation RestifyTMDbRequest

#pragma mark Singleton Methods

+ (id)sharedRequest {
    static RestifyTMDbRequest *sharedRequest = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRequest = [[self alloc] init];
    });
    return sharedRequest;
}

#pragma mark Methods

-(void) queryMoviesWithParameters:(RestifyTMDbQueryParameters *)parameters completion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion {
    if (parameters) {
        __block NSMutableDictionary *queryParamters = [NSMutableDictionary dictionary];
        [queryParamters setObject:parameters.keyword forKey:kQuery];
        dispatch_group_t serviceGroup = dispatch_group_create();
        
        NSMutableArray *movieList = [[NSMutableArray alloc] init];
        if (parameters.years.count > 0) {
            __block NSMutableArray *serviceErrors = [NSMutableArray array];
            for (NSString *year in parameters.years) {
                // Start the  service for each year
                [queryParamters setObject:year forKey:kReleaseYear];
                dispatch_group_enter(serviceGroup);
                [self beginGetRquestWithUrl:[self createURLwithComponents:queryParamters path:kTMDbSearchMovie] completion:^( id response, NSError * error) {
                    if (error) {
                        [serviceErrors addObject:error];
                    }
                    else {
                        NSDictionary* responseData = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
                        if ([responseData objectForKey:@"results"]> 0) {
                            [movieList addObjectsFromArray:[responseData objectForKey:@"results"]];
                        }
                    }
                    dispatch_group_leave(serviceGroup);
                }];
            }
            dispatch_group_wait(serviceGroup,DISPATCH_TIME_FOREVER);
            
            if (serviceErrors.count > 0) {
                completion(nil, serviceErrors[0]);
                return;
            }
            else {
                int i;
                struct movie movies[movieList.count];
                for (int i = 0; i<movieList.count; i++) {
                    NSDictionary *movieDict = movieList[i];
                    struct movie movie;
                    movie.average_vote = [movieDict[@"vote_average"] floatValue];
                    movie.id = [movieDict[@"vote_average"] intValue];
                    movie.title = strdup([movieDict[@"title"] cStringUsingEncoding:NSUTF8StringEncoding]);;
                    movies[i] = movie;
                }
                switch (parameters.orderBy) {
                    case TMDbOrderByRating:
                        sortByRating(movies, (int)movieList.count);
                        break;
                    default:
                        break;
                }
                NSMutableArray *responseList = [[NSMutableArray alloc] init];
                NSInteger maxRecordCount = movieList.count>parameters.maxRecords?parameters.maxRecords:movieList.count;
                for (i = 0; i < maxRecordCount; ++i) {
                    struct movie cStructMovie = movies[i];
                    TMDbMovie *movie = [[TMDbMovie alloc] init];
                    movie.title = [NSString stringWithCString:cStructMovie.title encoding:NSUTF8StringEncoding];
                    movie.movieId = cStructMovie.id;
                    movie.rating = cStructMovie.average_vote;
                    [responseList addObject:movie];
                }
                completion(responseList,nil);
            }
        }
        else {
            [self beginGetRquestWithUrl:[self createURLwithComponents:queryParamters path:kTMDbSearchMovie] completion:^( id response, NSError * error) {
                completion(response, error);
            }];
        }
    }
    
}

-(NSURL *) createURLwithComponents:(NSDictionary *) queryParameters path:(NSString*) path {
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = kTMDbServerScheme;
    components.host = kTMDbBaseServerUrl;
    components.path = path;
    NSMutableArray *queryItems = [NSMutableArray array];
    //Add API Key to query by default
    NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:kApiKey value:[RestifyTMDbConfig apiKey]];
    [queryItems addObject:queryItem];
    for (NSString *key in queryParameters.allKeys) {
        NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:key value:queryParameters[key]];
        [queryItems addObject:queryItem];
    }
    components.queryItems = queryItems;
    return components.URL;
}

- (void)beginGetRquestWithUrl:(NSURL *)URL
                  completion:(void (^)(id response, NSError * error))completion
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:URL];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        completion(data,error);
    }] resume];
}


@end
