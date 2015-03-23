//
//  BusinessProfileViewController.h
//  BridgeApp
//
//  Created by Shrikar Archak on 3/17/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "BusinessCell.h"
@interface BusinessProfileViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) User *user;
@property (assign, nonatomic) BOOL fromTabbar;
@end
