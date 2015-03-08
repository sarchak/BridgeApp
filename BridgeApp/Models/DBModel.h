//
//  DBModel.h
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuerySortOption.h"
#import "Parse/Parse.h"

@interface DBModel : NSObject

@property (nonatomic, strong) PFObject* pfObject;
@property (nonatomic, strong) NSString* objectId;
@property (nonatomic, strong) NSDate* createdAt;
@property (nonatomic, strong) NSDate* updatedAt;

-(DBModel*)initWithDictionary:(NSDictionary*)dict;
-(void)updateWithDictionary:(NSDictionary*) dict;

-(NSDictionary*)serialize;
-(NSString*)tableName;
-(void)saveWithCompletion:(void (^)(NSError *error))completion;
-(void)deleteWithCompletion:(void (^)(NSError *error))completion;
-(void)findWithCompletion:(NSArray*)withFilters sortOptions:(NSArray*)sortOptions completion:(void (^)(NSArray *foundObjects, NSError *error))completion;
-(void)findByIdWithCompletion:(NSString*)objectId completion:(void (^)(DBModel *foundObject, NSError *error))completion;


@end
