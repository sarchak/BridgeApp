//
//  MessagesViewController.h
//  BridgeApp
//
//  Created by Emrah Seker on 3/9/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "JSQMessagesViewController.h"
#import "User.h"

@interface MessagesViewController : JSQMessagesViewController
@property (nonatomic, strong) User* fromUser;
@property (nonatomic, strong) NSString* threadId;
@end
