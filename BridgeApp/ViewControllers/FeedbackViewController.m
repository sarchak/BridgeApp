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
@property (strong, nonatomic) Job *job;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Bridge";
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backPressed)];
    
    if (self.job.rating && self.job.rating != (NSNumber *)[NSNull null]) {
        self.starView = [RateView rateViewWithRating:[self.job.rating floatValue]];
    } else {
        self.starView = [RateView rateViewWithRating:0.0f];
    }
    self.starView.canRate = YES;
    self.starView.starNormalColor = [UIColor grayColor];
    self.starView.starBorderColor = [UIColor blackColor];
    self.starView.starFillColor = [UIColor yellowColor];

    [self.containerView addSubview:self.starView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    tap.numberOfTapsRequired = 1;
    self.starView.userInteractionEnabled = YES; //if you want touch on your image you'll need this
    [self.starView addGestureRecognizer:tap];
}

-(FeedbackViewController *)initWithJob:(Job*)job {
    self.job = job;
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) backPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) onTap {
    self.job.reviewed = true;
    long roundedVal = lroundf(self.starView.rating);
    
    self.job.rating = [NSNumber numberWithLong:roundedVal];
    
    [self.job saveWithCompletion:^(NSError *error) {
        [self backPressed];
    }];
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
