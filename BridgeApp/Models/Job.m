//
//  Job.m
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "Job.h"

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
    self.ownerId = dict[@"ownerId"];
    self.statusText = dict[@"statusText"];
    self.rating = dict[@"rating"];
    self.category = dict[@"category"];
    self.attachmentIds = dict[@"attachmentIds"];
    self.applicantIds = dict[@"applicantIds"];
    self.status = [dict[@"status"] integerValue];
    self.reviewed = [dict[@"reviewed"] boolValue];
    
}

-(NSMutableDictionary*)toDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:(self.title ?: [NSNull null]) forKey:@"title"];
    [dict setObject:(self.jobDescription ?: [NSNull null]) forKey:@"jobDescription"];
    [dict setObject:(self.dueDate ?: [NSNull null]) forKey:@"dueDate"];
    [dict setObject:(self.price ?: [NSNull null]) forKey:@"price"];
    [dict setObject:(self.ownerId ?: [NSNull null]) forKey:@"ownerId"];
    [dict setObject:(self.statusText ?: [NSNull null]) forKey:@"statusText"];
    [dict setObject:(self.rating ?: [NSNull null]) forKey:@"rating"];
    [dict setObject:(self.category ?: [NSNull null]) forKey:@"category"];
    [dict setObject:(self.attachmentIds ?: [NSNull null]) forKey:@"attachmentIds"];
    [dict setObject:(self.applicantIds ?: [NSNull null]) forKey:@"applicantIds"];
    [dict setObject:@(self.status) forKey:@"status"];
    [dict setObject:@(self.reviewed) forKey:@"reviewed"];
    
    return dict;
}

-(NSString*)tableName {
    return @"Job";
}

@end
