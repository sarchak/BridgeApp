//
//  ChatMessage.h
//  BridgeApp
//
//  Created by Shrikar Archak on 3/11/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSQMessage.h"
#import "Parse/Parse.h"

@interface ChatMessage : JSQMessage
@property (nonatomic, strong) NSString* threadId;

+(ChatMessage*) initWithDictionary: (NSDictionary*) dictionary;
+(void) getAllMessages:(NSString*) threadId laterThan:(NSDate*) date completion:(void(^)(NSArray *messages, NSError *error)) completion;
-(PFObject*) convertToPFObject;
-(void) saveWithCompletion: (void (^)(ChatMessage *message, NSError *error))completion;
@end
