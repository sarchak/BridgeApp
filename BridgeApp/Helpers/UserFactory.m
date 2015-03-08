//
//  UserFactory.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "UserFactory.h"
#import "Constants.h"

@implementation UserFactory


+(User*) getFreelancer {
    User *user = [[User alloc] init];
    user.username = @"DevGuy";
    user.password = @"Something";
    user.usertype = UserTypeFreelancer;
    
    user.dictionary = @{@"username": user.username,@"password": user.password, @"usertype": [NSNumber numberWithInt:user.usertype]};
    return user;
}

+(PFUser*) getFreeLancerAsPFUser {
    PFUser *user = [PFUser user];
    user[USERNAME] = @"DevGuy";
    user[PASSWORD] = @"Something";
    user[USERTYPE] = [NSNumber numberWithInt:UserTypeFreelancer];
    return user;
}


+(User*) getBusiness {
    User *user = [[User alloc] init];
    user.username = @"Philz Coffee";
    user.password = @"Something";
    user.usertype = UserTypeBusiness;
    user.dictionary = @{@"username": user.username,@"password": user.password, @"usertype": [NSNumber numberWithInt:user.usertype]};
    return user;
}

+(PFUser*) getBusinessAsPFUser{
    PFUser *user = [PFUser user];
    user.username = @"philz";
    user.password = @"coffee";
    user[BUSINESSNAME] = @"Philz Coffee";
    user[USERTYPE] = [NSNumber numberWithInt:UserTypeBusiness];
    
    return user;
}


+(User*) getUser:(NSDictionary *)dictionary{

    User *user = [[User alloc] init];
    user.dictionary = dictionary;
    user.username = dictionary[USERNAME];
    user.password = dictionary[PASSWORD];
    user.usertype = [[dictionary objectForKey:USERTYPE] boolValue];
    return user;
}

@end
