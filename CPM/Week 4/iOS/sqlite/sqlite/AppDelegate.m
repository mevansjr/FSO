//
//  AppDelegate.m
//  sqlite
//
//  Created by Mark Evans on 4/15/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "FirstViewController.h"

@implementation AppDelegate
@synthesize dbpath,passCall,passParseId,deleteFlag,lastOpen;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"Vw4U41E4V8FO8JnwC1twDxAh6nnGv4Vx6GaJfr1Y"
                  clientKey:@"YTckobCQW0SxY4FI9zHb3TiSEg5f1YCcuUU3rcy7"];
    deleteFlag = @"NO";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *d_date = [defaults objectForKey:@"date"];
    
    NSString *dateMod = [NSDateFormatter localizedStringFromDate:d_date
                                                       dateStyle:NSDateFormatterMediumStyle
                                                       timeStyle:NSDateFormatterShortStyle];
    NSLog(@"appDelegate state: %@", dateMod);
    
    if (d_date != nil)
    {
        NSDate *d_date = [defaults objectForKey:@"date"];
        lastOpen =  d_date;
        
        NSString *dateMod = [NSDateFormatter localizedStringFromDate:d_date
                                                           dateStyle:NSDateFormatterMediumStyle
                                                           timeStyle:NSDateFormatterShortStyle];
        NSLog(@"Date not nil - was saved: %@", dateMod);
    } else {
        NSString *dateMod = [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSinceNow:-180]
                                                           dateStyle:NSDateFormatterMediumStyle
                                                           timeStyle:NSDateFormatterShortStyle];
        
        lastOpen = [NSDate dateWithTimeIntervalSinceNow:-180];
        NSLog(@"Date was nil - was saved: %@", dateMod);
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    UINavigationController *navBar1 = [[UINavigationController alloc]initWithRootViewController:viewController1];
    self.window.rootViewController = navBar1;
    [self.window makeKeyAndVisible];
    return YES;
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
