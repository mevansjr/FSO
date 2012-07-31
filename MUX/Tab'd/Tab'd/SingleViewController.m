//
//  SingleViewController.m
//  Tab'd
//
//  Created by Mark Evans on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SingleViewController.h"
#import <MapKit/MapKit.h>
#import "ViewController.h"
#import "MyAnnotation.h"
#import "AppDelegate.h"
#import "MenuViewController.h"
#import "CurrentTabView.h"
#import "FriendToGiftViewController.h"

@interface SingleViewController ()

@end

@implementation SingleViewController
@synthesize theMapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        UIImage *headerImage = [UIImage imageNamed:@"logo_titleView.png"];
//        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:headerImage];
    }
    return self;
}

- (IBAction)showMap:(CLLocationCoordinate2D)coord title:(NSString *)title
{
    NSString *mCoord = [[NSString alloc]initWithFormat:@"Lon: %f Lat: %f", coord.longitude, coord.latitude];
    
    name.text = title;
    lonlat.text = mCoord;
    
    MenuViewController *menuView = [[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
    [menuView passTitle:title];
    
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = coord.latitude;
    newRegion.center.longitude = coord.longitude;
    newRegion.span.latitudeDelta = 0.00133;
    newRegion.span.longitudeDelta = 0.00133;
    
    self.theMapView.delegate = (id)self;
    
    self.title = title;
    
    [self.theMapView setRegion:newRegion animated:YES];
    
    CLLocationCoordinate2D location;
    location.latitude = coord.latitude;
    location.longitude = coord.longitude;
	
	passAnnotation=[[MyAnnotation alloc] init];
	passAnnotation.coordinate=location;
	passAnnotation.title=title;
	passAnnotation.subtitle=@"Food";
    
    [theMapView addAnnotation:passAnnotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKPinAnnotationView* pinView = (MKPinAnnotationView*)[self.theMapView dequeueReusableAnnotationViewWithIdentifier:@"MyAnnotation"];
    
    if (!pinView) 
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotation"];
    else
    pinView.annotation = annotation;
    pinView.animatesDrop = YES;
    pinView.canShowCallout = YES;
    pinView.enabled = YES;
    pinView.pinColor = MKPinAnnotationColorRed;
    
    return pinView;
}

-(IBAction)gift:(id)sender
{
    FriendToGiftViewController *friendView = [[FriendToGiftViewController alloc] initWithNibName:@"FriendToGiftViewController" bundle:nil];
    [self presentModalViewController:friendView animated:TRUE];
    NSLog(@"test");
}

-(IBAction)onClickItem:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Selected Item" message:@"Added to the Tab." delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
    [alert show];
    CurrentTabView *viewController = [[CurrentTabView alloc] initWithNibName:@"CurrentTabView" bundle:nil];
    [self presentModalViewController:viewController animated:TRUE];
}

-(IBAction)onClickMenu:(id)sender
{
    MenuViewController *menu = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    [self.navigationController pushViewController:menu animated:TRUE];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
