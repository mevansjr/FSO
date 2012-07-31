//
//  ViewController.m
//  Tab'd
//
//  Created by Mark Evans on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "ListMapViewController.h"
#import "SingleViewController.h"
#import "MyAnnotation.h"
#import "AppDelegate.h"
#import "CustomCellView.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize showArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Near Me";
        UIImage *headerImage = [UIImage imageNamed:@"logo_titleView.png"];
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:headerImage];
        self.tabBarItem.image = [UIImage imageNamed:@"marker"];
    }
    return self;
}

- (void)toggleList
{
    ListMapViewController *listMapController = [[ListMapViewController alloc] initWithNibName:@"ListMapViewController" bundle:nil];
    [self presentModalViewController:listMapController animated:TRUE];
}

- (void)viewDidLoad
{
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
//    UIBarButtonItem *leftButton =[[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEdit)];
//    self.navigationItem.leftBarButtonItem = leftButton;
    UIImage *listImg = [UIImage imageNamed:@"map.png"];
    UIBarButtonItem *rightButton =[[UIBarButtonItem alloc]initWithImage:listImg style:UIBarButtonItemStylePlain target:self action:@selector(toggleList)];  
    self.navigationItem.rightBarButtonItem = rightButton;
    rightButton.tintColor = [UIColor colorWithRed:0.7627 green:0.0 blue:0.0 alpha:1.0];
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate showArr];
    showArray = appDelegate.Array;
    
    CLLocationCoordinate2D theCoordinate1;
    theCoordinate1.latitude = 39.280753;
    theCoordinate1.longitude = -76.575201;
	
	CLLocationCoordinate2D theCoordinate2;
    theCoordinate2.latitude = 39.283975;
    theCoordinate2.longitude = -76.601894;
	
	CLLocationCoordinate2D theCoordinate3;
    theCoordinate3.latitude = 39.282945;
    theCoordinate3.longitude = -76.592689;
	
	CLLocationCoordinate2D theCoordinate4;
    theCoordinate4.latitude = 39.280047;
    theCoordinate4.longitude = -76.574584;
    
    CLLocationCoordinate2D theCoordinate5;
    theCoordinate5.latitude = 39.296048;
    theCoordinate5.longitude = -76.583633;
	
	MyAnnotation* myAnnotation1=[[MyAnnotation alloc] init];
    
	myAnnotation1.coordinate=theCoordinate1;
	myAnnotation1.title=@"Looney's Pub";
	myAnnotation1.subtitle=@"Bar";
	
	MyAnnotation* myAnnotation2=[[MyAnnotation alloc] init];
	
	myAnnotation2.coordinate=theCoordinate2;
	myAnnotation2.title=@"James Joyce Irish Pub";
	myAnnotation2.subtitle=@"Bar";
	
	MyAnnotation* myAnnotation3=[[MyAnnotation alloc] init];
	
	myAnnotation3.coordinate=theCoordinate3;
	myAnnotation3.title=@"Jimmy's Restaurant";
	myAnnotation3.subtitle=@"Restaurant";
	
	MyAnnotation* myAnnotation4=[[MyAnnotation alloc] init];
	
	myAnnotation4.coordinate=theCoordinate4;
	myAnnotation4.title=@"Coburns Tavern";
	myAnnotation4.subtitle=@"Bar";
    
    MyAnnotation* myAnnotation5=[[MyAnnotation alloc] init];
    
	myAnnotation5.coordinate=theCoordinate5;
	myAnnotation5.title=@"Sip & Bite Restaurant";
	myAnnotation5.subtitle=@"Restaurant";
    
	[showArray addObject:myAnnotation1];
	[showArray addObject:myAnnotation2];
	[showArray addObject:myAnnotation3];
	[showArray addObject:myAnnotation4];
    [showArray addObject:myAnnotation5];
    
    NSLog(@"from app del : %i",appDelegate.Array.count);
    NSLog(@"copied array from app del : %i",showArray.count);
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)toggleEdit
{
    [mapTableView setEditing:!mapTableView.editing animated:YES]; 
    
    if (mapTableView.editing) 
    {
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
    }
    else 
    {
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];  
    }
}

//-(void)toggleAdd
//{
//    //Add code here
//    NSLog(@"Add button was selected!");
//}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return showArray.count;  
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [showArray removeObjectAtIndex:indexPath.row];
        NSLog(@"copied array from app del : %i",showArray.count);
        [mapTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:true];
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
//    
//    MyAnnotation *loc = [showArray objectAtIndex:indexPath.row];
//	cell.textLabel.text = loc.title;
//    
//    return cell;
    static NSString *CellIdentifier = @"Cell";
    
    CustomCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"CustomCellView" owner:nil options:nil];
        
        for (UIView *view in views)
        {
            if([view isKindOfClass:[CustomCellView class]])
            {
                cell = (CustomCellView*)view;
                MyAnnotation *loc = [showArray objectAtIndex:indexPath.row];
                cell.textLabel.text = loc.title;
                cell.statusLabel.text = @"Restaurant";
            }
        }
    }
    
    MyAnnotation *loc = [showArray objectAtIndex:indexPath.row];
    cell.textLabel.text = loc.title;
    cell.statusLabel.text = @"Restaurant";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SingleViewController *myMap = [[SingleViewController alloc] initWithNibName:@"SingleViewController" bundle:nil];
    if (myMap != nil)
    {
        [self.navigationController pushViewController:myMap animated:YES];
        MyAnnotation *showCoord = [showArray objectAtIndex:indexPath.row];
        [myMap showMap:showCoord.coordinate title:showCoord.title];
    }
}

@end
