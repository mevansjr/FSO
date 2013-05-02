//
//  AddViewController.m
//  MdTA
//
//  Created by Mark Evans on 4/23/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import "AddViewController.h"
#import "AppDelegate.h"
#import "FirstViewController.h"
#import "Vehicle.h"
#import <Parse/Parse.h>
#import "Reachability.h"
#import "DetailsViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController
@synthesize ccStr, ctStr, cvStr, rpStr, rsStr, installdateStr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (ccStr != nil)
    {
        cc.text = ccStr;
        [submitBtn setTitle:@"Update" forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(updateDB:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(addVehicleDB:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (ctStr != nil)
    {
        ct.text = ctStr;
    }
    if (cvStr != nil)
    {
        cv.text = cvStr;
    }
    if (rpStr != nil)
    {
        rp.text = rpStr;
    }
    if (rsStr != nil)
    {
        rs.text = rsStr;
    }
    if (installdateStr != nil)
    {
        installdate.text = installdateStr;
    }
}

- (IBAction)updateDB:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if ([self connected])
    {
        PFQuery *query = [PFQuery queryWithClassName:@"newVehicle"];
        [query getObjectInBackgroundWithId:appDelegate.passParseId block:^(PFObject *obj, NSError *error) {
            if (!error) {
                // The get request succeeded. Log the score
                [obj setObject:cc.text forKey:@"cc"];
                [obj setObject:ct.text forKey:@"ct"];
                [obj setObject:cv.text forKey:@"cv"];
                [obj setObject:rp.text forKey:@"rp"];
                [obj setObject:rs.text forKey:@"rs"];
                [obj setObject:installdate.text forKey:@"date"];
                [obj saveInBackground];
                [self.presentingViewController.presentingViewController dismissViewControllerAnimated:TRUE completion:nil];
            } else {
                // Log details of our failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
                UIAlertView *prompt = [[UIAlertView alloc]initWithTitle:@"SYNC ISSUE" message:@"It appears this Vehicle is not in SYNC with the Database. Would you like to save this Vehicle as a new entry?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO", @"YES", nil];
                [prompt show];
            }
        }];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    //NO
    if (buttonIndex == 0)
    {
        PFObject *obj = [PFObject objectWithClassName:@"deleteVehicle"];
        [obj setObject:cc.text forKey:@"cc"];
        [obj setObject:ct.text forKey:@"ct"];
        [obj setObject:cv.text forKey:@"cv"];
        [obj setObject:rp.text forKey:@"rp"];
        [obj setObject:rs.text forKey:@"rs"];
        [obj setObject:installdate.text forKey:@"date"];
        [obj saveInBackground];
        
        PFQuery *query = [PFQuery queryWithClassName:@"newVehicle"];
        [query getObjectInBackgroundWithId:appDelegate.passParseId block:^(PFObject *obj, NSError *error) {
            if (!error) {
                // The get request succeeded. Log the score
                [obj deleteInBackground];
                [self.presentingViewController.presentingViewController dismissViewControllerAnimated:TRUE completion:nil];
            } else {
                // Log details of our failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
    //YES
    else if (buttonIndex == 1)
    {
        if ([self connected])
        {
            PFObject *obj = [PFObject objectWithClassName:@"newVehicle"];
            [obj setObject:cc.text forKey:@"cc"];
            [obj setObject:ct.text forKey:@"ct"];
            [obj setObject:cv.text forKey:@"cv"];
            [obj setObject:rp.text forKey:@"rp"];
            [obj setObject:rs.text forKey:@"rs"];
            [obj setObject:installdate.text forKey:@"date"];
            [obj saveInBackground];
        }
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:TRUE completion:nil];
    }
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

- (IBAction)addVehicleDB:(id)sender
{
    if ([self connected])
    {
        PFObject *obj = [PFObject objectWithClassName:@"newVehicle"];
        [obj setObject:cc.text forKey:@"cc"];
        [obj setObject:ct.text forKey:@"ct"];
        [obj setObject:cv.text forKey:@"cv"];
        [obj setObject:rp.text forKey:@"rp"];
        [obj setObject:rs.text forKey:@"rs"];
        [obj setObject:installdate.text forKey:@"date"];
        [obj saveInBackground];
        [self dismissViewControllerAnimated:TRUE completion:nil];
    } else {
        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"Check Connection" message:@"It appears that you're offline." delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
        [a show];
        [self dismissViewControllerAnimated:TRUE completion:nil];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.parentViewController dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    cc.delegate = self;
    ct.delegate = self;
    cv.delegate = self;
    rp.delegate = self;
    rs.delegate = self;
    installdate.delegate = self;
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    ccStr = nil;
    ctStr = nil;
    cvStr = nil;
    rpStr = nil;
    rsStr = nil;
    installdateStr = nil;
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(addVehicle:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
