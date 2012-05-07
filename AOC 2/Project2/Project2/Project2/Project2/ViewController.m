//
//  ViewController.m
//  Project2
//
//  Created by Mark Evans on 5/7/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    powerSwitch.on = true;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)onSwitch:(id)sender
{
    UISwitch *thisSwitch = (UISwitch*)sender;
    if (thisSwitch != nil)
    {
        //int tag = thisSwitch.tag;
        int stateTemp = thisSwitch.state;
        //powerSwitch.on = true;
        NSLog(@"You turned the calculator %d", stateTemp);
    }
    else {
        NSLog(@"Look closer!");
        
    }
}

-(IBAction)onDigitClick:(id)sender
{
    if (powerSwitch.on != false)
    {
        currentNum = currentNum*10 + (float)[sender tag];
        calcScreen.text = [NSString stringWithFormat:@"%2f", currentNum];
    } 
} 

-(IBAction)onOpClick:(id)sender
{
    if (currentOperator == 0)
    {
        result = currentNum;
    } else {
        switch (currentOperator) {
            case 1:
                result += currentNum;
                break;
            case 2:
                currentOperator = 0;
                break;
        }
        
    }
    currentNum = 0;
    calcScreen.text = [NSString stringWithFormat:@"%2f", result];
    if ([sender tag] == 0) 
        result = 0;
    currentOperator = [sender tag];
}

-(IBAction)onCancelInput:(id)sender
{
    currentNum = 0;
    calcScreen.text = @"0";
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
