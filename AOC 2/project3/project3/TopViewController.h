//
//  TopViewController.h
//  project3
//
//  Created by Mark Evans on 5/14/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface TopViewController : UIViewController
{
    IBOutlet UITextField *textField;
    
}

@property (retain, nonatomic) IBOutlet UIButton *closeKeyBoardButton;
@property (retain, nonatomic) IBOutlet UIButton *saveDataButton;
@property (retain, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (retain, nonatomic) IBOutlet UITextField *myTextField;
@property (strong) id<testDelegate> delegate;

-(IBAction)DidSave:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;

@end
