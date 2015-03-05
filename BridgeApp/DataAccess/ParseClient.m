//
//  ParseClient.m
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "ParseClient.h"
#import <Parse/Parse.h>

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
            
            [Parse setApplicationId:kParseApplicationId clientKey:kParseClientKey];
            
            instance = [[ParseClient alloc] init];
        }
    });
    
    return instance;
}


-(void)signUp:(NSString*)username password:(NSString*)password completion:(void (^)(NSDictionary *result, NSError *error))completion {
    PFUser *user = [PFUser user];
    user.username = username;
    user.password = password;
    
    //TODO(emrahs): decide what to do with the e-mails
    //user.email = @"email@example.com";
    
    //TODO(emrahs): we should probably use PFUser instead of creating our own User row type
    // other fields can be set just like with PFObject
    //user[@"phone"] = @"415-392-0202";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // TODO(emrahs): Return the user object as NSDictionary and let the user start use the app
        } else {
            NSString *errorString = [error userInfo][@"error"];
            // TODO(emrahs): Return the signup error
        }
    }];
}

-(void)login:(NSString*)username password:(NSString*)password completion:(void (^)(NSDictionary *result, NSError *error))completion {
    [PFUser logInWithUsernameInBackground:username password:password
        block:^(PFUser *user, NSError *error) {
            if (user) {
                // TODO(emrahs): Do stuff after successful login.
            } else {
                // TODO(emrahs): The login failed. Check error to see why.
            }
    }];
}

-(void)read:(NSString*)fromTableName withFilter:(NSArray*)queryFilters sortOption:(QuerySortOption*)sortOption completion:(void (^)(NSArray *result, NSError *error))completion {
    PFQuery *query = [PFQuery queryWithClassName:fromTableName];
    
    //TODO(emrahs): iterate over query filters and populate where clause
    //[query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
    
    //TODO(emrahs): consume the sortOption
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            // TODO(emrahs): Return an array of dictionaries.
            
//            // The find succeeded.
//            NSLog(@"Successfully retrieved %d scores.", objects.count);
//            // Do something with the found objects
//            for (PFObject *object in objects) {
//                NSLog(@"%@", object.objectId);
//            }
        } else {
            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}
-(void)update:(NSString*)tableName withFilter:(NSArray*)queryFilters sortOption:(QuerySortOption*)sortOption completion:(void (^)(NSDictionary *result, NSError *error))completion {
    PFQuery *query = [PFQuery queryWithClassName:tableName];
    
    // TODO(emrahs): use objectId to update
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:@"xWMyZ4YEGZ" block:^(PFObject *gameScore, NSError *error) {
        
        // Now let's update it with some new data. In this case, only cheatMode and score
        // will get sent to the cloud. playerName hasn't changed.
//        gameScore[@"cheatMode"] = @YES;
//        gameScore[@"score"] = @1338;
//        [gameScore saveInBackground];
        
        //TODO(emrahs): call the completion callback when done
        
    }];
}
-(void)insert:(NSString*)tableName withFilter:(NSArray*)queryFilters sortOption:(QuerySortOption*)sortOption completion:(void (^)(NSDictionary *result, NSError *error))completion {
    PFObject *object = [PFObject objectWithClassName:tableName];
    //TODO(emrahs): Populate object from NSDictionary and handle results
    
//    gameScore[@"score"] = @1337;
//    gameScore[@"playerName"] = @"Sean Plott";
//    gameScore[@"cheatMode"] = @NO;
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
        } else {
            // There was a problem, check error.description
        }
    }];
}
-(void)remove:(NSString*)tableName withFilter:(NSArray*)queryFilters sortOption:(QuerySortOption*)sortOption completion:(void (^)(NSDictionary *result, NSError *error))completion {
//    [gameScore deleteInBackground];
    //TODO(emrahs): actually use deleteInBackgroundWithBlock or deleteInBackgroundWithTarget:selector: to call the completion callback after deleting
}

@end
