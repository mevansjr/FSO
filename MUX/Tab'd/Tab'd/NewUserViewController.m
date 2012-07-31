//
//  NewUserViewController.m
//  Tab'd
//
//  Created by Mark Evans on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewUserViewController.h"
#import "TabsViewController.h"

@interface NewUserViewController ()

@end

@implementation NewUserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)onClose:(id)sender
{
    [self dismissModalViewControllerAnimated:TRUE];
}

- (IBAction)onSave:(id)sender
{
    [self dismissModalViewControllerAnimated:TRUE];
}

- (IBAction)validate:(id)sender
{
    if ([[firstName text] isEqualToString:@""] || [[lastName text] isEqualToString:@""] || [[email text] isEqualToString:@""] || [[userName text] isEqualToString:@""] || [[passConfirm text] isEqualToString:@""] || [[pass text] isEqualToString:@""]) 
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Required fields" message:@"Please fill out all fields" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
	}
    else if (![[pass text] isEqualToString:[passConfirm text]])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Required field" message:@"Your password does not match the confirm password." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
    }
    else 
    {
        [self dismissModalViewControllerAnimated:TRUE];
    }
}

- (IBAction)dismissKeyboard:(id)sender
{
    [firstName resignFirstResponder];
    [lastName resignFirstResponder];
    [pass resignFirstResponder];
    [passConfirm resignFirstResponder];
    [email resignFirstResponder];
    [userName resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
