//
//  ViewController.m
//  Project3
//
//  Created by Mark Evans on 5/14/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import "ViewController.h"
#import "TopViewController.h"

@implementation ViewController

-(IBAction)onClick:(id)sender
{
    
}

-(void)DidClose:(NSString*)newString
{
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   
}

- (void)viewDidLoad
{
    //[ViewController loadEvents];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
