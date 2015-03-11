//
//  ChatMessage.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/11/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "ChatMessage.h"
#import "ParseClient.h"

@implementation ChatMessage

+(ChatMessage*) initWithDictionary: (NSDictionary*) dictionary {
    ChatMessage *message = [[ChatMessage alloc] initWithSenderId:dictionary[@"senderId"] senderDisplayName:dictionary[@"senderDisplayName"] date:dictionary[@"sentAt"] text:dictionary[@"text"]];
    message.threadId = dictionary[@"threadId"];

    return message;
}

-(PFObject*) convertToPFObject {
    PFObject *pfObject = [[PFObject alloc] initWithClassName:@"ChatMessages"];
    pfObject[@"threadId"] = self.threadId;
    pfObject[@"senderId"] = self.senderId;
    pfObject[@"text"] = self.text;
    pfObject[@"senderDisplayName"] = self.senderDisplayName;
    pfObject[@"sentAt"] = self.date;
    return pfObject;
}


-(void) saveWithCompletion: (void (^)(ChatMessage *message, NSError *error))completion{
    PFObject *object = [self convertToPFObject];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSDictionary *dict = [[ParseClient sharedInstance] convertPFObjectToNSDictionary:object];
        ChatMessage *message = [ChatMessage initWithDictionary:dict];
        NSLog(@"Chat message in save with completion %@", message);
        completion(message, error);
    }];
}

+(void) getAllMessages:(NSString*) threadId completion:(void(^)(NSArray *messages, NSError *error)) completion{
    if(threadId != nil){
        PFQuery *query = [PFQuery queryWithClassName:@"ChatMessages"];
        [query whereKey:@"threadId" equalTo:threadId];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSMutableArray *array = [NSMutableArray array];
            for(PFObject *obj in objects){
                NSDictionary *dict = [[ParseClient sharedInstance] convertPFObjectToNSDictionary:obj];
                ChatMessage *message = [ChatMessage initWithDictionary:dict];
                [array addObject:message];
            }
            completion(array, error);
        }];
    }
    completion(nil,nil);
}
@end
