//
//  JobFactory.m
//  BridgeApp
//
//  Created by David Tong on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "JobFactory.h"
#import "UserFactory.h"

@implementation JobFactory

+(Job*) getJob1 {
    Job *job = [[Job alloc] init];
    job.title = @"Restaurant menu";
    job.jobDescription = @"I need a 3-page menu for my fast food resturant located in San Jose.";
    job.price = @199;
    job.owner = [UserFactory getUser:@{@"username": @"david at box", @"usertype": [NSNumber numberWithInt: UserTypeBusiness]}];
    
    return job;
}

+(Job*) getJob2 {
    Job *job = [[Job alloc] init];
    job.title = @"Non-profit campaign banner";
    job.jobDescription = @"We are a cancer research center. We need someone to design a banner to be used outside our office.";
    job.price = @399;
    job.owner = [UserFactory getUser:@{@"username": @"david at box", @"usertype": [NSNumber numberWithInt: UserTypeBusiness]}];
    
    return job;
}

@end
