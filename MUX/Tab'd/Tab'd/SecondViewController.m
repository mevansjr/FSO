//
//  SecondViewController.m
//  Tab'd
//
//  Created by Mark Evans on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"
#import "CurrentTabView.h"
#import "TabHistoryView.h"
#import "AddMoreViewController.h"
#import "GiftViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"User";
        UIImage *headerImage = [UIImage imageNamed:@"logo_titleView.png"];
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:headerImage];
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

-(IBAction)onClickCurrTab:(id)sender
{
    CurrentTabView *showCurrTab = [[CurrentTabView alloc] initWithNibName:@"CurrentTabView" bundle:nil];
    [self presentModalViewController:showCurrTab animated:TRUE];
}

-(IBAction)onClickTabHistory:(id)sender
{
    TabHistoryView *showTabHistory = [[TabHistoryView alloc] initWithNibName:@"TabHistoryView" bundle:nil];
    [self.navigationController pushViewController:showTabHistory animated:TRUE];
}

-(IBAction)giftFriend:(id)sender
{
    GiftViewController *giftView = [[GiftViewController alloc] initWithNibName:@"GiftViewController" bundle:nil];
    [self presentModalViewController:giftView animated:TRUE];
}

-(IBAction)onClickAdd:(id)sender
{
    AddMoreViewController *addMore = [[AddMoreViewController alloc] initWithNibName:@"AddMoreViewController" bundle:nil];
    [self presentModalViewController:addMore animated:TRUE];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    UIBarButtonItem *rightButton =[[UIBarButtonItem alloc]initWithTitle:@"$20" style:UIBarButtonItemStyleDone target:self action:@selector(onClickAdd:)];   
    self.navigationItem.rightBarButtonItem = rightButton;
    rightButton.tintColor = [UIColor colorWithRed:.8843 green:.2834 blue:.0021 alpha:1.0];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
