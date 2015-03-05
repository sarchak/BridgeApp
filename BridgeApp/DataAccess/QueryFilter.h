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
    QueryFilterOperatorGreaterThan
} QueryFilterOperator;

@interface QueryFilter : NSObject

@property (nonatomic, strong) NSString* fieldName;
@property (nonatomic, assign) QueryFilterOperator operator;
@property (nonatomic, strong) NSString* value;

@end
