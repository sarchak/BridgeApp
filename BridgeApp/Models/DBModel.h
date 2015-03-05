//
//  DBModel.h
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuerySortOption.h"

@interface DBModel : NSObject

@property (nonatomic, strong) NSString* objectId;
@property (nonatomic, strong) NSDate* createdOn;

-(NSDictionary*)serialize;
-(NSString*)tableName;
-(void)saveWithCompletion:(void (^)(NSArray *result, NSError *error))completion;
-(void)deleteWithCompletion:(void (^)(NSArray *result, NSError *error))completion;
-(void)findObjectsBy:(NSArray*)queryFilters sortOption:(QuerySortOption*)sortOption completion:(void (^)(NSArray *result, NSError *error))completion;
-(void)findObject:(NSArray*)queryFilters completion:(void (^)(DBModel *result, NSError *error))completion;


@end
