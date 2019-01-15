//
//  SortMovies.c
//  sample mine
//
//  Created by siva lingam on 13/1/19.
//  Copyright © 2019 siva lingam. All rights reserved.
//

#include "SortMovies.h"
#include <stdio.h>
#include <stdlib.h>

int compare(const void *mm1, const void *mm2)
{
    struct movie *m1 = (struct movie *)mm1;
    struct movie *m2 = (struct movie *)mm2;
    return (m2->average_vote > m1->average_vote) - (m2->average_vote < m1->average_vote);
}

void sortByRating(struct movie *movies, int size) {
    qsort(movies, size, sizeof(struct movie), compare);
}
