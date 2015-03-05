//
//  Job.h
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "DBModel.h"


typedef enum JobStatus : NSUInteger {
    JobStatusActive,
    JobStatusAssigned,
    JobStatusCanceled,
    JobStatusCompleted,
} JobStatus;


@interface Job : DBModel

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* jobDescription; //unfortunately "description" seems to collide with another function from NSObject
@property (nonatomic, strong) NSNumber* price;
@property (nonatomic, strong) NSDate* dueDate;
@property (nonatomic, strong) NSString* ownerId;
@property (nonatomic, assign) JobStatus status;
@property (nonatomic, assign) NSUInteger numberOfAssets;

@end
