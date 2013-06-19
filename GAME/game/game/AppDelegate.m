//
//  AppDelegate.m
//  game
//
//  Created by Mark Evans on 3/7/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "StartGameViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation AppDelegate
@synthesize qaArray, VersionDate_current_beginner, VersionDate_download_beginner, GameType, beginnerArray, intermediateArray, advancedArray, lastestScores, username, userProfile, PlayAudio, theusername, loggedinWithFacebook, resetImage, introShown;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *state = [defaults objectForKey:@"state"];
    NSString *resetState = [defaults objectForKey:@"resetState"];
    NSString *introState = [defaults objectForKey:@"introState"];
    NSLog(@"appDelegate state: %@",state);
    
    if (state != nil)
    {
        if ([state isEqualToString:@"YES"])
        {
            PlayAudio = @"YES";
        } else {
            PlayAudio = @"NO";
        }
    } else {
        PlayAudio = @"YES";
    }
    
    if (resetState != nil)
    {
        if ([resetState isEqualToString:@"YES"])
        {
            resetImage = @"YES";
        } else {
            resetImage = @"NO";
        }
    } else {
        resetImage = @"YES";
    }
    
    if (introState != nil)
    {
        if ([introShown isEqualToString:@"YES"])
        {
            introShown = @"YES";
        } else {
            introShown = @"NO";
        }
    } else {
        introShown = @"YES";
    }
    
    GameType = @"beginner";
    
    [Parse setApplicationId:@"TV0LogF1hor9F1qYLuebpXrg3NmKc3toqKbGCQPk" clientKey:@"ATRiIp53CNmfsSkmhy0ppudpv8jim3fkVTqQVn2C"];
    [PFFacebookUtils initializeWithApplicationId:@"125852597598422"];
    [PFTwitterUtils initializeWithConsumerKey:@"VqnvIbaP2G4tVeVwYiiEQ" consumerSecret:@"AQKlLL7vgc5Sm9JBiqaKOHk7FxqCClMnOujv5jqlAA"];

    // Set defualt ACLs
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    userProfile = [[NSDictionary alloc]init];
    
    // Override point for customization after application launch.
    //StartGameViewController *startGameViewController = [[StartGameViewController alloc] initWithNibName:@"StartGameViewController" bundle:nil];
    
    NSLog(@"Iphone %f ",[[UIScreen mainScreen] bounds].size.height);
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController5" bundle:nil];
        self.navController = [[UINavigationController alloc]initWithRootViewController:viewController];
        self.window.rootViewController = self.navController;
        [self.window makeKeyAndVisible];
        //this is iphone 5 xib
    } else {
        ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        self.navController = [[UINavigationController alloc]initWithRootViewController:viewController];
        self.window.rootViewController = self.navController;
        [self.window makeKeyAndVisible];
        // this is iphone 4 xib
    }
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

// Facebook oauth callback
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [PFFacebookUtils handleOpenURL:url];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    //[FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    //[FBSession.activeSession close];
}

@end
