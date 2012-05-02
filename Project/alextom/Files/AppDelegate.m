//
//  AppDelegate.m
//
//  Created by Mark Evans on 5/2/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window=_window;
@synthesize navigationController=_navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

@end
