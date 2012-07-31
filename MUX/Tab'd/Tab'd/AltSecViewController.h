//
//  AltSecViewController.h
//  Tab'd
//
//  Created by Mark Evans on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AltSecViewController : UIViewController
{
    IBOutlet UIButton *currTab;
    IBOutlet UIButton *tabHistory;
}
-(IBAction)onClickCurrTab:(id)sender;
-(IBAction)onClickTabHistory:(id)sender;
-(IBAction)onClickAdd:(id)sender;

@end