//
//  Weather.h
//  sqlite
//
//  Created by Mark Evans on 4/15/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property(assign)int tempF;
@property(assign)int tempC;
@property(assign)int day;
@property(assign)int month;
@property(assign)int year;
@property(assign)int iconID;

@end
