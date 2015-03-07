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
#import "UserFactory.h"
#import "User.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

// cheat code for development
- (IBAction)businessPressed:(id)sender {

    [self goToBusinessView];
}
- (IBAction)freelancerPressed:(id)sender {
    [self goToFreelancerView];
}

- (void)goToBusinessView {
    /* Setup the business owner */
    User *user = [UserFactory getBusiness];
    [User setCurrentUser: user];
    CreateJobScene1ViewController *cvc = [[CreateJobScene1ViewController alloc] init];
    [self.navigationController pushViewController:cvc animated:YES];
    
}

- (void)goToFreelancerView {
    [User setCurrentUser:[UserFactory getFreeLancer]];
    OpenJobsViewController *jvc = [[OpenJobsViewController alloc] init];
    [self.navigationController pushViewController:jvc animated:YES];
}

@end
