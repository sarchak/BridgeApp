//
//  User.m
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "User.h"
#import "ParseClient.h"
#import "UserFactory.h"

@interface User ()

@end

@implementation User

+(void)login:(NSString*)username password:(NSString*)password completion:(void (^)(NSError *error))completion {
    ParseClient *p = [ParseClient sharedInstance];
    [p login:username password:password completion:completion];
}

+(NSMutableArray*) usersWithDictionaries:(NSArray*)dictionaries {
    NSMutableArray *users = [[NSMutableArray alloc] init];
    User* temp = nil;
    
    for (NSDictionary* userDict in dictionaries) {
        temp = [[User alloc] initWithDictionary:userDict];
        [users addObject:temp];
    }
    
    return users;
}

-(User*)initWithDictionary:(NSDictionary*)dict {
    
    self = [super init];
    
    if (self) {
        [self updateWithDictionary:dict];
    }
    
    return self;
}

-(void)updateWithDictionary:(NSDictionary*) dict {
    [super updateWithDictionary:dict];
    
    self.username = dict[@"username"];
    self.email = dict[@"email"];
    self.password = dict[@"password"];
    self.name = dict[@"name"];
    self.summary = dict[@"summary"];
    self.usertype = [dict[@"type"] integerValue];
    self.rating = dict[@"rating"];
    self.reviewCount = [dict[@"reviewCount"] integerValue];
    self.history = dict[@"history"];
    self.assetCount = [dict[@"assetCount"] integerValue];
    self.score = dict[@"score"];
    self.phone = dict[@"phone"];
    self.website = dict[@"website"];
    self.profileImageURL = dict[@"profileImageURL"];
}

-(NSMutableDictionary*)toDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:(self.username ?: [NSNull null]) forKey:@"username"];
    [dict setObject:(self.email ?: [NSNull null]) forKey:@"email"];
    [dict setObject:(self.password ?: [NSNull null]) forKey:@"password"];
    [dict setObject:(self.name ?: [NSNull null]) forKey:@"name"];
    [dict setObject:(self.summary ?: [NSNull null]) forKey:@"summary"];
    [dict setObject:(self.rating ?: [NSNull null]) forKey:@"rating"];
    [dict setObject:(self.history ?: [NSNull null]) forKey:@"history"];
    [dict setObject:(self.score ?: [NSNull null]) forKey:@"score"];
    [dict setObject:(self.phone ?: [NSNull null]) forKey:@"phone"];
    [dict setObject:(self.website ?: [NSNull null]) forKey:@"website"];
    [dict setObject:(self.profileImageURL ?: [NSNull null]) forKey:@"profileImageURL"];
    [dict setObject:@(self.usertype) forKey:@"type"];
    [dict setObject:@(self.reviewCount) forKey:@"reviewCount"];
    [dict setObject:@(self.assetCount) forKey:@"assetCount"];
    
    return dict;
}

-(NSString*)tableName {
    return [User tableName];
}

+(NSString*)tableName {
    return @"_User";
}

-(NSArray*) includeKeys {
    return [User includeKeys];
}

+(NSArray*) includeKeys {
    return @[];
}

-(NSArray*)requiredFields {
    return @[
             @"username"
    ];
}

-(void)setAsCurrentUser {
    _currentUser = self;
}

-(void)signUpWithCompletion:(void (^)(NSError *error))completion {
    ParseClient *p = [ParseClient sharedInstance];
    [p signUp:self completion:completion];
}

-(PFUser*) getAsPFUser {
    PFUser *user = [PFUser user];
    user[USERNAME] = self.username;
    user[PASSWORD] = self.password;
    user[USERTYPE] = [NSNumber numberWithInt:self.usertype];
    return user;
}


-(void)saveWithCompletion:(void (^)(NSError *error))completion {
    ParseClient *p = [ParseClient sharedInstance];
    if (self.objectId) {
        [p updateUser:self completion:completion];
    }
    else {
        [p signUp:self completion:completion];
    }
}

static User *_currentUser = nil;
NSString * const kCurrentUser = @"kCurrentUser";

+(User*) currentUser {
//    if(_currentUser == nil){
//        NSData *data =  [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUser];
//        if(data != nil){
//            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//            _currentUser = [UserFactory getUser:dictionary];
//        }
//    }
    return _currentUser;
}

+(void) setCurrentUser:(User *)currentUser {
    _currentUser = currentUser;
    if(_currentUser != nil){

//        NSData *data = [NSJSONSerialization dataWithJSONObject:[currentUser serialize] options:0 error:NULL];
//        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUser];
//        [[NSUserDefaults standardUserDefaults] synchronize];        
    }
}

-(void)getAssignedJobsWithCompletion:(void (^)(NSArray *foundObjects, NSError *error))completion {
    NSMutableArray* filters = [[NSMutableArray alloc] init];
    [filters addObject:[QueryFilter filterByField:@"assignedToUser" operator:QueryFilterOperatorEquals value:self.pfObject]];
    [self findWithCompletionFromTable:@"Jobs" filters:filters sortOptions:nil completion:completion];
}

-(void)getCreatedJobsWithCompletion:(void (^)(NSArray *foundObjects, NSError *error))completion {
    NSMutableArray* filters = [[NSMutableArray alloc] init];
    [filters addObject:[QueryFilter filterByField:@"owner" operator:QueryFilterOperatorEquals value:self.pfObject]];
    [self findWithCompletionFromTable:@"Jobs" filters:filters sortOptions:nil completion:completion];
}

static User *_user = nil;
+(User*)getUserById:(NSString *)id {
    ParseClient *p = [ParseClient sharedInstance];
    [p readById:@"_User" objectId:id completion:^(NSDictionary *result, NSError *error) {
        _user = [[User alloc] initWithDictionary:result];
    }];
    return _user;
}


@end
