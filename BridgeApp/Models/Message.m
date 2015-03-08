//
//  Message.m
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "Message.h"

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
    return @"Message";
}


@end
