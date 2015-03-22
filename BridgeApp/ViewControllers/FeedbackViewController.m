//
//  FeedbackViewController.m
//  BridgeApp
//
//  Created by David Tong on 3/21/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "FeedbackViewController.h"
#import <RateView/RateView.h>

@interface FeedbackViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) RateView* starView;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Bridge";
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backPressed)];
    
    // Do any additional setup after loading the view from its nib.
    self.starView = [RateView rateViewWithRating:5.0f];
    self.starView.canRate = YES;
    self.starView.starNormalColor = [UIColor grayColor];
    self.starView.starBorderColor = [UIColor blackColor];
    self.starView.starFillColor = [UIColor yellowColor];

    [self.containerView addSubview:self.starView];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) backPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
