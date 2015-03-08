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
#import "ParseUI/ParseUI.h"
#import "UserFactory.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    LoginViewController *lvc = [[LoginViewController alloc] init];

    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:lvc];
    
    [Parse setApplicationId:@"skXmwEdM7oNPNJcuvhjSyDYauwS4tEaDHHdbvJsM" clientKey: @"gQgOjJZUKz8gHQ1VpCcDigH2qJTNuQ2OBIww263x"];

//    PFUser *user = [UserFactory getBusinessAsPFUser];
//    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        NSLog(@"User signedup");
//    }];
    self.window.rootViewController = nvc;
    [self.window makeKeyAndVisible];
    return YES;
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
