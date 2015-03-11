//
//  ChatMessageThread.h
//  BridgeApp
//
//  Created by Shrikar Archak on 3/11/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

@interface ChatMessageThread : NSObject
@property (nonatomic,strong) NSString* threadId;
@property (nonatomic,strong) NSString* jobId;
@property (nonatomic,strong) NSString *businessId;
@property (nonatomic,strong) NSString *freelancerId;

+(void) createMessageThread:(NSString*)jobId businessId:(NSString*) businessId freelancerId: (NSString*) freelancerID completion:(void (^)(NSString* threadID, NSError *error))completion;
@end
