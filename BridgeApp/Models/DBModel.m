//
//  DBModel.m
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "DBModel.h"
#import "QueryFilter.h"
#import "QuerySortOption.h"

@implementation DBModel

-(NSDictionary*)serialize {
    NSMutableDictionary* subClassProperties = [self toDictionary];
    
    [subClassProperties setObject:[self objectId] forKey:@"objectId"];
    [subClassProperties setObject:[self tableName] forKey:@"tableName"];
    [subClassProperties setObject:[self createdOn] forKey:@"createdOn"];
    
    return subClassProperties;
}

-(NSMutableDictionary*)toDictionary {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    return nil;
}

-(NSString*)tableName {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    return nil;
}

-(void)saveWithCompletion:(void (^)(NSArray *result, NSError *error))completion {

    //TODO(emrahs): Save (insert/update) this object using ParseClient
    
}

-(void)deleteWithCompletion:(void (^)(NSArray *result, NSError *error))completion {
    
    //TODO(emrahs): Delete this object using ParseClient
    
}

-(void)findObjects:(NSArray*)queryFilters sortOption:(QuerySortOption*)sortOption completion:(void (^)(NSArray *result, NSError *error))completion {
    
    //TODO(emrahs): Find objects using ParseClient
    
}


-(void)findObject:(NSArray*)queryFilters completion:(void (^)(DBModel *result, NSError *error))completion {
    
    //TODO(emrahs): Call findObjects and make sure zero or one object is returned
    
}

@end
