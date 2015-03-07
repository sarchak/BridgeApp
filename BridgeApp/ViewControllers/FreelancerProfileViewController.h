//
//  FreelancerProfileViewController.h
//  BridgeApp
//
//  Created by David Tong on 3/6/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface FreelancerProfileViewController : UIViewController

- (FreelancerProfileViewController *)initWithUser: (User*)user;

@end
