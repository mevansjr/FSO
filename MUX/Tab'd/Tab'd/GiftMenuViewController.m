//
//  GiftMenuViewController.m
//  Tab'd
//
//  Created by Mark Evans on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GiftMenuViewController.h"

@interface GiftMenuViewController ()

@end

@implementation GiftMenuViewController

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
    [ratingSlider addTarget:self 
                     action:@selector(sliderValueChanged:) 
           forControlEvents:UIControlEventValueChanged];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)sliderValueChanged:(id)sender
{
    ratingField.text = [NSString stringWithFormat:@"$%d.00", 
                        (int)(ratingSlider.value * 1) + 0];
}
- (IBAction)onClose:(id)sender
{
    [self dismissModalViewControllerAnimated:TRUE]; 
}
 
- (IBAction)validate:(id)sender
{
    if ([[ratingField text] isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Required fields" message:@"Please adjust the slider to reflect the amount of money you would like to gift!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Payment Withdraw" message:@"Thank you for using Tab'd. Please allow 1-2 business days for the amount to be reflected on your bank account." delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
    [alert show];
    [self dismissModalViewControllerAnimated:TRUE];
    }
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
