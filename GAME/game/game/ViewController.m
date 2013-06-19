//
//  ViewController.m
//  game
//
//  Created by Mark Evans on 3/7/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import "ViewController.h"
#import "GameViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "Reachability.h"
#import "CustomCell.h"
#import "UserProfileViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "RNBlurModalView.h"
#import "OLGhostAlertView.h"
#import "UIBorderLabel.h"
#import "LeaderBoardViewController.h"
#import "MyLoginViewController.h"
#import "MySignUpViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize beginnerArray, intermediateArray, advancedArray, qaArray, scoresTable, textPull, textRelease, textLoading, refreshHeaderView, refreshLabel, refreshArrow, refreshSpinner;

#define REFRESH_HEADER_HEIGHT 52.0f

-(void)setupStrings
{
    textPull = @"Pull down to refresh...";
    textRelease = @"Release to refresh...";
    textLoading = @"Loading...";
}

- (void)addPullToRefreshHeader
{
    refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
    refreshHeaderView.backgroundColor = [UIColor clearColor];
    
    refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, REFRESH_HEADER_HEIGHT)];
    refreshLabel.backgroundColor = [UIColor whiteColor];
    refreshLabel.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:12];
    refreshLabel.textAlignment = NSTextAlignmentCenter;
    
    refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    refreshArrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT - 27) / 2),
                                    (floorf(REFRESH_HEADER_HEIGHT - 44) / 2),
                                    27, 44);
    
    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    refreshSpinner.hidesWhenStopped = YES;
    
    [refreshHeaderView addSubview:refreshLabel];
    [refreshHeaderView addSubview:refreshArrow];
    [refreshHeaderView addSubview:refreshSpinner];
    [scoresTable addSubview:refreshHeaderView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoading) {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            scoresTable.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            scoresTable.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (isDragging && scrollView.contentOffset.y < 0) {
        // Update the arrow direction and label
        [UIView animateWithDuration:0.25 animations:^{
            if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
                // User is scrolling above the header
                refreshLabel.text = self.textRelease;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            } else {
                // User is scrolling somewhere within the header
                refreshLabel.text = self.textPull;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            }
        }];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading) return;
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
        // Released above the header
        [self startLoading];
    }
}

- (void)startLoading {
    isLoading = YES;
    
    // Show the header
    [UIView animateWithDuration:0.3 animations:^{
        scoresTable.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
        refreshLabel.text = self.textLoading;
        refreshArrow.hidden = YES;
        [refreshSpinner startAnimating];
    }];
    
    // Refresh action!
    [self refresh];
}

- (void)stopLoading {
    isLoading = NO;
    
    // Hide the header
    [UIView animateWithDuration:0.3 animations:^{
        scoresTable.contentInset = UIEdgeInsetsZero;
        [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    }
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(stopLoadingComplete)];
                     }];
}

- (void)stopLoadingComplete {
    // Reset the header
    refreshLabel.text = self.textPull;
    refreshArrow.hidden = NO;
    [refreshSpinner stopAnimating];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setupStrings];
    [self setTitle:@"Game"];
    scoresArray = [[NSArray alloc]init];
    if(![self connected])
    {
        NSLog(@"Not Connected to internet");
    } else {
        @try {
            if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]){
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"updateParent" object:nil];
                [self refresh];
                
                // The permissions requested from the user
                NSArray *permissionsArray = @[@"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
                
                // Login PFUser using Facebook
                [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
                    if (!user) {
                        if (!error) {
                            NSLog(@"Uh oh. The user cancelled the Facebook login.");
                        } else {
                            NSLog(@"Uh oh. An error occurred: %@", error);
                        }
                    } else if (user.isNew) {
                        NSLog(@"User with facebook signed up and logged in!");
                    } else {
                        NSLog(@"User with facebook logged in!");
                        
                    }
                }];
                
                AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                appDelegate.theusername = [PFUser currentUser].username;
                appDelegate.loggedinWithFacebook = @"YES";
                
                // Create request for user's Facebook data
                PF_FBRequest *request = [PF_FBRequest requestForMe];
                
                // Send request to Facebook
                [request startWithCompletionHandler:^(PF_FBRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        // result is a dictionary
                        NSDictionary *userData = (NSDictionary *)result;
                        
                        NSString *facebookID = userData[@"id"];
                        appDelegate.facebookID = facebookID;
                        
                        appDelegate.userProfile = @{
                                                    @"facebookId": facebookID,
                                                    @"name": userData[@"name"],
                                                    @"location": userData[@"location"][@"name"],
                                                    @"gender": userData[@"gender"],
                                                    @"birthday": userData[@"birthday"],
                                                    @"relationship": userData[@"relationship_status"]
                                                    };
                        NSLog(@"%@",[appDelegate.userProfile description]);
                    } else {
                        NSLog(@"ERROR: %@",[error description]);
                    }
                }];
            } else if ([PFUser currentUser]) {
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"updateParent" object:nil];
                [self refresh];
                AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                appDelegate.theusername = [PFUser currentUser].username;
                appDelegate.loggedinWithFacebook = @"NO";
            } else {
                NSLog(@"NOT LOGGED IN");
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
    }
}

