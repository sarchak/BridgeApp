//
//  Message.m
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "Message.h"
#import "User.h"
#import <JSQMessagesViewController/JSQMessages.h>

@interface Message ()  <JSQMessageData>

@end

@implementation Message

-(Message*)initWithDictionary:(NSDictionary*)dict {
    
    self = [super init];
    
    if (self) {
        [self updateWithDictionary:dict];
    }
    
    return self;
}

-(void)updateWithDictionary:(NSDictionary*) dict {
    [super updateWithDictionary:dict];
    
    self.threadId = dict[@"threadId"];
    self.senderId = dict[@"senderId"];
    self.message = dict[@"message"];
    
}

-(NSMutableDictionary*)toDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:(self.threadId ?: [NSNull null]) forKey:@"threadId"];
    [dict setObject:(self.senderId ?: [NSNull null]) forKey:@"senderId"];
    [dict setObject:(self.message ?: [NSNull null]) forKey:@"message"];
    
    return dict;
}

-(NSString*)tableName {
    return [Message tableName];
}

+(NSString*)tableName {
    return @"Message";
}

-(NSArray*) includeKeys {
    return [Message includeKeys];
}

+(NSArray*) includeKeys {
    return @[];
}

-(NSArray*)requiredFields {
    return @[
             @"threadId",
             @"senderId",
             @"message"
             ];
}



/**
 *  @return A string identifier that uniquely identifies the user who sent the message.
 *
 *  @discussion If you need to generate a unique identifier, consider using
 *  `[[NSProcessInfo processInfo] globallyUniqueString]`
 *
 *  @warning You must not return `nil` from this method. This value must be unique.
 */
//- (NSString *)senderId;

/**
 *  @return The display name for the user who sent the message.
 *
 *  @warning You must not return `nil` from this method.
 */
- (NSString *)senderDisplayName {
    return @"emrah";
}

/**
 *  @return The date that the message was sent.
 *
 *  @warning You must not return `nil` from this method.
 */
- (NSDate *)date {
    return [NSDate date];
}

/**
 *  This method is used to determine if the message data item contains text or media.
 *  If this method returns `YES`, an instance of `JSQMessagesViewController` will ignore
 *  the `text` method of this protocol when dequeuing a `JSQMessagesCollectionViewCell`
 *  and only call the `media` method.
 *
 *  Similarly, if this method returns `NO` then the `media` method will be ignored and
 *  and only the `text` method will be called.
 *
 *  @return A boolean value specifying whether or not this is a media message or a text message.
 *  Return `YES` if this item is a media message, and `NO` if it is a text message.
 */
- (BOOL)isMediaMessage {
    return NO;
}

/**
 *  @return An integer that can be used as a table address in a hash table structure.
 */
- (NSUInteger)hash {
    return 0;
}


@end
