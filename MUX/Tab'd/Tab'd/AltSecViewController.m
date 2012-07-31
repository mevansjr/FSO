//
//  AltSecViewController.m
//  Tab'd
//
//  Created by Mark Evans on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AltSecViewController.h"
#import "CurrentTabView.h"
#import "TabHistoryView.h"
#import "AddMoreViewController.h"

@interface AltSecViewController ()

@end

@implementation AltSecViewController

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
    [self.navigationController pushViewController:showCurrTab animated:TRUE];
}

-(IBAction)onClickTabHistory:(id)sender
{
    TabHistoryView *showTabHistory = [[TabHistoryView alloc] initWithNibName:@"TabHistoryView" bundle:nil];
    [self.navigationController pushViewController:showTabHistory animated:TRUE];
}

-(IBAction)onClickAdd:(id)sender
{
    AddMoreViewController *addMore = [[AddMoreViewController alloc] initWithNibName:@"AddMoreViewController" bundle:nil];
    [self.navigationController pushViewController:addMore animated:TRUE];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    UIBarButtonItem *rightButton =[[UIBarButtonItem alloc]initWithTitle:@"$5.23" style:UIBarButtonItemStyleDone target:nil action:nil];   
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
