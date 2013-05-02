//
//  DetailsViewController.m
//  MdTA
//
//  Created by Mark Evans on 4/24/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import "DetailsViewController.h"
#import "AddViewController.h"
#import "AppDelegate.h"
#import "FirstViewController.h"
#import "Vehicle.h"
#import <Parse/Parse.h>
#import "Reachability.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController
@synthesize ccStr,ctStr,cvStr,rpStr,rsStr,installdateStr,datemodStr,parseIdStr;

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

- (IBAction)delete:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    dbPathString = appDelegate.dbpath;
    if (sqlite3_open([dbPathString UTF8String], &theDB)==SQLITE_OK)
    {
        char *error;
        NSString *deleteStr = [[NSString alloc]initWithFormat:@"Delete from Vehicles where call is '%s'", [ccStr UTF8String]];
        if (sqlite3_exec(theDB, [deleteStr UTF8String], NULL, NULL, &error)==SQLITE_OK)
        {
            NSLog(@"Vehicle deleted");
        } else {
            NSLog(@"Error exec delete");
        }
    } else {
        NSLog(@"Error open delete");
    }
    NSString *msg = [[NSString alloc]initWithFormat:@"Vehicle %@ has been deleted.", ccStr];
    UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"Alert" message:msg delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
    [a show];
    if ([self connected])
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
        [query getObjectInBackgroundWithId:parseIdStr block:^(PFObject *obj, NSError *error) {
            if (!error) {
                // The get request succeeded. Log the score
                [obj deleteInBackground];
                [self dismissViewControllerAnimated:TRUE completion:nil];
            } else {
                // Log details of our failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
}

- (IBAction)update:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.passCall = ccStr;
    appDelegate.passParseId = parseIdStr;
    
    AddViewController *addView = [[AddViewController alloc]initWithNibName:@"AddViewController" bundle:nil];
    [addView setCcStr:ccStr];
    [addView setCtStr:ctStr];
    [addView setCvStr:cvStr];
    [addView setRpStr:rpStr];
    [addView setRsStr:rsStr];
    [addView setInstalldateStr:installdateStr];
    [self presentViewController:addView animated:TRUE completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    cc.text = ccStr.uppercaseString;
    ct.text = ctStr.uppercaseString;
    cv.text = cvStr.uppercaseString;
    rp.text = rpStr.uppercaseString;
    rs.text = rsStr.uppercaseString;
    installdate.text = installdateStr.uppercaseString;
    datemod.text = datemodStr;
    parseId.text = parseIdStr;
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
