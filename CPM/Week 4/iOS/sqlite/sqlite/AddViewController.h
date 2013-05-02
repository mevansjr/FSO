//
//  AddViewController.h
//  MdTA
//
//  Created by Mark Evans on 4/23/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface AddViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>
{
    sqlite3 *theDB;
    NSString *dbPathString;
    NSString *pCC;
    NSString *pCT;
    NSString *pCV;
    NSString *pRP;
    NSString *pRS;
    NSString *pDATE;
    NSString *pPARSEID;
    IBOutlet UITextField *cc;
    IBOutlet UITextField *ct;
    IBOutlet UITextField *cv;
    IBOutlet UITextField *rp;
    IBOutlet UITextField *rs;
    IBOutlet UITextField *installdate;
    IBOutlet UIButton *submitBtn;
}
@property (strong, nonatomic) NSString *ccStr;
@property (strong, nonatomic) NSString *ctStr;
@property (strong, nonatomic) NSString *cvStr;
@property (strong, nonatomic) NSString *rpStr;
@property (strong, nonatomic) NSString *rsStr;
@property (strong, nonatomic) NSString *installdateStr;

@end
