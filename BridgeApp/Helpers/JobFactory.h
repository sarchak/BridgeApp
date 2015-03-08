//
//  JobFactory.h
//  BridgeApp
//
//  Created by David Tong on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Job.h"

@interface JobFactory : NSObject

+ (Job *)getJob1;
+ (Job *)getJob2;

@end
