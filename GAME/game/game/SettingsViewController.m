//
//  SettingsViewController.m
//  game
//
//  Created by Mark Evans on 4/11/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import "SettingsViewController.h"
#import "UIBorderLabel.h"
#import "CustomCell.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "UserProfileViewController.h"
#import "RCSwitchOnOff.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSLog(@"%@",appDelegate.PlayAudio);
    NSLog(@"Logged in with Facbook: %@",appDelegate.loggedinWithFacebook);
    if ([appDelegate.loggedinWithFacebook isEqualToString:@"YES"])
    {
        NSString *username = [appDelegate.userProfile objectForKey:@"name"];
        name = [[NSString alloc]initWithFormat:@"%@",username];
        profileSettings = [[NSArray alloc]initWithObjects:name,@"Log Out", nil];
    } else {
        name = [[NSString alloc]initWithFormat:@"%@",appDelegate.theusername];
        profileSettings = [[NSArray alloc]initWithObjects:name,@"Log Out", nil];
    }
    audioSettings = [[NSArray alloc]initWithObjects:@"Mute Audio", nil];
    helpSettings = [[NSArray alloc]initWithObjects:@"Tutorial on How to Play", nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    thenavbar.delegate = self;
    
    //Set Custom NavBar
    UIImage *image = [UIImage imageNamed:@"navbg.png"];
    [[UINavigationBar appearance]setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"shadow.png"]];
    
    [closebtn setShowsTouchWhenHighlighted:YES];
    
    UIImage *headerImage = [UIImage imageNamed:@"logosettings.png"];
    navItem.titleView = [[UIImageView alloc] initWithImage:headerImage];
    
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                UITextAttributeTextColor: [UIColor whiteColor],
                          UITextAttributeTextShadowColor: [UIColor blackColor],
                         UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                     UITextAttributeFont: [UIFont fontWithName:@"MarkerFelt-Wide" size:20.0f]
     }];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Profile";
    }
    else if (section == 1)
    {
        return @"Help";
    }
    else if (section == 2)
    {
        return @"Audio";
    }
    return nil;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return profileSettings.count;
    }
    else if (section == 1)
    {
        return helpSettings.count;
    }
    else if (section == 2)
    {
        return audioSettings.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
//    CustomCell *cell = (CustomCell *)[nib objectAtIndex:0];
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0.0941 green:0.7686 blue:0.7451 alpha:1.0]];
    bgColorView.layer.cornerRadius = 10;
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (cell != nil)
    {
        if (indexPath.section == 0)
        {
            cell.textLabel.text = [profileSettings objectAtIndex:indexPath.row];
            cell.selectedBackgroundView = bgColorView;
        }
        else if (indexPath.section == 1)
        {
            cell.textLabel.text = [helpSettings objectAtIndex:indexPath.row];
            cell.selectedBackgroundView = bgColorView;
        }
        else if (indexPath.section == 2)
        {
            switchView = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(72, 20, 63, 23)];
            [self.view addSubview:switchView];
            
            //switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *state = [defaults objectForKey:@"state"];
            if (state != nil)
            {
                if ([state isEqualToString:@"YES"])
                {
                    [switchView setOn:FALSE animated:TRUE];
                } else {
                    [switchView setOn:TRUE animated:TRUE];
                }
            }
            
            cell.accessoryView = switchView;
            [switchView addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
            cell.textLabel.text = [audioSettings objectAtIndex:indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    
//        @try {
//            
//            if (detail != nil)
//            {
//                cell.sourceLabel.text = d;
//            }
//            if (status != nil)
//            {
//                cell.statusLabel.text = status.stringValue;
//            }
//        }
//        @catch (NSException *exception) {
//            NSLog(@"%@",exception);
//        }
        
    }
    return cell;
}

- (void)switchValueChange:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSLog(@"Data saved");
    UISwitch* switchControl = sender;
    if([switchControl isOn])
    {
        appDelegate.PlayAudio = @"NO";
        [defaults setObject:@"NO" forKey:@"state"];
        [defaults synchronize];
    } else {
        appDelegate.PlayAudio = @"YES";
        [defaults setObject:@"YES" forKey:@"state"];
        [defaults synchronize];
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 50.0f;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"Log Out"])
    {
        [PFUser logOut];
        [self dismissViewControllerAnimated:TRUE completion:nil];
        ViewController *viewController = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
        [viewController viewDidAppear:true];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"Tutorial on How to Play"])
    {
        NSLog(@"This would go to the How-To ViewController.");
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:name])
    {
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            UserProfileViewController *userProfile = [[UserProfileViewController alloc]initWithNibName:@"UserProfileViewController5" bundle:nil];
            userProfile.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:userProfile animated:TRUE completion:nil];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            //this is iphone 5 xib
        } else {
            UserProfileViewController *userProfile = [[UserProfileViewController alloc]initWithNibName:@"UserProfileViewController" bundle:nil];
            userProfile.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:userProfile animated:TRUE completion:nil];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            // this is iphone 4 xib
        }
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"Mute Audio"])
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
