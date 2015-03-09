//
//  ConversationThread.m
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "ConversationThread.h"
#import "ParseClient.h"

@implementation ConversationThread

-(ConversationThread*)initWithDictionary:(NSDictionary*)dict {
    
    self = [super init];
    
    if (self) {
        [self updateWithDictionary:dict];
    }
    
    return self;
}

-(void)updateWithDictionary:(NSDictionary*) dict {
    [super updateWithDictionary:dict];
    
    self.jobId = dict[@"jobId"];
    self.businessId = dict[@"businessId"];
    self.freelancerId = dict[@"freelancerId"];
    
}

-(NSMutableDictionary*)toDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:(self.jobId ?: [NSNull null]) forKey:@"jobId"];
    [dict setObject:(self.businessId ?: [NSNull null]) forKey:@"businessId"];
    [dict setObject:(self.freelancerId ?: [NSNull null]) forKey:@"freelancerId"];
    
    return dict;
}

-(NSString*)tableName {
    return [ConversationThread tableName];
}

+(NSString*)tableName {
    return @"ConversationThread";
}

-(NSArray*) includeKeys {
    return [ConversationThread includeKeys];
}

+(NSArray*) includeKeys {
    return @[];
}

-(NSArray*)requiredFields {
    return @[
             @"jobId",
             @"businessId",
             @"freelancerId"
             ];
}

static ConversationThread *_thread = nil;

- (ConversationThread *)getConversationByJobId:(NSString *)jobId completion:(void (^)(NSError *error))completion {
    ParseClient *p = [ParseClient sharedInstance];
    
    [p readById:[self tableName] objectId:jobId completion:^(NSDictionary *result, NSError *error) {
        
        _thread = [[ConversationThread alloc] initWithDictionary:result];
    }];
    
    return _thread;
}


@end
