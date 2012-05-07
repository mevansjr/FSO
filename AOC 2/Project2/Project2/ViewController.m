//
//  ViewController.m
//  Project2
//
//  Created by Mark Evans on 5/7/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import "ViewController.h"
#import "infoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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

-(IBAction)onClearAll:(id)sender
{
    currentNum = 0;
    calcScreen.text = @"0";
    currentOperator = 0;
    
}

-(IBAction)onColorClick:(id)sender
{
    UISegmentedControl *segControl = (UISegmentedControl*)sender;
    if (segControl != nil)
    {
        int selectedIndex = segControl.selectedSegmentIndex;
        NSLog(@"%d", selectedIndex);
        switch (selectedIndex) 
        {
            case 0:
                self.view.backgroundColor = [UIColor whiteColor];
                break;
                
            case 1:
                self.view.backgroundColor = [UIColor redColor];
                break;
                
            case 2:
                self.view.backgroundColor = [UIColor greenColor];
                break;
                
            default:
                self.view.backgroundColor = [UIColor whiteColor];
                break;
        }
    }
}

-(IBAction)onInfoClick:(id)sender
{
    infoViewController *viewController = [[infoViewController alloc] initWithNibName:@"infoViewController" bundle:nil];
    if (viewController != nil)
    {
        [self presentModalViewController:viewController animated:TRUE];
    }
    
}
    
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
