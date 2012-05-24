//
//  ViewController.m
//  project4
//
//  Created by Mark Evans on 5/14/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import "ViewController.h"
#import "TopViewController.h"

@implementation ViewController

-(IBAction)onClick:(id)sender
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *dataString = textView.text;
    [defaults setValue:dataString forKey:@"data"];
    [defaults synchronize];
    
    if ((textView.text.length == 0)||([textView.text isEqualToString:@"Empty!"]))
    {
        UIAlertView *showAlert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"You need to add an Event to save data!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [showAlert show];
    }
    else 
    {
        UIAlertView *showAlert2 = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Data has been saved."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [showAlert2 show];
    }
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
    else
    {
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *appendText = [defaults stringForKey:@"data"];
    if (appendText.length > 0) 
    {
        textView.text = appendText;
    }
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
    leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [swipeLabel addGestureRecognizer:leftSwipe];
    
    rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [swipeLabel addGestureRecognizer:rightSwipe];
    
    [super viewWillAppear:animated];
}
-(void)onSwipe:(UISwipeGestureRecognizer*)recognizer
{
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        NSString *test = @"left";
        NSLog(@"%@", test);
    }
    else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight)
    {
        TopViewController *topView = [[TopViewController alloc] initWithNibName:@"TopViewController" bundle:nil];
        if (topView != nil)
        {
            topView.delegate = self;
            [self presentModalViewController:topView animated:true];
        }
        [textView resignFirstResponder];
        
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
