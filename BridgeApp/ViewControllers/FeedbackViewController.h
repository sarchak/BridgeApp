//
//  FeedbackViewController.h
//  BridgeApp
//
//  Created by David Tong on 3/21/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Job.h"

@interface FeedbackViewController : UIViewController

-(FeedbackViewController *)initWithJob:(Job*)job;

@end
