//
//  DetailedJobViewController.h
//  BridgeApp
//
//  Created by David Tong on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Job.h"
#import "BusinessOwnerCell.h"

@interface DetailedJobViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, BusinessOwnerCellDelegate>

@property (weak, nonatomic) IBOutlet UILabel *jobTitleLabel;

- (DetailedJobViewController *)initWithJob:(Job *)job;

@end
