//
//  SettingsViewController.m
//  Tab'd
//
//  Created by Mark Evans on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "AddMoreViewController.h"
#import "AboutViewController.h"
#import "GiftViewController.h"
#import "TabsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize titles, rows1, rows2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Settings";
        UIImage *headerImage = [UIImage imageNamed:@"logo_titleView.png"];
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:headerImage];
        self.tabBarItem.image = [UIImage imageNamed:@"Settings"];
    }
    return self;
}

-(IBAction)onClickInfo:(id)sender
{
    AboutViewController *aboutView = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    [self presentModalViewController:aboutView animated:TRUE];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    titles = [[NSMutableArray alloc] initWithObjects:@"Account Settings", nil];
    rows1 = [[NSMutableArray alloc] initWithObjects:@"Account Profile", @"Add More Credits", @"Gift a Friend", @"Log Out" , nil];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return rows1.count;  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return titles.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *headerTitle = [titles objectAtIndex:0];
    return headerTitle;
}

//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    NSString *footerTitle = [[NSString alloc] initWithFormat:@"Footer Title"];
//    return footerTitle;
//}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        //
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *showText = [rows1 objectAtIndex:indexPath.row];
	cell.textLabel.text = showText;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondViewController *secView = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    AddMoreViewController *addMore = [[AddMoreViewController alloc] initWithNibName:@"AddMoreViewController" bundle:nil];
    //FirstViewController *firstView = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    GiftViewController *giftView =[[GiftViewController alloc] initWithNibName:@"GiftViewController" bundle:nil];
    TabsViewController *tabsView =[[TabsViewController alloc] initWithNibName:@"TabsViewController" bundle:nil];
    
    if (indexPath.row == 0)
    {
        [self.navigationController pushViewController:secView animated:TRUE];
    }
    else if (indexPath.row == 1)
    {
        [self presentModalViewController:addMore animated:TRUE];
    }
    else if (indexPath.row == 2)
    {
        [self presentModalViewController:giftView animated:TRUE];          
    }
    else if (indexPath.row == 3)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"You have been LOGGED out." delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
        [alert show];
        [self.navigationController pushViewController:tabsView animated:TRUE];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
