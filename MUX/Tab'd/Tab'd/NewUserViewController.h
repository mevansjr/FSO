//
//  NewUserViewController.h
//  Tab'd
//
//  Created by Mark Evans on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewUserViewController : UIViewController
{
    IBOutlet UITextField *firstName;
    IBOutlet UITextField *lastName;
    IBOutlet UITextField *pass;
    IBOutlet UITextField *passConfirm;
    IBOutlet UITextField *userName;
    IBOutlet UITextField *email;
}
- (IBAction)onClose:(id)sender;
- (IBAction)onSave:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)validate:(id)sender;

@end
