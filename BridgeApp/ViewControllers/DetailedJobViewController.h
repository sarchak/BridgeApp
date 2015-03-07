//
//  DetailedJobViewController.h
//  BridgeApp
//
//  Created by David Tong on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Job.h"

@interface DetailedJobViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *jobTitleLabel;

- (DetailedJobViewController *)initWithJob:(Job *)job;

@end
