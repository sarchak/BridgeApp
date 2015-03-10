//
//  BusinessDetailViewController.h
//  BridgeApp
//
//  Created by Shrikar Archak on 3/8/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@interface BusinessDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) PFObject *job;
@end
