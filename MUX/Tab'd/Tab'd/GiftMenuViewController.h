//
//  GiftMenuViewController.h
//  Tab'd
//
//  Created by Mark Evans on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiftMenuViewController : UIViewController
{
    IBOutlet UITextField *ratingField;
    IBOutlet UISlider *ratingSlider;
}
- (IBAction)onClose:(id)sender;
- (IBAction)validate:(id)sender;

@end
