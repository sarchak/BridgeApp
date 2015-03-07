//
//  TextViewController.h
//  BridgeApp
//
//  Created by Shrikar Archak on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "Job.h"

@interface TextViewController : UIViewController
@property (weak, nonatomic) Job *job;
@property (assign, nonatomic) BOOL isTitle;
@end
