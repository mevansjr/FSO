//
//  ViewController.h
//
//  Created by Mark Evans on 4/23/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import <UIKit/UIKit.h>

// Important to have <UITextFieldDelegate> to return keyboard
@interface ViewController : UIViewController <UITextFieldDelegate>
{
    UITextField *myText;
    UILabel *infoLabel;
    UILabel *textStatusLabel;
}


@end