-(void)refresh
{
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
    @try {
        PFQuery *query = [PFQuery queryWithClassName:@"SavedScore"];
        [query addDescendingOrder:@"score"];
        [query setLimit:10];
        scoresArray = [query findObjects];
        [scoresTable reloadData];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

-(void)intro
{
    
    //STEP 1 Construct Panels
    MYIntroductionPanel *panel = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"SampleImage1"] description:@"Welcome to MYIntroductionView, your 100 percent customizable interface for introductions and tutorials! Simply add a few classes to your project, and you are ready to go!"];
    
    //You may also add in a title for each panel
    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"SampleImage2"] title:@"Your Ticket!" description:@"MYIntroductionView is your ticket to a great tutorial or introduction!"];
    
    //STEP 2 Create IntroductionView
    
    /*A standard version*/
    //MYIntroductionView *introductionView = [[MYIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) headerImage:[UIImage imageNamed:@"SampleHeaderImage.png"] panels:@[panel, panel2]];
    
    
    /*A version with no header (ala "Path")*/
    //MYIntroductionView *introductionView = [[MYIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) panels:@[panel, panel2]];
    
    /*A more customized version*/
    MYIntroductionView *introductionView = [[MYIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) headerText:@"MYIntroductionView" panels:@[panel, panel2] languageDirection:MYLanguageDirectionLeftToRight];
    [introductionView setBackgroundImage:[UIImage imageNamed:@"SampleBackground"]];
    
    
    //Set delegate to self for callbacks (optional)
    introductionView.delegate = self;
    
    //STEP 3: Show introduction view
    [introductionView showInView:self.view];
}

#pragma mark - Sample Delegate Methods

-(void)introductionDidFinishWithType:(MYFinishType)finishType{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (finishType == MYFinishTypeSkipButton) {
        NSLog(@"Did Finish Introduction By Skipping It");
        appDelegate.introShown = @"NO";
        [defaults setObject:@"NO" forKey:@"introState"];
        [defaults synchronize];
    }
    else if (finishType == MYFinishTypeSwipeOut){
        NSLog(@"Did Finish Introduction By Swiping Out");
        appDelegate.introShown = @"NO";
        [defaults setObject:@"NO" forKey:@"introState"];
        [defaults synchronize];
    }
    
    //One might consider making the introductionview a class variable and releasing it here.
    // I didn't do this to keep things simple for the sake of example.
}

-(void)introductionDidChangeToPanel:(MYIntroductionPanel *)panel withIndex:(NSInteger)panelIndex{
    NSLog(@"%@ \nPanelIndex: %d", panel.Description, panelIndex);
}

-(IBAction)buyLevels:(id)sender
{
    OLGhostAlertView *thealert = [[OLGhostAlertView alloc]initWithTitle:@"NOT AVAILABLE" message:@"Coming Soon!" timeout:4.2 dismissible:TRUE];
    thealert.position = OLGhostAlertViewPositionCenter;
    [thealert show];
}

