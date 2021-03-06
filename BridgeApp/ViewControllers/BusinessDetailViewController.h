//
//  BusinessDetailViewController.h
//  BridgeApp
//
//  Created by Shrikar Archak on 3/8/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Job.h"
#import "BusinessCell.h"
#import "ApplicantCell.h"


@interface BusinessDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate, BusinessCellDelegate, ApplicantCellDelegate>
@property (strong, nonatomic) Job *job;
@end
