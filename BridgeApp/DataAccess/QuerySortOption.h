//
//  QuerySortOption.h
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum QuerySortDirection : NSUInteger {
    QuerySortDirectionAscending,
    QuerySortDirectionDescending
} QuerySortDirection;

@interface QuerySortOption : NSObject


@property (nonatomic, assign) QuerySortDirection sortDirection;
// Comma-delimited field name list
@property (nonatomic, strong) NSString* fieldNames;



+(QuerySortOption*)sortByFields:(NSString*)fieldNames direction:(QuerySortDirection)direction;

@end
