//
//  SortMovies.h
//  RestifyTMDb
//
//  Created by siva lingam on 13/1/19.
//  Copyright © 2019 Gemalto (security to be free). All rights reserved.
//

#ifndef SortMovies_h
#define SortMovies_h

struct movie{
    char *title;
    int id;
    float average_vote;
};

/** Sort the movies by its ratings
 param movies: array of movie to be sorted
 param size: movies array total count
 since 1.0
 */
void sortByRating(struct movie *movies, int size);

#endif /* SortMovies_h */
