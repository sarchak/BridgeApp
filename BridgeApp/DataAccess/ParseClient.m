//
//  ParseClient.m
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "ParseClient.h"
#import <Parse/Parse.h>
#import "User.h"

@implementation ParseClient

+(ParseClient *) sharedInstance {
    static ParseClient *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            //TODO(emrahs): API Keys are in .gitignore'd Secrets.plist for now. There should be a better way of hiding keys from GitHub.
            NSString *path = [[NSBundle mainBundle]pathForResource:@"Secrets" ofType:@"plist"];
            NSDictionary *secretsDict = [NSDictionary dictionaryWithContentsOfFile: path];
            NSString *kParseApplicationId = [secretsDict objectForKey: @"ParseApplicationId"];
            NSString *kParseClientKey = [secretsDict objectForKey: @"ParseClientKey"];
            kParseApplicationId = @"skXmwEdM7oNPNJcuvhjSyDYauwS4tEaDHHdbvJsM" ;
            kParseClientKey = @"gQgOjJZUKz8gHQ1VpCcDigH2qJTNuQ2OBIww263x";
            
            [Parse setApplicationId:kParseApplicationId clientKey:kParseClientKey];
            
            instance = [[ParseClient alloc] internalInit];
        }
    });
    
    return instance;
}

- (ParseClient*)internalInit {
    return [super init];
}

- (ParseClient*)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"ParseClient class is singleton. Please use [ParseClient sharedInstance] to get an instance."
                                 userInfo:nil];
    return nil;
}


-(void)signUp:(User *)user completion:(void (^)(NSError *error))completion {
    PFUser *pfUser = [PFUser user];
    pfUser.username = user.email;
    pfUser.email = user.email;
    pfUser.password = user.password;

    NSDictionary* dict = [user serialize];
    NSArray* keys = [dict allKeys];
    for (id key in keys) {
        if ([key isEqual:@"objectId"]
            || [key isEqual:@"createdAt"]
            || [key isEqual:@"updatedAt"]
            || [key isEqual:@"password"]
            || [key isEqual:@"email"]) {
            // skip these fields
            continue;
        }
        pfUser[key] = dict[key];
    }
    
    [pfUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self login:user.email password:user.password completion:completion];
        } else {
            completion(error);
        }
    }];
}

-(void)updateUser:(User *)user completion:(void (^)(NSError *error))completion {
    PFUser *pfUser = [PFUser currentUser];
    if (![pfUser.objectId isEqual:user.objectId]) {
        NSString* errorMessage = [NSString stringWithFormat:@"Current user (%@) is not the user that is being updated! (%@)", pfUser, user];
        NSError* error = [NSError errorWithDomain:errorMessage code:1 userInfo:nil];
        completion(error);
        return;
    }
    
    NSDictionary* dict = [user serialize];
    NSArray* keys = [dict allKeys];
    for (id key in keys) {
        if ([key isEqual:@"objectId"]
            || [key isEqual:@"createdAt"]
            || [key isEqual:@"createdAt"]
            || [key isEqual:@"email"]) {
            // these fields are not editable
            continue;
        }
        else if ([key isEqual:@"password"] && [dict[key] isEqual:[NSNull null]]) {
            // password was not reset
            continue;
        }
        
        pfUser[key] = dict[key];
    }
    
    [pfUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        completion(error);
    }];
}

-(void)login:(NSString*)email password:(NSString*)password completion:(void (^)(NSError *error))completion {
    [PFUser logInWithUsernameInBackground:email password:password
        block:^(PFUser *pfUser, NSError *error) {
            if (pfUser) {
                @try {
                    NSDictionary* dict = [self convertPFObjectToNSDictionary:pfUser];
                    User* user = [[User alloc] initWithDictionary:dict];
                    [user setAsCurrentUser];
                }
                @catch (NSException *exception) {
                    NSLog(@"Exception during parse login: %@", exception.description);
                    completion([NSError errorWithDomain:exception.description code:1 userInfo:nil]);
                }
                completion(nil);
            }
            else {
                completion(error);
            }
    }];
}

-(void)read:(NSString*)fromTableName withFilters:(NSArray*)queryFilters sortOptions:(NSArray*)sortOptions completion:(void (^)(NSArray *result, NSError *error))completion {
    
    if ([fromTableName isEqual:@"User"]) {
        NSError* error = [NSError errorWithDomain:@"Unfortunately User table cannot be queried in the generic way." code:1 userInfo:nil];
        completion(nil, error);
        return;
    }
    
    PFQuery *query = [self buildQuery:fromTableName withFilter:queryFilters sortOptions:sortOptions];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSMutableArray* objectDictionaries = [[NSMutableArray alloc] init];
            for (PFObject *object in objects) {
                [objectDictionaries addObject:[self convertPFObjectToNSDictionary:object]];
            }
            completion(objectDictionaries, error);
        } else {
            completion(nil, error);
        }
    }];
}

