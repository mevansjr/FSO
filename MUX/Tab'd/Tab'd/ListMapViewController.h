//
//  ListMapViewController.h
//  Tab'd
//
//  Created by Mark Evans on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@interface ListMapViewController : UIViewController <MKMapViewDelegate>
{
    IBOutlet MKMapView *listViewMap;
    NSMutableArray *nshowArray;
    NSMutableArray *mshowArray;
    MyAnnotation* passAnnotation;
    MyAnnotation* passAnnotation2;
    MyAnnotation *loc;
    MyAnnotation *loc2;
    MyAnnotation *loc3;
    MyAnnotation *loc4;
    MyAnnotation *loc5;
    MyAnnotation *loc6;
    MyAnnotation *loc7;
    MyAnnotation *loc8;
    MyAnnotation *loc9;
    MyAnnotation *loc10;
}
- (IBAction)onClickClose:(id)sender;
//- (void)showMap:(CLLocationCoordinate2D)coord title:(NSString *)title;
@property IBOutlet MKMapView *listViewMap;
@property (nonatomic, retain) NSMutableArray *nshowArray;
@property (nonatomic, retain) NSMutableArray *mshowArray;
@property (nonatomic,retain) MyAnnotation *loc;
@property (nonatomic,retain) MyAnnotation *loc2;
@property (nonatomic,retain) MyAnnotation *loc3;
@property (nonatomic,retain) MyAnnotation *loc4;
@property (nonatomic,retain) MyAnnotation *loc5;
@property (nonatomic,retain) MyAnnotation *loc6;
@property (nonatomic,retain) MyAnnotation *loc7;
@property (nonatomic,retain) MyAnnotation *loc8;
@property (nonatomic,retain) MyAnnotation *loc9;
@property (nonatomic,retain) MyAnnotation *loc10;

@end