-(void)viewDidAppear:(BOOL)animated
{
//    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    if ([appDelegate.introShown isEqualToString:@"YES"])
//    {
//        [self intro];
//    }
    
    if(![self connected])
    {
        NSLog(@"Not Connected to internet");
        self.navigationItem.rightBarButtonItem = nil;
    } else {
        @try {
            if (![PFUser currentUser]) { // No user logged in
                // Create the log in view controller
                MyLoginViewController *logInViewController = [[MyLoginViewController alloc]init];
                //PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
                [logInViewController setDelegate:self]; // Set ourselves as the delegate
                [logInViewController setFacebookPermissions:[NSArray arrayWithObjects:@"friends_about_me", nil]];
                [logInViewController setFields: PFLogInFieldsDefault | PFLogInFieldsFacebook];
                logInViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                
                // Create the sign up view controller
                MySignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
                signUpViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                [signUpViewController setDelegate:self]; // Set ourselves as the delegate
                
                // Assign our sign up controller to be displayed from the login controller
                [logInViewController setSignUpController:signUpViewController];
                
                // Present the log in view controller
                [self presentViewController:logInViewController animated:YES completion:NULL];
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
    }
}

#pragma mark - PFSignUpViewControllerDelegate
// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
    if (error){
        NSLog(@"%@",error.description);
    }
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info
{
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || !field.length) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        RNBlurModalView *modal;
        modal = [[RNBlurModalView alloc] initWithTitle:@"Missing Information" message:@"Make sure you fill out all of the information!"];
        [modal show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error
{
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController
{
    NSLog(@"User dismissed the signUpViewController");
}

#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password
{
    // Check if both fields are completed
    if (username && password && username.length && password.length) {
        return YES; // Begin login process
    }
    
    RNBlurModalView *modal;
    modal = [[RNBlurModalView alloc] initWithTitle:@"Missing Information" message:@"Make sure you fill out all of the information!"];
    [modal show];
    
    return NO; // Interrupt login process
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    NSString *cancelTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
	if([title isEqualToString:@"Log Out"])
	{
        [self logOutButtonTapAction:nil];
    }
    else if([title isEqualToString:@"User Profile"])
	{
        UserProfileViewController *userProfile = [[UserProfileViewController alloc]initWithNibName:@"UserProfileViewController" bundle:nil];
        userProfile.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:userProfile animated:TRUE completion:nil];
    }
    else if([cancelTitle isEqualToString:@"Cancel"])
    {
        NSLog(@"Cancel button clicked.");
    }
}

#pragma mark - Logout button handler

- (IBAction)logOutButtonTapAction:(id)sender
{
    [PFUser logOut];
    [self.navigationController popViewControllerAnimated:YES];
    [self viewDidAppear:true];
}

- (IBAction)action:(id)sender
{
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        UserProfileViewController *userProfile = [[UserProfileViewController alloc]initWithNibName:@"UserProfileViewController5" bundle:nil];
        userProfile.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:userProfile animated:TRUE completion:nil];
        //this is iphone 5 xib
    } else {
        UserProfileViewController *userProfile = [[UserProfileViewController alloc]initWithNibName:@"UserProfileViewController" bundle:nil];
        userProfile.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:userProfile animated:TRUE completion:nil];
        // this is iphone 4 xib
    }
}

-(void)playend
{
    AudioServicesPlaySystemSound(end);
}

- (IBAction)startBeginner:(id)sender
{
    AppDelegate *appDelegate;
    appDelegate = [[UIApplication sharedApplication]delegate];
    appDelegate.GameType = @"beginner";
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        GameViewController *game = [[GameViewController alloc]initWithNibName:@"GameViewController5" bundle:nil];
        game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:game animated:TRUE completion:nil];
        //this is iphone 5 xib
    } else {
        GameViewController *game = [[GameViewController alloc]initWithNibName:@"GameViewController" bundle:nil];
        game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:game animated:TRUE completion:nil];
        // this is iphone 4 xib
    }
}

- (IBAction)startIntermediate:(id)sender
{
    AppDelegate *appDelegate;
    appDelegate = [[UIApplication sharedApplication]delegate];
    appDelegate.GameType = @"intermediate";
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        GameViewController *game = [[GameViewController alloc]initWithNibName:@"GameViewController5" bundle:nil];
        game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:game animated:TRUE completion:nil];
        //this is iphone 5 xib
    } else {
        GameViewController *game = [[GameViewController alloc]initWithNibName:@"GameViewController" bundle:nil];
        game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:game animated:TRUE completion:nil];
        // this is iphone 4 xib
    }
}

