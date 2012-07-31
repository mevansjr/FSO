//
//  SettingsViewController.h
//  Tab'd
//
//  Created by Mark Evans on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *myTableView;
    NSMutableArray *titles;
    NSMutableArray *rows1;
    NSMutableArray *rows2;
}
@property (nonatomic, retain) NSMutableArray *titles;
@property (nonatomic, retain) NSMutableArray *rows1;
@property (nonatomic, retain) NSMutableArray *rows2;

@end
