//
//  StartGameViewController.m
//  game
//
//  Created by Mark Evans on 3/27/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import "StartGameViewController.h"
#import "ViewController.h"
#import "GameViewController.h"
#import "UserProfileViewController.h"

@interface StartGameViewController ()

@end

@implementation StartGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    ViewController *viewController = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    [viewController viewDidLoad];
}

- (IBAction)startBeginner:(id)sender
{
    GameViewController *game = [[GameViewController alloc]initWithNibName:@"GameViewController" bundle:nil];
    [self presentViewController:game animated:TRUE completion:nil];
}

- (IBAction)startIntermediate:(id)sender
{
    GameViewController *game = [[GameViewController alloc]initWithNibName:@"GameViewController" bundle:nil];
    [self presentViewController:game animated:TRUE completion:nil];
}

- (IBAction)startAdvanced:(id)sender
{
    GameViewController *game = [[GameViewController alloc]initWithNibName:@"GameViewController" bundle:nil];
    [self presentViewController:game animated:TRUE completion:nil];
}

- (IBAction)showLeaderBoard:(id)sender
{
    ViewController *leaderBoard = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    [self presentViewController:leaderBoard animated:TRUE completion:nil];
}

- (IBAction)action:(id)sender
{
    ViewController *viewController = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    [viewController viewWillAppear:TRUE];
    UserProfileViewController *userProfile = [[UserProfileViewController alloc]initWithNibName:@"UserProfileViewController" bundle:nil];
    [self presentViewController:userProfile animated:TRUE completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *settings = [UIImage imageNamed:@"profile.png"];
    CGRect frame = CGRectMake(0, 0, settings.size.width, settings.size.height);
    UIView *settingsView = [[UIView alloc]initWithFrame:frame];
    UIButton* settingsBtn = [[UIButton alloc] initWithFrame:frame];
    [settingsBtn setBackgroundImage:settings forState:UIControlStateNormal];
    [settingsBtn setShowsTouchWhenHighlighted:YES];
    [settingsBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [settingsView addSubview:settingsBtn];
    
    UIImage *start = [UIImage imageNamed:@"start.png"];
    CGRect startframe = CGRectMake(0, 0, start.size.width, start.size.height);
    UIView *startView = [[UIView alloc]initWithFrame:startframe];
    UIButton* startBtn = [[UIButton alloc]initWithFrame:startframe];
    [startBtn setBackgroundImage:start forState:UIControlStateNormal];
    [startBtn setShowsTouchWhenHighlighted:YES];
    [startBtn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [startView addSubview:startBtn];
    
    UIBarButtonItem *logButton =[[UIBarButtonItem alloc]initWithCustomView:settingsView];
    UIBarButtonItem *rightButton =[[UIBarButtonItem alloc]initWithCustomView:startView];
    
    UIImage *headerImage = [UIImage imageNamed:@"logo.png"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:headerImage];
    
    self.navigationItem.leftBarButtonItem = logButton;
    self.navigationItem.rightBarButtonItem = rightButton;
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
