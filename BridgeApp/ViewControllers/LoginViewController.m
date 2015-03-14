//
//  LoginViewController.m
//  BridgeApp
//
//  Created by David Tong on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "LoginViewController.h"
#import "CreateJobScene1ViewController.h"
#import "FreelancerProfileViewController.h"
#import "OpenJobsViewController.h"
#import "SignUpViewController.h"
#import "BusinessViewController.h"
#import "UserFactory.h"
#import "User.h"
#import "FBShimmeringView.h"

@interface LoginViewController ()


@end

@implementation LoginViewController
{
    UIImageView *_wallpaperView;
    FBShimmeringView *_shimmeringView;
    UIView *_contentView;
    UILabel *_logoLabel;
    
    UILabel *_valueLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor blackColor];
//    
//    _wallpaperView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    _wallpaperView.image = [UIImage imageNamed:@"Wallpaper"];
//    _wallpaperView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.view addSubview:_wallpaperView];
    
    CGRect valueFrame = self.view.bounds;
    valueFrame.size.height = valueFrame.size.height * 0.25;
    
    _valueLabel = [[UILabel alloc] initWithFrame:valueFrame];
    _valueLabel.font = [UIFont fontWithName:@"Avenir-Light" size:32.0];
    _valueLabel.textColor = [UIColor whiteColor];
    _valueLabel.textAlignment = NSTextAlignmentCenter;
    _valueLabel.numberOfLines = 0;
    _valueLabel.alpha = 0.0;
    _valueLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_valueLabel];
    
    _shimmeringView = [[FBShimmeringView alloc] init];
    _shimmeringView.shimmering = YES;
    _shimmeringView.shimmeringBeginFadeDuration = 0.2;
    _shimmeringView.shimmeringOpacity = 0.3;
    [self.view addSubview:_shimmeringView];
    
    _logoLabel = [[UILabel alloc] initWithFrame:_shimmeringView.bounds];
    _logoLabel.text = @"Bridge";
    _logoLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60.0];
    _logoLabel.textColor = [UIColor whiteColor];
    _logoLabel.textAlignment = NSTextAlignmentCenter;
    _logoLabel.backgroundColor = [UIColor clearColor];
    _shimmeringView.contentView = _logoLabel;
    

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect shimmeringFrame = self.view.bounds;
    shimmeringFrame.origin.y = 50;
    shimmeringFrame.size.height = shimmeringFrame.size.height * 0.32;
    _shimmeringView.frame = shimmeringFrame;
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




// cheat code for development
- (IBAction)businessPressed:(id)sender {
    [self goToBusinessView];
}
- (IBAction)freelancerPressed:(id)sender {
    [self goToFreelancerView];
}

- (void)goToBusinessView {
    /* Setup the business owner */
    [User login:@"philz" password:@"bridgeapp" completion:^(NSError *error) {
        NSLog(@"User logged in %@", [User currentUser].username);
        BusinessViewController *bvc = [[BusinessViewController alloc] init];
        [self.navigationController pushViewController:bvc animated:YES];
    }];

    
    
    
}

- (void)goToFreelancerView {
    [User login:@"DevGuy" password:@"Something" completion:^(NSError *error) {
        OpenJobsViewController *jvc = [[OpenJobsViewController alloc] init];
        [self.navigationController pushViewController:jvc animated:YES];
    }];
}

@end
