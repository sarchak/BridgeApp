//
//  UserFactory.h
//  BridgeApp
//
//  Created by Shrikar Archak on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserFactory : NSObject

+(User*) getFreelancer;
+(User*) getBusiness;
+(User*) getUser:(NSDictionary *)dictionary;
@end
