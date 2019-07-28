//
//  SortingMovies.m
//  flimApp
//
//  Created by Mac on 28/07/19.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "SortingMovies.h"

struct movieData
{
    double  ratting;
    NSString *title;
    NSString *date;

};

@implementation SortingMovies

-(NSMutableArray*)sortByRatting:(NSMutableArray*) arrayOfMovie
{
    int arraySize = [arrayOfMovie count];
    struct movieData obj[arraySize];
    int n = sizeof(obj) / sizeof(*obj);

    for (int index = 0; index<arrayOfMovie.count; index++)
    {
        NSDictionary *dirTemp  = arrayOfMovie[index];

        
        obj[index].ratting = [dirTemp[@"vote_average"] doubleValue];
        obj[index].title   = dirTemp[@"title"];
        obj[index].date    = dirTemp[@"release_date"] ;

    } // Converting Dictionry to Structure
    
    quickSortIterative(obj, 0, n - 1); // Sorting in c
    
    NSMutableArray *tempArrayS = [NSMutableArray new];

    for(int i = 0; i<arraySize; i++)
    {
        NSNumber *myDoubleNumber = [NSNumber numberWithDouble:obj[i].ratting];
        

        NSDictionary *dirD = @{@"vote_average":[myDoubleNumber stringValue],
                              @"title":obj[i].title,
                              @"release_date":obj[i].date};
        [tempArrayS addObject:dirD];
    } // covering to Structure to Dictionry
    
    return tempArrayS;
    

}

    void swap(struct movieData* a, struct movieData* b)
    {
        struct movieData t = *a;
        *a = *b;
        *b = t;
    }
    
    /* This function is same in both iterative and recursive*/
    int partition(struct movieData arr[], int l, int h)
    {
        int x = arr[h].ratting;
        int i = (l - 1);
        
        for (int j = l; j <= h - 1; j++) {
            if (arr[j].ratting >= x) {
                i++;
                swap(&arr[i], &arr[j]);
            }
        }
        swap(&arr[i + 1], &arr[h]);
        return (i + 1);
    }
    
    /* A[] --> Array to be sorted,
     l --> Starting index,
     h --> Ending index */
    void quickSortIterative(struct movieData arr[], int low, int heigh)
    {
        int stack[heigh - low + 1];
        
        int top = -1;

        stack[++top] = low;
        stack[++top] = heigh;
        
        while (top >= 0) {
            // Pop h and l
            heigh = stack[top--];
            low = stack[top--];
            
            int pivot = partition(arr, low, heigh);
            
            // If there are elements on left side of pivot,
            // then push left side to stack
            if (pivot - 1 > low) {
                stack[++top] = low;
                stack[++top] = pivot - 1;
            }
            
            // If there are elements on right side of pivot,
            // then push right side to stack
            if (pivot + 1 < heigh) {
                stack[++top] = pivot + 1;
                stack[++top] = heigh;
            }
        }
    }





@end
