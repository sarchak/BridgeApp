//
//  QuerySortOption.m
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "QuerySortOption.h"

@implementation QuerySortOption

+(QuerySortOption*)sortByFields:(NSString*)fieldNames direction:(QuerySortDirection)direction {
    
    QuerySortOption* option = [[QuerySortOption alloc] init];
    option.fieldNames = fieldNames;
    option.sortDirection = direction;
    
    return option;
}

@end
