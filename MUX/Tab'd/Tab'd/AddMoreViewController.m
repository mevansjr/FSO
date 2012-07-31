//
//  AddMoreViewController.m
//  Tab'd
//
//  Created by Mark Evans on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddMoreViewController.h"

@interface AddMoreViewController ()

@end

@implementation AddMoreViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)dismissKeyboard:(id)sender 
{
    [firstName resignFirstResponder];
    [lastName resignFirstResponder];
    [creditNumber resignFirstResponder];
    [expDate resignFirstResponder];
}

- (IBAction)validate:(id)sender
{
    if ([[firstName text] isEqualToString:@""] || [[lastName text] isEqualToString:@""] || [[creditNumber text] isEqualToString:@""] || [[expDate text] isEqualToString:@""]) 
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Required fields" message:@"Please fill out all fields" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
	}
    else 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Payment Deposit" message:@"Thank you for using Tab'd. Please allow 1-2 business days for the amount to be reflected on your bank account. Money has been added to your account!" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
        [alert show];
        [self dismissModalViewControllerAnimated:TRUE];
    }
}

- (IBAction)onClose:(id)sender
{
    [self dismissModalViewControllerAnimated:TRUE];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
