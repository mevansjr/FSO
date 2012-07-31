//
//  SingleViewController.h
//  Tab'd
//
//  Created by Mark Evans on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@interface SingleViewController : UIViewController
{
    IBOutlet MKMapView *theMapView;
    MyAnnotation* passAnnotation;
    MyAnnotation* passAnnotation2;
    IBOutlet UILabel *name;
    IBOutlet UILabel *lonlat;
    IBOutlet UIButton *gift1;
    IBOutlet UIButton *gift2;
    IBOutlet UIButton *gift3;
}
@property IBOutlet MKMapView *theMapView;
- (IBAction)showMap:(CLLocationCoordinate2D)coord title:(NSString *)title;
-(IBAction)onClickItem:(id)sender;
-(IBAction)onClickMenu:(id)sender;
-(IBAction)gift:(id)sender;

@end