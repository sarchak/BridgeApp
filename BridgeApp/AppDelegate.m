//
//  AppDelegate.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/4/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "AppDelegate.h"
#import "CreateJobScene1ViewController.h"
#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "User.h"
#import "NSUserDefaults+ChatSettings.h"
#import "UserFactory.h"
#import "ChameleonFramework/Chameleon.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    LoginViewController *lvc = [[LoginViewController alloc] init];

    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:lvc];
    
    [Parse setApplicationId:@"skXmwEdM7oNPNJcuvhjSyDYauwS4tEaDHHdbvJsM" clientKey: @"gQgOjJZUKz8gHQ1VpCcDigH2qJTNuQ2OBIww263x"];

//    PFUser *user = [PFUser user];
//    user.username = @"shrikar";
//    user.password = @"bridgeapp";
//    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        NSLog(@"Signup completed :%@",error);
//    }];
//    [PFUser logInWithUsernameInBackground:@"philz" password:@"bridgeapp" block:^(PFUser *user, NSError *error) {
//        NSLog(@"user :%@", user);
//        NSLog(@"error :%@", error);
//    }];
    
//    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        NSLog(@"User signedup");
//    }];
    
//    User *user = [[User alloc] init];
//    user.username = @"shrikar";
//    user.password = @"brigeapp";
//    user.usertype = UserTypeFreelancer;
//    user.summary = @"iOS Developer and a Backend Developer";
//    [user signUpWithCompletion:^(NSError *error) {
//        NSLog(@"Signed up :%@", error);
//
//    }];
    [NSUserDefaults saveIncomingAvatarSetting:YES];
    [NSUserDefaults saveOutgoingAvatarSetting:YES];

    UINavigationBar *navBar = [UINavigationBar appearance];

    [navBar setBarTintColor:[UIColor flatNavyBlueColor]];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [navBar setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UIToolbar appearance] setTranslucent:NO];
    
    
    /* Push notifications */
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    
    
    self.window.rootViewController = nvc;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[ @"global" ];
    [currentInstallation saveInBackground];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
