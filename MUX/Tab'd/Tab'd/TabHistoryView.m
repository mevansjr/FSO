//
//  TabHistoryView.m
//  Tab'd
//
//  Created by Mark Evans on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TabHistoryView.h"
#import "CurrentTabView.h"
#import "PastTabViewController.h"
#import "ClearViewController.h"

@interface TabHistoryView ()

@end

@implementation TabHistoryView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImage *headerImage = [UIImage imageNamed:@"logo_titleView.png"];
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:headerImage];
    }
    return self;
}

- (IBAction)onClick:(id)sender
{
    PastTabViewController *showTab = [[PastTabViewController alloc] initWithNibName:@"PastTabViewController" bundle:nil];
    [self.navigationController pushViewController:showTab animated:TRUE];
}

- (IBAction)onClickExport:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Export" message:@"Your Tab History has been exported to PDF. Please sync to iTunes to extract file." delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)onClickClear:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Are you sure you want to Clear all Tab History?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
    ClearViewController *clear = [[ClearViewController alloc] initWithNibName:@"ClearViewController" bundle:nil];
    [self.navigationController pushViewController:clear animated:TRUE];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
