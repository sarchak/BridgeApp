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
#import "BusinessProfileViewController.h"
#import "FreelancerProfileViewController.h"
#import "ChameleonFramework/Chameleon.h"
#import "POP/POP.h"
@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *businessOwner;

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
    _valueLabel.textColor = HEADERBARCOLOR;
    _valueLabel.textAlignment = NSTextAlignmentCenter;
    _valueLabel.numberOfLines = 0;
    _valueLabel.alpha = 0.0;
    _valueLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_valueLabel];
    
    _shimmeringView = [[FBShimmeringView alloc] init];
    _shimmeringView.shimmering = YES;
    _shimmeringView.shimmeringBeginFadeDuration = 0.1;
    _shimmeringView.shimmeringOpacity = 0.1;
    [self.view addSubview:_shimmeringView];
    
    _logoLabel = [[UILabel alloc] initWithFrame:_shimmeringView.bounds];
    _logoLabel.text = @"Bridge";
    _logoLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:65.0];
    _logoLabel.textColor = HEADERBARCOLOR;
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
    POPSpringAnimation *scale =
    [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scale.toValue = [NSValue valueWithCGPoint:CGPointMake(1.5, 1.5)];
    scale.springBounciness = 15;
    scale.springSpeed = 5.0f;
    scale.velocity= [NSValue valueWithCGSize:CGSizeMake(10.f, 10.f)];
    POPSpringAnimation *scaledown =
    [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaledown.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    scaledown.springBounciness = 15;
    scaledown.springSpeed = 5.0f;
    scaledown.velocity= [NSValue valueWithCGSize:CGSizeMake(10.f, 10.f)];;
    
    [self.businessOwner pop_addAnimation:scale forKey:@"scale"];
    [scale setCompletionBlock:^(POPAnimation *anim, BOOL completed) {
        [self.businessOwner pop_removeAnimationForKey:@"scale"];
    }];
    [self.businessOwner pop_addAnimation:scaledown forKey:@"scaledown"];
    
    [User login:@"philz" password:@"bridgeapp" completion:^(NSError *error) {
        NSLog(@"User logged in %@", [User currentUser].username);
        
        BusinessProfileViewController *bpvc = [[BusinessProfileViewController alloc] init];
        bpvc.user = [User currentUser];
        bpvc.fromTabbar = YES;
        BusinessViewController *bvc = [[BusinessViewController alloc] init];
        
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:bvc];
        UITabBarController *tbc = [[UITabBarController alloc] init];
        [tbc setViewControllers:@[nvc,bpvc]];
        
        NSArray *items = tbc.tabBar.items;
        
        UITabBarItem *home = [items objectAtIndex:0];
        UITabBarItem *profile = [items objectAtIndex:1];
        
        UITabBar *tabBar = [UITabBar appearance];
        [tabBar setBarTintColor:NAVBARCOLOR];
        
        [tabBar setTintColor:HEADERBARCOLOR];
        
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           nil] forState:UIControlStateNormal];
        
        UITabBarItem *tmp = [home initWithTitle:@"Jobs" image:[UIImage imageNamed:@"jobs"] selectedImage: [UIImage imageNamed:@"jobs"]];
        
        UIImage *profileImage = [[UIImage imageNamed:@"profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        tmp = [profile initWithTitle:@"Profile" image:profileImage selectedImage: [UIImage imageNamed:@"profile"]];
        
        
        
        //        [self.navigationController pushViewController:tbc animated:YES];
        [self presentViewController:tbc animated:NO completion:nil];
        
    }];

    
    
}

- (void)goToFreelancerView {
    [User login:@"shrikar" password:@"bridgeapp" completion:^(NSError *error) {
        FreelancerProfileViewController *fpvc = [[FreelancerProfileViewController alloc] initWithUser:[User currentUser]];
        fpvc.fromTabBar = YES;
        OpenJobsViewController *jvc = [[OpenJobsViewController alloc] init];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:jvc];
        UINavigationController *nvc2 = [[UINavigationController alloc] initWithRootViewController:fpvc];
        
        UITabBarController *tbc = [[UITabBarController alloc] init];
        [tbc setViewControllers:@[nvc,nvc2]];
        
        NSArray *items = tbc.tabBar.items;
        
        UITabBarItem *home = [items objectAtIndex:0];
        UITabBarItem *profile = [items objectAtIndex:1];
        
        UITabBar *tabBar = [UITabBar appearance];
        [tabBar setBarTintColor:NAVBARCOLOR];
        [tabBar setTintColor:HEADERBARCOLOR];
    
        
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           nil] forState:UIControlStateNormal];

        home = [home initWithTitle:@"Jobs" image:[UIImage imageNamed:@"jobs"] selectedImage: [UIImage imageNamed:@"jobs"]];
        
        profile = [profile initWithTitle:@"Profile" image:[UIImage imageNamed:@"profile"] selectedImage: [UIImage imageNamed:@"profile"]];

        


        
        [self presentViewController:tbc animated:NO completion:nil];
    }];
}

@end
