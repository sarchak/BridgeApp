//
//  Job.m
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "Job.h"
#import "ParseClient.h"
#import "Asset.h"

@implementation Job

-(Job*)initWithDictionary:(NSDictionary*)dict {
    
    self = [super init];
    
    if (self) {
        [self updateWithDictionary:dict];        
    }
    
    return self;
}

-(void)updateWithDictionary:(NSDictionary*) dict {
    [super updateWithDictionary:dict];
    
    self.title = dict[@"title"];
    self.jobDescription = dict[@"jobDescription"];
    self.dueDate = dict[@"dueDate"];
    self.price = dict[@"price"];
    self.statusText = dict[@"statusText"];
    self.rating = dict[@"rating"];
    self.category = dict[@"category"];
    self.status = [dict[@"status"] integerValue];
    self.reviewed = [dict[@"reviewed"] boolValue];
    
    // Relations
    ParseClient *p = [ParseClient sharedInstance];
    self.ownerPFUser = dict[@"ownerPFUser"];
    self.owner = [[User alloc] initWithDictionary:[p convertPFObjectToNSDictionary:self.ownerPFUser]];
    
    self.assignedToUserPFUser = dict[@"assignedToUserPFUser"];
    self.assignedToUser = [[User alloc] initWithDictionary:[p convertPFObjectToNSDictionary:self.assignedToUserPFUser]];
    
    self.applicantsPFUsers = dict[@"applicantsPFUsers"];
    self.applicants = [User usersWithDictionaries:[p convertPFObjectArrayToNSDictionary:self.applicants]];
    
    self.attachmentsPFObjects = dict[@"attachmentsPFObjects"];
    self.attachments = [Asset assetsWithDictionaries:[p convertPFObjectArrayToNSDictionary:self.attachmentsPFObjects]];
    
}

-(NSMutableDictionary*)toDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:(self.title ?: [NSNull null]) forKey:@"title"];
    [dict setObject:(self.jobDescription ?: [NSNull null]) forKey:@"jobDescription"];
    [dict setObject:(self.dueDate ?: [NSNull null]) forKey:@"dueDate"];
    [dict setObject:(self.price ?: [NSNull null]) forKey:@"price"];
    [dict setObject:(self.statusText ?: [NSNull null]) forKey:@"statusText"];
    [dict setObject:(self.rating ?: [NSNull null]) forKey:@"rating"];
    [dict setObject:(self.category ?: [NSNull null]) forKey:@"category"];
    [dict setObject:@(self.status) forKey:@"status"];
    [dict setObject:@(self.reviewed) forKey:@"reviewed"];

    // Relations
    [dict setObject:(self.ownerPFUser ?: [NSNull null]) forKey:@"ownerPFUser"];
    [dict setObject:(self.assignedToUserPFUser ?: [NSNull null]) forKey:@"assignedToUserPFUser"];
    [dict setObject:(self.applicantsPFUsers ?: [NSNull null]) forKey:@"applicantsPFUsers"];
    [dict setObject:(self.attachmentsPFObjects ?: [NSNull null]) forKey:@"attachmentsPFObjects"];

    return dict;
}

-(NSString*)tableName {
    return @"Job";
}

@end