- (IBAction)startAdvanced:(id)sender
{
    AppDelegate *appDelegate;
    appDelegate = [[UIApplication sharedApplication]delegate];
    appDelegate.GameType = @"advanced";
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        GameViewController *game = [[GameViewController alloc]initWithNibName:@"GameViewController5" bundle:nil];
        game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:game animated:TRUE completion:nil];
        //this is iphone 5 xib
    } else {
        GameViewController *game = [[GameViewController alloc]initWithNibName:@"GameViewController" bundle:nil];
        game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:game animated:TRUE completion:nil];
        // this is iphone 4 xib
    }
}

- (IBAction)showLeaderBoard:(id)sender
{
    LeaderBoardViewController *leaderBoard = [[LeaderBoardViewController alloc]initWithNibName:@"LeaderBoardViewController" bundle:nil];
    leaderBoard.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:leaderBoard animated:TRUE completion:nil];
}

- (IBAction)showSettings:(id)sender
{
    SettingsViewController *settings = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
    settings.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:settings animated:TRUE completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate;
    appDelegate = [[UIApplication sharedApplication]delegate];
    
    [self addPullToRefreshHeader];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"end" ofType:@"mp3"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &end);
    
    UIImage *settings = [UIImage imageNamed:@"profile.png"];
    CGRect frame = CGRectMake(0, 4, settings.size.width, settings.size.height);
    UIView *settingsView = [[UIView alloc]initWithFrame:frame];
    UIButton* settingsBtn = [[UIButton alloc] initWithFrame:frame];
    [settingsBtn setBackgroundImage:settings forState:UIControlStateNormal];
    [settingsBtn setShowsTouchWhenHighlighted:YES];
    [settingsBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [settingsView addSubview:settingsBtn];
    
    UIImage *start = [UIImage imageNamed:@"settings.png"];
    CGRect startframe = CGRectMake(0, 4, start.size.width, start.size.height);
    UIView *startView = [[UIView alloc]initWithFrame:startframe];
    UIButton* startBtn = [[UIButton alloc]initWithFrame:startframe];
    [startBtn setBackgroundImage:start forState:UIControlStateNormal];
    [startBtn setShowsTouchWhenHighlighted:YES];
    [startBtn addTarget:self action:@selector(showSettings:) forControlEvents:UIControlEventTouchUpInside];
    [startView addSubview:startBtn];
    
    logButton =[[UIBarButtonItem alloc]initWithCustomView:settingsView];
    settingsButton =[[UIBarButtonItem alloc]initWithCustomView:startView];
    
    UIImage *headerImage = [UIImage imageNamed:@"logo.png"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:headerImage];
    
    self.navigationItem.leftBarButtonItem = logButton;
    self.navigationItem.rightBarButtonItem = settingsButton;
    UIImage *image = [UIImage imageNamed:@"navbg.png"];
    [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
    [[UINavigationBar appearance]setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                UITextAttributeTextColor: [UIColor whiteColor],
                          UITextAttributeTextShadowColor: [UIColor blackColor],
                         UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                     UITextAttributeFont: [UIFont fontWithName:@"MarkerFelt-Wide" size:20.0f]
     }];
    
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"shadow.png"]];
    
    NSArray *custom_path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = [custom_path objectAtIndex:0];
    NSString *filePath = [dir stringByAppendingPathComponent:@"beginnerMath.plist"];
    NSString *filePath2 = [dir stringByAppendingPathComponent:@"intermediateMath.plist"];
    NSString *filePath3 = [dir stringByAppendingPathComponent:@"advancedMath.plist"];
    
    NSError *attributesError = nil;
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&attributesError];
    NSDictionary *fileAttributes2 = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath2 error:&attributesError];
    NSDictionary *fileAttributes3 = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath3 error:&attributesError];
    NSDate *fileModificationDate = [fileAttributes objectForKey:NSFileModificationDate];
    NSDate *fileModificationDate2 = [fileAttributes2 objectForKey:NSFileModificationDate];
    NSDate *fileModificationDate3 = [fileAttributes3 objectForKey:NSFileModificationDate];
    NSLog(@"Date1 = %@, Date2 = %@, Date3 = %@",fileModificationDate, fileModificationDate2, fileModificationDate3);
    
    NSMutableDictionary *localDictionary;
    NSMutableDictionary *localDictionary2;
    NSMutableDictionary *localDictionary3;
    NSURL *remoteUrl = [NSURL URLWithString:@"http://www.markevansjr.com/download/beginnerMath.plist"];
    NSURL *remoteUrl2 = [NSURL URLWithString:@"http://www.markevansjr.com/download/intermediateMath.plist"];
    NSURL *remoteUrl3 = [NSURL URLWithString:@"http://www.markevansjr.com/download/advancedMath.plist"];
    
    NSMutableDictionary *remoteDictionary = [NSMutableDictionary dictionaryWithContentsOfURL:remoteUrl];
    if(remoteDictionary != nil) {
        [remoteDictionary writeToFile:filePath atomically:YES];
        NSLog(@"File was saved!");
        localDictionary = remoteDictionary;
    }
    else {
        localDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
        if(localDictionary == nil) localDictionary = [NSMutableDictionary dictionary];
    }
    
    NSMutableDictionary *remoteDictionary2 = [NSMutableDictionary dictionaryWithContentsOfURL:remoteUrl2];
    if(remoteDictionary2 != nil) {
        [remoteDictionary2 writeToFile:filePath2 atomically:YES];
        NSLog(@"File was saved 2!");
        localDictionary2 = remoteDictionary2;
    }
    else {
        localDictionary2 = [NSMutableDictionary dictionaryWithContentsOfFile:filePath2];
        if(localDictionary2 == nil) localDictionary2 = [NSMutableDictionary dictionary];
    }
    
    NSMutableDictionary *remoteDictionary3 = [NSMutableDictionary dictionaryWithContentsOfURL:remoteUrl3];
    if(remoteDictionary3 != nil) {
        [remoteDictionary3 writeToFile:filePath3 atomically:YES];
        NSLog(@"File was saved 3!");
        localDictionary3 = remoteDictionary3;
    }
    else {
        localDictionary3 = [NSMutableDictionary dictionaryWithContentsOfFile:filePath3];
        if(localDictionary3 == nil) localDictionary3 = [NSMutableDictionary dictionary];
    }
    
    NSString *plist_path = [dir stringByAppendingPathComponent:@"beginnerMath.plist"];
    //NSString *plist_path = [[NSBundle mainBundle] pathForResource:@"beginnerMath" ofType:@"plist"];
    NSDictionary *plistDictionary = [[NSDictionary alloc]initWithContentsOfFile:plist_path];
    if (plist_path != nil){
        beginnerArray = [plistDictionary objectForKey: @"Beginner" ];
        appDelegate.beginnerArray = [[NSMutableArray alloc]initWithArray:beginnerArray];
    }
    
    NSString *plist_path2 = [dir stringByAppendingPathComponent:@"intermediateMath.plist"];
    //NSString *plist_path2 = [[NSBundle mainBundle] pathForResource:@"intermediateMath" ofType:@"plist"];
    NSDictionary *plistDictionary2 = [[NSDictionary alloc]initWithContentsOfFile:plist_path2];
    if (plist_path2 != nil){
        intermediateArray = [plistDictionary2 objectForKey: @"Intermediate" ];
        appDelegate.intermediateArray = [[NSMutableArray alloc]initWithArray:intermediateArray];
    }
    
    NSString *plist_path3 = [dir stringByAppendingPathComponent:@"advancedMath.plist"];
    //NSString *plist_path3 = [[NSBundle mainBundle] pathForResource:@"advancedMath" ofType:@"plist"];
    NSDictionary *plistDictionary3 = [[NSDictionary alloc]initWithContentsOfFile:plist_path3];
    if (plist_path3 != nil){
        advancedArray = [plistDictionary3 objectForKey: @"Advanced" ];
        appDelegate.advancedArray = [[NSMutableArray alloc]initWithArray:advancedArray];
    }
    
    qa1 = [[NSMutableDictionary alloc]init];
    [qa1 setObject:@"14 + 27 =" forKey:@"question"];
    [qa1 setObject:@"41" forKey:@"answer"];
    
    qa2 = [[NSMutableDictionary alloc]init];
    [qa2 setObject:@"55 - 12 =" forKey:@"question"];
    [qa2 setObject:@"43" forKey:@"answer"];
    
    qa3 = [[NSMutableDictionary alloc]init];
    [qa3 setObject:@"14 x 11 =" forKey:@"question"];
    [qa3 setObject:@"154" forKey:@"answer"];
    
    qa4 = [[NSMutableDictionary alloc]init];
    [qa4 setObject:@"55 / 5 =" forKey:@"question"];
    [qa4 setObject:@"11" forKey:@"answer"];
    
    qa5 = [[NSMutableDictionary alloc]init];
    [qa5 setObject:@"(10 x 12) + 14 =" forKey:@"question"];
    [qa5 setObject:@"134" forKey:@"answer"];
    
    qa6 = [[NSMutableDictionary alloc]init];
    [qa6 setObject:@"(13 x 5) - 14 =" forKey:@"question"];
    [qa6 setObject:@"51" forKey:@"answer"];
    
    qa7 = [[NSMutableDictionary alloc]init];
    [qa7 setObject:@"789 + 44 =" forKey:@"question"];
    [qa7 setObject:@"745" forKey:@"answer"];
    
    qa8 = [[NSMutableDictionary alloc]init];
    [qa8 setObject:@"30 / 5 =" forKey:@"question"];
    [qa8 setObject:@"6" forKey:@"answer"];
    
    qa9 = [[NSMutableDictionary alloc]init];
    [qa9 setObject:@"(3 x 12) + 4 =" forKey:@"question"];
    [qa9 setObject:@"40" forKey:@"answer"];
    
    qa10 = [[NSMutableDictionary alloc]init];
    [qa10 setObject:@"(42 / 6) + 4 =" forKey:@"question"];
    [qa10 setObject:@"11" forKey:@"answer"];
    
    appDelegate.qaArray = [[NSMutableArray alloc]initWithObjects:qa1, qa2, qa3, qa4, qa5, qa6, qa7, qa8, qa9, qa10, nil];
}

