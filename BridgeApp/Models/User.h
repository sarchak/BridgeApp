//
//  User.h
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "DBModel.h"

@interface User : DBModel

@property (nonatomic, strong) NSString* userName;
@property (nonatomic, strong) NSString* password; //TODO: should we have this? A hash maybe?
@property (nonatomic, strong) NSString* profileImageURL;


-(User*)currentUser;

-(void)signUpWithCompletion:(void (^)(NSDictionary *result, NSError *error))completion;
-(void)login:(NSString*)username password:(NSString*)password completion:(void (^)(NSDictionary *result, NSError *error))completion;

@end
