//
//  ListMapViewController.m
//  Tab'd
//
//  Created by Mark Evans on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListMapViewController.h"
#import <MapKit/MapKit.h>
#import "ViewController.h"
#import "MyAnnotation.h"
#import "AppDelegate.h"

@interface ListMapViewController ()

@end

@implementation ListMapViewController
@synthesize listViewMap;
@synthesize nshowArray;
@synthesize mshowArray;
@synthesize loc, loc2, loc3, loc4, loc5, loc6, loc7, loc8, loc9, loc10;

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

//- (void)showMap:(CLLocationCoordinate2D)coord title:(NSString *)title
//{
//    MKCoordinateRegion newRegion;
//    newRegion.center.latitude = coord.latitude;
//    newRegion.center.longitude = coord.longitude;
//    newRegion.span.latitudeDelta = 0.0333;
//    newRegion.span.longitudeDelta = 0.0333;
//    
//    [self.listViewMap setRegion:newRegion animated:YES];
//    
//    CLLocationCoordinate2D location;
//    location.latitude = coord.latitude;
//    location.longitude = coord.longitude;
//	
//	passAnnotation=[[MyAnnotation alloc] init];
//    
//	passAnnotation.coordinate=location;
//	passAnnotation.title=title;
//	passAnnotation.subtitle=@"Food";
//    
//    [listViewMap addAnnotation:passAnnotation];
//}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKPinAnnotationView* pinView = (MKPinAnnotationView*)[self.listViewMap dequeueReusableAnnotationViewWithIdentifier:@"MyAnnotation"];
    
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

- (IBAction)onClickClose:(id)sender
{
    [self dismissModalViewControllerAnimated:TRUE];
}

- (void)toggleList
{
    ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:TRUE];
}

- (void)viewDidLoad
{
    [super viewDidLoad]; 
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    UIImage *listImg = [UIImage imageNamed:@"list.png"];
    UIBarButtonItem *rightButton =[[UIBarButtonItem alloc]initWithImage:listImg style:UIBarButtonItemStylePlain target:self action:@selector(toggleList)];  
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:TRUE];
    
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 39.291996;
    newRegion.center.longitude = -76.590393;
    newRegion.span.latitudeDelta = 0.0333;
    newRegion.span.longitudeDelta = 0.0333;
    
    self.listViewMap.delegate = self;
    
    [self.listViewMap setRegion:newRegion animated:YES];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate Array];
    nshowArray = appDelegate.Array;
    
    NSLog(@"listmap from app del : %i",appDelegate.Array.count);
    NSLog(@"listmap copied array from app del : %i",nshowArray.count);
    
    [listViewMap removeAnnotations:listViewMap.annotations]; //Removes all Annotations
    for (int i = 0; nshowArray.count > i; i++) 
    {
        MyAnnotation *theloc = [nshowArray objectAtIndex:i]; //Loops through and re-adds locations in array
        [listViewMap addAnnotation:theloc];
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [nshowArray setArray:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
