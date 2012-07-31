//
//  TabsViewController.m
//  Tab'd
//
//  Created by Mark Evans on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TabsViewController.h"
#import "FirstViewController.h"
#import "ViewController.h"
#import "SettingsViewController.h"
#import "SearchViewController.h"
#import "ListMapViewController.h"
#import "AddMoreViewController.h"
#import "CurrentTabView.h"
#import "AppDelegate.h"

@interface TabsViewController ()

@end

@implementation TabsViewController
@synthesize usernames;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Home";
        UIImage *headerImage = [UIImage imageNamed:@"logo_titleView.png"];
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:headerImage];
        self.tabBarItem.image = [UIImage imageNamed:@"Home"];
    }
    return self;
}

- (IBAction)onClickLoc:(id)sender
{
    ListMapViewController *showLoc = [[ListMapViewController alloc] initWithNibName:@"ListMapViewController" bundle:nil];
    [self presentModalViewController:showLoc animated:TRUE];
}

- (IBAction)onClickSearch:(id)sender
{
    SearchViewController *showSearch = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    [self presentModalViewController:showSearch animated:TRUE];
}

- (IBAction)onClickSettings:(id)sender
{
    CurrentTabView *currTab = [[CurrentTabView alloc] initWithNibName:@"CurrentTabView" bundle:nil];
    [self presentModalViewController:currTab animated:TRUE];
}

- (IBAction)onClickBuy:(id)sender
{
    AddMoreViewController *showAdd = [[AddMoreViewController alloc] initWithNibName:@"AddMoreViewController" bundle:nil];
  [self presentModalViewController:showAdd animated:TRUE];
}

- (IBAction)logIn:(id)sender
{
    FirstViewController *login = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    [self presentModalViewController:login animated:TRUE];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [viewController viewDidLoad];
    
    FirstViewController *firstView = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    [self presentModalViewController:firstView animated:TRUE];
    
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
//    UIBarButtonItem *rightButton =[[UIBarButtonItem alloc]initWithTitle:@"Log In" style:UIBarButtonItemStyleDone target:self action:@selector(logIn:)];  
//    self.navigationItem.rightBarButtonItem = rightButton;
//    rightButton.tintColor = [UIColor colorWithRed:.8843 green:.2834 blue:.0021 alpha:1.0];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
