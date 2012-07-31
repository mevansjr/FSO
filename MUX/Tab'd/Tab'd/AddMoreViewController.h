//
//  AddMoreViewController.h
//  Tab'd
//
//  Created by Mark Evans on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMoreViewController : UIViewController
{
    IBOutlet UITextField *firstName;
    IBOutlet UITextField *lastName;
    IBOutlet UITextField *creditNumber;
    IBOutlet UITextField *expDate;
}
- (IBAction)onClose:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)validate:(id)sender;

@end
