//
//  ViewController.h
//  Project2
//
//  Created by Mark Evans on 5/7/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UILabel *calcScreen;
    IBOutlet UISwitch* powerSwitch;
    int currentOperator;
    int currentColor;
    float currentNum;
    float result;
}

-(IBAction)onSwitch:(id)sender;
-(IBAction)onDigitClick:(id)sender;

@end
