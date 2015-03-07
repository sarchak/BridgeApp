//
//  CreateJobScene2ViewController.h
//  BridgeApp
//
//  Created by Shrikar Archak on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleSubtitleCell.h"
#import "THDatePickerViewController.h"
#import "Job.h"

@interface CreateJobScene2ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, TitleSubtitleCellDelegate,THDatePickerDelegate>
@property (nonatomic, strong) Job *job;
@property (nonatomic, strong) NSString *category;
@end
