//
//  RootViewController.h
//
//  Created by Mark Evans on 5/2/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UITextFieldDelegate> 
{
    IBOutlet UITextField *userName;
}

-(IBAction)onClick:(id)sender;

@end
