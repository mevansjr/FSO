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
    
    /* 1. Created a new Empty Application Project. */
    NSLog(@"QUESTION 1. Empty Application was created.");
    /* 2. Create a variable using the float data type. Cast the float to an int and using NSLog, output both the initial float value as well as the int value. */
    
    float speed = 4.23;
    float intSpeed = (int)4.23;
    NSLog(@"QUESTION 2a. I can run %.2f seconds in 40 yards!", speed);
    NSLog(@"QUESTION 2b. I can run %.0f seconds in 40 yards!", intSpeed);
    
    /* 3. Perform an AND, OR comparison. Use float, int and bool types */
    
    float mark = 67.7;
    int jon = 73;
    if ((mark > 70) && (jon < 72)) {
        NSLog(@"QUESTION 3a. Mark is %.1f inches, Jon= %d inches, Mark is taller than Jon!", mark, jon);
    } else if ((mark < 68) || (jon > 71)) {
        NSLog(@"QUESTION 3a. Jon is %d inches, Mark= %.1f inches, Jon is taller than Mark!", jon, mark);
    }
    
    BOOL isNotAtleastFiveFeet = !((mark >= 60) && (jon >= 60));
    if (isNotAtleastFiveFeet) {
        NSLog(@"QUESTION 3b. Mark and Jon are NOT five feet tall.");
    } else {
        NSLog(@"QUESTION 3b. Mark and Jon are taller than five feet.");
    }
    
    /* 4. Use an if, else if and else check using any of the data types of your choice. */
    
    if (mark >= 61) {
        NSLog(@"QUESTION 4. Mark is taller than five feet!");
    } else if (mark == 60) {
        NSLog(@"QUESTION 4. Mark is exactly five feet tall!");
    } else {
        NSLog(@"QUESTION 4. Mark is under five feet tall!");
    }
    
    /* 5. Perform a single for loop printing out values to the console */
    
    NSLog(@"QUESTION 5. START OF FOR LOOP");
    for (int i = 1; i < 11; i++) {
        NSLog(@".. %d-feet!..", i);
    }
    NSLog(@"I'm done counting. Fee-Fye-Foe-Fum.");
    NSLog(@"END OF LOOP");
    
    /* 6. Perform a nested loop printing out values to the console */
    
    NSLog(@"QUESTION 6. START OF NESTED LOOP");
    int m;
    int n;
    for (n = 1; n < 6; n++)
    {
        NSLog( @"Set >%d. Our Father prayer...", n);
        for (m = 1; m < 11; m++)
        {
            NSLog ( @".. >%d. Hail Mary prayer...", m);
        }
    }
    NSLog(@"END OF LOOP");
    
    /* 7. Perform a while loop that increments an int variable and outputs to the console. */ 
    
    NSLog(@"QUESTION 7. START OF WHILE LOOP");
    int thisNumber = 5;
    int x = 0;
    while (x < 50) {
        NSLog(@"..Number= %d. Every five, blah..", x);
        x+= thisNumber;
    }
    NSLog(@"I'm done incrementing by %d.", thisNumber);
    NSLog(@"END OF LOOP");
    
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
