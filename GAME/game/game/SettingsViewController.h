//
//  SettingsViewController.h
//  game
//
//  Created by Mark Evans on 4/11/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCSwitchOnOff.h"

@interface SettingsViewController : UIViewController <UINavigationBarDelegate, UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UINavigationBar *thenavbar;
    IBOutlet UINavigationItem *navItem;
    IBOutlet UITableView *theTableView;
    IBOutlet UIButton *closebtn;
    RCSwitchOnOff* switchView;
    NSString *name;
    NSArray *profileSettings;
    NSArray *helpSettings;
    NSArray *audioSettings;
}

@end
