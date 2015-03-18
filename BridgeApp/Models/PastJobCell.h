//
//  PastJobCell.h
//  BridgeApp
//
//  Created by David Tong on 3/17/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Job.h"

@interface PastJobCell : UITableViewCell

@property (strong, nonatomic) Job* job;
@property (weak, nonatomic) IBOutlet UILabel *jobTitleLabel;

@end
