//
//  AppDelegate.m
//  project1
//
//  Created by Mark Evans on 3/26/12.
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

    /* (1) Created new Empty Application.  */
    
    /* The names of the players */
    NSMutableArray *playersArray = [NSMutableArray arrayWithObjects:@"Ray Rice", @"Ray Lewis", @"Anquan Boldin", @"Joe Flacco", nil];
    
    /* Ray Rice one-liner */
    NSMutableArray *rayRiceArray = [NSMutableArray arrayWithObjects:@"Yay, time to run.", nil];
    
    /* Ray Lewis one-liner */
    NSMutableArray *rayLewisArray = [NSMutableArray arrayWithObjects:@"Lets get some!", nil];
    
    /* Anquan Boldin one-liner */
    NSMutableArray *anquanBoldinArray = [NSMutableArray arrayWithObjects:@"Is it time to go home!?", nil];
    
    /* Joe Flacco one-liner */
    NSMutableArray *joeFlaccoArray = [NSMutableArray arrayWithObjects:@"I'm a Quarterback, I shouldn't have to run.", nil];
    
    /* Player 40 yard dash time */
    NSMutableArray *playerDashTimeArray = [NSMutableArray arrayWithObjects:@"4.23 seconds.", @"4.67 seconds.", @"4.77 seconds.", @"5.34 seconds.", nil];    
    
    /* (2) Cast the float to an int  */
    
    float avgSpeed = 4.75f; /* Average 40 yard dash time. */
    float minSpeed = 5.25f; /* Minimum 40 yard dash time. */
    
    /* Cast the float minSpeed to an int as newMinSpeed */
    int newMinSpeed = (int)minSpeed; 
    
    /* Output both the float and the float var that was cast to an int */
    NSLog(@"NFL recommends a speed of %d seconds minimum for WR's, RB's, and TE's, but the average speed of all players in the NFL is %.2f seconds.",  newMinSpeed, avgSpeed);
    
    
    
    /* (3)(4) Use an if, else if and else */
    int temp = 93;
    BOOL isCanceled = false;

    if (((temp > 90) && (temp < 102)) && (!(isCanceled))) /* Using BOOL, AND, and OR */
    {
        NSLog(@"Coach: The temperature outside is %d degrees, It's a hot day for football!", temp);
    }
    else if ((temp <= 32) || (isCanceled)) 
    {
        NSLog(@"Coach: The temperature outside is %d degrees, It's like playing on ice, the ground is frozen! The event is canceled", temp);
    }
    else {
        NSLog(@"Coach: The temperature outside is %d degrees, It's some great football weather!", temp);
    }
    
    /* (5)Perform a single for loop. (6)Perform a nested loop. (7)Perform a while loop. */    
    
    for (int i=0; i<1; i++) {
        int d = i + 1;
        int check = d;
        //int j = 0;
        NSLog (@"Ray Rice: %@", [rayRiceArray objectAtIndex:i]);
        NSLog (@"Ray Lewis: %@", [rayLewisArray objectAtIndex:i]);
        NSLog (@"Anquan Boldin: %@", [anquanBoldinArray objectAtIndex:i]);
        NSLog (@"Joe Flacco: %@", [joeFlaccoArray objectAtIndex:i]);
        while (check == 1) {
            NSLog (@"***PLAYERS 40 YARD DASH TIMES***");
            for (int j=0; j<4; j++) {
                NSLog (@"%@'s 40 yard dash time: %@", [playersArray objectAtIndex:j],  [playerDashTimeArray objectAtIndex:j]);
            }
            check++;
        }
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
