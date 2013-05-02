//
//  FirstViewController.h
//  sqlite
//
//  Created by Mark Evans on 4/15/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface FirstViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIAlertViewDelegate>
{
    NSMutableArray *theArray;
    NSMutableArray *sourceArray;
    NSMutableArray *deleteArray;
    sqlite3 *theDB;
    NSString *dbPathString;
    NSString *sql;
    NSString *addStr;
    NSArray *resultArr;
    NSArray *resultArr2;
    NSMutableArray *currDBArr;
    NSMutableArray *currDBArr2;
    NSMutableArray *arr;
    NSTimer *timer;
    NSString *pCC;
    NSString *pCT;
    NSString *pCV;
    NSString *pRP;
    NSString *pRS;
    NSString *pDATE;
    NSString *pPARSEID;
    IBOutlet UITableView *theTableView;
    IBOutlet UISearchBar *theSearchBar;
    IBOutlet UISegmentedControl *theSegmentedControl;
}
- (void)createOrOpenDB;
@property (nonatomic, strong) UITableView *theTableView;
@property (nonatomic, strong) NSMutableArray *theArray;
@property (nonatomic, strong) NSMutableArray *sourceArray;

@end
