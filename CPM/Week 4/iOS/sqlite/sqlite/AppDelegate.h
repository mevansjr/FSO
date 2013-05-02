//
//  AppDelegate.h
//  sqlite
//
//  Created by Mark Evans on 4/15/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *dbpath;

@property (strong, nonatomic) NSString *passCall;

@property (strong, nonatomic) NSString *passParseId;

@property (strong, nonatomic) NSString *deleteFlag;

@property (strong, nonatomic) NSDate *lastOpen;

@end
