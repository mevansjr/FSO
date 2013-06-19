//
//  MySignUpViewController.m
//  game
//
//  Created by Mark Evans on 4/12/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import "MySignUpViewController.h"

@interface MySignUpViewController ()

@end

@implementation MySignUpViewController

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
    
    [self.signUpView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blur5login.png"]]];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.signUpView.logo removeFromSuperview];
        //this is iphone 5 xib
    } else {
        [self.signUpView.logo removeFromSuperview];
        // this is iphone 4 xib
    }
    
    // Set buttons appearance
    [self.signUpView.dismissButton setImage:[UIImage imageNamed:@"closebtn.png"] forState:UIControlStateNormal];
    [self.signUpView.dismissButton setShowsTouchWhenHighlighted:TRUE];
    
    [self.signUpView.signUpButton setBackgroundImage:[UIImage imageNamed:@"signupbtn.png"] forState:UIControlStateNormal];
    [self.signUpView.signUpButton setBackgroundImage:[UIImage imageNamed:@"signupbtnh.png"] forState:UIControlStateHighlighted];
    [self.signUpView.signUpButton.titleLabel removeFromSuperview];
    
    [self.signUpView.usernameField setBackground:[UIImage imageNamed:@"fields.png"]];
    [self.signUpView.passwordField setBackground:[UIImage imageNamed:@"fields.png"]];
    [self.signUpView.emailField setBackground:[UIImage imageNamed:@"fields.png"]];
    [self.signUpView.usernameField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.signUpView.passwordField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.signUpView.emailField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.signUpView.usernameField setTextColor:[UIColor colorWithRed:1.0 green:0.9642 blue:0.9020 alpha:1.0]];
    [self.signUpView.passwordField setTextColor:[UIColor colorWithRed:1.0 green:0.9642 blue:0.9020 alpha:1.0]];
    [self.signUpView.emailField setTextColor:[UIColor colorWithRed:1.0 green:0.9642 blue:0.9020 alpha:1.0]];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
