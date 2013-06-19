//
//  LeaderBoardViewController.h
//  game
//
//  Created by Mark Evans on 3/27/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <AudioToolbox/AudioToolbox.h>

@interface LeaderBoardViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate, UINavigationBarDelegate>
{
    SystemSoundID end;
    IBOutlet UINavigationItem *navItem;
    IBOutlet UINavigationBar *thenavbar;
    IBOutlet UIButton *gameButton;
    IBOutlet UILabel *showScore;
    IBOutlet UIButton *closebtn;
    IBOutlet UIBarButtonItem *logButton;
    IBOutlet UITableView *scoresTable;
    UIActionSheet *popquery;
    NSString *passStr;
    NSArray *scoresArray;
    UIView *refreshHeaderView;
    UILabel *refreshLabel;
    UIImageView *refreshArrow;
    UIActivityIndicatorView *refreshSpinner;
    BOOL isDragging;
    BOOL isLoading;
    NSString *textPull;
    NSString *textRelease;
    NSString *textLoading;
    IBOutlet UIView *headerview;
}
- (void)setupStrings;
- (void)addPullToRefreshHeader;
- (void)startLoading;
- (void)stopLoading;
- (void)refresh;
@property (nonatomic, retain) UIView *refreshHeaderView;
@property (nonatomic, retain) UILabel *refreshLabel;
@property (nonatomic, retain) UIImageView *refreshArrow;
@property (nonatomic, retain) UIActivityIndicatorView *refreshSpinner;
@property (nonatomic, copy) NSString *textPull;
@property (nonatomic, copy) NSString *textRelease;
@property (nonatomic, copy) NSString *textLoading;
@property (strong, nonatomic) UITableView *scoresTable;
@end