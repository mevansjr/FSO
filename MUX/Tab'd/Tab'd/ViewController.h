//
//  ViewController.h
//  Tab'd
//
//  Created by Mark Evans on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *mapTableView;
    NSMutableArray *showArray;
    MyAnnotation* passAnn;
}
@property (nonatomic, retain) NSMutableArray *showArray;

@end
