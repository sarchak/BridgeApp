//
//  User.h
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "DBModel.h"
#import "Job.h"

typedef enum UserType : NSUInteger {
    UserTypeFreeLancer,
    UserTypeBusiness
} UserType;

@interface User : DBModel
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) NSString* password; //TODO: should we have this? A hash maybe?
@property (nonatomic, strong) NSString* profileImageURL;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSMutableArray *history;
@property (nonatomic, strong) NSString* phone;
@property (nonatomic, strong) NSString* website;

@property (nonatomic, assign) UserType usertype;
@property (nonatomic, assign) double rating;
@property (nonatomic, assign) int assetCount;
@property (nonatomic, assign) double score;
@property (nonatomic, assign) int reviewCount;


//-(User*)currentUser;
+(User*) currentUser;
-(void)signUpWithCompletion:(void (^)(NSDictionary *result, NSError *error))completion;
-(void)login:(NSString*)username password:(NSString*)password completion:(void (^)(NSDictionary *result, NSError *error))completion;
+(void) setCurrentUser:(User*) currentUser;

@end
