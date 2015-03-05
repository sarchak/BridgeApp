//
//  ParseClient.h
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueryFilter.h"
#import "QuerySortOption.h"

@interface ParseClient : NSObject

+ (ParseClient*) sharedInstance;

-(void)connect;

-(void)signUp:(NSString*)username password:(NSString*)password completion:(void (^)(NSDictionary *result, NSError *error))completion;
-(void)login:(NSString*)username password:(NSString*)password completion:(void (^)(NSDictionary *result, NSError *error))completion;

-(void)read:(NSString*)fromTableName withFilter:(NSArray*)queryFilters sortOption:(QuerySortOption*)sortOption completion:(void (^)(NSArray *result, NSError *error))completion;
-(void)update:(NSString*)tableName withFilter:(NSArray*)queryFilters sortOption:(QuerySortOption*)sortOption completion:(void (^)(NSDictionary *result, NSError *error))completion;
-(void)insert:(NSString*)tableName withFilter:(NSArray*)queryFilters sortOption:(QuerySortOption*)sortOption completion:(void (^)(NSDictionary *result, NSError *error))completion;
-(void)remove:(NSString*)tableName withFilter:(NSArray*)queryFilters sortOption:(QuerySortOption*)sortOption completion:(void (^)(NSDictionary *result, NSError *error))completion;

@end
