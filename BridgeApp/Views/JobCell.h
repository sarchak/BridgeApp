//
//  JobCell.h
//  BridgeApp
//
//  Created by David Tong on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Job.h"

@interface JobCell : UITableViewCell

@property (nonatomic, strong) Job * job;
@property (weak, nonatomic) IBOutlet UILabel *jobTitle;
@property (weak, nonatomic) IBOutlet UILabel *jobSummary;
@property (weak, nonatomic) IBOutlet UILabel *jobPrice;

@end
