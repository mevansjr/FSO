//
//  CurrentTabView.m
//  Tab'd
//
//  Created by Mark Evans on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CurrentTabView.h"
#import "AltSecViewController.h"

@interface CurrentTabView ()

@end

@implementation CurrentTabView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Current Tab";
        UIImage *headerImage = [UIImage imageNamed:@"logo_titleView.png"];
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:headerImage];
        self.tabBarItem.image = [UIImage imageNamed:@"Tabs.png"];
    }
    return self;
}

- (IBAction)onClose:(id)sender
{
    [self dismissModalViewControllerAnimated:TRUE];
}

- (IBAction)onClick:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Payment Withdraw" message:@"Thank you for using Tab'd. Please allow 1-2 business days for the amount to be reflected on your bank account." delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
    [alert show];
    //AltSecViewController *theView = [[AltSecViewController alloc] initWithNibName:@"AltSecViewController" bundle:nil];
    [self dismissModalViewControllerAnimated:TRUE];
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
