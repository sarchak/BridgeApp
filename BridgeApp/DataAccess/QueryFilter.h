//
//  QueryFilter.h
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum QueryFilterOperator : NSUInteger {
    QueryFilterOperatorEquals,
    QueryFilterOperatorLessThan,
    QueryFilterOperatorLessThanOrEqualTo,
    QueryFilterOperatorGreaterThan,
    QueryFilterOperatorGreaterThanOrEqualTo
} QueryFilterOperator;

@interface QueryFilter : NSObject

@property (nonatomic, strong) NSString* fieldName;
@property (nonatomic, assign) QueryFilterOperator operator;
@property (nonatomic, strong) NSObject* value;


+(QueryFilter*)filterByField:(NSString*)fieldName operator:(QueryFilterOperator)op value:(NSObject*)value;

@end
