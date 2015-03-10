//
//  User.h
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "DBModel.h"
#import "Job.h"
#import "Constants.h"
#import "Parse/Parse.h"

typedef enum UserType : NSUInteger {
    UserTypeFreelancer,
    UserTypeBusiness
} UserType;

@interface User : DBModel

@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* summary;
@property (nonatomic, assign) UserType usertype;
@property (nonatomic, strong) NSNumber* rating;
@property (nonatomic, assign) NSInteger reviewCount;
@property (nonatomic, strong) NSMutableArray* history;
@property (nonatomic, assign) NSInteger assetCount;
@property (nonatomic, strong) NSNumber* score;
@property (nonatomic, strong) NSString* phone;
@property (nonatomic, strong) NSString* website;
@property (nonatomic, strong) NSString* profileImageURL;

@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSString* businessName;

//@property (nonatomic, assign) double rating;
//@property (nonatomic, assign) int assetCount;
//@property (nonatomic, assign) double score;
//@property (nonatomic, assign) int reviewCount;


//  static getters
+(User*)currentUser;
+(void)getUserById:(NSString *)id completion:(void (^)(NSDictionary *foundObjects, NSError *error))completion;

// static setters
+(void) setCurrentUser:(User*) currentUser;

// instance getters
-(void)getAssignedJobsWithCompletion:(void (^)(NSArray *foundObjects, NSError *error))completion;
-(void)getCreatedJobsWithCompletion:(void (^)(NSArray *foundObjects, NSError *error))completion;
-(PFUser*) getAsPFUser;

// instance setters
-(void)setAsCurrentUser;

// actions
+(void)login:(NSString*)username password:(NSString*)password completion:(void (^)(NSError *error))completion;
+(NSMutableArray*) usersWithDictionaries:(NSArray*)dictionaries;
-(void)signUpWithCompletion:(void (^)(NSError *error))completion;
-(void)saveWithCompletion:(void (^)(NSError *error))completion;

+(NSString*)tableName;
+(NSArray*) includeKeys;

@end
