//
//  FirstViewController.m
//  Tab'd
//
//  Created by Mark Evans on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "TabsViewController.h"
#import "NewUserViewController.h"
#import "AppDelegate.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

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

-(IBAction)onClick:(id)sender
{
    if ([[myTextFieldUser text] isEqualToString:@""] || [[myTextFieldPass text] isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Required fields" message:@"Please fill out all fields" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
    }
    else 
    {
//        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        NSString *saveUserName = [myTextFieldUser text];
//        [appDelegate.usernames addObject:saveUserName];
        [self dismissModalViewControllerAnimated:TRUE];
    }
}

- (IBAction)dismissKeyboard:(id)sender {
    [myTextFieldUser resignFirstResponder];
    [myTextFieldPass resignFirstResponder];
}

- (IBAction)onClose:(id)sender
{
    [self dismissModalViewControllerAnimated:TRUE];
}

- (IBAction)newUser:(id)sender
{
    NewUserViewController *newUser = [[NewUserViewController alloc] initWithNibName:@"NewUserViewController" bundle:nil];
    [self presentModalViewController:newUser animated:TRUE];
}

- (IBAction)onClickForget:(id)sender
{
    UIAlertView *aleartView = [[UIAlertView alloc] initWithTitle:@"Forgot Password?" message:@"Please visit http://www.tabd.com/help" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
    [aleartView show];
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
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
