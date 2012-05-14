//
//  ViewController.m
//  project3
//
//  Created by Mark Evans on 5/14/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import "ViewController.h"
#import "TopViewController.h"

@implementation ViewController

-(IBAction)onClick:(id)sender
{
    TopViewController *topView = [[TopViewController alloc] initWithNibName:@"TopViewController" bundle:nil];
    if (topView != nil)
    {
        topView.delegate = self;
        [self presentModalViewController:topView animated:true];
    }
    [textView resignFirstResponder];
}

-(void)DidClose:(NSString*)newString
{
    if([textView.text isEqualToString:@"Empty!"])
    {
        textView.text = @"";
        outputText = [NSMutableString stringWithString:textView.text];
        [outputText appendString:newString];
        textView.text = outputText;
    }
    else {
        outputText = [NSMutableString stringWithString:textView.text];
        [outputText appendString:newString];
        textView.text = outputText;
        
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.text = [NSString stringWithString:@""];
    return true;
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
