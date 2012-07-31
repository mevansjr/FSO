//
//  MenuViewController.h
//  Tab'd
//
//  Created by Mark Evans on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *myTableView;
    NSMutableArray *titles;
    NSMutableArray *rows1;
    NSMutableArray *rows2;
}
- (void)passTitle:(NSString*)theTitle;
@property (nonatomic, retain) NSMutableArray *titles;
@property (nonatomic, retain) NSMutableArray *rows1;
@property (nonatomic, retain) NSMutableArray *rows2;

@end