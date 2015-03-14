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
#import "QueryFilter.h"

@interface Job ()

@property (nonatomic, strong) NSMutableArray* applicantsArray; // Array of User objects
@property (nonatomic, strong) NSMutableArray* applicantsPFUsers; // Array of PFUser objects

@property (nonatomic, strong) NSMutableArray* attachmentsArray; // Array of Asset objects
@property (nonatomic, strong) NSMutableArray* attachmentsPFObjects; // Array of PFObjects

@end

@implementation Job

static dispatch_once_t _applicantsArrayOnceToken;
static dispatch_once_t _attachmentsArrayOnceToken;


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
    
    self.applicantsArray = nil;
    self.applicantsPFUsers = nil;
    _applicantsArrayOnceToken = 0;
    if(dict[@"applicants"] != nil && ![dict[@"applicants"] isEqual:[NSNull null]]){
        for (PFObject* pfObject in dict[@"applicants"]) {
            User* user = [[User alloc] initWithDictionary:[p convertPFObjectToNSDictionary:pfObject]];
            [self addApplicant:user];
        }
        
    }
    
    self.attachmentsArray = nil;
    self.attachmentsPFObjects = nil;
    _attachmentsArrayOnceToken = 0;
    if(dict[@"attachments"] != nil && ![dict[@"attachments"] isEqual:[NSNull null]]){
        for (PFObject* pfObject in dict[@"attachments"]) {
            Asset* attachment = [[Asset alloc] initWithDictionary:[p convertPFObjectToNSDictionary:pfObject]];
            [self addAttachment:attachment];
        }
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
    return [Job includeKeys];
}

+(NSArray*) includeKeys {
    return @[@"owner", @"assignedToUser", @"applicants", @"attachments"];
}

-(NSArray*)requiredFields {
    return @[
             @"title",
             @"owner"
             ];
}

-(void)addApplicant:(User*)user {
    
    if (self.applicantsArray == nil) {
//        dispatch_once(&_applicantsArrayOnceToken, ^{
            if (self.applicantsArray == nil) {
                self.applicantsArray = [[NSMutableArray alloc] init];
            }
            if (self.applicantsPFUsers == nil) {
                self.applicantsPFUsers = [[NSMutableArray alloc] init];
            }
//        });
        // @TODO this is working almost properly, but it doesn't seem to be adding the applicant to Parse
    }
    self.status = JobStatusHasApplicants;
    [self.applicantsArray addObject:user];
    [self.applicantsPFUsers addObject:user.pfObject];
}

-(NSArray*) applicants {
    // return a new array to make sure outsiders don't modify ours
    return [NSArray arrayWithArray:self.applicantsArray];
}

-(bool)hasUserApplied:(User*)user {

    for (User* userInArray in self.applicantsArray) {
        if ([user.objectId isEqual:userInArray.objectId]) {
            return true;
        }
    }
    return false;
    // won't work: return [self.applicantsArray containsObject:user];
    // because it's a different object reference
}

-(bool)isAssignedTo:(User*)user {
    if ([user.objectId isEqual:self.assignedToUser.objectId]) {
        return true;
    }
    return false;
    // won't work: return [self.applicantsArray containsObject:user];
    // because it's a different object reference
}

-(void)addAttachment:(Asset*)asset {
    if (self.attachmentsArray == nil) {
        dispatch_once(&_attachmentsArrayOnceToken, ^{
            if (self.attachmentsArray == nil) {
                self.attachmentsArray = [[NSMutableArray alloc] init];
            }
            if (self.attachmentsPFObjects == nil) {
                self.attachmentsPFObjects = [[NSMutableArray alloc] init];
            }
        });
    }
    
    [self.attachmentsArray addObject:asset];
    [self.attachmentsPFObjects addObject:asset.pfObject];
}

-(NSArray*) attachments {
    // return a new array to make sure outsiders don't modify ours
    return [NSArray arrayWithArray:self.attachmentsArray];
}

+(void)getAllOpenJobs:(void (^)(NSArray *foundObjects, NSError *error))completion {
    QueryFilter *filter = [[QueryFilter alloc] init];
    filter.operator = QueryFilterOperatorEquals;
    filter.fieldName = @"status";
    filter.value = [NSNumber numberWithInt:JobStatusPendingAssignment];
    Job* job = [[Job alloc] init];
    [job findWithCompletionFromTable:@"Jobs" filters:@[filter] sortOptions:nil completion:completion];
}

+(void)getJobWithOptions: (JobStatus) status completion: (void (^)(NSArray *foundObjects, NSError *error))completion {
    QueryFilter *filter = [[QueryFilter alloc] init];
    filter.operator = QueryFilterOperatorEquals;
    filter.fieldName = @"status";
    filter.value = [NSNumber numberWithInt:status];
    Job* job = [[Job alloc] init];
    QuerySortOption *sort = [[QuerySortOption alloc] init];
    sort.sortDirection = QuerySortDirectionDescending;
    sort.fieldNames = @"createdAt";
    [job findWithCompletionFromTable:@"Jobs" filters:@[filter] sortOptions:@[sort] completion:completion];
}

+(void)getJobAssignedToUserWithStatus:(User*) user status:(JobStatus) status completion: (void (^)(NSArray *foundObjects, NSError *error))completion {
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" equalTo:user.objectId];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        PFUser *pfuser = objects.firstObject;

        QueryFilter *filter = [[QueryFilter alloc] init];
        filter.operator = QueryFilterOperatorEquals;
        filter.fieldName = @"status";
        filter.value = [NSNumber numberWithInt:status];
        QueryFilter *userfilter = [[QueryFilter alloc] init];
        userfilter.operator = QueryFilterOperatorEquals;
        userfilter.fieldName = @"assignedToUser";
        userfilter.value = pfuser;
        
        Job* job = [[Job alloc] init];
        [job findWithCompletionFromTable:@"Jobs" filters:@[userfilter,filter] sortOptions:nil completion:completion];
    }];
}


@end
