//
//  FirstViewController.h
//  Tab'd
//
//  Created by Mark Evans on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
{
    IBOutlet UIButton *button1;
    IBOutlet UITextField *myTextFieldUser;
    IBOutlet UITextField *myTextFieldPass;
}
-(IBAction)onClick:(id)sender;
- (IBAction)onClose:(id)sender;

@end
