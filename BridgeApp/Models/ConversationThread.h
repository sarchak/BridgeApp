//
//  ConversationThread.h
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "DBModel.h"

@interface ConversationThread : DBModel

@property (nonatomic, strong) NSString* jobId;
@property (nonatomic, strong) NSString* businessId;
@property (nonatomic, strong) NSString* freelancerId;

@end
