//
//  MenuViewController.m
//  Tab'd
//
//  Created by Mark Evans on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "AddMoreViewController.h"
#import "AboutViewController.h"
#import "CustomCellView2.h"
#import "TabsViewController.h"
#import "CurrentTabView.h"
#import "AppDelegate.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize titles, rows1, rows2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.title = @"Settings";
//        UIImage *headerImage = [UIImage imageNamed:@"logo_titleView.png"];
//        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:headerImage];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.title = [[NSString alloc] initWithFormat:@"%@ Menu", appDelegate.savedTitle];
        self.tabBarItem.image = [UIImage imageNamed:@"Settings"];
    }
    return self;
}

-(IBAction)onClickInfo:(id)sender
{
    AboutViewController *aboutView = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    [self presentModalViewController:aboutView animated:TRUE];
}

- (void)passTitle:(NSString*)theTitle
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.savedTitle = theTitle;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    titles = [[NSMutableArray alloc] initWithObjects:@"", nil];
    rows1 = [[NSMutableArray alloc] initWithObjects:@"Nachos", @"Mozzarella Sticks", @"Crab Dip", @"Crab Pretzel", @"Crab Balls", nil];
    rows2 = [[NSMutableArray alloc] initWithObjects:@"$4.99", @"$5.99", @"$11.99", @"$8.99", @"$10.99", nil];
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
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    NSString *showText = [rows1 objectAtIndex:indexPath.row];
//	cell.textLabel.text = showText;
//    
//    return cell;
    static NSString *CellIdentifier = @"Cell";
    
    CustomCellView2 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"CustomCellView2" owner:nil options:nil];
        
        for (UIView *view in views)
        {
            if([view isKindOfClass:[CustomCellView2 class]])
            {
                cell = (CustomCellView2*)view;
                NSString *showText = [rows1 objectAtIndex:indexPath.row];
                NSString *showSub = [rows2 objectAtIndex:indexPath.row];
                cell.textLabel.text = showText;
                cell.statusLabel.text = showSub;
            }
        }
    }
    
    NSString *showText = [rows1 objectAtIndex:indexPath.row];
    NSString *showSub = [rows2 objectAtIndex:indexPath.row];
    cell.textLabel.text = showText;
    cell.statusLabel.text = showSub;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Selected Item" message:@"Added to the Tab." delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
    [alert show];
    
    CurrentTabView *viewController = [[CurrentTabView alloc] initWithNibName:@"CurrentTabView" bundle:nil];
    [self presentModalViewController:viewController animated:TRUE];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
