//
//  ViewController.h
// 
//
//  Created by Mark Evans on 4/10/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{

}

-(bool)compareNum:(NSInteger)compIntOne compIntTwo:(NSInteger)compIntTwo;

-(NSInteger)addNum:(NSInteger)firstInt secondInt:(NSInteger)secondInt;

-(NSMutableString*)appendString:(NSString*)appendStringOne appendStringTwo:(NSString*)appendStringTwo;

-(void) displayAlertWithNSNumber:(NSNumber*)numberVar;


@end
