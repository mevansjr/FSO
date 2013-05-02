//
//  DetailsViewController.h
//  MdTA
//
//  Created by Mark Evans on 4/24/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface DetailsViewController : UIViewController
{
    sqlite3 *theDB;
    NSString *dbPathString;
    IBOutlet UILabel *cc;
    IBOutlet UILabel *ct;
    IBOutlet UILabel *cv;
    IBOutlet UILabel *rp;
    IBOutlet UILabel *rs;
    IBOutlet UILabel *installdate;
    IBOutlet UILabel *datemod;
    IBOutlet UILabel *parseId;
}
- (IBAction)close:(id)sender;
@property (strong, nonatomic) NSString *ccStr;
@property (strong, nonatomic) NSString *ctStr;
@property (strong, nonatomic) NSString *cvStr;
@property (strong, nonatomic) NSString *rpStr;
@property (strong, nonatomic) NSString *rsStr;
@property (strong, nonatomic) NSString *installdateStr;
@property (strong, nonatomic) NSString *datemodStr;
@property (strong, nonatomic) NSString *parseIdStr;

@end
