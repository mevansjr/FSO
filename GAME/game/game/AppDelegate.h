//
//  AppDelegate.h
//  game
//
//  Created by Mark Evans on 3/7/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navController;

@property (strong, nonatomic) NSMutableArray *qaArray;

@property (strong, nonatomic) NSMutableArray *beginnerArray;

@property (strong, nonatomic) NSMutableArray *intermediateArray;

@property (strong, nonatomic) NSMutableArray *advancedArray;

@property (strong, nonatomic) NSMutableArray *lastestScores;

@property (strong, nonatomic) NSDictionary *userProfile;

@property (strong, nonatomic) NSString *username;

@property (strong, nonatomic) NSString *facebookID;

@property (strong, nonatomic) NSString *loggedinWithFacebook;

@property (strong,nonatomic) NSString *PlayAudio;

@property (strong,nonatomic) NSString *GameType;

@property (strong,nonatomic) NSDate *VersionDate_current_beginner;

@property (strong,nonatomic) NSDate *VersionDate_download_beginner;

@property (strong,nonatomic) NSString *theusername;

@property (strong,nonatomic) NSString *resetImage;

@property (strong,nonatomic) NSString *introShown;

@end
