//
//  ViewController.h
//  game
//
//  Created by Mark Evans on 3/7/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <AudioToolbox/AudioToolbox.h>
#import <iAd/iAd.h>
#import "SettingsViewController.h"
#import "MYIntroductionView.h"

@interface ViewController : UIViewController <MYIntroductionDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate, UINavigationBarDelegate>
{
    SystemSoundID end;
    IBOutlet UINavigationItem *navItem;
    IBOutlet UINavigationBar *thenavbar;
    IBOutlet UIButton *gameButton;
    IBOutlet UILabel *showScore;
    IBOutlet UIBarButtonItem *logButton;
    IBOutlet UIBarButtonItem *settingsButton;
    IBOutlet UITableView *scoresTable;
    NSString *_facebookID;
    NSMutableDictionary *qa1;
    NSMutableDictionary *qa2;
    NSMutableDictionary *qa3;
    NSMutableDictionary *qa4;
    NSMutableDictionary *qa5;
    NSMutableDictionary *qa6;
    NSMutableDictionary *qa7;
    NSMutableDictionary *qa8;
    NSMutableDictionary *qa9;
    NSMutableDictionary *qa10;
    UIActionSheet *popquery;
    NSMutableArray *qaArray;
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
    NSMutableArray *beginnerArray;
    NSMutableArray *intermediateArray;
    NSMutableArray *advancedArray;
}
-(void)playend;
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
@property (strong, nonatomic) NSMutableArray *qaArray;
@property (strong, nonatomic) NSMutableArray *beginnerArray;
@property (strong, nonatomic) NSMutableArray *intermediateArray;
@property (strong, nonatomic) NSMutableArray *advancedArray;
@property (strong, nonatomic) UITableView *scoresTable;
@end
