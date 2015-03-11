//
//  ChatMessageThread.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/11/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "ChatMessageThread.h"

@implementation ChatMessageThread

+(void) createMessageThread:(NSString*)jobId businessId:(NSString*) businessId freelancerId: (NSString*) freelancerId completion:(void (^)(NSString* threadId, NSError *error))completion{
    
    PFQuery *query = [PFQuery queryWithClassName:@"ChatMessageThread"];
    [query whereKey:@"jobId" equalTo:jobId];
    [query whereKey:@"businessId" equalTo:businessId];
    [query whereKey:@"freelancerId" equalTo:freelancerId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        /* Thread already exists*/
        if(objects != nil && objects.count > 0){
            PFObject *first = objects.firstObject;
            NSLog(@"Thread already exists : %@", first.objectId);
            completion(first.objectId, nil);
        } else {
            NSLog(@"Creating new thread");
            PFObject *object = [[PFObject alloc] initWithClassName:@"ChatMessageThread"];
            object[@"businessId"] = businessId;
            object[@"freelancerId"] = freelancerId;
            object[@"jobId"] = jobId;
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if(succeeded){
                    completion(object.objectId, nil);
                } else {
                    completion(nil, error);
                }
            }];
            
        }
    }];
}
@end
