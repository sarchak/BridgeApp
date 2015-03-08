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
#import "User.h"

@interface ParseClient : NSObject

+ (ParseClient*) sharedInstance;

-(ParseClient*)init;
-(void)signUp:(User *)user completion:(void (^)(NSError *error))completion;
-(void)updateUser:(User *)user completion:(void (^)(NSError *error))completion;
-(void)login:(NSString*)username password:(NSString*)password completion:(void (^)(NSError *error))completion;

-(void)read:(NSString*)fromTableName withFilters:(NSArray*)queryFilters sortOptions:(NSArray*)sortOptions completion:(void (^)(NSArray *result, NSError *error))completion;
-(void)readById:(NSString*)tableName objectId:(NSString*)objectId completion:(void (^)(NSDictionary *result, NSError *error))completion;
-(void)update:(NSString*)tableName row:(NSDictionary*)row completion:(void (^)(NSDictionary* dict, NSError *error))completion;
-(void)insert:(NSString*)tableName row:(NSDictionary*)row completion:(void (^)(NSDictionary* dict, NSError *error))completion;
-(void)remove:(NSString*)tableName withFilter:(NSArray*)queryFilters completion:(void (^)(NSError *error))completion ;

@end
