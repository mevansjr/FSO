//
//  FriendToGiftViewController.m
//  Tab'd
//
//  Created by Mark Evans on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendToGiftViewController.h"

@interface FriendToGiftViewController ()

@end

@implementation FriendToGiftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:TRUE];    
}

-(IBAction)giftSelect:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gift A Friend Payment" message:@"Thank you for using Tab'd. Please allow 1-2 business days for the amount to be reflected on your bank account." delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
    [self dismissModalViewControllerAnimated:TRUE];
    [alert show];    
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
