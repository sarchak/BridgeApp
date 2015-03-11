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

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
- (IBAction)onSubmit:(id)sender {
    if ([self.usernameTextField.text  isEqual: @"business"]) {
        [self goToBusinessView];
    } else if ([self.usernameTextField.text  isEqual: @"freelancer"]) {
        [self goToFreelancerView];
    }
}

- (IBAction)signup:(id)sender {
    SignUpViewController *svc = [[SignUpViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}

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
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:bvc];
        [self presentViewController:nvc animated:YES completion:nil];
    }];

    
    
    
}

- (void)goToFreelancerView {
    [User login:@"DevGuy" password:@"Something" completion:^(NSError *error) {
        OpenJobsViewController *jvc = [[OpenJobsViewController alloc] init];
        [self.navigationController pushViewController:jvc animated:YES];
    }];
}

@end
