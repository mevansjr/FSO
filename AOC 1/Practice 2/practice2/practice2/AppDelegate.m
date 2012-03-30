//
//  AppDelegate.m
//  practice2
//
//  Created by Mark Evans on 3/30/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    /*
    1. Create a new empty project.
    2. Within the didFinishLaunchingWithOptions function, create a simple if, else if check using a bool variable that you create yourself.
    3. Within the first if, print something to NSLog when the condition is true
    4. Within the if-else check, print to NSLog when that condition is hit.
    */
    
    int temp = 93;
    BOOL isCanceled = NO;
    
    if (((temp > 90) && (temp < 102)) && (!(isCanceled))) /* Using BOOL, AND, and OR */
    {
        NSLog(@"Coach: The temperature outside is %d degrees, It's a hot day for football!", temp);
    }
    else if ((temp <= 32) || (isCanceled)) 
    {
        NSLog(@"Coach: The temperature outside is %d degrees, It's like playing on ice, the ground is frozen! The event is canceled.", temp);
    }
    else {
        NSLog(@"Coach: The temperature outside is %d degrees, It's some great football weather!", temp);
    }
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