-(void)readById:(NSString*)tableName objectId:(NSString*)objectId completion:(void (^)(NSDictionary *result, NSError *error))completion {
    PFQuery *query = [PFQuery queryWithClassName:tableName];
    [query whereKey:@"objectId" equalTo:objectId];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSDictionary* foundObject = nil;
            for (PFObject *object in objects) {
                foundObject = [self convertPFObjectToNSDictionary:object];
                break;
            }
            completion(foundObject, error);
        } else {
            completion(nil, error);
        }
    }];
}

-(void)update:(NSString*)tableName row:(NSDictionary*)row completion:(void (^)(NSDictionary* dict, NSError *error))completion {
    PFQuery *query = [PFQuery queryWithClassName:tableName];
    [query whereKey:@"objectId" equalTo:row[@"objectId"]];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * foundObject, NSError *error) {
        if (!error) {
            for (id columnName in row) {
                if ([row isEqual:@"objectId"] || [row isEqual:@"createdAt"] || [row isEqual:@"updatedAt"]) {
                    // these columns are not editable
                    continue;
                }
                foundObject[columnName] = row[columnName];
            }
            
            // Save
            [foundObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                completion([self convertPFObjectToNSDictionary:foundObject], error);
            }];
        } else {
            completion(nil, error);
        }
    }];
}

-(void)insert:(NSString*)tableName row:(NSDictionary*)row completion:(void (^)(NSDictionary* dict, NSError *error))completion {
    PFObject *object = [PFObject objectWithClassName:tableName];
    
    for (id columnName in row) {
        if ([row isEqual:@"objectId"] || [row isEqual:@"createdAt"] || [row isEqual:@"createdAt"]) {
            // these columns are not editable
            continue;
        }
        object[columnName] = row[columnName];
    }
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        completion([self convertPFObjectToNSDictionary:object], error);
    }];
}

-(void)remove:(NSString*)tableName withFilter:(NSArray*)queryFilters completion:(void (^)(NSError *error))completion {
    PFQuery *query = [self buildQuery:tableName withFilter:queryFilters sortOptions:nil];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * foundObject, NSError *error) {
        if (!error) {
            // Save
            [foundObject deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                completion(error);
            }];
        } else {
            completion(error);
        }
    }];
}
-(PFQuery*)buildQuery:(NSString*)tableName withFilter:(NSArray*)queryFilters sortOptions:(NSArray*)sortOptions {
    PFQuery *query = [PFQuery queryWithClassName:tableName];
    
    for (QueryFilter* filter in queryFilters) {
        switch (filter.operator) {
            case QueryFilterOperatorEquals:
                [query whereKey:filter.fieldName equalTo:filter.value];
                break;
            case QueryFilterOperatorGreaterThan:
                [query whereKey:filter.fieldName greaterThan:filter.value];
                break;
            case QueryFilterOperatorGreaterThanOrEqualTo:
                [query whereKey:filter.fieldName greaterThanOrEqualTo:filter.value];
                break;
            case QueryFilterOperatorLessThan:
                [query whereKey:filter.fieldName lessThan:filter.value];
                break;
            case QueryFilterOperatorLessThanOrEqualTo:
                [query whereKey:filter.fieldName lessThanOrEqualTo:filter.value];
        }
    }
    
    for (QuerySortOption* option in sortOptions) {
        switch (option.sortDirection) {
            case QuerySortDirectionAscending:
                [query orderByAscending:option.fieldNames];
                break;
            case QuerySortDirectionDescending:
                [query orderByDescending:option.fieldNames];
                break;
        }
    }
    
    return query;
}

-(NSMutableDictionary*)convertPFObjectToNSDictionary:(PFObject*)pfObject {
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    NSArray* keys = [pfObject allKeys];
    for (id key in keys) {
        dict[key] = pfObject[key];
    }
    dict[@"objectId"] = pfObject.objectId;
    dict[@"createdAt"] = pfObject.createdAt;
    dict[@"updatedAt"] = pfObject.updatedAt;
    dict[@"pfObject"] = pfObject;
    
    return dict;
}

-(NSMutableArray*) convertPFObjectArrayToNSDictionaries:(NSArray*)pfObjects {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    for (PFObject* pfObject in pfObjects) {
        [array addObject:[self convertPFObjectToNSDictionary:pfObject]];
    }
    
    return array;
}


-(NSDictionary*) mapPFObjectToDict:(PFObject*) object {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSString *key in [object allKeys]) {
        [dict setObject:[object objectForKey:key] forKey:key];
    }
    return dict;
}
@end
