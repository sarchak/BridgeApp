//
//  User.m
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "User.h"

@implementation User

-(User*)currentUser {
    
    //TODO(emrahs): return current user
    
    return nil;
}

-(void)signUpWithCompletion:(void (^)(NSDictionary *result, NSError *error))completion {
    //TODO(emrahs): Saving user first time happens here.
}

-(void)login:(NSString*)username password:(NSString*)password completion:(void (^)(NSDictionary *result, NSError *error))completion {
    //TODO(emrahs): Just calling ParseClient should be enough
}

@end
