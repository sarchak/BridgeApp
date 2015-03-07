//
//  DetailedJobViewController.m
//  BridgeApp
//
//  Created by David Tong on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "DetailedJobViewController.h"

@interface DetailedJobViewController ()

@property (strong, nonatomic) Job* job;

@end

@implementation DetailedJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.jobTitleLabel.text = self.job.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (DetailedJobViewController *)initWithJob:(Job *)job {
    self.job = job;
    return self;
}

@end
