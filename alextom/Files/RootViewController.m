//
//  RootViewController.m
//
//  Created by Mark Evans on 5/2/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import "RootViewController.h"
#import "SearchViewController.h"

@implementation RootViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"git-bg.png"]]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark === Text field delegate methods ===
#pragma mark -

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.text) {
        SearchViewController *viewController = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
        viewController.query = [NSString stringWithFormat:@"%@", textField.text];
        [[self navigationController] pushViewController:viewController animated:YES];
        [viewController release];
    }
	[textField resignFirstResponder];
	return YES;
}

-(IBAction)onClick:(id)sender
{
    [userName resignFirstResponder];
}

@end
