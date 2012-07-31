//
//  AppDelegate.m
//  Tab'd
//
//  Created by Mark Evans on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "TabsViewController.h"
#import "ViewController.h"
#import "ListMapViewController.h"
#import "BaseViewController.h"
#import "SettingsViewController.h"
#import "CurrentTabView.h"
#import "MoreViewController.h"

@implementation AppDelegate

@synthesize Array;
@synthesize loc, loc2, loc3, loc4, loc5, loc6, loc7, loc8, loc9, loc10, savedTitle, isLoggedIn,usernames;

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //UIViewController *viewController1 = [[CurrentTabView alloc] initWithNibName:@"CurrentTabView" bundle:nil];
    UIViewController *viewController2 = [[TabsViewController alloc] initWithNibName:@"TabsViewController" bundle:nil];
    UIViewController *viewController3 = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    UIViewController *viewController4 = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    //UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    UINavigationController *navController2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    UINavigationController *navController3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
    UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:viewController4];
    //self.tabBarController = [[UITabBarController alloc] init];
    //self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController1, navController2, navController3, nil];
    //self.window.rootViewController = self.tabBarController;
    self.tabBarController = [[BaseViewController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController2, navController4, navController3, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)showArr
{
	Array = [[NSMutableArray alloc] initWithCapacity:Array.count];
    NSLog(@"%i",Array.count);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
