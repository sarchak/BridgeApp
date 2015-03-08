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

+(User*) getFreeLancer;
+(User*) getBusiness;
+(id) getUser:(NSDictionary *)dictionary;


+(PFUser*) getFreeLancerAsPFUser;
+(PFUser*) getBusinessAsPFUser;

@end
