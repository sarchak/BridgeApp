//
//  Job.h
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "DBModel.h"
#import "User.h"
#import "Asset.h"
#import "Parse/Parse.h"

@class User;
typedef enum JobStatus : NSUInteger {
    JobStatusPendingAssignment,
    JobStatusActive,
    JobStatusAssigned,
    JobStatusCanceled,
    JobStatusCompleted,
} JobStatus;


@interface Job : DBModel

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* jobDescription;
@property (nonatomic, strong) NSDate* dueDate;
@property (nonatomic, strong) NSNumber* price;
@property (nonatomic, assign) JobStatus status;
@property (nonatomic, strong) NSString* statusText;
@property (nonatomic, assign) BOOL reviewed;
@property (nonatomic, strong) NSNumber* rating;
@property (nonatomic, strong) NSString* category;
@property (nonatomic, assign) NSUInteger numberOfAssets;

// Relations
@property (nonatomic, strong) User *owner;
@property (nonatomic, strong) User *assignedToUser;


-(NSArray*) applicants;
-(void)addApplicant:(User*)user;

-(NSArray*) attachments;
-(void)addAttachment:(Asset*)asset;


+(NSArray*) includeKeys;

+(void)getAllOpenJobs:(void (^)(NSArray *foundObjects, NSError *error))completion;
-(void)addApplicant:(User*)user;
-(bool)hasUserApplied:(User*)user;
@end
