//
//  AppDelegate.h
//  Tab'd
//
//  Created by Mark Evans on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAnnotation.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    MyAnnotation *loc;
    MyAnnotation *loc2;
    MyAnnotation *loc3;
    MyAnnotation *loc4;
    MyAnnotation *loc5;
    MyAnnotation *loc6;
    MyAnnotation *loc7;
    MyAnnotation *loc8;
    MyAnnotation *loc9;
    MyAnnotation *loc10;
    BOOL *isLoggedIn;
    NSMutableArray *usernames;
}
@property (nonatomic,retain) NSMutableArray *usernames;
@property BOOL *isLoggedIn;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (nonatomic, retain) NSMutableArray *Array;
@property (nonatomic, retain) NSString *savedTitle;
@property (nonatomic,retain) MyAnnotation *loc;
@property (nonatomic,retain) MyAnnotation *loc2;
@property (nonatomic,retain) MyAnnotation *loc3;
@property (nonatomic,retain) MyAnnotation *loc4;
@property (nonatomic,retain) MyAnnotation *loc5;
@property (nonatomic,retain) MyAnnotation *loc6;
@property (nonatomic,retain) MyAnnotation *loc7;
@property (nonatomic,retain) MyAnnotation *loc8;
@property (nonatomic,retain) MyAnnotation *loc9;
@property (nonatomic,retain) MyAnnotation *loc10;
-(void)showArr;

@end
