//
//  Message.h
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "DBModel.h"

@interface Message : DBModel

@property (nonatomic, strong) NSString* threadId;
@property (nonatomic, strong) NSString* senderId;
@property (nonatomic, strong) NSString* message;

+(NSString*)tableName;
+(NSArray*) includeKeys;

@end