-(void)viewDidUnload
{
    AudioServicesDisposeSystemSoundID(end);
}

-(IBAction)start:(id)sender
{
    GameViewController *gameView = [[GameViewController alloc]initWithNibName:@"GameViewController" bundle:nil];
    [self presentViewController:gameView animated:true completion:nil];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,30)];
    
        UIBorderLabel *headerLabel= [[UIBorderLabel alloc]initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height)];
        headerLabel.topInset = 10;
        headerLabel.leftInset = 15;
        headerLabel.bottomInset = 12;
        headerLabel.rightInset = 15;
        headerLabel.text = @"Top 10";
        headerLabel.textColor = [UIColor blackColor];
        headerLabel.shadowOffset = CGSizeMake(0, -1);
        headerLabel.shadowColor = [UIColor whiteColor];
        headerLabel.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:16];
        headerLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"headerbg.png"]];
        [headerView addSubview:headerLabel];
    
        return headerView;
    }
    
    return nil;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return scoresArray.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
    CustomCell *cell = (CustomCell *)[nib objectAtIndex:0];
    if (cell != nil)
    {
        @try {
            PFObject *obj = [scoresArray objectAtIndex:indexPath.row];
            NSString *detail = [obj objectForKey:@"playerName"];
            NSNumber *status = [obj objectForKey:@"score"];
            NSString *d = [[NSString alloc]initWithFormat:@"%d -  %@",indexPath.row+1,detail];
            
            if (detail != nil)
            {
                cell.sourceLabel.text = d;
            }
            if (status != nil)
            {
                cell.statusLabel.text = status.stringValue;
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Confirm" message:@"Do you want to share this score on your Facebook wall?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
//    [alert show];
//    PFObject *obj = [scoresArray objectAtIndex:indexPath.row];
//    NSNumber *status = [obj objectForKey:@"score"];
//    passStr = [[NSString alloc]initWithFormat:@"I scored %@, while playing GameNameGoesHere!",status.stringValue];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Yes"])
    {
         NSLog(@"%@",passStr);
        NSMutableDictionary* params = [[NSMutableDictionary alloc]initWithCapacity:1];
        [params setObject:passStr forKey:@"name"];
        [params setObject:passStr forKey:@"description"];
        if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]){
            [FBRequest requestWithGraphPath:@"me/feed" parameters:params HTTPMethod:@"POST"];
        }
    }
}

@end
