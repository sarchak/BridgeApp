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
    self.owner = [[User alloc] initWithDictionary:[p convertPFObjectToNSDictionary:dict[@"owner"]]];
    if(dict[@"assignedToUser"] != nil && ![dict[@"assignedToUser"] isEqual:[NSNull null]]){
        self.assignedToUser = [[User alloc] initWithDictionary:[p convertPFObjectToNSDictionary:dict[@"assignedToUser"]]];
    }
    if(dict[@"applicants"] != nil && ![dict[@"applicants"] isEqual:[NSNull null]]){
        self.applicants = [User usersWithDictionaries:[p convertPFObjectArrayToNSDictionaries:dict[@"applicants"]]];
    }
    if(dict[@"attachments"] != nil && ![dict[@"attachments"] isEqual:[NSNull null]]){
        self.attachments = [Asset assetsWithDictionaries:[p convertPFObjectArrayToNSDictionaries:dict[@"attachments"]]];
    }
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
    [dict setObject:(self.owner.pfObject ?: [NSNull null]) forKey:@"owner"];
    [dict setObject:(self.assignedToUser.pfObject ?: [NSNull null]) forKey:@"assignedToUser"];
    [dict setObject:(self.applicantsPFUsers ?: [NSNull null]) forKey:@"applicants"];
    [dict setObject:(self.attachmentsPFObjects ?: [NSNull null]) forKey:@"attachments"];

    return dict;
}

-(NSString*)tableName {
    return @"Jobs";
}

-(NSArray*) includeKeys {
    //return @[@"owner", @"assignedToUser", @"applicants", @"attachments"];
    return @[@"owner", @"assignedToUser"];
}

-(NSArray*)requiredFields {
    return @[
             @"title",
             @"owner"
             ];
}

-(void)addApplicant:(User*)user {
    if (self.applicants == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (self.applicants == nil) {
                self.applicants = [[NSMutableArray alloc] init];
            }
        });
    }
    
    [self.applicants addObject:user];
}

-(void)addAttachment:(Asset*)asset {
    if (self.attachments == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (self.attachments == nil) {
                self.attachments = [[NSMutableArray alloc] init];
            }
        });
    }
    
    [self.attachments addObject:asset];
}

@end
