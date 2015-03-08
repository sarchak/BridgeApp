//
//  Job.h
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "DBModel.h"
#import "User.h"
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
@property (nonatomic, strong) NSString* ownerId;
@property (nonatomic, assign) JobStatus status;
@property (nonatomic, strong) NSString* statusText;
@property (nonatomic, assign) BOOL reviewed;
@property (nonatomic, strong) NSNumber* rating;
@property (nonatomic, strong) NSString* category;
@property (nonatomic, strong) NSArray* attachmentIds;
@property (nonatomic, strong) NSMutableArray* applicantIds;
@property (nonatomic, assign) NSUInteger numberOfAssets;
@property (nonatomic, strong) User *owner;

@end
