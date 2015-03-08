//
//  QueryFilter.m
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "QueryFilter.h"

@implementation QueryFilter

+(QueryFilter*)filterByField:(NSString*)fieldName operator:(QueryFilterOperator)op value:(NSObject*)value {
    QueryFilter *filter = [[QueryFilter alloc] init];
    filter.fieldName = fieldName;
    filter.operator = op;
    filter.value = value;
    
    return filter;
}


@end
