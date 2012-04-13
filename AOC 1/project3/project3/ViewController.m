//
//  ViewController.m
//  
//
//  Created by Mark Evans on 4/10/12.
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
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    int one = 5;
    int two = 5;
    NSInteger result = [self addNum:one secondInt:two];
    NSNumber *number = [NSNumber numberWithInt:result];
    [self displayAlertWithNSNumber:number];
    [self compareNum:one compIntTwo:two]; /* Using Compare Function */
    [self appendString:@"I'm part one of the string!" appendStringTwo:@"I'm part two of the string."]; /* Combining both strings with Append Function */

    [super viewDidAppear:animated];
}

// Add Function 
// This function will take two NSInteger or int types and return the result of an addition between these two.

-(NSInteger)addNum:(NSInteger)firstInt secondInt:(NSInteger)secondInt
{
    return (firstInt + secondInt);
}

// Compare Function
// Create a function called Compare that takes two NSInteger values. Return true or false based on whether the values are equal.    

-(bool) compareNum:(NSInteger)compIntOne compIntTwo:(NSInteger)compIntTwo 
{
    bool resultsofComp = (compIntOne == compIntTwo);
    NSString *stringResult = [NSString stringWithFormat: @"Are both INTs the same?  %@", resultsofComp ? @"TRUE" : @"FALSE"];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Compare Alert" message:(NSString*)stringResult delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    if (alertView != nil)
    {
        [alertView show];
    }
    return resultsofComp;
}
    
// Append Function  
// This function will take two NSStrings and return a new NSString containing the appended strings.

-(NSString*)appendString:(NSString*)appendStringOne appendStringTwo:(NSString*)appendStringTwo
{
    NSString *result = [[NSString alloc] initWithFormat:@"%@ %@", appendStringOne, appendStringTwo];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Appended String Alert" message:(NSString*)result delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    if (alertView != nil)
    {
        [alertView show];
    }
    return result;
}  

// displayAlertWithNSNumber Function 
// Part of second section of instructions
    
-(void) displayAlertWithNSNumber:(NSNumber*)numberVar
{
    NSInteger number = [numberVar integerValue];    
    NSString *tmpMsg = [[NSString alloc] initWithFormat:@"The addition of the two INTs: %d", number];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"NSNumber Alert" message:(NSString*)tmpMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    if (alertView != nil)
     {
     [alertView show];
     }          
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
