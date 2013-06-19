//
//  MyLoginViewController.m
//  game
//
//  Created by Mark Evans on 4/5/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import "MyLoginViewController.h"

@interface MyLoginViewController ()

@end

@implementation MyLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blur5login.png"]]];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.logInView.logo removeFromSuperview];
        //this is iphone 5 xib
    } else {
        [self.logInView.logo removeFromSuperview];
        // this is iphone 4 xib
    }
    
    // Set buttons appearance
    [self.logInView.dismissButton removeFromSuperview];
//    
    //[self.logInView.facebookButton setImage:nil forState:UIControlStateNormal];
    //[self.logInView.facebookButton setImage:nil forState:UIControlStateHighlighted];
    
    [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"loginbtn.png"] forState:UIControlStateNormal];
    [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"loginbtnh.png"] forState:UIControlStateHighlighted];
    [self.logInView.logInButton.titleLabel removeFromSuperview];
    [self.logInView.externalLogInLabel removeFromSuperview];
    
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"signupbtn.png"] forState:UIControlStateNormal];
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"signupbtnh.png"] forState:UIControlStateHighlighted];
    [self.logInView.signUpButton.titleLabel removeFromSuperview];
    [self.logInView.signUpLabel removeFromSuperview];
    
    [self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:@"fb.png"] forState:UIControlStateNormal];
    [self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:@"fbh.png"] forState:UIControlStateHighlighted];
    [self.logInView.facebookButton.titleLabel removeFromSuperview];
    [self.logInView.facebookButton.imageView removeFromSuperview];
    [self.logInView.passwordForgottenButton removeFromSuperview];

//
//    [self.logInView.twitterButton setImage:nil forState:UIControlStateNormal];
//    [self.logInView.twitterButton setImage:nil forState:UIControlStateHighlighted];
//    [self.logInView.twitterButton setBackgroundImage:[UIImage imageNamed:@"twitter.png"] forState:UIControlStateNormal];
//    [self.logInView.twitterButton setBackgroundImage:[UIImage imageNamed:@"twitter_down.png"] forState:UIControlStateHighlighted];
//    [self.logInView.twitterButton setTitle:@"" forState:UIControlStateNormal];
//    [self.logInView.twitterButton setTitle:@"" forState:UIControlStateHighlighted];
//    
//    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"signup.png"] forState:UIControlStateNormal];
//    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"signup_down.png"] forState:UIControlStateHighlighted];
//    [self.logInView.signUpButton setTitle:@"" forState:UIControlStateNormal];
//    [self.logInView.signUpButton setTitle:@"" forState:UIControlStateHighlighted];
    
//    // Add login field background
//   UIImageView *fieldsBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainbtn-org.png"]];
//    [self.logInView insertSubview:fieldsBackground atIndex:1];
    
    // Set field text color
    [self.logInView.usernameField setTextColor:[UIColor colorWithRed:1.0 green:0.9642 blue:0.9020 alpha:1.0]];
    [self.logInView.passwordField setTextColor:[UIColor colorWithRed:1.0 green:0.9642 blue:0.9020 alpha:1.0]];
    [self.logInView.usernameField setBackground:[UIImage imageNamed:@"fields.png"]];
    [self.logInView.passwordField setBackground:[UIImage imageNamed:@"fields.png"]];
    [self.logInView.usernameField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.logInView.passwordField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)viewDidLayoutSubviews {
    [self.logInView.facebookButton setFrame:CGRectMake(self.logInView.facebookButton.frame.origin.x, self.logInView.facebookButton.frame.origin.y-46, self.logInView.facebookButton.frame.size.width, self.logInView.facebookButton.frame.size.height)];
    [self.logInView.signUpButton setFrame:CGRectMake(self.logInView.signUpButton.frame.origin.x, self.logInView.signUpButton.frame.origin.y-94, self.logInView.signUpButton.frame.size.width, self.logInView.signUpButton.frame.size.height)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
