//
//  DBModel.m
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "DBModel.h"
#import "ParseClient.h"
#import "QueryFilter.h"
#import "QuerySortOption.h"

// adding this circular dependency just temporarily. will remove it later
#import "User.h"
#import "Job.h"
#import "ConversationThread.h"
#import "Message.h"
#import "Asset.h"

@implementation DBModel

-(DBModel*)initWithDictionary:(NSDictionary*)dict {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in the subclass", NSStringFromSelector(_cmd)];
    
    return nil;
}

-(void)updateWithDictionary:(NSDictionary*) dict {
    self.pfObject = dict[@"pfObject"];
    self.objectId = dict[@"objectId"];
    self.createdAt = dict[@"createdAt"];
    self.updatedAt = dict[@"updatedAt"];
}

-(NSMutableDictionary*)toDictionary {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in the subclass", NSStringFromSelector(_cmd)];
    
    return nil;
}

-(NSDictionary*)serialize {
    NSMutableDictionary* subClassProperties = [self toDictionary];
    
    [subClassProperties setObject:(self.objectId ?: [NSNull null]) forKey:@"objectId"];
    [subClassProperties setObject:(self.createdAt ?: [NSNull null]) forKey:@"createdAt"];
    [subClassProperties setObject:(self.updatedAt ?: [NSNull null]) forKey:@"updatedAt"];
    [subClassProperties setObject:(self.tableName ?: [NSNull null]) forKey:@"tableName"];
    
    return subClassProperties;
}

-(NSString*)tableName {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    return nil;
}

-(void)saveWithCompletion:(void (^)(NSError *error))completion {

    ParseClient* p = [ParseClient sharedInstance];
    if (self.objectId) {
        [p update:self.tableName row:self.serialize completion:^(NSDictionary *dict, NSError *error) {
            [self updateWithDictionary:dict];
            completion(error);
        }];
    }
    else {
        [p insert:self.tableName row:self.serialize completion:^(NSDictionary *dict, NSError *error) {
            [self updateWithDictionary:dict];
            completion(error);
        }];
    }
    
}

-(void)deleteWithCompletion:(void (^)(NSError *error))completion {
    
    ParseClient* p = [ParseClient sharedInstance];
    if (self.objectId) {
        QueryFilter* filter = [QueryFilter filterByField:@"objectId" operator:QueryFilterOperatorEquals value:self.objectId];
        [p remove:self.tableName withFilter:[NSArray arrayWithObjects:filter, nil] completion:completion];
    }
    
}

-(void)findWithCompletion:(NSArray*)queryFilters sortOptions:(NSArray*)sortOptions completion:(void (^)(NSArray *foundObjects, NSError *error))completion {
    
    ParseClient* p = [ParseClient sharedInstance];
    [p read:self.tableName withFilters:queryFilters sortOptions:sortOptions completion:^(NSArray *result, NSError *error) {
        NSMutableArray* array = [[NSMutableArray alloc] init];
        for (NSDictionary* dict in result) {
            [array addObject:[self initWithDictionary:dict]];
        }
        completion(array, error);
    }];
    
}

-(void)findByIdWithCompletion:(NSString*)objectId completion:(void (^)(DBModel *foundObject, NSError *error))completion {
    
    ParseClient* p = [ParseClient sharedInstance];
    [p readById:self.tableName objectId:objectId completion:^(NSDictionary *result, NSError *error) {
        
        if (result == nil) {
            if (error == nil) {
                error = [NSError errorWithDomain:@"No objects were found on the server." code:1 userInfo:nil];
            }
            completion(nil, error);
        } else {
            DBModel* object = [[[self class] alloc] init];
            [object updateWithDictionary:result];
            
            completion(object, error);
        }
        
    }];
    
}

@end
