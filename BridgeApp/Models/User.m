//
//  User.m
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "User.h"
#import "UserFactory.h"

@implementation User

//-(User*)currentUser {
//    
//    //TODO(emrahs): return current user
//    
//    return nil;
//}

-(void)signUpWithCompletion:(void (^)(NSDictionary *result, NSError *error))completion {
    //TODO(emrahs): Saving user first time happens here.
}

-(void)login:(NSString*)username password:(NSString*)password completion:(void (^)(NSDictionary *result, NSError *error))completion {
    //TODO(emrahs): Just calling ParseClient should be enough
}

static User *_currentUser = nil;
NSString * const kCurrentUser = @"kCurrentUser";

+(User*) currentUser {
    if(_currentUser == nil){
        NSData *data =  [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUser];
        if(data != nil){
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            _currentUser = [UserFactory getUser:dictionary];
        }
    }
    return _currentUser;
}

+(void) setCurrentUser:(User *)currentUser {
    _currentUser = currentUser;
    if(_currentUser != nil){
        NSData *data = [NSJSONSerialization dataWithJSONObject:currentUser.dictionary options:0 error:NULL];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUser];
        [[NSUserDefaults standardUserDefaults] synchronize];        
    }
}

@end
